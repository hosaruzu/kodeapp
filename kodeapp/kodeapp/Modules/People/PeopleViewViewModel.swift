//
//  PeopleViewViewModel.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 13.03.2024.
//

import Foundation

final class PeopleViewViewModel {

    // MARK: - Callbacks

    var onLoad: (() -> Void)?

    // MARK: - Data

    private var people: [Person] = [] {
        didSet {
            people.forEach { person in
                cellViewModels.append(PersonTableViewCellViewModel(person: person))
            }
        }
    }

    // MARK: - Dependecies

    private let networkService: PeopleNetworkService
    private let coordinator: PeopleCoordinator

    // MARK: - Init

    init(networkService: PeopleNetworkService, coordinator: PeopleCoordinator) {
        self.networkService = networkService
        self.coordinator = coordinator
        fetchPeople()
    }

    private var cellViewModels: [PersonTableViewCellViewModel] = []

    // MARK: - Public

    var itemsCount: Int {
        people.count
    }

    func itemFor(_ indexPath: IndexPath) -> Person {
        return people[indexPath.row]
    }

    func cellViewModelFor(_ indexPath: IndexPath) -> PersonTableViewCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func onRefresh() {
        fetchPeople()
    }

    func onCellTap(with person: Person) {
        showPersonScreen(with: person)
    }

    // MARK: - Fetch people

    private func fetchPeople() {
        Task { await fetchPeople() }
    }

    @MainActor
    private func fetchPeople() async {
        do {
            let fetched = try await networkService.getPeopleList()
            people = fetched.items
            onLoad?()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    // MARK: - Coordinator flow

    private func showPersonScreen(with person: Person) {
        coordinator.showPerson(with: person)
    }
}
