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
    private let tableView = PeopleTableView()
    private let loader = Loader()

    // MARK: - View model

    private let viewModel: PeopleViewViewModel

    // MARK: - DEBUG

    var onCellTap: (() -> Void)?

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
        showLoader()
        tableView.onCellTap = { [weak self] in
            self?.onCellTap?()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - UI constants

    private enum UIConstants {
        static let searchBarHorizontalOffset: CGFloat = 16

        static let loaderWidth: CGFloat = 100
        static let loaderHeight: CGFloat = 100
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
            loader,
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

            tableView.topAnchor.constraint(equalTo: headerSearchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: UIConstants.loaderWidth),
            loader.heightAnchor.constraint(equalToConstant: UIConstants.loaderHeight)
        ])

    }
}

// MARK: - Loader lifecycle

private extension PeopleViewController {

    func showLoader() {
        loader.isHidden = false
        loader.start()
        view.bringSubviewToFront(loader)
    }

    func hideLoader() {
        loader.isHidden = true
        loader.stop()
        view.sendSubviewToBack(loader)
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
