//
//  NetworkCacheService.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

protocol NetworkCacheService {
    func cacheData(from urlRequest: URLRequest, cachedURLResponse: CachedURLResponse)
    func retrieveCachedData(for urlRequest: URLRequest) -> Data?
}

final class NetworkCacheServiceImpl: NetworkCacheService {

    private let userDefaults: UserDefaults
    private let urlCache: URLCache

    init(userDefaults: UserDefaults, urlCache: URLCache) {
        self.userDefaults = userDefaults
        self.urlCache = urlCache
    }

    func cacheData(from urlRequest: URLRequest, cachedURLResponse: CachedURLResponse) {
        guard let urlString = urlRequest.url?.absoluteString else { return }
        userDefaults.set(3600 + Date.timeIntervalSinceReferenceDate, forKey: responseCacheKey(urlString: urlString))
    }

    func retrieveCachedData(for urlRequest: URLRequest) -> Data? {
        guard
            let urlString = urlRequest.url?.absoluteString,
            let storedData = userDefaults.object(forKey: responseCacheKey(urlString: urlString)),
            let expirationTamstamp = storedData as? TimeInterval
        else { return nil }

        guard expirationTamstamp > Date.timeIntervalSinceReferenceDate else {
            userDefaults.removeObject(forKey: responseCacheKey(urlString: urlString))
            return nil
        }

        return urlCache.cachedResponse(for: urlRequest)?.data
    }

    private func responseCacheKey(urlString: String) -> String {
        return "ExpirationTimestamp_\(urlString)"
    }
}
