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
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .tertiaryLabel
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
        switch type {
        case .birthDay:
            iconImageView.image = UIImage(resource: .favoriteIcon)
            titleLabel.text = title
            subtitleLabel.text = subtitle
            selectionStyle = .none
            isUserInteractionEnabled = false
        case .phone:
            iconImageView.image = UIImage(resource: .phoneIcon)
            titleLabel.text = title.formatToPhoneNumber()
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
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),

            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
