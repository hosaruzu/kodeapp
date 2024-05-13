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
            categorizedPeople = .init(grouping: people, by: { $0.department })
        }
    }

    private var categorizedPeople: [String: [Person]] = [:] {
        didSet {
            onLoad?()
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

    // MARK: - Public

    var isLoaded: Bool {
        !categorizedPeople.isEmpty
    }

    func itemFor(_ indexPath: IndexPath) -> Person {
        return people[indexPath.row]
    }

    func onRefresh() {
        fetchPeople()
    }

    func onCellTap(with person: Person) {
        showPersonScreen(with: person)
    }

    func itemFor(_ indexPath: IndexPath, category: Categories) -> Person? {
        let person = categorizedPeople[category.rawValue]?[indexPath.row]
        return person
    }

    func itemCount(for category: Categories) -> Int? {
        if category == .all {
            return people.count
        } else {
            return categorizedPeople[category.rawValue]?.count
        }
    }

    func cellViewModelFor(_ indexPath: IndexPath, category: Categories) -> PersonTableViewCellViewModel? {
        if category == .all {
            let person = people[indexPath.row]
            return .init(person: person)
        } else {
            if let person = categorizedPeople[category.rawValue]?[indexPath.row] {
                return .init(person: person)
            }
        }
        return nil
    }

    // MARK: - Fetch people

    private func fetchPeople() {
        Task { await fetchPeople() }
    }

    @MainActor
    private func fetchPeople() async {
        do {
            try? await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
            let fetched = try await networkService.getPeopleList()
            people = fetched.items
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    // MARK: - Coordinator flow

    private func showPersonScreen(with person: Person) {
        coordinator.showPerson(with: person)
    }
}
