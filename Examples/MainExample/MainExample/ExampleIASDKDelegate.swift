//
//  IASDKDelegate.swift
//  MainExample
//
//  Created by Danijel Huis on 01.08.2025..
//

import Foundation
import IACore
import IAIntegrations
import IAOverTheCounter
import IAOrdering

@MainActor
final class ExampleIASDKDelegate {
    
    private weak var viewModel: ExampleAppViewModel?
    
    init(viewModel: ExampleAppViewModel?) {
        self.viewModel = viewModel
    }
}

extension ExampleIASDKDelegate: SDKDelegate {

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
