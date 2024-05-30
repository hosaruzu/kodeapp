//
//  Filters.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 28.05.2024.
//

import Foundation

enum Filters: Int, CaseIterable {
    case standart
    case ascending
    case descending

    var name: String {
        switch self {
        case .standart:
            "Default"
        case .ascending:
            "Ascending"
        case .descending:
            "Descending"
        }
    }

    static var count: Int {
        Filters.allCases.count
    }

    static func nameFor(_ indexPath: IndexPath) -> String {
        Filters.allCases[indexPath.row].name
    }

    static func filterFor(_ indexPath: IndexPath) -> Filters? {
        Filters(rawValue: indexPath.row)
    }

    var index: Int {
        rawValue
    }
}
