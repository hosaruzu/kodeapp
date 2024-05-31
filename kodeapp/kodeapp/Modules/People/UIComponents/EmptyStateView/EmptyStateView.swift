//
//  EmptyStateView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 31.05.2024.
//

import UIKit

final class EmptyStateView: UIView {

    // MARK: - Subviews

    private let emptyImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .init(resource: .magnyfyingGlass)
        return image
    }()

    private let emptyTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.text = "We didn't find anyone"
        return label
    }()

    private let emptySubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Try adjusting the query"
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVStack()
        hide()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func show() {
        UIView.animate(withDuration: 0.3) { [self] in
            isHidden = false
            layer.opacity = 1
        }

    }

    func hide() {
        UIView.animate(withDuration: 0.3) { [self] in
            isHidden = true
            layer.opacity = 0
        }
    }
}

// MARK: - Setup layout

private extension EmptyStateView {

    func setupVStack() {
        let vStack = UIStackView(arrangedSubviews: [emptyImageView, emptyTitleLabel, emptySubtitleLabel])
        vStack.axis = .vertical
        vStack.spacing = Spec.vStackDefaultSpacing
        vStack.setCustomSpacing(Spec.titleToSubtitleSpacing, after: emptyTitleLabel)
        vStack.alignment = .center

        addSubviews([vStack])
        NSLayoutConstraint.activate([
            emptyImageView.widthAnchor.constraint(equalToConstant: Spec.imageViewWidth),
            emptyImageView.heightAnchor.constraint(equalToConstant: Spec.imageViewHeight),

            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private enum Spec {
    static let imageViewWidth: CGFloat = 56
    static let imageViewHeight: CGFloat = 56
    static let vStackDefaultSpacing: CGFloat = 8
    static let titleToSubtitleSpacing: CGFloat = 12
}
