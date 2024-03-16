//
//  Loader.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 16.03.2024.
//

import UIKit

final class Loader: UIView {

    // MARK: - Subviews

    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI constants

    private enum UIConstants {
        static let loaderWidth: CGFloat = 100
        static let loaderHeight: CGFloat = 100
    }

    // MARK: - Public
    
    func start() {
        activityIndicator.startAnimating()
    }

    func stop() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - Setup subviews

private extension Loader {

    func setupSubviews() {
        addSubviews([activityIndicator])

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: UIConstants.loaderWidth),
            activityIndicator.heightAnchor.constraint(equalToConstant: UIConstants.loaderHeight)
        ])
    }
}
