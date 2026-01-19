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
final class UIKitExampleViewModel {

    var onCurrentTabUpdated: (() -> Void)?
    var onIsLoadedUpdated: (() -> Void)?
    var onErrorMessageUpdated: (() -> Void)?

    private lazy var sdkDelegate = UIKitExampleDelegate(viewModel: self)

    private(set) var currentTab: ExampleTab = .start {
        didSet {
            onCurrentTabUpdated?()
        }
    }

    private(set) var isLoaded: Bool = false {
        didSet {
            onIsLoadedUpdated?()
        }
    }

    private(set) var errorMessage: String? {
        didSet {
            onErrorMessageUpdated?()
        }
    }

    init() {
        setupSDK()
    }

    func setCurrentTab(_ tab: ExampleTab) {
        currentTab = tab
    }

    func initializeSDK() async {
        do {
            let prerequisitesOptions = IASDKPrerequisitesOptions(
                isCancellable: false,
                isAnimated: true,
            )
            // We don't need to check initialization result because IASDKPrerequisitesOptions.isCancellable is false. Otherwise we would have to check if cancelled. 
            let _ = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)

            self.isLoaded = true
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Error\n\(error.localizedDescription)"
        }
    }
}

private extension UIKitExampleViewModel {

    func setupSDK() {
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
            .pharmacyDetails,
            .prescription
        ])

        IASDK.setDelegate(sdkDelegate)

        IASDK.setEnvironment(.staging)
        IASDK.configuration.apiKey = Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String ?? ""
        IASDK.configuration.clientID = Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String ?? ""
        IASDK.configuration.channelID = 2
        IASDK.Pharmacy.savePharmacyID(2163)  // Comment this if you want to use apofinder as part of the prerequisites flow.
    }
}
