//
//  UIKItExampleDelegate.swift
//  UIKitExample
//
//  Created by Saša Brezovac on 27.10.2025..
//

import Foundation
import IACore
import IAIntegrations
import IAOverTheCounter
import IAOrdering

@MainActor
final class UIKitExampleDelegate {
    private weak var viewModel: UIKitExampleViewModel?
    
    init(viewModel: UIKitExampleViewModel? = nil) {
        self.viewModel = viewModel
    }
}

extension UIKitExampleDelegate: SDKDelegate { }

extension UIKitExampleDelegate: OrderingDelegate { }

extension UIKitExampleDelegate: PrescriptionDelegate { }

extension UIKitExampleDelegate: CardLinkDelegate { }

