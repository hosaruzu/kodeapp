//
//  ErrorView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 05.06.2024.
//
import UIKit

final class ErrorView: UIView {

    // MARK: - Callbacks

    var onButtonTap: (() -> Void)?

    // MARK: - Subviews

    private let errorImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .init(resource: .error)
        return image
    }()

    private let errorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.text = "Some super-intelligence broke everything"
        return label
    }()

    private let errorSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "We'll try to fix it quickly"
        return label
    }()

    private let errorButton: UIButton = {
        let button = UIButton(type: .system)
        let text = NSAttributedString(
            string: "Try again",
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)])
        button.setAttributedTitle(text, for: .normal)
        button.setTitleColor(.accent, for: .normal)
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVStack()
        setupButtonAction()
        hide()
        backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func show() {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = false
            self.alpha = 1
        }

    }

    func hide() {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = true
            self.alpha = 0
        }
    }
}

// MARK: - Setup layout

private extension ErrorView {

    func setupVStack() {
        let vStack = UIStackView(arrangedSubviews: [errorImageView, errorTitleLabel, errorSubtitleLabel, errorButton])
        vStack.axis = .vertical
        vStack.spacing = Spec.vStackDefaultSpacing
        vStack.setCustomSpacing(Spec.imageToTitleOffset, after: errorImageView)
        vStack.alignment = .center

        addSubviews([vStack])
        NSLayoutConstraint.activate([
            errorImageView.widthAnchor.constraint(equalToConstant: Spec.imageViewWidth),
            errorImageView.heightAnchor.constraint(equalToConstant: Spec.imageViewHeight),

            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - Setup button

private extension ErrorView {

    func setupButtonAction() {
        errorButton.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
    }

    @objc
    func buttonTap(_ sender: UIButton) {
        onButtonTap?()
    }
}

// MARK: - UI constants

private enum Spec {
    static let imageViewWidth: CGFloat = 56
    static let imageViewHeight: CGFloat = 56
    static let vStackDefaultSpacing: CGFloat = 12
    static let imageToTitleOffset: CGFloat = 8
}
