//
//  CardLinkExampleViewModel.swift
//  CardLinkExample
//
//  Created by Saša Brezovac on 17.03.2026..
//

import Foundation
import Combine
import IACore
import IAIntegrations
import IACardLink
import UIKit

@MainActor
final class CardLinkExampleViewModel: ObservableObject {
    @Published var isLoaded = false
    @Published var errorMessage: String?

    private lazy var delegate = CardLinkExampleDelegate()
    private var pharmacyID: String?

    init() {
        assert(Bundle.main.bundleIdentifier != "set.your.bundle.id.here", "Please set your bundle ID in Build Settings. Bundle ID must be registered with your API key.")
        
        IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
        IASDK.configuration.clientID = "ENTER YOUR CLIENT ID HERE"

        IASDK.register([
            .integrations,
            .cardLink
        ])
        
        IASDK.setDelegate(delegate)
        
        Task {
            await initializeSDK()
        }
    }

    func initializeSDK() async {
        errorMessage = nil

        do {
            let options = IASDKInitializationOptions(
                prerequisitesOptions: .init(
                    isCancellable: false,
                    isAnimated: true,
                    shouldRunOnboarding: true,
                    shouldRunApofinder: false
                )
            )
            let result = try await IASDK.initialize(options: options)
            if result.prerequisitesResult?.legalResult != nil,
               let pharmacyID = result.prerequisitesResult?.pharmacyResult.pharmacyID {
                self.pharmacyID = "\(pharmacyID)"
                isLoaded = true
            } else {
                errorMessage = "Initialization result failed legalResult:\(String(describing: result.prerequisitesResult?.legalResult)), pharmacy: \(String(describing: result.prerequisitesResult?.pharmacyResult.pharmacyID))"
            }
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }

    func startCardLink(from rootViewController: UIViewController) {
        guard let pharmacyId = pharmacyID else {
            print("Pharmacy ID is not available")
            return
        }

        let configuration = CardLinkConfiguration(
            pharmacyId: pharmacyId,
            consentStatus: .undetermined,
            canCode: nil,
            phoneNumber: "",
            userId: "example_user_123",
            cardName: nil,
            isSaveCardEnabled: true,
            source: .unknown,
            appID: nil
        )

        CardLink.start(
            type: .startCardlink,
            forcePresent: false,
            on: rootViewController,
            configuration: configuration
        ) { [weak self] action in
            self?.handleCardLinkAction(action)
        }
    }
    
    func startCardLink() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Unable to get root view controller")
            return
        }
        
        startCardLink(from: rootViewController)
    }

    private func handleCardLinkAction(_ action: CardLinkOutputAction) {
        switch action {
        case .consentAccepted(let phoneNumber):
            print("Consent accepted with phone number: \(phoneNumber)")

        case .consentDeclined:
            print("Consent declined")

        case .sessionCreated(let session):
            print("Session created: \(session.cardSessionId), expires at: \(session.sessionExpiresAt)")

        case .backButtonPressed:
            print("Back button pressed, finishing CardLink")
            CardLink.finish()

        case .goToCart:
            print("User wants to go to cart")

        case .openTermsAndConditions:
            print("User wants to view terms and conditions")

        case .prescriptionsRedeemed(let prescription):
            print("Prescriptions redeemed: \(prescription)")

        case .cardsSaved(let cards):
            print("Cards saved: \(cards)")

        case .addedPrescriptionsToCart(let prescriptions):
            print("Added prescriptions to cart: \(prescriptions)")

        case .willStartScanning:
            print("NFC scanning will start")

        case .failedToInitialize(let error):
            print("CardLink failed to initialize: \(error)")

        case .trackEvent(let event):
            print("Track event: \(event)")

        case .reopenCardlink:
            print("Reopen CardLink requested")
        @unknown default:
            print("unkonown")
        }
    }
}
