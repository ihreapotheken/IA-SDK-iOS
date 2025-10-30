//
//  ViewController.swift
//  UIKitExample
//
//  Created by Saša Brezovac on 27.10.2025..
//

import SwiftUI
import UIKit
import IAIntegrations
import IAOverTheCounter
import IAPharmacy
import IAOrdering
import IAPrescription
import IACardLink

final class UIKitExampleViewController: UITabBarController {
    @ObservedObject var viewModel = UIKitExampleViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true

        viewModel.onStateChange = { [weak self] isLoaded, errorMessage in
            guard let self else { return }
            if isLoaded {
                self.createTabBarController()
            } else if let errorMessage {
                self.createErrorController(message: errorMessage)
            }
        }
        
        Task {
            await viewModel.initializeSDK()
        }
    }
    
    private func createTabBarController() {
        guard viewControllers?.isEmpty ?? true else { return }
        self.tabBar.isHidden = false
        
        let startViewController = UIHostingController(rootView: IAStartScreen())
        let startNavigationController = UINavigationController(rootViewController: startViewController)
        startNavigationController.tabBarItem = UITabBarItem(title: "Start", image: nil, selectedImage: nil)
        startNavigationController.setNavigationBarHidden(true, animated: false)
        
        let searchViewController = UIHostingController(rootView: IAProductSearchScreen())
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        searchNavigationController.setNavigationBarHidden(true, animated: false)
        
        let orderingViewController = UIHostingController(rootView: IACartScreen())
        let orderingNavigationController = UINavigationController(rootViewController: orderingViewController)
        orderingNavigationController.tabBarItem = UITabBarItem(title: "Cart", image: nil, selectedImage: nil)
        orderingNavigationController.setNavigationBarHidden(true, animated: false)
        
        let pharmacyViewController = UIHostingController(rootView: IAPharmacyScreen())
        let pharmacyNavigationController = UINavigationController(rootViewController: pharmacyViewController)
        pharmacyNavigationController.tabBarItem = UITabBarItem(title: "Pharmacy", image: nil, selectedImage: nil)
        pharmacyNavigationController.setNavigationBarHidden(true, animated: false)
       
        let scannerViewController = UIHostingController(rootView: IAScannerScreen(type: .prescription))
        let scannerNavigationController = UINavigationController(rootViewController: scannerViewController)
        scannerNavigationController.tabBarItem = UITabBarItem(title: "Scanner", image: nil, selectedImage: nil)
        scannerNavigationController.setNavigationBarHidden(true, animated: false)
        
        viewControllers = [
            startNavigationController,
            searchNavigationController,
            orderingNavigationController,
            pharmacyNavigationController,
            scannerNavigationController
        ]
    }
    
    private func createErrorController(message: String) {
        self.tabBar.isHidden = true
        
        let hostingController = UIHostingController(rootView: ErrorView(message: message))
        guard let hostingView = hostingController.view else { return }
        hostingView.frame = view.bounds
        hostingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingView.backgroundColor = .clear
        
        addChild(hostingController)
        view.addSubview(hostingView)
        hostingController.didMove(toParent: self)
    }
}

private struct ErrorView: View {
    let message: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
