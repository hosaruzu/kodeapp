//
//  LoaderView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 01.04.2024.
//

import UIKit

protocol Loadable {

    func start()
    func stop()
}

final class LoaderView: UIView, Loadable {

    // MARK: - Subview

    private let activityIndicator = UIActivityIndicatorView()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setup()
        start()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        activityIndicator.color = .accent
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        addSubviews([activityIndicator])
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // MARK: - Public

    func start() {
        activityIndicator.startAnimating()
    }

    func stop() {
        activityIndicator.stopAnimating()
    }

}
