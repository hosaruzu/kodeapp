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
    var onFilterStateChange: ((Filters) -> Void)?

    // MARK: - Data

    private var people: [Person] = [] {
        didSet {
            categorizedPeople = .init(grouping: people, by: { $0.department })
        }
    }

    private var filteredPeople: [Person] = [] {
        didSet {
            categorizedPeople = .init(grouping: filteredPeople, by: { $0.department })
            onLoad?()
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

    // MARK: - Public properties

    var isLoaded: Bool {
        !categorizedPeople.isEmpty
    }

    private(set) var inSearchMode = false

    // MARK: - Public methods

    func onRefresh() {
        fetchPeople()
        selectedFilterState = .standart
    }

    func onCellTap(with person: Person) {
        showPersonScreen(with: person)
    }

    func onFilterTapEvent() {
        showFilterModalScreen(with: self)
    }

    func itemFor(
        _ indexPath: IndexPath,
        category: Categories,
        inSearchMode: Bool = false
    ) -> Person? {
        if category == .all {
            let person =  inSearchMode ? filteredPeople[indexPath.row] : people[indexPath.row]
            return person
        } else {
            let person = categorizedPeople[category.rawValue]?[indexPath.row]
            return person
        }
    }

    func itemsCount(
        for category: Categories,
        inSearchMode: Bool = false
    ) -> Int? {
        if category == .all {
            return inSearchMode ? filteredPeople.count : people.count
        } else {
            return categorizedPeople[category.rawValue]?.count
        }
    }

    func cellViewModelFor(
        _ indexPath: IndexPath,
        category: Categories,
        inSearchMode: Bool = false
    ) -> PersonTableViewCellViewModel? {
        if category == .all {
            let person =  inSearchMode ? filteredPeople[indexPath.row] : people[indexPath.row]
            return .init(person: person)
        } else {
            if let person = categorizedPeople[category.rawValue]?[indexPath.row] {
                return .init(person: person)
            }
        }
        return nil
    }

    // MARK: - Search

    func onSearchEvent(_ searchText: String = "") {
        inSearchMode = !searchText.isEmpty
        filteredPeople = people
        guard !searchText.isEmpty else { return }
        let searchText = searchText.lowercased()
        filteredPeople = filteredPeople.filter {
            $0.lastName.lowercased().contains(searchText)
            || $0.firstName.lowercased().contains(searchText)
            || $0.userTag.lowercased().contains(searchText)
        }
    }

    // MARK: - Filter

    private var selectedFilterState: Filters = .standart {
        didSet {
            filterPeople(by: selectedFilterState)
            onFilterStateChange?(selectedFilterState)
        }
    }

    private var defaultFilteredPeople: [Person] = []

    var filterIndex: Int {
        selectedFilterState.index
    }

    func onFilterTap(_ filter: Filters) {
        selectedFilterState = filter
    }

    func filterPeople(by filter: Filters) {
        switch filter {
        case .standart:
            people = defaultFilteredPeople
        case .ascending:
            people = people.sorted { $0.firstName < $1.firstName }
        case .descending:
            people = people.sorted { $0.firstName > $1.firstName }
        }
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
            defaultFilteredPeople = people
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    // MARK: - Coordinator flow

    private func showPersonScreen(with person: Person) {
        coordinator.showPerson(with: person)
    }

    private func showFilterModalScreen(with viewModel: PeopleViewViewModel) {
        coordinator.presentFilterScreen(with: viewModel)
    }
}
