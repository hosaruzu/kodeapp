//
//  ImageLoader.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 29.03.2024.
//

import UIKit

final class ImageLoader {

    // MARK: - Singleton

    static let shared = ImageLoader()
    private init() {}

    // MARK: - Properties

    private var cache = NSCache<NSString, NSData>()
    private let networkRequest = NetworkRequstsImpl()

    // MARK: - Get image data

    func downloadImage(_ id: String, size: ImageSize) async throws -> Data {
        let request = try networkRequest.build(endpoint: PeopleEndpoint.avatar(id: id, size: size))
        return try await downloadImage(request)
    }

    private func downloadImage(_ urlRequest: URLRequest) async throws -> Data {
        guard let url = urlRequest.url else { throw NetworkError.cantBuildUrl }
        let key = url.absoluteString

        if let data = getFromCache(for: key) {
            return data as Data
        }
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        setToCache(data, for: key)
        return data
    }

    // MARK: - Caching

    private func setToCache(_ object: Data, for key: String) {
        cache.setObject(object as NSData, forKey: key as NSString)
    }

    private func getFromCache(for key: String) -> Data? {
        guard let object = cache.object(forKey: key as NSString) else { return nil }
        return object as Data
    }
}
