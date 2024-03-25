//
//  PeopleEndpoint.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

enum PeopleEndpoint {
    case people
    case avatar(id: String)
}

extension PeopleEndpoint: Endpoint {
    var method: HTTPMethod { .get }

    var host: String {
        switch self {
        case .people:
            return "stoplight.io"
        case .avatar:
            return "robohash.org"
        }
    }
    var path: String {
        switch self {
        case .people:
            return "/mocks/kode-education/trainee-test/25143926/users"
        case .avatar(let id):
            return "/\(id)"
        }
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        print(components.url)
        guard let url = components.url else { return nil }
        return url
    }
}
