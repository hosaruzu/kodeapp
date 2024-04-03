//
//  PeopleCoordinator.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 19.03.2024.
//

import Foundation
import UIKit

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
        let peopleScreen = screenFactory.makePeopleScreen(coordinator: self)
        router.setRootModule(peopleScreen)
    }

    func showPerson(with person: Person) {
        let profileScreen = screenFactory.makeProfileScreen(with: person, coordinator: self)
        router.push(profileScreen)
    }

    func presentAC(phone: String) {
        let phoneAlertController = screenFactory.makeCallPhoneAlert(with: phone)
        router.present(phoneAlertController, animated: true)
    }
}
