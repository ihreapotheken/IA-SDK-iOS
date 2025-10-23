//
//  OrderingOnlyExampleViewModel.swift
//  OrderingOnlyExample
//
//  Created by Saša Brezovac on 22.10.2025..
//

import Foundation
import UIKit
import Combine
import IACore
import IAIntegrations
import IAOrdering


@MainActor @available(iOS 16.0, *)
final class OrderingOnlyExampleAppViewModel: ObservableObject {
    @Published var isLoaded = false
    @Published var errorMessage: String?
    @Published var selectedTab: OrderingOnlyExampleTab = .start
    @Published private(set) var images: [Data] = []
    
    private lazy var delegate = OrderingOnlyExampleIASDKDelegate(viewModel: self)
    private let orderId: String = "order_ID"
    
    init() {
        assert(Bundle.main.bundleIdentifier != "set.your.bundle.id.here", "Please set your bundle ID in Build Settings. Bundle ID must be registered with your API key.")
        IASDK.setEnvironment(.staging)
        IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
        IASDK.configuration.clientID = "ENTER YOUR CLIENT ID HERE"
        IASDK.Pharmacy.setPharmacyID(2163)
        
        IASDK.register([
            .integrations,
            .ordering
        ])
        
        // Example (setup delegate):
        IASDK.setDelegates(
            sdk: delegate,
            ordering: delegate
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
    
    func addPrescription() async {
        loadPrescriptionFromAssetsAndQueue()
        do {
            try await IAOrderingSDK.transferPrescriptions(images: images, orderID: orderId)
            _ = delegate.cartButtonWillOpenCartScreen()
        } catch {
            print("error: \(error)")
        }
    }
    
    func goToCart() {
        self.selectedTab = .cart
    }
}

// MARK: - Load image from the Assests -

extension OrderingOnlyExampleAppViewModel {
    private func addImage(_ image: UIImage) {
        guard let pngData = image.pngData() else {
            print("Failed to convert UIImage to PNG data.")
            return
        }
        images.append(pngData)
    }
    
    private func loadPrescriptionFromAssetsAndQueue() {
        guard let image = UIImage(named: "prescription") else {
            print("Asset 'prescription' image not found.")
            return
        }
        addImage(image)
    }
}

// MARK: - Supporting types -

enum OrderingOnlyExampleTab {
    case start
    case cart
}


