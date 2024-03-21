//
//  ProfileTableViewCell.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 20.03.2024.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {

    // MARK: - Callbacks

    var onPhoneCellTap: (() -> Void)?

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

    func setup(image: UIImage, title: String, subtitle: String? = nil) {
        iconImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
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
