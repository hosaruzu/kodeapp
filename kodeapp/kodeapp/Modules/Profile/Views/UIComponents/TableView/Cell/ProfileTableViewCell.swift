//
//  ProfileTableViewCell.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 20.03.2024.
//

import UIKit

enum CellType {
    case birthDay
    case phone
}

final class ProfileTableViewCell: UITableViewCell {

    // MARK: - Subviews

    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.title
        label.textColor = AppConstants.Color.textPrimary
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.title
        label.textColor = AppConstants.Color.textSecondary
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        iconImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }

    // MARK: - Public

    func setup(type: CellType, title: String, subtitle: String? = nil) {
        titleLabel.text = title
        switch type {
        case .birthDay:
            iconImageView.image = AppConstants.Images.favorite
            iconImageView.tintColor = AppConstants.Color.textPrimary
            subtitleLabel.text = subtitle
            selectionStyle = .none
            isUserInteractionEnabled = false

        case .phone:
            iconImageView.image = AppConstants.Images.phone
            iconImageView.tintColor = AppConstants.Color.textPrimary
        }
    }
}

// MARK: - Setup layout

private extension ProfileTableViewCell {
    func setupSubviews() {
        contentView.addSubviews([
            iconImageView,
            titleLabel,
            subtitleLabel
        ])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Spec.Icon.leading),
            iconImageView.widthAnchor.constraint(equalToConstant: Spec.Icon.width),
            iconImageView.heightAnchor.constraint(equalToConstant: Spec.Icon.height),

            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: Spec.Title.leading),

            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Spec.Subtitle.trailing)
        ])
    }
}

private enum Spec {
    enum Icon {
        static let leading: CGFloat = 16
        static let width: CGFloat = 24
        static let height: CGFloat = 24
    }

    enum Title {
        static let leading: CGFloat = 12
    }

    enum Subtitle {
        static let trailing: CGFloat = -16
    }
}
