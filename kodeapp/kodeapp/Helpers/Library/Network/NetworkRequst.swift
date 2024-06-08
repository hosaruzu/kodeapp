//
//  NetworkRequsts.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

protocol NetworkRequst: AnyObject {
    func build(endpoint: Endpoint) throws -> URLRequest
}

final class NetworkRequstsImpl: NetworkRequst {

    func build(endpoint: Endpoint) throws -> URLRequest {
        guard let url = endpoint.url else { throw NetworkError.cantBuildUrl }
        var urlRequest = URLRequest(url: url, timeoutInterval: 15)
        urlRequest.httpMethod = endpoint.method.name
        return urlRequest
    }
}
