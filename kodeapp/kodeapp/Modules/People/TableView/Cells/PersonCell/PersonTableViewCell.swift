//
//  PersonTableViewCell.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 13.03.2024.
//

import UIKit

final class PersonTableViewCell: UITableViewCell {

    // MARK: - Subviews

    private let personImageView = Avatar()
    private let personNameLabel = Title(font: UIConstants.nameFont)
    private let personRoleLabel = Title(font: UIConstants.roleFont, color: .secondaryLabel)
    private let personTagLabel = Title(font: UIConstants.tagFont, color: .tertiaryLabel)

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        personImageView.image = .imagePlaceholder
        personNameLabel.text = nil
        personRoleLabel.text = nil
        personTagLabel.text = nil
    }

    // MARK: - UIConstants

    private enum UIConstants {
        static let nameFont: UIFont = .systemFont(ofSize: 16, weight: .medium)
        static let roleFont: UIFont = .systemFont(ofSize: 13)
        static let tagFont: UIFont = .systemFont(ofSize: 14, weight: .medium)

        static let nameToTagOffset: CGFloat = 4
        static let nameToRoleOffset: CGFloat = 3
        static let imageToNameOffset: CGFloat = 16

        static let contentVerticalOffset: CGFloat = 6
        static let contentHorizontalOffset: CGFloat = 16
    }

    // MARK: - Public

    func setup(with model: PersonTableViewCellViewModel) {
        personTagLabel.text = model.tag
        personNameLabel.text = model.name
        personRoleLabel.text = model.role
    }
}

// MARK: - Setup subviews

private extension PersonTableViewCell {

    func setupLayout() {
        let nameTagStack = UIStackView(arrangedSubviews: [
            personNameLabel,
            personTagLabel
        ])
        nameTagStack.axis = .horizontal
        nameTagStack.alignment = .bottom
        nameTagStack.spacing = UIConstants.nameToTagOffset

        let nameRoleStack = UIStackView(arrangedSubviews: [
            nameTagStack,
            personRoleLabel
        ])
        nameRoleStack.axis = .vertical
        nameRoleStack.spacing = UIConstants.nameToRoleOffset
        nameRoleStack.alignment = .leading

        let cellStack = UIStackView(arrangedSubviews: [
            personImageView,
            nameRoleStack
        ])

        cellStack.axis = .horizontal
        cellStack.spacing = UIConstants.imageToNameOffset
        cellStack.alignment = .center

        contentView.addSubviews([
            cellStack
        ])

        NSLayoutConstraint.activate([
            cellStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIConstants.contentVerticalOffset),
            cellStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: UIConstants.contentHorizontalOffset),
            cellStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -UIConstants.contentHorizontalOffset),
            cellStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -UIConstants.contentVerticalOffset)
        ])
    }
}
