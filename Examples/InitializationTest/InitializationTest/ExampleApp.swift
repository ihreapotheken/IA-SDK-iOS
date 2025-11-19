//
//  ExampleApp.swift
//  InitializationTest
//
//  Created by Danijel Huis on 12.11.2025..
//

import Foundation
import SwiftUI
import IACore
import IAOverTheCounter

@main
struct InitializationExampleApp: App {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            ExampleScreen()
        }
    }
}

struct ExampleScreen: View {
    @StateObject var viewModel = ExampleViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            button(
                viewModel.isClientIDValid ? "Set invalid client ID" : "Set valid client ID",
                description: "Initialization will fail if invalid"
            ) {
                viewModel.setIsClientIDValid(!viewModel.isClientIDValid)
            }
            .tint(.gray)
            
            button(
                viewModel.isPharmacyIDValid ? "Set invalid pharmacy ID" : "Set valid pharmacy ID", 
                description: "Prerequisites will fail if invalid"
            ) {
                viewModel.setIsPharmacyIDValid(!viewModel.isPharmacyIDValid)
            }
            .tint(.gray)
            
            Divider()
            
            button(
                viewModel.isAutoInitializationEnabled ? "Disable auto initialization & prerequisites" : "Enable auto initialization & prerequisites", 
                backgroundColor: viewModel.willInitializationSucceed && viewModel.willPrerequisitesSucceed ? Color.green : Color.red
            ) {
                viewModel.setIsAutoInitializationEnabled(!viewModel.isAutoInitializationEnabled)
            }
            
            button(
                "Initialize only",
                backgroundColor: viewModel.willInitializationSucceed ? Color.green : Color.red
            ) {
                Task { await viewModel.initializeSDK(shouldRunPrerequisites: false, shouldFail: false) }
            }
            
            button(
                "Initialize and run prerequisites",
                backgroundColor: viewModel.willInitializationSucceed && viewModel.willPrerequisitesSucceed ? Color.green : Color.red
            ) {
                Task { await viewModel.initializeSDK(shouldRunPrerequisites: true, shouldFail: false) }
            }
            
            button("Reset all") {
                Task { await viewModel.resetAll() }
            }
            
            Divider()
            
            button("Show IASDK screen") {
                viewModel.isIASDKScreenPresented = true
            }
            .tint(.green)
            
            Spacer()
            
            Text(viewModel.initializationStatusText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(viewModel.prerequisitesStatusText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(viewModel.autoInitializationStatusText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Client ID: \(viewModel.isClientIDValid ? "valid \(IASDK.configuration.clientID)" : "invalid ID")")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Pharmacy ID: \(viewModel.isPharmacyIDValid ? "valid \(IASDK.Pharmacy.getPharmacyID() ?? -1)" : "invalid (9999)")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
        }
        .padding(16)
        .fullScreenCover(isPresented: $viewModel.isIASDKScreenPresented) {
            IAProductSearchScreen()
                .hostEmbedStyle(.presentation(onDismiss: { viewModel.isIASDKScreenPresented = false }))
        }
    }
}

private extension ExampleScreen {
    func button(_ text: String, description: String? = nil, backgroundColor: Color = .blue, action: @escaping () -> Void) -> some View {
        Button(action: action) { 
            VStack(spacing: 0) {
                Text(text)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(backgroundColor)
                
                if let description {
                    Text(description)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color.black)
                }
                
            }
        }
    }
}
