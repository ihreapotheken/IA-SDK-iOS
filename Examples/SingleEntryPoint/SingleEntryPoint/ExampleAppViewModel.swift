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
        assert(Bundle.main.bundleIdentifier != "set.your.bundle.id.here", "Please set your bundle ID in Build Settings. Bundle ID must be registered with your API key.")
        IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
        IASDK.configuration.clientID = "ENTER YOUR CLIENT ID HERE"
        
        IASDK.register([
            .integrations, 
            .overTheCounter,
            .ordering,
            .apofinder
        ])
    }
    
    func initializeSDK() async {
        errorMessage = nil

        do {
            let options = IASDKInitializationOptions(
                prerequisitesOptions: .init(
                    shouldShowIndicator: true, 
                    isCancellable: false, 
                    isAnimated: true, 
                    shouldRunLegal: true, 
                    shouldRunOnboarding: true, 
                    shouldRunApofinder: true
                )
            )
            let result = try await IASDK.initialize(options: options)
            if result.prerequisitesResult.didAgreeToLegalNotice, result.prerequisitesResult.pharmacyID != nil {
                navigationPath.append(.iaStartScreen)
            } else {
                errorMessage = "Initialization result failed didAgreeToLegalNotice:\(result.prerequisitesResult.didAgreeToLegalNotice), pharmacy: \(result.prerequisitesResult.pharmacyID)"
            }            
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }
    
    func pop() {
        _ = navigationPath.popLast()
    }
    
    func resetPrerequisites() async {
        try? await IAIntegrationsSDK.Prerequisites.resetAllPrerequisites()
    }
}

enum Route: Hashable {
    case iaStartScreen
}
