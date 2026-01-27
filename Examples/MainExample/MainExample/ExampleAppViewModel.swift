//
//  ExampleAppViewModel.swift
//  MainExample
//
//  Created by Danijel Huis on 14.10.2025..
//

import Foundation
import Combine
import IACore
import IAIntegrations
import IAOverTheCounter
import IAPrescription
import IAOrdering
import IAPharmacy

@MainActor
final class ExampleAppViewModel: ObservableObject {
    
    @Published var isLoaded = false
    @Published var errorMessage: String?
    @Published var selectedTab: ExampleTab = .start
    @Published var moreNavigationPath: [MoreScreenRoute] = []
    @Published var moreActiveSheet: MoreActiveSheet?
    
    private lazy var delegate = ExampleIASDKDelegate(viewModel: self)
    
    init() {
        // Validate that SharedConfig.xcconfig has been properly configured.
        precondition(
            Bundle.main.bundleIdentifier != "ENTER YOUR BUNDLE IDENTIFIER HERE" &&
            Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String != "ENTER YOUR API KEY HERE" &&
            Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String != "ENTER YOUR CLIENT ID HERE",
            "Please configure SharedConfig.xcconfig with your bundle identifier, API key, and client ID."
        )
        
        IASDK.register([
            .integrations,
            .overTheCounter,
            .ordering,
            .apofinder, 
            .pharmacy,
            .prescription
        ])
        
        // Example (setup delegate):
        IASDK.setDelegate(delegate)
        
        IASDK.setEnvironment(.staging)
        IASDK.configuration.apiKey = Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String ?? ""
        IASDK.configuration.clientID = Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String ?? ""
        IASDK.Pharmacy.savePharmacyID(2163)  // Comment this if you want to use apofinder as part of the prerequisites flow.
        
        Task {
            await initializeSDK()
        }
    }
    
    func initializeSDK() async {
        errorMessage = nil
        
        do {
            let prerequisitesOptions = IASDKPrerequisitesOptions(
                isCancellable: false, 
                isAnimated: true,
                shouldRunLegal: true,
                shouldRunOnboarding: true, 
                shouldRunApofinder: true
            )
            
            let result = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
            
            // Example: This is just an example how to handle result if you set IASDKPrerequisitesOptions.isCancellable to true.
            // Otherwise no need to check.
            if let prerequisitesResult = result.prerequisitesResult,
               !prerequisitesResult.isCancelled {
                isLoaded = true
            } else {
                errorMessage = "Initialization cancelled."
            }  
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }
    
    func resetPrerequisitesAndExit() async {
        try? await IASDK.Prerequisites.resetAllPrerequisites()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Allow user defaults to save
            exit(0)
        }
    }
}

// MARK: - Supporting types -

enum MoreScreenRoute: Hashable {
    case search
}

enum MoreActiveSheet: Identifiable {
    case search
    
    var id: Self {
        self
    }
}
