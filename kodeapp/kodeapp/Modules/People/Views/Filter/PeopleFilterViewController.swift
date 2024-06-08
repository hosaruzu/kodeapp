//
//  FilterViewController.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 24.05.2024.
//

import UIKit

final class PeopleFilterViewController: UIViewController {

    // MARK: - View model

    private let viewModel: PeopleViewViewModel

    // MARK: - Data

    private let defaultFilterElement = 0

    // MARK: - Subviews

    private let tableView = UITableView()

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
        setupTableView()
        setupBackButton()
        setupSubviews()
        setupConstraints()
    }
}

// MARK: - Setup appearance

private extension PeopleFilterViewController {

    func setupAppearance() {
        view.backgroundColor = .systemBackground
        title = "Filter"
    }
}

// MARK: - Setup table view

private extension PeopleFilterViewController {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterCell.self)
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .none
        tableView.selectRow(at: [defaultFilterElement, viewModel.filterIndex], animated: true, scrollPosition: .none)
    }
}

// MARK: - Setup layout

private extension PeopleFilterViewController {

    func setupSubviews() {
        view.addSubviews([tableView])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Back button

private extension PeopleFilterViewController {

    func setupBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: AppConstants.Images.back,
            style: .plain,
            target: self,
            action: #selector(dissmissModal)
        )
    }

    @objc func dissmissModal() {
        dismiss(animated: true)
    }
}

extension PeopleFilterViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Filters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FilterCell.self, for: indexPath)
        cell.configure(with: Filters.nameFor(indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filter = Filters.filterFor(indexPath) else { return }
        viewModel.onFilterTap(filter)
        dissmissModal()
    }
}
