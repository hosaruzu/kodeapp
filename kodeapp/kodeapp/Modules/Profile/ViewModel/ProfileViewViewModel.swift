//
//  ProfileViewViewModel.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 19.03.2024.
//

import Foundation

final class ProfileViewViewModel {

    // MARK: - Properties

    private let person: Person

    // MARK: - Coordinator

    private let coordinator: PeopleCoordinator

    // MARK: - Init

    init(person: Person, coordinator: PeopleCoordinator) {
        self.person = person
        self.coordinator = coordinator
    }

    // MARK: - Public properties

    var tableViewModel: ProfileTableViewViewModel {
        .init(phoneNumber: person.phone, birthDate: person.birthday)
    }

    var id: String {
        person.id
    }

    var name: String {
        "\(person.firstName) \(person.lastName)"
    }

    var tag: String {
        person.userTag
    }

    var position: String {
        person.position
    }

    func onPhoneCellTap() {
        coordinator.presentAC(phone: person.phone.formatToPhoneNumber())
    }
}
