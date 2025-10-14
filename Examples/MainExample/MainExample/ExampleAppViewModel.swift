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

@MainActor @available(iOS 16.0, *)
final class ExampleAppViewModel: ObservableObject {
    @Published var isLoaded = false
    @Published var errorMessage: String?
    @Published var selectedTab: ExampleTab = .start
    @Published var moreNavigationPath: [MoreScreenRoute] = []
    @Published var moreActiveSheet: MoreActiveSheet?

    private lazy var delegate = ExampleIASDKDelegate(viewModel: self)
    
    init() {
        assert(Bundle.main.bundleIdentifier != "set.your.bundle.id.here", "Please set your bundle ID in Build Settings. Bundle ID must be registered with your API key.")
        IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
        IASDK.configuration.clientID = "ENTER YOUR CLIENT ID HERE"
        
        IASDK.register([
            .integrations,
            .overTheCounter,
            .ordering,
            .apofinder, 
            .pharmacyDetails,
            .prescription
        ])
        
        // Example (setup delegate): 
        IASDK.setDelegates(
            sdk: delegate,
            ordering: delegate,
            prescription: delegate,
            cardLink: delegate
        )        
        Task {
            await initializeSDK()
        }
    }
    
    func initializeSDK() async {
        errorMessage = nil
                
        do {
            let options = IASDKInitializationOptions(
                prerequisitesOptions: .init(
                    shouldShowIndicator: true, 
                    isCancellable: false, 
                    isAnimated: true
                )
            )
            let result = try await IASDK.initialize(options: options)
            if result.prerequisitesResult.didAgreeToLegalNotice, result.prerequisitesResult.pharmacyID != nil {
                isLoaded = true
            } else {
                errorMessage = "Initialization result failed didAgreeToLegalNotice:\(result.prerequisitesResult.didAgreeToLegalNotice), pharmacy: \(result.prerequisitesResult.pharmacyID)"
            }
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }
    
    func resetPrerequisitesAndExit() async {
        try? await IAIntegrationsSDK.Prerequisites.resetAllPrerequisites()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Allow user defaults to save
            exit(0)
        }
    }
}

// MARK: - Supporting types -

enum ExampleTab {
    case start
    case cart
    case pharmacy
    case more
}

enum MoreScreenRoute: Hashable {
    case search
}

enum MoreActiveSheet: Identifiable {
    case search
    
    var id: Self {
        self
    }
}
