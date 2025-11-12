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
        
        IASDK.Pharmacy.setPharmacyID(2163)  // Comment this if you want to use apofinder as part of the prerequisites flow.
    }

    func initializeSDK() async {
        do {
            let prerequisitesOptions = IASDKPrerequisitesOptions(
                shouldShowIndicator: true,
                isCancellable: false,
                isAnimated: true,
            )
            // We don't need to check initialization result because IASDKPrerequisitesOptions.isCancellable is false. Otherwise we would have to check if cancelled. 
            let _ = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
            onStateChange?(true, nil)
        } catch {
            onStateChange?(false, "Error\n\(error)")
        }
    }
}
