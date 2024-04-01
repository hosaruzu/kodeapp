//
//  ProfileTableView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 20.03.2024.
//

import UIKit

final class ProfileTableView: UIView {

    // MARK: - Callbacks

    var onPhoneCellTap: (() -> Void)?

    // MARK: - Subviews

    private let tableView = UITableView()

    // MARK: - View model

    private var viewModel: ProfileTableViewViewModel?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstaints()
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with viewModel: ProfileTableViewViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Setup layout

private extension ProfileTableView {

    func setupSubviews() {
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

// MARK: - Setup TableView

private extension ProfileTableView {

    func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ProfileTableView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel else { return UITableViewCell() }
        let cell = tableView.dequeue(ProfileTableViewCell.self, for: indexPath)
        switch indexPath.section {
        case 0:
            cell.setup(type: .birthDay, title: viewModel.birthday, subtitle: viewModel.age)
            return cell
        case 1:
            cell.setup(type: .phone, title: viewModel.phone)
            return cell
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            tableView.deselectRow(at: indexPath, animated: true)
            onPhoneCellTap?()
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
