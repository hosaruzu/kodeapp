//
//  Endpoint.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var url: URL? { get }
}

extension Endpoint {
    var scheme: String { "https" }
}
