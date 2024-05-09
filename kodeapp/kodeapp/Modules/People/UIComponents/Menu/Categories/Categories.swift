//
//  Categories.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 04.05.2024.
//

import Foundation

// swiftlint:disable identifier_name
enum Categories: String, CaseIterable {
    case all = "All"
    case android = "Android"
    case ios = "iOS"
    case design = "Design"
    case management = "Management"
    case backOffice = "Back-office"
    case qa = "QA"
    case frontend = "Frontend"
    case hr = "HR"
    case analytics = "Analytics"
    case pr = "PR"
    case backend = "Backend"
    case support = "Support"
}
// swiftlint:enable identifier_name

extension Categories {

    static var allValues: [String] {
        allCases.map { $0.rawValue }
    }

    static func category(for indexPath: IndexPath) -> Self.RawValue {
        Categories.allValues[indexPath.row]
    }
}
