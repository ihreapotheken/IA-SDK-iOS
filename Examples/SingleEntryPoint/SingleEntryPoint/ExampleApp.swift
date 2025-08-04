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
            TabView {
                hostScreen1()
                    .tabItem { Image(systemName: "house.fill") }
                
                hostScreen2()
                    .tabItem { Image(systemName: "pills.circle") }
                
                hostScreen3()
                    .tabItem { Image(systemName: "gearshape.fill") }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.gray, for: .tabBar)
        }
    }
}

@available(iOS 16.0, *)
private extension ExampleApp {
    private func hostScreen1() -> some View {
        Text("Host screen 1")
    }
    
    private func hostScreen2() -> some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack(spacing: 20) {
                Text("This is view defined in host app that starts IA SDK.")
                
                Button("Start IA SDK") {
                    Task { await viewModel.startSDK() }
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.red)
                }
                
                Spacer()
                
                Button("Reset Prerequisites") {
                    Task { await viewModel.resetPrerequisitesAndPharmacy() }
                }
            }
            .padding()
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .iaStartScreen:
                    IAStartScreen()
                        .hostEmbedStyle(.navigation(onDismiss: { viewModel.pop() }))
                }
            }
        }
    }
    
    private func hostScreen3() -> some View {
        Text("Host screen 3")
    }
}
