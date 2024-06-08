//
//  NetworkDecoder.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

protocol NetworkDecoder: AnyObject {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

final class NetworkDecoderImpl: NetworkDecoder {

    private lazy var decoder = JSONDecoder()

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        guard let decoded = try? decoder.decode(type.self, from: data) else {
            throw NetworkError.decodingFailure
        }
        return decoded
    }
}
