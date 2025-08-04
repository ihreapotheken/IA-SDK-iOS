//
//  MainExampleApp.swift
//  MainExample
//
//  Created by Danijel Huis on 01.08.2025..
//

import SwiftUI
import IACore
import IAIntegrations
import IAOverTheCounter
import IAOrdering
import IAPharmacy

@main
struct MainExampleApp: App {
    @StateObject private var viewModel = ExampleAppViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isLoaded {
                TabView {   
                    IAProductSearchScreen()
                        .tabItem { Text("Search") }
                    
                    IACartScreen()
                        .tabItem { Text("Cart") }
                    
                    IAPharmacyScreen()
                        .tabItem { Text("Pharmacy") }
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.gray, for: .tabBar)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

@MainActor
final class ExampleAppViewModel: ObservableObject {
    @Published var isLoaded = false
    @Published var errorMessage: String?

    private let delegate = IASDKDelegate()
    
    init() {
        IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
        IASDK.configuration.clientID = "ENTER YOUR CLIENT ID HERE"
        IASDK.delegate = delegate
        
        IAIntegrationsSDK.register()
        IAOverTheCounterSDK.register()
        IAOrderingSDK.register(delegate: delegate)
        IAPharmacySDK.registerPharmacyDetails()
        
        Task {
            await initializeSDK()
        }
    }
    
    func initializeSDK() async {
        
        do {
            let _ = try await IASDK.initialize(options: .init(shouldShowIndicator: true, isCancellable: false, isAnimated: false))
            isLoaded = true
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }
}
