//
//  IAProductGridExamples.swift
//  MainExample
//
//  Created by Danijel Huis on 15.04.2026..
//

import Foundation
import SwiftUI
import IACore
import IAOverTheCounter

private let loremIpsum = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""

struct IAProductGridWithoutNavigationExampleScreen: View {
    let onDismiss: () -> Void
    
    var body: some View {
        NavigationStack {
            IAProductGridExampleContent(
                explanationText: "This is host app screen with embedded IAProductGrid.\n\nHost app didn't provide navigation to IAProductGrid so it will present its connected screens (product details, full product grid) modally, meaning those screens will animate from bottom.",
                navigator: nil,
                onDismiss: onDismiss
            )
            .navigationTitle("IAProductGrid")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { onDismiss() } label: { Image(systemName: "xmark") }
                }
            }
        }
    }
}

struct IAProductGridWithNavigationExampleScreen: View {
    let onDismiss: () -> Void
    
    var body: some View {
        UIKitNavigationView(
            routeIdentifier: .custom("IAProductGridWithNavigationExampleScreen"),
            shouldUpdateRootView: false
        ) { navigator in
            NavigationStack {
                IAProductGridExampleContent(
                    explanationText: "This is host app screen with embedded IAProductGrid.\n\nHost app provided navigation to IAProductGrid so it will push its connected screens (product details, full product grid) in navigation, meaning those screens will animate from right to left.",
                    navigator: navigator,
                    onDismiss: onDismiss
                )
                .navigationTitle("IAProductGrid")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button { onDismiss() } label: { Image(systemName: "xmark") }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct IAProductGridExampleContent: View {
    let explanationText: String
    let navigator: Navigator?
    let onDismiss: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 24) {
                    Text(explanationText)
                    
                    Divider()
                    
                    Text("Products of the month")
                    IAProductGrid(
                        type: .productsOfTheMonth(pznToExclude: nil),
                        shouldShowLoading: true, 
                        navigator: navigator ?? UIKitNavigator()
                    )
                    
                    Divider()
                    
                    Text("Current offers")
                    IAProductGrid(
                        type: .currentOffers(pznToExclude: nil), 
                        shouldShowLoading: true, 
                        navigator: navigator ?? UIKitNavigator()
                    )
                    
                    Divider()
                    
                    Text("Custom PZNs")
                    IAProductGrid(
                        type: .custom(title: "Something", pzns: ["10203603", "00021798", "00032566", "00958298", "04356248"]), 
                        shouldShowLoading: true, 
                        navigator: navigator ?? UIKitNavigator()
                    )
                    
                    Text(loremIpsum)
                    
                    Text(loremIpsum)
                }
                .padding(24)
            }
        }
        .background(.ia.screenBg)
        .tint(.blue)
    }
}
