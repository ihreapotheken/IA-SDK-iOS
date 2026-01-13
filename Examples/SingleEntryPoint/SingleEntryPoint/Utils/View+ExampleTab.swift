//
//  View+ExampleTab.swift
//  MainExample
//
//  Created by Bruno Benčević on 12.01.2026..
//

import SwiftUI

enum ExampleTab {
    case tab1
    case tab2
    case tab3

    var systemImageName: String {
        return switch self {
        case .tab1: "1.square"
        case .tab2: "2.square"
        case .tab3: "3.square"
        }
    }
}

extension View {

    func tab(_ tab: ExampleTab) -> some View {
        self.tabItem {
            Image(systemName: tab.systemImageName)
        }
        .tag(tab)
    }
}
