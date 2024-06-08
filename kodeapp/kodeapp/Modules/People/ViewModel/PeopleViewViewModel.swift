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
    var onSearchStateChange: ((Bool) -> Void)?
    var onOnConnectionStatusChange: ((Bool) -> Void)?
    var onErrorEvent: (() -> Void)?

    // MARK: - Data

    private var people: [Person] = [] {
        didSet {
            peopleByDepartment = .init(grouping: people, by: { $0.department })
        }
    }

    private var peopleFiltered: [Person] = [] {
        didSet {
            peopleByDepartment = .init(grouping: peopleFiltered, by: { $0.department })
            onLoad?()
        }
    }

    private var peopleByDepartment: [String: [Person]] = [:] {
        didSet {
            onLoad?()
        }
    }

    private var peopleUnfiltered: [Person] = []

    // MARK: - Dependencies

    private let networkService: PeopleNetworkService
    private var networkMonitor: NetworkMonitor
    private let coordinator: PeopleCoordinator

    // MARK: - Init

    init(
        networkService: PeopleNetworkService,
        coordinator: PeopleCoordinator,
        networkMonitor: NetworkMonitor
    ) {
        self.networkService = networkService
        self.coordinator = coordinator
        self.networkMonitor = networkMonitor
        fetchPeople()
        checkNetworkConnectionState()
    }

    // MARK: - Public properties

    var isLoaded: Bool {
        !peopleByDepartment.isEmpty
    }

    private(set) var inSearchMode = false

    // MARK: - Public methods

    func onRefresh() {
        fetchPeople()
    }

    func onCellTap(with person: Person) {
        showPersonScreen(with: person)
    }

    func onFilterTap() {
        showFilterModalScreen(with: self)
    }

    func onErrorButtonTap() {
        fetchPeople()
    }

    // MARK: - Table view data source

    func itemFor(
        _ indexPath: IndexPath,
        department: Departments,
        inSearchMode: Bool = false
    ) -> Person? {
        if department == .all {
            let person =  inSearchMode ? peopleFiltered[indexPath.row] : people[indexPath.row]
            return person
        } else {
            let person = peopleByDepartment[department.rawValue]?[indexPath.row]
            return person
        }
    }

    func itemsCount(
        for department: Departments,
        inSearchMode: Bool = false
    ) -> Int? {
        if department == .all {
            return inSearchMode ? peopleFiltered.count : people.count
        } else {
            return peopleByDepartment[department.rawValue]?.count
        }
    }

    func cellViewModelFor(
        _ indexPath: IndexPath,
        department: Departments,
        inSearchMode: Bool = false
    ) -> PersonTableViewCellViewModel? {
        if         department == .all {
            let person =  inSearchMode ? peopleFiltered[indexPath.row] : people[indexPath.row]
            return .init(person: person)
        } else {
            if let person = peopleByDepartment[        department.rawValue]?[indexPath.row] {
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
            peopleUnfiltered = fetched.items
            filterPeople(by: selectedFilterState)
        } catch NetworkError.noInternetConnection {
            onOnConnectionStatusChange?(false)
            onErrorEvent?()
        } catch {
            onErrorEvent?()
        }
    }

    // MARK: - Search

    func onSearchEvent(_ searchText: String = "") {
        inSearchMode = !searchText.isEmpty
        peopleFiltered = people
        guard inSearchMode else {
            onSearchStateChange?(inSearchMode)
            return
        }
        let searchText = searchText.lowercased()
        peopleFiltered = peopleFiltered.filter {
            $0.lastName.lowercased().contains(searchText)
            || $0.firstName.lowercased().contains(searchText)
            || $0.userTag.lowercased().contains(searchText)
        }
        onSearchStateChange?(inSearchMode && peopleFiltered.isEmpty)
    }

    // MARK: - Filter

    private var selectedFilterState: Filters = .standart {
        didSet {
            filterPeople(by: selectedFilterState)
            onFilterStateChange?(selectedFilterState)
        }
    }

    var filterIndex: Int {
        selectedFilterState.index
    }

    func onFilterTap(_ filter: Filters) {
        selectedFilterState = filter
    }

    func filterPeople(by filter: Filters) {
        switch filter {
        case .standart:
            people = peopleUnfiltered
        case .ascending:
            people = people.sorted { $0.firstName < $1.firstName }
        case .descending:
            people = people.sorted { $0.firstName > $1.firstName }
        }
    }

    // MARK: - Network connection

    private func checkNetworkConnectionState() {
        networkMonitor.onConnectionStatusChange = { isConnected in
            self.onOnConnectionStatusChange?(isConnected)
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
