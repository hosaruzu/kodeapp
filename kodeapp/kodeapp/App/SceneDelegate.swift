//
//  SceneDelegate.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 11.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private let appFactory: AppFactory = AppAssembly()
    private var appCoordinator: Coordinator?
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
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator()
        window.windowScene = scene
        self.window = window
        self.appCoordinator = coordinator
        window.makeKeyAndVisible()
        coordinator.start()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
