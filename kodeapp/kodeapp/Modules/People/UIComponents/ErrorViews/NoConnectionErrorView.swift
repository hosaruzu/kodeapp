//
//  NoConnectionErrorView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 05.06.2024.
//

import UIKit

final class NoConnectionErrorView: UIView {

    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = """
        Can't update data.
        Check your internet connection.
        """
        return label
    }()

    private var constraintContainerTop: NSLayoutConstraint?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func show() {
        animate(.show)
    }

    func hide() {
        animate(.hide)
    }
}

// MARK: - Setup view

private extension NoConnectionErrorView {

    func setupAppearance() {
        backgroundColor = .clear
    }

    func setupSubviews() {
        addSubviews([containerView, errorLabel])
    }

    func setupConstraints() {
        constraintContainerTop = containerView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Spec.Animation.topOffScreenOffset
        )
        constraintContainerTop?.isActive = true

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: Spec.containerViewHeight),

            errorLabel.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: Spec.errorLabelBottomOffset
            ),
            errorLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Spec.errorLabelLeadingOffset
            )
        ])
    }
}

// MARK: - Setup animation

private extension NoConnectionErrorView {

    private func animate(_ direction: AnimationDirection) {
        let duration = Spec.Animation.animationDuration
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            switch direction {
            case .show:
                self.constraintContainerTop?.constant = Spec.Animation.topOnScreenOffset
            case .hide:
                self.constraintContainerTop?.constant = Spec.Animation.topOffScreenOffset
            }
            self.layoutIfNeeded()
        }
        animator.startAnimation()
    }
}

private enum Spec {

    static let containerViewHeight: CGFloat = 120
    static let errorLabelBottomOffset: CGFloat = -12
    static let errorLabelLeadingOffset: CGFloat = 24

    enum Animation {
        static let animationDuration: Double = 0.8
        static let topOnScreenOffset: CGFloat = 0
        static let topOffScreenOffset: CGFloat = -1000
    }
}

private enum AnimationDirection {
    case show
    case hide
}
