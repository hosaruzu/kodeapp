//
//  SkeletonCell.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 02.04.2024.
//

import UIKit

final class SkeletonCell: UITableViewCell, SkeletonLoadable {

    // MARK: - Subviews

    private let skeletonImageView = Avatar()
    private let skeletonTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "Skeleton Person Name"
        label.textColor = .clear
        return label
    }()
    private let skeletonSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Skeleton Role"
        label.textColor = .clear
        return label
    }()

    // MARK: - Layers

    private let skeletonImageLayer = CAGradientLayer()
    private let skeletonTitleLayer = CAGradientLayer()
    private let skeletonSubtitleLayer = CAGradientLayer()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSublayers()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIConstants

    private enum UIConstants {
        static let nameToTagOffset: CGFloat = 4
        static let nameToRoleOffset: CGFloat = 3
        static let imageToNameOffset: CGFloat = 16

        static let contentVerticalOffset: CGFloat = 6
        static let contentHorizontalOffset: CGFloat = 16

        static let imageWidth: CGFloat = 72
        static let imageHeight: CGFloat = 72
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        setupSublayersLayout()
    }

    private func setupSublayersLayout() {
        skeletonImageLayer.frame = skeletonImageView.bounds
        skeletonImageLayer.cornerRadius = skeletonImageView.bounds.height / 2

        skeletonTitleLayer.frame = skeletonTitleLabel.bounds
        skeletonTitleLayer.cornerRadius = skeletonTitleLabel.bounds.height / 2

        skeletonSubtitleLayer.frame = skeletonSubtitleLabel.bounds
        skeletonSubtitleLayer.cornerRadius = skeletonSubtitleLabel.bounds.height / 2
    }

    private func setupSublayers() {
        skeletonImageLayer.startPoint = CGPoint(x: 0, y: 0.5)
        skeletonImageLayer.endPoint = CGPoint(x: 1, y: 0.5)
        skeletonImageView.layer.addSublayer(skeletonImageLayer)

        skeletonTitleLayer.startPoint = CGPoint(x: 0, y: 0.5)
        skeletonTitleLayer.endPoint = CGPoint(x: 1, y: 0.5)
        skeletonTitleLabel.layer.addSublayer(skeletonTitleLayer)

        skeletonSubtitleLayer.startPoint = CGPoint(x: 0, y: 0.5)
        skeletonSubtitleLayer.endPoint = CGPoint(x: 1, y: 0.5)
        skeletonSubtitleLabel.layer.addSublayer(skeletonSubtitleLayer)

        let imageGroup = makeAnimationGroup()
        imageGroup.beginTime = 0.0
        skeletonImageLayer.add(imageGroup, forKey: "backgroundColor")

        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        skeletonTitleLayer.add(titleGroup, forKey: "backgroundColor")

        let subtitleGroup = makeAnimationGroup()
        subtitleGroup.beginTime = 0.0
        skeletonSubtitleLayer.add(subtitleGroup, forKey: "backgroundColor")
    }

    func setupLayout() {
        let nameRoleStack = UIStackView(arrangedSubviews: [
            skeletonTitleLabel,
            skeletonSubtitleLabel
        ])
        nameRoleStack.axis = .vertical
        nameRoleStack.spacing = UIConstants.nameToRoleOffset
        nameRoleStack.alignment = .leading

        let cellStack = UIStackView(arrangedSubviews: [
            skeletonImageView,
            nameRoleStack
        ])

        cellStack.axis = .horizontal
        cellStack.spacing = UIConstants.imageToNameOffset
        cellStack.alignment = .center

        contentView.addSubviews([
            cellStack
        ])

        NSLayoutConstraint.activate([
            skeletonImageView.widthAnchor.constraint(equalToConstant: UIConstants.imageWidth),
            skeletonImageView.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight),

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
