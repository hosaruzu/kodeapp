//
//  PeopleEndpoint.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

enum PeopleEndpoint {
    case people
    case avatar(id: String, size: AppConstants.ImageSize)
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
        case .avatar(let id, _):
            return "/\(id)"

        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .people:
           return []
        case .avatar(_, let size):
            return [
                URLQueryItem(name: "bgset", value: "bg2"),
                URLQueryItem(name: "size", value: size.rawValue)
            ]
        }
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else { return nil }
        return url
    }
}
