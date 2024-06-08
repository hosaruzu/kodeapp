//
//  PersonTableViewCell.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 13.03.2024.
//

import UIKit

final class PersonTableViewCell: UITableViewCell {

    // MARK: - Task for cancelation

    private var downloadTask: (Task<Void, Never>)?

    // MARK: - Subviews

    private let personImageView = Avatar()
    private let loader = LoaderView()
    private let personNameLabel = Title(font: AppConstants.Fonts.title)
    private let personRoleLabel = Title(
        font: AppConstants.Fonts.body,
        color: AppConstants.Color.textPrimary)
    private let personTagLabel = Title(
        font: AppConstants.Fonts.bodyLarge,
        color: AppConstants.Color.textTertiary)

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        downloadTask?.cancel()
        loader.start()
        personImageView.image = nil
        personNameLabel.text = nil
        personRoleLabel.text = nil
        personTagLabel.text = nil
    }

    // MARK: - Public

    func setup(with viewModel: PersonTableViewCellViewModel) {
        personTagLabel.text = viewModel.personTag
        personNameLabel.text = viewModel.fullName
        personRoleLabel.text = viewModel.personPosition

        downloadTask = Task {
            await self.personImageView
                .setImage(
                    viewModel.personId,
                    size: .big,
                    indicator: loader)
        }
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
        nameTagStack.spacing = Spec.Stacks.nameToTagOffset

        let nameRoleStack = UIStackView(arrangedSubviews: [
            nameTagStack,
            personRoleLabel
        ])
        nameRoleStack.axis = .vertical
        nameRoleStack.spacing = Spec.Stacks.nameToRoleOffset
        nameRoleStack.alignment = .leading

        let cellStack = UIStackView(arrangedSubviews: [
            personImageView,
            nameRoleStack
        ])

        cellStack.axis = .horizontal
        cellStack.spacing = Spec.Stacks.spacing
        cellStack.alignment = .center

        contentView.addSubviews([
            cellStack,
            loader
        ])

        NSLayoutConstraint.activate([
            loader.widthAnchor.constraint(equalToConstant: Spec.Loader.width),
            loader.heightAnchor.constraint(equalToConstant: Spec.Loader.height),
            loader.centerYAnchor.constraint(equalTo: personImageView.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: personImageView.centerXAnchor),
            personImageView.widthAnchor.constraint(equalToConstant: Spec.Image.width),
            personImageView.heightAnchor.constraint(equalToConstant: Spec.Image.height),

            cellStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Spec.Stacks.vertical),
            cellStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Spec.Stacks.horizontal),
            cellStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Spec.Stacks.horizontal),
            cellStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Spec.Stacks.vertical)
        ])
    }
}

// MARK: - UI constants

private enum Spec {
    enum Stacks {
        static let vertical: CGFloat = 6
        static let horizontal: CGFloat = 16
        static let spacing: CGFloat = 16
        static let nameToTagOffset: CGFloat = 4
        static let nameToRoleOffset: CGFloat = 3
    }

    enum Loader {
        static let width: CGFloat = 72
        static let height: CGFloat = 72
    }

    enum Image {
        static let width: CGFloat = 72
        static let height: CGFloat = 72
    }
}
