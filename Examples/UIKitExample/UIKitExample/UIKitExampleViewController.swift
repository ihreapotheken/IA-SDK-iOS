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

    private let viewModel = UIKitExampleViewModel()
    private var didSetupTabBarController = false

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

        setupUpdateCallbacks()

        Task {
            await viewModel.initializeSDK()
            self.setupTabBarContorller()
        }
    }
}

private extension UIKitExampleViewController {

    func setupUpdateCallbacks() {
        viewModel.onCurrentTabUpdated = { [weak self] in
            self?.tabBarController?.selectedIndex = self?.viewModel.currentTab.rawValue ?? 0
        }

        viewModel.onIsLoadedUpdated = { [weak self] in
            guard self?.viewModel.isLoaded == true,
                  self?.didSetupTabBarController == false else { return }

            self?.setupTabBarContorller()
        }

        viewModel.onErrorMessageUpdated = { [weak self] in
            self?.showErrorAlert()
        }
    }

    func setupTabBarContorller() {
        guard !didSetupTabBarController else { return }

        self.overrideUserInterfaceStyle = .light
        self.tabBar.tintColor = .red
        self.viewControllers = [
            createController(for: .start, content: IAStartScreen()),
            createController(for: .search, content: IAProductSearchScreen()),
            createController(for: .cart, content: IACartScreen()),
            createController(for: .pharmacy, content: IAPharmacyScreen()),
            createController(for: .scanner, content: IAScannerScreen(type: .prescription))
        ]

        self.tabBar.isHidden = false
        didSetupTabBarController = true
    }

    func createController(for tab: ExampleTab, content: some View) -> UIViewController {
        let controller = UIHostingController(rootView: content)
        controller.overrideUserInterfaceStyle = .light

        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem = .init(title: tab.title, image: .init(systemName: tab.systemImageName), selectedImage: nil)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.overrideUserInterfaceStyle = .light

        return navigationController
    }

    func showErrorAlert() {
        guard let errorMessage = viewModel.errorMessage,
              !errorMessage.isEmpty else { return }

        let alertVC = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        self.present(alertVC, animated: true)
    }
}
