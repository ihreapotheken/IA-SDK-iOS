//
//  ExampleAppViewModel.swift
//  SingleEntryPoint
//
//  Created by Danijel Huis on 01.08.2025..
//

import IACore
import Combine
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
        IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
        IASDK.configuration.clientID = "ENTER YOUR CLIENT ID HERE"
        
        IAIntegrationsSDK.register()
        IAOverTheCounterSDK.register()
    }
    
    func startSDK() async {
        
        do {
            let result = try await IASDK.initialize(options: .init(shouldShowIndicator: true, isCancellable: true))
            if result.didAgreeToLegalNotice, result.pharmacyID != nil {
                navigationPath.append(.iaStartScreen)
            }
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }
    
    func pop() {
        _ = navigationPath.popLast()
    }
    
    func resetPrerequisitesAndPharmacy() async {
        IASDK.Pharmacy.setPharmacyID(nil)
        try? await IAIntegrationsSDK.Prerequisites.resetAllPrerequisites()
    }
}

enum Route: Hashable {
    case iaStartScreen
}
