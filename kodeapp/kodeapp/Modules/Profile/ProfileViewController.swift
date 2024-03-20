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

    // MARK: - Init

    init(viewModel: ProfileViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.backButtonTitle = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
    }
}
