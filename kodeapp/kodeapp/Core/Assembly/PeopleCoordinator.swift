//
//  PeopleCoordinator.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 19.03.2024.
//

import Foundation

final class PeopleCoordinator: BaseCoordinator {

    // MARK: - Callback

    var finishFlow: (() -> Void)?

    // MARK: - Dependencies

    private let screenFactory: ScreenFactory
    private let router: Router

    // MARK: - Init

    init(
        screenFactory: ScreenFactory,
        router: Router
    ) {
        self.screenFactory = screenFactory
        self.router = router
    }

    // MARK: - Coordinator

    override func start() {
        showPeople()
    }

    // MARK: - Flow

    private func showPeople() {
        let peopleScreen = screenFactory.makePeopleScreen()
//        peopleScreen.onSelectPerson = { [weak self] in self?.showPerson() }
        router.setRootModule(peopleScreen)

        // DEBUG
        peopleScreen.onCellTap = { [weak self] in self?.showPerson() }
    }

    private func showPerson() {
        let profileScreen = screenFactory.makeProfileScreen()
        router.push(profileScreen)
    }
}
