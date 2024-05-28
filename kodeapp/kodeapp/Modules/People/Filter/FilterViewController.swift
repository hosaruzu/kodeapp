//
//  FilterViewController.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 24.05.2024.
//

import UIKit

final class FilterViewController: UIViewController {

    // MARK: - View model

    private let viewModel: PeopleViewViewModel

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

private extension FilterViewController {

    func setupAppearance() {
        view.backgroundColor = .systemBackground
        title = "Filter"
    }
}

// MARK: - Setup table view

private extension FilterViewController {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterCell.self)
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .none
//        tableView.selectRow(at: <#T##IndexPath?#>, animated: <#T##Bool#>, scrollPosition: <#T##UITableView.ScrollPosition#>)
    }
}

// MARK: - Setup layout

private extension FilterViewController {

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

private extension FilterViewController {

    func setupBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .backIcon,
            style: .plain,
            target: self,
            action: #selector(dissmissModal)
        )
    }

    @objc func dissmissModal() {
        dismiss(animated: true)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Filters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FilterCell.self, for: indexPath)
        cell.configure(with: Filters.nameFor(indexPath))
        return cell
    }
}
