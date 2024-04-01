//
//  ProfileTableViewViewModel.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 01.04.2024.
//

import Foundation

struct ProfileTableViewViewModel {
    let phoneNumber: String
    let birthDate: String

    var formattedBirthday: String {
        guard let formatted = birthDate.convertDate(inputDate: birthDate) else { return "No birthday" }
        return formatted
    }

    var age: String {
        guard let result = birthDate.yearsSinceDate(inputDate: birthDate) else { return "Can't get age" }
        return "\(result) years old"
    }
}
