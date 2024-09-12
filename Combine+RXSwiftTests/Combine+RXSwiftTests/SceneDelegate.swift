//
//  SceneDelegate.swift
//  Combine+RXSwiftTests
//
//  Created by Тёма on 12.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        let networkManager = NetworkManager()
        let viewModel = ViewModel(networkManager: networkManager)
        let viewController = ViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
