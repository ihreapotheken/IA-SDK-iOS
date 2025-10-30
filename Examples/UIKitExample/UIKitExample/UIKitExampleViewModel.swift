//
//  UIKitExampleViewModel.swift
//  UIKitExample
//
//  Created by Saša Brezovac on 27.10.2025..
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
final class UIKitExampleViewModel: ObservableObject {
    var onStateChange: ((_ isLoaded: Bool, _ errorMessage: String?) -> Void)?
    private lazy var sdkDelegate = UIKitExampleDelegate(viewModel: self)
    
    init() {
        setupSDK()
    }
    
    private func setupSDK() {
        assert(Bundle.main.bundleIdentifier != "set.your.bundle.id.here", "Please set your bundle ID in Build Settings. Bundle ID must be registered with your API key.")
        IASDK.setEnvironment(.staging)
        IASDK.Pharmacy.setPharmacyID(2163)
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
        
        IASDK.setDelegates(
            sdk: sdkDelegate,
            ordering: sdkDelegate,
            prescription: sdkDelegate,
            cardLink: sdkDelegate
        )
    }

    func initializeSDK() async {
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
            print("result: \(result)")
            onStateChange?(true, nil)
        } catch {
            onStateChange?(false, "Error\n\(error)")
        }
    }
}
