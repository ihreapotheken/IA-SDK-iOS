//
//  IASDKDelegate.swift
//  MainExample
//
//  Created by Danijel Huis on 01.08.2025..
//

import Foundation
import UIKit
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
    // In this case, instead of presenting the cart (default behavior), we will switch to cart tab in our example app.
    func sdkWillNavigateToTarget(_ navigationTarget: IANavigationTarget, decisionHandler: @escaping (HandlingDecision) -> Void) {
        switch navigationTarget {
        case .cart:
            // Don't switch tab if some controller is presented, because tabview is behind it and switch won't be seen by user. In that case SDK will present cart.
            if UIApplication.shared.topPresentedViewController?.presentingViewController == nil, viewModel?.selectedTab != .cart {
                viewModel?.selectedTab = .cart
                decisionHandler(.handled)
            } else {
                decisionHandler(.performDefault)
            }
            
        default:
            decisionHandler(.performDefault)
        }
    }
}
