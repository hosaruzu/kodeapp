//
//  ProfileViewController.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 19.03.2024.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - View model

    private let viewModel: ProfileViewViewModel

    // MARK: - Subviews

    private let topView = TopView()
    private let tableView = ProfileTableView()

    // MARK: - Init

    init(viewModel: ProfileViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private enum UIConstants {
        static let topViewToSafeAreaOffset: CGFloat = -24
        static let topViewHeightMultiplier: CGFloat = 4
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupSubviews()
        setupConstraints()
        setup(with: viewModel)
        tableView.onPhoneCellTap = { [weak self] in
            self?.viewModel.onPhoneCellTap()
        }
    }

    private func setup(with viewModel: ProfileViewViewModel) {
        topView.setup(with: viewModel.id, name: viewModel.name, tag: viewModel.tag, position: viewModel.position)
        tableView.setup(with: viewModel.tableViewModel)
    }
}

// MARK: - Setup Appearance

private extension ProfileViewController {

    func setupAppearance() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Setup layout

private extension ProfileViewController {

    func setupSubviews() {
        view.addSubviews([
            topView,
            tableView
        ])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: UIConstants.topViewToSafeAreaOffset),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(
                equalToConstant: view.bounds.height / UIConstants.topViewHeightMultiplier),

            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
