//
//  OrderingOnlyExampleApp.swift
//  OrderingOnlyExample
//
//  Created by Saša Brezovac on 22.10.2025..
//

import SwiftUI
import IAIntegrations
import IAOrdering
import IACore

@main
struct OrderingOnlyExampleApp: App {
    @StateObject private var viewModel = OrderingOnlyExampleAppViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isLoaded {
                TabView(selection: $viewModel.selectedTab) {
                    startScreen
                        .tabItem { Text("Start") }
                        .tag(OrderingOnlyExampleTab.start)
                    
                    IACartScreen()
                        .tabItem { Text("Cart") }
                        .tag(OrderingOnlyExampleTab.cart)
                    
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
private extension OrderingOnlyExampleApp {
    @ViewBuilder var startScreen: some View {
        VStack(spacing: 50) {
            Text("Start Screen")
            
            Button {
                Task {
                    await viewModel.addPrescription()
                }
            } label: {
                Text("Add prescription")
            }
        }
    }
}

