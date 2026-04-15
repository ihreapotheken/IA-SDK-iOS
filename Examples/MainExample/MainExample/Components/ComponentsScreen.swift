//
//  ComponentsScreen.swift
//  MainExample
//
//  Created by Danijel Huis on 26.02.2026..
//

import Foundation
import SwiftUI
import IACore

struct ComponentsScreen: View {
    @State private var activeSheetTag: ComponentScreenTag?

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    Divider()

                    VStack(spacing: 16) {
                        VStack(spacing: 12) {
                            componentButton(.productGridWithoutNavigation)
                            componentButton(.productGridWithNavigation)
                            componentButton(.cartButton)
                        }
                    }
                    .padding(.spacing.xx_md)
                    .tint(.ia.bottomNavigation)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.ia.screenBg)
        .navigationTitle("Components")
        .fullScreenCover(item: $activeSheetTag) { tag in
            componentView(tag)
        }
    }

    @ViewBuilder
    func componentButton(_ tag: ComponentScreenTag) -> some View {
        Button(tag.title) {
            activeSheetTag = tag
        }
    }

    @ViewBuilder
    func componentView(_ tag: ComponentScreenTag) -> some View {
        switch tag {
        case .productGridWithoutNavigation:
            IAProductGridWithoutNavigationExampleScreen(onDismiss: {
                activeSheetTag = nil
            })
        case .productGridWithNavigation:
            IAProductGridWithNavigationExampleScreen(onDismiss: {
                activeSheetTag = nil
            })
        case .cartButton:
            IACartButtonExampleScreen(onDismiss: {
                activeSheetTag = nil
            })
        }
    }
}

enum ComponentScreenTag: Hashable, Identifiable {
    case productGridWithoutNavigation
    case productGridWithNavigation
    case cartButton

    var title: String {
        switch self {
        case .productGridWithoutNavigation: "IAProductGrid (Without Navigation)"
        case .productGridWithNavigation: "IAProductGrid (With Navigation)"
        case .cartButton: "IACartButton"
        }
    }

    var id: Self {
        self
    }
}
