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
    
    init(viewModel: UIKitExampleViewModel?) {
        self.viewModel = viewModel
    }
}

extension UIKitExampleDelegate: SDKDelegate {

    func sdkWillNavigateToTarget(_ navigationTarget: IANavigationTarget, decisionHandler: @escaping (HandlingDecision) -> Void) {
        switch navigationTarget {
        case .cart:
            viewModel?.setCurrentTab(.cart)
            decisionHandler(.handled)

        case .pharmacyDetails:
            viewModel?.setCurrentTab(.pharmacy)
            decisionHandler(.handled)

        default:
            decisionHandler(.performDefault)
        }
    }
}
