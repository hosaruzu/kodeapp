//
//  MenuView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 04.05.2024.
//

import UIKit

final class MenuView: UIView {

    var onSectionChange: ((Int) -> Void)?

    // MARK: - UI

    private(set) var collectionView: UICollectionView?

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiaryLabel
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = initializeCollectionView()
        setupCollectionViewDelegatesAndRegistrations()
        setupCollectionViewAppearance()
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func selectItem(at row: Int) {
        collectionView?.selectItem(at: [0, row], animated: true, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - Setup collection view

private extension MenuView {

    func makeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }

    func initializeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeFlowLayout())
        return collectionView
    }

    func setupCollectionViewAppearance() {
        guard let collectionView else { return }
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.selectItem(at: [0, 0], animated: false, scrollPosition: [])
    }

    func setupCollectionViewDelegatesAndRegistrations() {
        guard let collectionView else { return }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCollectionViewCell.self)
    }
}

// MARK: - Setup subviews

private extension MenuView {

    func addSubviews() {
        guard let collectionView else { return }
        addSubviews([
            collectionView,
            bottomView
        ])
    }

    func setupLayout() {
        guard let collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            bottomView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 0.33)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension MenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Categories.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(MenuCollectionViewCell.self, for: indexPath)
        cell.setCellCategory(Categories.category(for: indexPath))
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        onSectionChange?(indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = Categories.category(for: indexPath).defineWidth()
        return CGSize(width: width + 24, height: collectionView.frame.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 0)
    }

    // For prevent menu cell sliding from bottom on displaying

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        MenuCollectionViewCell.performWithoutAnimation {
            cell.layoutIfNeeded()
        }
    }
}
