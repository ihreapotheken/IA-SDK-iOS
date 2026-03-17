//
//  OrderingOnlyExampleIASDKDelegate.swift
//  OrderingOnlyExample
//
//  Created by Saša Brezovac on 22.10.2025..
//

import Foundation
import IACore
import IAIntegrations
import IAOrdering

@MainActor
final class OrderingOnlyExampleIASDKDelegate {

    private weak var viewModel: OrderingOnlyExampleAppViewModel?
    
    init(viewModel: OrderingOnlyExampleAppViewModel) {
        self.viewModel = viewModel
    }
}

extension OrderingOnlyExampleIASDKDelegate: SDKDelegate {

    // Example (override behavior): How to override default behavior.
    // In this case, instead of presenting the cart (default behavior),
    // we will switch to cart tab in our example app.
    func sdkWillNavigateToTarget(_ navigationTarget: IANavigationTarget, decisionHandler: @escaping (HandlingDecision) -> Void) {
        guard navigationTarget == .cart else {
            decisionHandler(.performDefault)
            return
        }

        viewModel?.selectedTab = .cart
        decisionHandler(.handled)
    }
}
