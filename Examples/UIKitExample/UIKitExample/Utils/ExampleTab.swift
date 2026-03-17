//
//  ExampleTab.swift
//  UIKitExample
//
//  Created by Bruno Benčević on 12.01.2026..
//

import Foundation

enum ExampleTab: Int {
    case start = 0
    case search = 1
    case cart = 2
    case pharmacy = 3
    case scanner = 4

    var title: String {
        return switch self {
        case .start: "Start"
        case .search: "Search"
        case .cart: "Cart"
        case .pharmacy: "Pharmacy"
        case .scanner: "Scanner"
        }
    }
    
    var systemImageName: String {
        return switch self {
        case .start: "house"
        case .search: "magnifyingglass"
        case .cart: "cart"
        case .pharmacy: "plus.square"
        case .scanner: "qrcode.viewfinder"
        }
    }
}
