//
//  ProfileTableViewViewModel.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 01.04.2024.
//

import Foundation

struct ProfileTableViewViewModel {

    // MARK: - Private

    private let phoneNumber: String
    private let birthDate: String

    // MARK: - Public

    enum CellType: Int, CaseIterable {
        case birhtDay
        case phone
    }

    var numberOfSections: Int {
        CellType.allCases.count
    }

    var numberOfRows = 1

    var phone: String {
        phoneNumber.formatToPhoneNumber()
    }

    var birthday: String {
        guard let formatted = birthDate.convertDate(inputDate: birthDate) else { return "No birthday" }
        return formatted
    }

    var age: String {
        guard let result = birthDate.yearsSinceDate(inputDate: birthDate) else { return "Can't get age" }
        return "\(result) years old"
    }

    // MARK: - Init

    init(phoneNumber: String, birthDate: String) {
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
    }
}
