//
//  Alert+.swift
//  InitializationTest
//
//  Created by Danijel Huis on 12.11.2025..
//

import Foundation
import UIKit
import IACore

@MainActor
public struct Alert {
    public static func debug(_ message: String) {
        show(title: "Debug Info", message: message)
    }
    
    private static func show(title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        guard let rootViewController = UIApplication.shared.topPresentedViewController else { return }
        rootViewController.present(alert, animated: true)
    }
}
