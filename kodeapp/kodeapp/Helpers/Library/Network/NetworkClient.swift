//
//  NetworkService.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

protocol NetworkClient: AnyObject {

    func send(request: URLRequest) async throws -> Data
}

final class NetworkClientImpl: NetworkClient {

    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func send(request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.notAvailable
            }
            switch response.statusCode {
            case 200...299:
                return data
            default:
                throw NetworkError.responseError(statusCode: response.statusCode)
            }
        } catch {
            switch (error as? URLError)?.code {
            case .some(.notConnectedToInternet):
                throw NetworkError.noInternetConnection
            case .some(.timedOut):
                throw NetworkError.timeout
            default:
                throw NetworkError.unknown
            }
        }
    }
}


}
