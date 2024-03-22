//
//  ProfileTableView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 20.03.2024.
//

import UIKit

final class ProfileTableView: UIView {

    // MARK: - Callbacks

    var onPhoneCellTap: ((String) -> Void)?

    // MARK: - Subviews

    private let tableView = UITableView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstaints()
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Constants

//    private enum
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
        let cell = tableView.dequeue(ProfileTableViewCell.self, for: indexPath)
        switch indexPath.section {
        case 0:
            cell.setup(image: UIImage(resource: .favoriteIcon), title: "Birth date", subtitle: "28 years")
            return cell
        case 1:
          cell.setup(image: UIImage(resource: .phoneIcon), title: "980-962-6297")
            return cell
        default:
            break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 1:
            onPhoneCellTap?("980-962-6297")
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
