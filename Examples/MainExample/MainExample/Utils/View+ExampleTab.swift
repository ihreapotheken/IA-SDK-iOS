//
//  View+ExampleTab.swift
//  MainExample
//
//  Created by Bruno Benčević on 12.01.2026..
//

import SwiftUI

enum ExampleTab {
    case start
    case cart
    case pharmacy
    case more

    var title: String {
        return switch self {
        case .start: "Start"
        case .cart: "Cart"
        case .pharmacy: "Pharmacy"
        case .more: "More"
        }
    }

    var systemImageName: String {
        return switch self {
        case .start: "house"
        case .cart: "cart"
        case .pharmacy: "plus.square"
        case .more: "ellipsis.circle"
        }
    }
}

extension View {

    func tab(_ tab: ExampleTab) -> some View {
        self.tabItem {
            Text(tab.title)

            Image(systemName: tab.systemImageName)
        }
        .tag(tab)
    }
}
