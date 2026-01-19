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

final class OrderingOnlyExampleAppViewModel: ObservableObject {

    @Published var isLoaded = false
    @Published var errorMessage: String?
    @Published var selectedTab: ExampleTab = .start
    @Published private(set) var images: [Data] = []
    
    private lazy var delegate = OrderingOnlyExampleIASDKDelegate(viewModel: self)
    private let orderId: String = "order_ID"
    
    init() {
        // Validate that SharedConfig.xcconfig has been properly configured.
        precondition(
            Bundle.main.bundleIdentifier != "ENTER YOUR BUNDLE IDENTIFIER HERE" &&
            Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String != "ENTER YOUR API KEY HERE" &&
            Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String != "ENTER YOUR CLIENT ID HERE",
            "Please configure SharedConfig.xcconfig with your bundle identifier, API key, and client ID."
        )
                
        IASDK.register([
            .integrations,
            .ordering
        ])
        
        // Example (setup delegate):
        IASDK.setDelegate(delegate)
        
        IASDK.setEnvironment(.staging)
        IASDK.configuration.apiKey = Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String ?? ""
        IASDK.configuration.clientID = Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String ?? ""
        IASDK.configuration.channelID = 2
        IASDK.Pharmacy.savePharmacyID(2163)  // Comment this if you want to use apofinder as part of the prerequisites flow.

        Task {
            await initializeSDK()
        }
    }
    
    func initializeSDK() async {
        errorMessage = nil
        
        do {            
            let prerequisitesOptions = IASDKPrerequisitesOptions(
                isCancellable: false, 
                isAnimated: true, 
            )

            // We don't need to check initialization result because IASDKPrerequisitesOptions.isCancellable is false. Otherwise we would have to check if cancelled.
            let _ = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)

            isLoaded = true
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }
    
    func resetPrerequisitesAndExit() async {
        try? await IASDK.Prerequisites.resetAllPrerequisites()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Allow user defaults to save
            exit(0)
        }
    }
    
    func addPrescription() async {
        loadPrescriptionFromAssetsAndQueue()

        do {
            try await IAOrderingSDK.transferPrescriptions(images: images, orderID: orderId)
        } catch {
            print("error: \(error)")
        }
    }
}

// MARK: - Load image from the Assests -

private extension OrderingOnlyExampleAppViewModel {

    private func loadPrescriptionFromAssetsAndQueue() {
        guard let image = UIImage(named: "prescription") else {
            print("Asset 'prescription' image not found.")
            return
        }

        guard let pngData = image.pngData() else {
            print("Failed to convert UIImage to PNG data.")
            return
        }

        images.append(pngData)
    }
}
