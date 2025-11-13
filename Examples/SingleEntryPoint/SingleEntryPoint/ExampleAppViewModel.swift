//
//  ExampleAppViewModel.swift
//  SingleEntryPoint
//
//  Created by Danijel Huis on 01.08.2025..
//

import Foundation
import IACore
import Combine
import IAOrdering
import IAIntegrations
import IAOverTheCounter

@MainActor
final class ExampleAppViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var navigationPath: [Route] = []
    
    init() {
        setup()
    }
    
    func setup() {
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
            .apofinder
        ])
        
        IASDK.setEnvironment(.staging)
        IASDK.configuration.apiKey = Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String ?? ""
        IASDK.configuration.clientID = Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String ?? ""
        IASDK.Pharmacy.setPharmacyID(2163)  // Comment this if you want to use apofinder as part of the prerequisites flow.
    }
    
    func initializeSDK() async {
        errorMessage = nil
        
        do {
            let prerequisitesOptions = IASDKPrerequisitesOptions(
                shouldShowIndicator: true, 
                isCancellable: false, 
                isAnimated: true, 
                shouldRunLegal: true, 
                shouldRunOnboarding: true, 
                shouldRunApofinder: true
            )
            let _ = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
            // We don't need to check initialization result because IASDKPrerequisitesOptions.isCancellable is false. Otherwise we would have to check if cancelled. 
            navigationPath.append(.iaStartScreen)
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }
    
    func pop() {
        _ = navigationPath.popLast()
    }
    
    func resetPrerequisites() async {
        try? await IASDK.Prerequisites.resetAllPrerequisites()
    }
}

enum Route: Hashable {
    case iaStartScreen
}
