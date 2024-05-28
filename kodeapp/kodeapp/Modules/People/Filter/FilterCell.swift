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
        view.image = .radioUnchecked
        view.contentMode = .scaleAspectFit
        return view
    }()

    let filterNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .medium)
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
                constant: Spec.filterVerticalOffset
            ),
            filterImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Spec.filterVerticalOffset),
            filterImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Spec.filterImageLeadingOffset
            ),
            filterImageView.widthAnchor.constraint(equalToConstant: Spec.filterImageWidht),
            filterImageView.heightAnchor.constraint(equalToConstant: Spec.filterImageHeight),

            filterNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            filterNameLabel.leadingAnchor.constraint(
                equalTo: filterImageView.trailingAnchor,
                constant: Spec.filterNameLabelLeadingOffset
            ),
            filterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Image view selection toggle

extension FilterCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        filterImageView.image = selected ? .radioChecked : .radioUnchecked
    }
}

// MARK: - UI Constants

private enum Spec {

    static let filterVerticalOffset: CGFloat = 18
    static let filterImageWidht: CGFloat = 24
    static let filterImageHeight: CGFloat = 24
    static let filterNameLabelLeadingOffset: CGFloat = 18
    static let filterImageLeadingOffset: CGFloat = 24
}
