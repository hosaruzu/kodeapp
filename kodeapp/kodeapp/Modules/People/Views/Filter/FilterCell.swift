//
//  FilterCell.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 28.05.2024.
//

import UIKit

final class FilterCell: UITableViewCell {

    // MARK: - Subviews

    let filterImageView: UIImageView = {
        let view = UIImageView()
        view.image = AppConstants.Images.radio
        view.contentMode = .scaleAspectFit
        return view
    }()

    let filterNameLabel: UILabel = {
        let view = UILabel()
        view.font = AppConstants.Fonts.title
        return view
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(with name: String) {
        filterNameLabel.text = name
    }
}

// MARK: - Setup subviews

private extension FilterCell {

    func setupSubviews() {
        contentView.addSubviews([
            filterImageView,
            filterNameLabel
        ])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            filterImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Spec.Image.vertical
            ),
            filterImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Spec.Image.vertical),
            filterImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Spec.Image.leading
            ),
            filterImageView.widthAnchor.constraint(equalToConstant: Spec.Image.widht),
            filterImageView.heightAnchor.constraint(equalToConstant: Spec.Image.height),

            filterNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            filterNameLabel.leadingAnchor.constraint(
                equalTo: filterImageView.trailingAnchor,
                constant: Spec.Label.leading
            ),
            filterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Image view selection toggle

extension FilterCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        filterImageView.image = selected ? AppConstants.Images.radioChecked : AppConstants.Images.radio
    }
}

// MARK: - UI Constants

private enum Spec {
    enum Image {
        static let vertical: CGFloat = 18
        static let leading: CGFloat = 24
        static let widht: CGFloat = 24
        static let height: CGFloat = 24
    }

    enum Label {
        static let leading: CGFloat = 18
    }
}
