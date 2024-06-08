//
//  NetworkService.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

protocol NetworkClient: AnyObject {
    func send(_ request: URLRequest) async throws -> Data
}

final class NetworkClientImpl: NetworkClient {

    // MARK: - Dependencies

    private let urlSession: URLSession
    private let cacheService: NetworkCacheService

    // MARK: - Init

    init(
        urlSession: URLSession,
        cacheService: NetworkCacheService
    ) {
        self.urlSession = urlSession
        self.cacheService = cacheService
    }

    // MARK: - Send request

    func send(_ request: URLRequest) async throws -> Data {
        if let cachedData = cacheService.retrieveCachedData(for: request) {
            return cachedData
        }

        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.notAvailable
            }
            switch response.statusCode {
            case 200...299:
                cacheService.cacheData(
                    from: request,
                    cachedURLResponse: CachedURLResponse(response: response, data: data))
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
