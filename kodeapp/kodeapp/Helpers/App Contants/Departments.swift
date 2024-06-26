//
//  Department.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 04.05.2024.
//

import Foundation

// swiftlint:disable identifier_name
enum Departments: String, CaseIterable {
    case all
    case android
    case ios
    case design
    case management
    case backOffice = "back_office"
    case qa
    case frontend
    case hr
    case analytics
    case pr
    case backend
    case support
    // swiftlint:enable identifier_name
}

extension Departments {

    var name: String {
        switch self {
        case .ios:
            "iOS"
        case .backOffice:
            "Back office"
        default:
            rawValue.capitalized
        }
    }

    static func department(for indexPath: IndexPath) -> String {
        allCases[indexPath.row].name
    }
}
