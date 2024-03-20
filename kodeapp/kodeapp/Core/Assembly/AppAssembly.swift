//
//  AppAssembly.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 16.03.2024.
//

import UIKit

final class AppAssembly {

    fileprivate let screenFactory: ScreenFactory
    fileprivate let coordinatorFactory: CoordinatorFactory

    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
    }
}

protocol AppFactory {
    // Next: add cordinator
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension AppAssembly: AppFactory {

    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        let router = RouterImp(rootController: rootVC)
        let coordinator = coordinatorFactory.makeAppCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, coordinator)
    }
}

protocol ScreenFactory {

    func makePeopleScreen() -> PeopleViewController
    func makeProfileScreen() -> ProfileViewController
}

final class ScreenFactoryImpl: ScreenFactory {

    @MainActor
    func makePeopleScreen() -> PeopleViewController {
        let viewModel = PeopleViewViewModel()
        let viewController = PeopleViewController(viewModel: viewModel)

        return viewController
    }

    @MainActor
    func makeProfileScreen() -> ProfileViewController {
        let viewModel = ProfileViewViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        return viewController
    }
}

protocol CoordinatorFactory {

    func makeAppCoordinator(router: Router) -> AppCoordinator
    func makePeopleCoordinator(router: Router) -> PeopleCoordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {

    private let screenFactory: ScreenFactory

    fileprivate init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }

    func makeAppCoordinator(router: Router) -> AppCoordinator {
        return AppCoordinator(coordinatorFactory: self, router: router)
    }

    func makePeopleCoordinator(router: Router) -> PeopleCoordinator {
        return PeopleCoordinator(screenFactory: screenFactory, router: router)
    }
}
