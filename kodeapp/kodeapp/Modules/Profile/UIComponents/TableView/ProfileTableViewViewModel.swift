//
//  ProfileTableViewViewModel.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 01.04.2024.
//

import Foundation

struct ProfileTableViewViewModel {
    private let phoneNumber: String
    private let birthDate: String

    init(phoneNumber: String, birthDate: String) {
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
    }

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
}
