//
//  ExampleApp.swift
//  SingleEntryPoint
//
//  Created by Danijel Huis on 01.08.2025..
//

import SwiftUI
import IACore
import IAIntegrations
import IAOverTheCounter

@main
struct ExampleApp: App {

    @StateObject private var viewModel = ExampleAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $viewModel.currentTab) {
                genericScreen(id: 1)
                    .tab(.tab1)
                
                hostScreen
                    .tab(.tab2)

                genericScreen(id: 3)
                    .tab(.tab3)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.gray, for: .tabBar)
            .preferredColorScheme(.light)
            .tint(.red)
        }
    }
}

private extension ExampleApp {

    func genericScreen(id: Int) -> some View {
        Text("Host Screen #\(id)")
    }
    
    var hostScreen: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    Text("This Screen is defined in the Host App that starts IA SDK.")

                    Button("Initialize IA SDK & Open Start Screen") {
                        Task { await viewModel.initializeSDKAndOpenStartScreen() }
                    }
                    .buttonStyle(.borderedProminent)

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.red)
                    }
                }
                .frame(maxHeight: .infinity)

                Divider()

                VStack(spacing: 16) {
                    Text("Miscellaneous")
                        .bold()
                    
                    Button("Reset Prerequisites") {
                        Task { await viewModel.resetPrerequisites() }
                    }
                }
            }
            .padding(16)
            .multilineTextAlignment(.center)
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .iaStartScreen:
                    IAStartScreen()
                        .hostEmbedStyle(.navigation(onDismiss: {
                            viewModel.pop()
                        }))
                }
            }
        }
    }
}
