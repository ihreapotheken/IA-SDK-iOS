//
//  SceneDelegate.swift
//  UIKitExample
//
//  Created by Saša Brezovac on 27.10.2025..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIKitExampleViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}

