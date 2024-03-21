//
//  TopView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 20.03.2024.
//

import UIKit

final class TopView: UIView {

    // MARK: - Subviews

    private let personImageView = Avatar()
    private let personNameLabel = Title(font: UIConstants.nameFont)
    private let personRoleLabel = Title(
        font: UIConstants.roleFont,
        color: AppConstants.Color.textSecondary)
    private let personTagLabel = Title(
        font: UIConstants.tagFont,
        color: AppConstants.Color.textTertiary)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setup() {
        personNameLabel.text = "Person name"
        personTagLabel.text = "Tag"
        personRoleLabel.text = "Role"
    }

    // MARK: - UI constants

    private enum UIConstants {
        static let nameFont: UIFont = .systemFont(ofSize: 24, weight: .bold)
        static let roleFont: UIFont = .systemFont(ofSize: 13, weight: .regular)
        static let tagFont: UIFont = .systemFont(ofSize: 17, weight: .regular)
    }
}

private extension TopView {

    func setupLayout() {
        let xStack = UIStackView(
            arrangedSubviews: [
                personNameLabel,
                personTagLabel
            ])
        xStack.axis = .horizontal
        xStack.alignment = .center
        xStack.spacing = 4

        let mainStack = UIStackView(
            arrangedSubviews: [
                personImageView,
                xStack,
                personRoleLabel
            ])
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.setCustomSpacing(24, after: personImageView)
        mainStack.alignment = .center

        addSubviews([mainStack])
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
