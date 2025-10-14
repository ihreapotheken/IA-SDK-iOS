//
//  MainExampleApp.swift
//  MainExample
//
//  Created by Danijel Huis on 01.08.2025..
//

import Foundation
import SwiftUI
import IAIntegrations
import IAOverTheCounter
import IAOrdering
import IAPharmacy

@MainActor @main
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
                TabView(selection: $viewModel.selectedTab) {   
                    IAStartScreen()
                        .tabItem { Text("Start") }
                        .tag(ExampleTab.start)
                    
                    IACartScreen()
                        .tabItem { Text("Cart") }
                        .tag(ExampleTab.cart)
                    
                    IAPharmacyScreen()
                        .tabItem { Text("Pharmacy") }
                        .tag(ExampleTab.pharmacy)
                    
                    moreScreen
                        .tabItem { Text("More") }
                        .tag(ExampleTab.more)
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

@available(iOS 16.0, *)
private extension MainExampleApp {
    @ViewBuilder var moreScreen: some View {
        NavigationStack(path: $viewModel.moreNavigationPath) {
            VStack(spacing: 16) {
                Button("Push search") {
                    viewModel.moreNavigationPath.append(.search)
                }
                
                Button("Present search") {
                    viewModel.moreActiveSheet = .search
                }
                Spacer()
                
                Button("Reset Prerequisites and exit app") {
                    Task { await viewModel.resetPrerequisitesAndExit() }
                }
            }
            // Example (Push): How to push any IA SDK screen.
            .navigationDestination(for: MoreScreenRoute.self) { route in
                switch route {
                case .search:
                    IAProductSearchScreen()
                        .hostEmbedStyle(.navigation(onDismiss: { 
                            viewModel.moreNavigationPath.removeAll()
                        }))
                }
            }
            // Example (Present): How to present any IA SDK screen.
            .fullScreenCover(item: $viewModel.moreActiveSheet) { tag in
                switch tag {
                case .search:
                    IAProductSearchScreen()
                        .hostEmbedStyle(.presentation(onDismiss: { 
                            viewModel.moreActiveSheet = nil
                        }))
                }
            }
        }
    }
}
