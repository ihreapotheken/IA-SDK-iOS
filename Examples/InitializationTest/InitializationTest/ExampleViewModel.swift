//
//  ExampleViewModel.swift
//  InitializationTest
//
//  Created by Danijel Huis on 12.11.2025..
//

import Foundation
import IACore
import IAOverTheCounter
import IAOrdering
import IAIntegrations
import Combine

@MainActor
final class ExampleViewModel: ObservableObject {
    @Published var isIASDKScreenPresented = false
    @Published var initializationStatusText = ""
    @Published var prerequisitesStatusText = ""
    @Published var autoInitializationStatusText = ""
    @Published var isClientIDValid = false
    @Published var isPharmacyIDValid = true
    @Published var isAutoInitializationEnabled = false
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // Validate that SharedConfig.xcconfig has been properly configured.
        precondition(
            Bundle.main.bundleIdentifier != "ENTER YOUR BUNDLE IDENTIFIER HERE" &&
            Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String != "ENTER YOUR API KEY HERE" &&
            Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String != "ENTER YOUR CLIENT ID HERE",
            "Please configure SharedConfig.xcconfig with your bundle identifier, API key, and client ID."
        )
        
        IASDK.setEnvironment(.staging)
        IASDK.configuration.apiKey = Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String ?? ""
        IASDK.configuration.clientID = Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String ?? ""
        IASDK.register([.integrations,  .apofinder, .overTheCounter, .ordering])
        IASDK.configuration.defaultInitializationOptions = .init(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
        IASDK.Pharmacy.savePharmacyID(2163)

        setIsClientIDValid(true)
        setIsPharmacyIDValid(true)
        setIsAutoInitializationEnabled(false)
        
        IASDK.initializationStatePublisher.sink { [weak self] _ in
            self?.updateStatuses()
        }.store(in: &cancellables)
    }
    
    func setIsAutoInitializationEnabled(_ value: Bool) {
        isAutoInitializationEnabled = value
        IASDK.configuration.isAutoInitializationEnabled = isAutoInitializationEnabled
        updateStatuses()
    }
    
    func initializeSDK(shouldRunPrerequisites: Bool, shouldFail: Bool) async {
        do  {                        
            let result = try await IASDK.initialize(
                options: .init(
                    shouldShowIndicator: true, 
                    prerequisitesOptions: shouldRunPrerequisites ? prerequisitesOptions : nil)
            )
            Alert.debug("Initialization succeeded: \(result)")
            
        } catch {
            Alert.debug("Initialization failed: \(error)")
        }
    }
    
    func setIsClientIDValid(_ value: Bool) {
        isClientIDValid = value
        IASDK.configuration.clientID = isClientIDValid ? "5004" : "invalid ID"
        updateStatuses()
    }
    
    func setIsPharmacyIDValid(_ value: Bool) {
        isPharmacyIDValid = value
        let pharmacyID = isPharmacyIDValid ? 2163 : 9999
        IASDK.Pharmacy.savePharmacyID(pharmacyID)
        updateStatuses()
    }
    
    func resetAll() async {
        do {
            try await IASDK.Prerequisites.resetAllPrerequisites()
            setIsClientIDValid(true)
            setIsPharmacyIDValid(true)
            setIsAutoInitializationEnabled(false)
            IASDK.cleanCache(initialization: true, prerequisites: true)
            
        } catch {
            print(">>> \(error)")
        }
    }
    
    var willInitializationSucceed: Bool {
        isClientIDValid
    }
    
    var willPrerequisitesSucceed: Bool {
        isClientIDValid && isPharmacyIDValid
    }
    
    private var prerequisitesOptions: IASDKPrerequisitesOptions {
        .init(
            isCancellable: false, 
            isAnimated: true, 
            shouldRunLegal: true, 
            shouldRunOnboarding: true, 
            shouldRunApofinder: false   // So we can test fail when pharmacyID is nil.
        )
    }
    
    private func updateStatuses() {
        let initializationState = IASDK.initializationState
        
        let initializationText = switch initializationState.initializationResult {
        case .success: "Initialized"
        case .failure: "Error"
        case .none: "Not initialized"
        }
        initializationStatusText = "Initialization status: \(initializationText)"
        
        
        let prerequisitesText = switch initializationState.prerequisitesResult {
        case .success: "Finished"
        case .failure: "Error"
        case .none: "Not started"
        }
        prerequisitesStatusText = "Prerequisites status: \(prerequisitesText)"
        
        let autoInitializationText: String = IASDK.configuration.isAutoInitializationEnabled ? "Enabled" : "Disabled"
        autoInitializationStatusText = "Auto initialization: \(autoInitializationText)"
    }
}
