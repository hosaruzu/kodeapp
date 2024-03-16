//
//  AppAssembly.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 16.03.2024.
//

import UIKit

final class AppAssembly {

    fileprivate let screenFactory: ScreenFactory

    init() {
        screenFactory = ScreenFactoryImpl()
    }
}

protocol AppFactory {
    // Next: add cordinator
    func makeKeyWindow() -> UIWindow
}

extension AppAssembly: AppFactory {

    func makeKeyWindow() -> UIWindow {
        let window = UIWindow()
        let peopleViewController = screenFactory.makePeopleScreen()
        let navigationController = UINavigationController(rootViewController: peopleViewController)
        window.rootViewController = navigationController
        return window
    }
}

protocol ScreenFactory {
    func makePeopleScreen() -> UIViewController
}

final class ScreenFactoryImpl: ScreenFactory {

    @MainActor
    func makePeopleScreen() -> UIViewController {
        let viewModel = PeopleViewViewModel()
        let viewController = PeopleViewController(viewModel: viewModel)

        return viewController
    }
}
