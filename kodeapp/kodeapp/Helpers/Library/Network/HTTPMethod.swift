//
//  HTTPMethod.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

enum HTTPMethod: String {
    case get

    var name: String { rawValue.uppercased() }
}
