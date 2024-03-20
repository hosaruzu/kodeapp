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

    // MARK: - Init

    init(viewModel: ProfileViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.isNavigationBarHidden = false

        view.addSubviews([topView])
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -24),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: view.bounds.height / 4)
        ])
    }
}
