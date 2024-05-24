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
    }
}

// MARK: - Setup appearance

private extension FilterViewController {

    func setupAppearance() {
        view.backgroundColor = .systemBackground
        title = "Filter"
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
