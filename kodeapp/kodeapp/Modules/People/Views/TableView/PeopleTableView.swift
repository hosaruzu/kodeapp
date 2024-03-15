//
//  PeopleTableView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 13.03.2024.
//

import UIKit

final class PeopleTableView: UIView {

    // MARK: - Subviews
    private let tableView = UITableView()

    // MARK: - DEBUG

    private let data: [PersonTableViewCellViewModel] = [
        .init(name: "Person", role: "role", tag: "pr"),
        .init(name: "Person", role: "role", tag: "pr"),
        .init(name: "Person", role: "role", tag: "pr"),
        .init(name: "Person", role: "role", tag: "pr")
    ]

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupLayout()
        setupConstaints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup TableView

private extension PeopleTableView {

    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: "cell")
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

// MARK: - UITableViewDataSource

extension PeopleTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PersonTableViewCell else { fatalError() }
        cell.setup(with: data[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
