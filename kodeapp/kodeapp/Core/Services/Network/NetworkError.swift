//
//  NetworkError.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

enum NetworkError: Error {
        case cantBuildUrl
        case notAvailable
        case responseError(statusCode: Int)
        case noInternetConnection
        case parsingFailure
        case timeout
        case unknown
    }

extension NetworkError {
    var description: String {
        switch self {
        case .cantBuildUrl:
            "Invalid URL"
        case .notAvailable:
            "Server is currently unavaliable"
        case .responseError(let statusCode):
            "Error occured with status code: \(statusCode)"
        case .noInternetConnection, .timeout:
            "No internet connection"
        case .parsingFailure:
            "Can't parse data"
        case .unknown:
            "Unknown error occured: \(localizedDescription)"
        }
    }
}
