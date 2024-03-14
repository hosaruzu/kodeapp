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

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        add()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func add() {
        addSubviews([tableView])
        tableView.backgroundColor = .systemBackground
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
