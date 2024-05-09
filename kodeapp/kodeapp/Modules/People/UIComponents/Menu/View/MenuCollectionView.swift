//
//  MenuCollectionView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 04.05.2024.
//

import UIKit

protocol SectionChangable: AnyObject {
    func moveTo(_ section: Int)
}

final class MenuCollectionView: UICollectionView {

    var onSectionChange: ((Int) -> Void)?

    private let flowLayout = UICollectionViewFlowLayout()

    // MARK: - SectionChangable

    weak var sectionChangable: SectionChangable?

    // MARK: - Init

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupDelegates()
        setupCollectionView()
        setupFlowLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension MenuCollectionView {

    func setupDelegates() {
        dataSource = self
        delegate = self
        register(MenuCollectionViewCell.self)
    }

    func setupCollectionView() {
        backgroundColor = .none
        bounces = false
        showsHorizontalScrollIndicator = false
        selectItem(at: [0, 0], animated: false, scrollPosition: [])
    }

    func setupFlowLayout() {
        flowLayout.scrollDirection = .horizontal
    }
}

// MARK: - UICollectionViewDataSource

extension MenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Categories.allValues.count
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

extension MenuCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        onSectionChange?(indexPath.row)
        self.sectionChangable?.moveTo(indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = Categories.category(for: indexPath).defineWidth()
        return CGSize(width: width + 24, height: collectionView.frame.height)
    }
}
