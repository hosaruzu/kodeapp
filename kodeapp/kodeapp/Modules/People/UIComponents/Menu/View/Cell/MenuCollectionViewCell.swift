//
//  MenuCollectionViewCell.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 04.05.2024.
//

import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {

    // MARK: - UI

    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    private let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        view.isHidden = true
        return view
    }()

    private var widthConstraint = NSLayoutConstraint()
    var leadingConstraint = NSLayoutConstraint()

    // MARK: - Properties

    override var isSelected: Bool {
        didSet {
            categoryNameLabel.textColor = isSelected ? .label : .secondaryLabel
            indicator.isHidden = !isSelected
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setCellCategory(_ name: String) {
        categoryNameLabel.text = name
    }
}

// MARK: - Setup subviews

private extension MenuCollectionViewCell {

    func setupSubviews() {
        contentView.addSubviews([categoryNameLabel, indicator])
        NSLayoutConstraint.activate([
            categoryNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            indicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            indicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            indicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
