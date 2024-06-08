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
    private let personNameLabel = Title(font: AppConstants.Fonts.titleLarge)
    private let personRoleLabel = Title(font: AppConstants.Fonts.subtitle, color: AppConstants.Color.textSecondary)
    private let personTagLabel = Title(font: AppConstants.Fonts.body, color: AppConstants.Color.textTertiary)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setup(with id: String, name: String, tag: String, position: String) {
        personNameLabel.text = name
        personTagLabel.text = tag
        personRoleLabel.text = position

        Task {
           await personImageView.setImage(id, size: .big)
        }
    }
}

// MARK: - Setup layout

private extension TopView {

    func setupLayout() {
        let xStack = UIStackView(
            arrangedSubviews: [
                personNameLabel,
                personTagLabel
            ])
        xStack.axis = .horizontal
        xStack.alignment = .center
        xStack.spacing = Spec.Stacks.xStackSpacing

        let mainStack = UIStackView(
            arrangedSubviews: [
                personImageView,
                xStack,
                personRoleLabel
            ])
        mainStack.axis = .vertical
        mainStack.spacing = Spec.Stacks.mainStackSpacing
        mainStack.setCustomSpacing(Spec.Stacks.customSpacing, after: personImageView)
        mainStack.alignment = .center

        addSubviews([mainStack])
        NSLayoutConstraint.activate([
            personImageView.widthAnchor.constraint(equalToConstant: Spec.Image.width),
            personImageView.heightAnchor.constraint(equalToConstant: Spec.Image.height),

            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: - UI constants

private enum Spec {
    enum Stacks {
        static let xStackSpacing: CGFloat = 4
        static let mainStackSpacing: CGFloat = 12
        static let customSpacing: CGFloat = 24
    }

    enum Image {
        static let width: CGFloat = 104
        static let height: CGFloat = 104
    }
}
