//
//  PeopleTableView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 13.03.2024.
//

import UIKit

final class PeopleTableView: UIView {

    // MARK: - Callbacks

    var onRefresh: (() -> Void)?
    var onCellTap: (() -> Void)?

    // MARK: - Subviews

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()

    // MARK: - DEBUG

     private var data: [PersonTableViewCellViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupLayout()
        setupConstaints()
        setupRefreshControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

// MARK: - Setup TableView

private extension PeopleTableView {

    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PersonTableViewCell.self)
    }
}

// MARK: - Setup layout

private extension PeopleTableView {

    func setupLayout() {
        addSubviews([tableView])
    }

    func setupConstaints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Setup refresh control

private extension PeopleTableView {

    func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
    }

    @objc
    func onRefresh(_ sender: UIRefreshControl) {
        onRefresh?()
    }
}

// MARK: - UITableViewDataSource

extension PeopleTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(PersonTableViewCell.self, for: indexPath)
        cell.setup(with: data[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onCellTap?()
    }
}
