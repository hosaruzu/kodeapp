//
//  PeopleNetworkService.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

protocol PeopleNetworkService {

    func getPeopleList() async throws -> PeopleResponse
    func getAvatarData(_ id: String) async throws -> Data
}

final class PeopleNetworkServiceImpl: PeopleNetworkService {

    private let networkClient: NetworkClient
    private let decoder: NetworkDecoder
    private let request: NetworkRequst

    init(
        networkClient: NetworkClient,
        decoder: NetworkDecoder,
        request: NetworkRequst
    ) {
        self.networkClient = networkClient
        self.decoder = decoder
        self.request = request
    }

    func getPeopleList() async throws -> PeopleResponse {
        let request = try request.build(endpoint: PeopleEndpoint.people)
        let data = try await networkClient.send(request)
        return try decoder.decode(PeopleResponse.self, from: data)
    }

    func getAvatarData(_ id: String) async throws -> Data {
        let request = try request.build(endpoint: PeopleEndpoint.avatar(id: id))
        return try await networkClient.send(request)
    }
}
