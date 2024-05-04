//
//  MenuCollectionView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 04.05.2024.
//

import UIKit

protocol MenuMovable: AnyObject {
    func move(originX: CGFloat, width: CGFloat)
}

final class MenuCollectionView: UICollectionView {

    private let flowLayout = UICollectionViewFlowLayout()

    // MARK: - MenuMovable

    weak var movableDelegate: MenuMovable?

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
        isScrollEnabled = false
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
        UIView.animate(withDuration: 0.4) {
            self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let cellRect = attributes.frame
        let cellFrameInSuperView = collectionView.convert(cellRect, to: collectionView.superview)
        movableDelegate?.move(originX: cellFrameInSuperView.origin.x, width: cellFrameInSuperView.width)
    }

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

// MARK: -

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
