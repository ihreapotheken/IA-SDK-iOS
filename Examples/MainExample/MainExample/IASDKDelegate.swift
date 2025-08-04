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
final class IASDKDelegate {}

extension IASDKDelegate: SDKDelegate {
    func pharmacyHeaderWillOpenPharmacyScreen(pharmacy: Pharmacy) -> WillOpenResult {
        return .notHandled
    }
    
    func startScreenWillOpenProductSearchScreen() -> WillOpenResult {
        return .notHandled
    }
    
    func startScreenWillOpenDiscoverOffersScreen() -> WillOpenResult {
        return .notHandled
    }
    
    func hostAppShouldOpenPrivacyPolicy() {
        print("Host app should open its own privacy policy settings page.")
    }
    
    func willOpenApoFinder() -> WillOpenResult {
        return .notHandled
    }
}

extension IASDKDelegate: OrderingDelegate {
    
    func orderingWillOpenPharmacyScreen(pharmacy: Pharmacy) -> WillOpenResult {
        return .notHandled
    }
}
