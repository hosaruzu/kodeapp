//
//  MenuView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 04.05.2024.
//

import UIKit

final class MenuView: UIView {

    // MARK: - UI

    private let menuCollectionView = MenuCollectionView()
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        return view
    }()
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiaryLabel
        return view
    }()

    // MARK: - Constraints

    private var widthConstraint = NSLayoutConstraint()
    private var leadingConstraint = NSLayoutConstraint()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        menuCollectionView.movableDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup subviews

private extension MenuView {

    func addSubviews() {
        addSubviews([
            menuCollectionView,
            bottomView,
            indicatorView
        ])
    }

    func setupConstraints() {
        let initialWidth = Categories.allCases[0].rawValue.defineWidth()
        widthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: initialWidth + 24)
        widthConstraint.isActive = true

        leadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingConstraint.isActive = true

        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: topAnchor),
            menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            bottomView.bottomAnchor.constraint(equalTo: menuCollectionView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 0.33),

            indicatorView.bottomAnchor.constraint(equalTo: menuCollectionView.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}

// MARK: - MenuMovable

extension MenuView: MenuMovable {

    func animateIndicatorView(originX: CGFloat, width: CGFloat) {
        leadingConstraint.constant = originX
        widthConstraint.constant = width
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    func move(originX: CGFloat, width: CGFloat) {
        animateIndicatorView(originX: originX, width: width)
    }
}
