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
            Group {
                if viewModel.isLoaded {
                    TabView(selection: $viewModel.selectedTab) {
                        startScreen
                            .tab(.start)

                        IACartScreen()
                            .tab(.cart)
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
            .preferredColorScheme(.light)
            .tint(.red)
        }
    }
}

private extension OrderingOnlyExampleApp {
    
    var startScreen: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                Text("Tap on the Button below to add a Prescription to the Cart")

                Button {
                    Task {
                        await viewModel.addPrescription()
                    }
                } label: {
                    Text("Add Prescription")
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxHeight: .infinity)

            Divider()

            VStack(spacing: 16) {
                Text("Miscellaneous")
                    .bold()

                Button("Reset Prerequisites & Exit Application") {
                    Task { await viewModel.resetPrerequisitesAndExit() }
                }
            }
        }
        .padding(16)
        .multilineTextAlignment(.center)
    }
}

