//
//  UIKitExampleViewModel.swift
//  DemoUIKitExample
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
//        assert(Bundle.main.bundleIdentifier != "set.your.bundle.id.here", "Please set your bundle ID in Build Settings. Bundle ID must be registered with your API key.")
        IASDK.setEnvironment(.staging)
        IASDK.configuration.apiKey = "e9f3d6a12c4b8f75d1e0a93c5b7d6e2f3c1a9b8e7f4d2c0a1b6e5d3f8c7a1b9e"//"ENTER YOUR API KEY HERE"
        IASDK.configuration.clientID = "5004"//"ENTER YOUR CLIENT ID HERE"
        
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
        Task {
            await initializeSDK()
        }
    }

    func initializeSDK() async {
        do {
            let options = IASDKInitializationOptions(
                prerequisitesOptions: .init(
                    shouldShowIndicator: true,
                    isCancellable: false,
                    isAnimated: true,
                    shouldRunLegal: false,
                    shouldRunOnboarding: false,
                    shouldRunApofinder: false
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
