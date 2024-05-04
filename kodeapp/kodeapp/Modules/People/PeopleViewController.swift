//
//  PeopleViewController.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 13.03.2024.
//

import UIKit

final class PeopleViewController: UIViewController {

    // MARK: - Subviews

    private let headerSearchBar = SearchBar()
    private let menuView = MenuView()
    private let tableView = PeopleTableView()

    // MARK: - View model

    private var viewModel: PeopleViewViewModel

    // MARK: - Init

    init(viewModel: PeopleViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupSearchBar()
        addSubviews()
        setupLayout()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Setup bindings

    private func setupBindings() {
        viewModel.onLoad = { [weak self] in
            self?.display(with: self?.viewModel)
        }

        tableView.onRefresh = { [weak self] in
            self?.viewModel.onRefresh()
        }

        tableView.onCellTap = { [weak self] person in
            self?.viewModel.onCellTap(with: person)
        }
    }

    private func display(with viewModel: PeopleViewViewModel?) {
        tableView.configure(with: self.viewModel)
    }

    // MARK: - UI constants

    private enum UIConstants {
        static let searchBarHorizontalOffset: CGFloat = 16
    }
}

// MARK: - Setup appearance

private extension PeopleViewController {

    func setupAppearance() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Setup subviews

private extension PeopleViewController {

    func addSubviews() {
        view.addSubviews([
            headerSearchBar,
            menuView,
            tableView
        ])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            headerSearchBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            headerSearchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: UIConstants.searchBarHorizontalOffset
            ),
            headerSearchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -UIConstants.searchBarHorizontalOffset
            ),

            menuView.topAnchor.constraint(equalTo: headerSearchBar.bottomAnchor, constant: 6),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 44),

            tableView.topAnchor.constraint(equalTo: menuView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
}

// MARK: - UISearchBarDelegate

extension PeopleViewController: UISearchBarDelegate {

    func setupSearchBar() {
        headerSearchBar.delegate = self
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        headerSearchBar.isSearching = true
        headerSearchBar.showCancelButton()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        headerSearchBar.isSearching = false
        headerSearchBar.hideCancelButton()
        headerSearchBar.didEndEditing()
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        headerSearchBar.isFilterClicked = !headerSearchBar.isFilterClicked
    }
}
