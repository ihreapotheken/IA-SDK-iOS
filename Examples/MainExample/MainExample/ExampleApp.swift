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
            Group {
                if viewModel.isLoaded {
                    TabView(selection: $viewModel.selectedTab) {
                        IAStartScreen()
                            .tab(.start)

                        IACartScreen()
                            .tab(.cart)

                        IAPharmacyScreen()
                            .tab(.pharmacy)

                        moreScreen
                            .tab(.more)
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

private extension MainExampleApp {

    @ViewBuilder
    var moreScreen: some View {
        NavigationStack(path: $viewModel.moreNavigationPath) {
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    Text("Tap on any of these Buttons to navigate to the corespoding Screens")

                    Button("Push Search Screen") {
                        viewModel.moreNavigationPath.append(.search)
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Present Search Screen") {
                        viewModel.moreActiveSheet = .search
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxHeight: .infinity)

                Divider()

                VStack(spacing: 16) {
                    Text("Miscellaneous")
                        .bold()

                    Button("Reset Prerequisites and Exit Application") {
                        Task { await viewModel.resetPrerequisitesAndExit() }
                    }
                }
            }
            .padding(16)
            .multilineTextAlignment(.center)
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
