//
//  PersonTableViewCellViewModel.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 15.03.2024.
//

import Foundation

final class PersonTableViewCellViewModel {

    // MARK: - Dependencies

    private let person: Person

    // MARK: - Init

    init(person: Person) {
        self.person = person
    }

    // MARK: - Public

    var fullName: String {
        "\(person.firstName) \(person.lastName)"
    }

    var personPosition: String {
        person.position
    }

    var personTag: String {
        person.userTag
    }

    var personId: String {
        person.id
    }
}
