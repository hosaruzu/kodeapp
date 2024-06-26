//
//  PeopleViewController.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 13.03.2024.
//

import UIKit

final class PeopleViewController: UIViewController {

    // MARK: - View model

    private var viewModel: PeopleViewViewModel

    // MARK: - Subviews

    private let headerSearchBar = SearchBar()
    private let menuView = MenuView()
    private let sliderView = SliderView()
//    private let emptyStateView = EmptyStateView()
    private let networkErrorView = NetworkErrorView()
    private let errorView = ErrorView()

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
        setupSubviewsInitialPosition()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarAppearance()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNetworkErrorBinding()
    }

    // MARK: - Setup bindings

    private func setupBindings() {
        sliderView.onEndDragging = { [weak self] item in
            self?.menuView.selectItem(at: item)
        }

        menuView.onSectionChange = { [weak self] row in
            self?.sliderView.scrollToItem(at: row)
        }

        viewModel.onLoad = { [weak self] in
            self?.display(with: self?.viewModel)
        }

        sliderView.onRefresh = { [weak self] in
            self?.viewModel.onRefresh()
        }

        sliderView.onCellTap = { [weak self] person in
            self?.viewModel.onCellTap(with: person)
        }

        viewModel.onErrorEvent = { [weak self] in
            self?.showErrorView()
            self?.errorView.show()
        }

        errorView.onButtonTap = { [weak self] in
            self?.hideErrorView()
            self?.viewModel.onErrorButtonTap()
        }
    }

    // MARK: - Private methods

    private func setupNetworkErrorBinding() {
        viewModel.onOnConnectionStatusChange = { [weak self] isConnected in
            self?.handleNetworkErrorDisplay(isConnected)
        }
    }

    private func display(with viewModel: PeopleViewViewModel?) {
        sliderView.configure(with: viewModel)
    }

    private func handleNetworkErrorDisplay(_ isConnected: Bool) {
        if isConnected {
            networkErrorView.hide()
            view.sendSubviewToBack(networkErrorView)
        } else {
            networkErrorView.show()
            view.bringSubviewToFront(networkErrorView)
        }
    }

    private func showErrorView() {
        view.bringSubviewToFront(errorView)
        errorView.show()
    }

    private func hideErrorView() {
        view.sendSubviewToBack(errorView)
        errorView.hide()
    }
}

// MARK: - Setup appearance

private extension PeopleViewController {
    func setupAppearance() {
        view.backgroundColor = .systemBackground
    }

    func setupNavigationBarAppearance() {
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Setup subviews

private extension PeopleViewController {
    func addSubviews() {
        view.addSubviews([
            headerSearchBar,
            menuView,
            sliderView,
            networkErrorView,
            errorView
        ])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            headerSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerSearchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spec.SearchBarView.horizontal
            ),
            headerSearchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Spec.SearchBarView.horizontal
            ),
            headerSearchBar.heightAnchor.constraint(equalToConstant: Spec.SearchBarView.height),

            menuView.topAnchor.constraint(
                equalTo: headerSearchBar.bottomAnchor,
                constant: Spec.MenuView.top),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.heightAnchor.constraint(equalToConstant: Spec.MenuView.height),

            sliderView.topAnchor.constraint(equalTo: menuView.bottomAnchor),
            sliderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sliderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            networkErrorView.topAnchor.constraint(equalTo: view.topAnchor),
            networkErrorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            networkErrorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            networkErrorView.bottomAnchor.constraint(equalTo: headerSearchBar.bottomAnchor),

            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupSubviewsInitialPosition() {
        view.sendSubviewToBack(networkErrorView)
        view.sendSubviewToBack(errorView)
    }
}

// MARK: - UISearchBar & UISearchBarDelegate

extension PeopleViewController: UISearchBarDelegate {
    func setupSearchBar() {
        let backgroundImage = searchBarImage(size: .init(
            width: view.bounds.width,
            height: Spec.SearchBarView.height)
        )
        headerSearchBar.setSearchFieldBackgroundImage(backgroundImage, for: .normal)
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
        viewModel.onSearchEvent()
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        viewModel.onFilterTap()
        viewModel.onFilterStateChange = { [weak self] state in
            self?.headerSearchBar.filterState = state
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.onSearchEvent(searchText)
    }
}

// MARK: - UI constants

private enum Spec {
    enum SearchBarView {
        static let horizontal: CGFloat = 16
        static let height: CGFloat = 44
    }

    enum MenuView {
        static let top: CGFloat = 6
        static let height: CGFloat = 44
    }
}
