//
//  CardLinkExampleApp.swift
//  CardLinkExample
//
//  Created by Saša Brezovac on 17.03.2026..
//

import SwiftUI

@main
struct CardLinkExampleApp: App {
    @StateObject private var viewModel = CardLinkExampleViewModel()

    var body: some Scene {
        WindowGroup {
            if viewModel.isLoaded {
                NavigationView {
                    VStack(spacing: 20) {
                        Image(systemName: "creditcard.fill")
                            .imageScale(.large)
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                        
                        Text("CardLink Example")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 100)
                        
                        Text("Tap the button below to start CardLink manually")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button(action: {
                            viewModel.startCardLink()
                        }) {
                            Text("Start CardLink")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding()
                }
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                }
            }
        }
    }
}
