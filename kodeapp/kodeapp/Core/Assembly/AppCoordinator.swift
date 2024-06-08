//
//  AppCoordinator.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 19.03.2024.
//

import Foundation

final class AppCoordinator: BaseCoordinator {

    // MARK: - Dependencies

    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    // MARK: - Init

    init(
        coordinatorFactory: CoordinatorFactory,
        router: Router
    ) {
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }

    // MARK: - Coordinator

    override func start() {
        runPeopleFlow()
    }

    // MARK: - Flow

    private func runPeopleFlow() {
        let coordinator = coordinatorFactory.makePeopleCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
