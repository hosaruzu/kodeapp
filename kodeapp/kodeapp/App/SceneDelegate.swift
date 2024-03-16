//
//  SceneDelegate.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 11.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private let appFactory: AppFactory = AppAssembly()
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        runUI(scene: windowScene)
    }

    func runUI(scene: UIWindowScene) {
        let window = appFactory.makeKeyWindow()
        window.windowScene = scene
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
