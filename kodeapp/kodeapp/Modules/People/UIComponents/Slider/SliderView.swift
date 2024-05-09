//
//  SliderView.swift
//  SlideTabs
//
//  Created by Artem Tebenkov on 08.05.2024.
//

import UIKit

final class SliderView: UIView {

    var onEndDragging: ((Int) -> Void)?
    var onRefresh: (() -> Void)?
    var onCellTap: ((Person) -> Void)?

    // MARK: - Subviews

    private(set) var collectionView: UICollectionView?

    private var viewModel: PeopleViewViewModel? {
        didSet {
            collectionView?.reloadData()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = initializeCollectionView()
        setupCollectionViewAppearance()
        setupCollectionViewDelegatesAndRegistrations()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func scrollToItem(at row: Int) {
        collectionView?.scrollToItem(at: [0, row], at: .centeredHorizontally, animated: true)
    }

    func configure(with viewModel: PeopleViewViewModel?) {
        self.viewModel = viewModel
    }
}

// MARK: - Initialize collection view

private extension SliderView {

    func makeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }

    func initializeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeFlowLayout())
        return collectionView
    }

    func setupCollectionViewAppearance() {
        guard let collectionView else { return }
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
    }

    func setupCollectionViewDelegatesAndRegistrations() {
        guard let collectionView else { return }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
    }
}

// MARK: - Setup subviews

private extension SliderView {

    func setupSubviews() {
        guard let collectionView else { return }
        addSubviews([collectionView])
    }

    func setupLayout() {
        guard let collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension SliderView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Categories.allValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CategoryCell.self, for: indexPath)
        cell.configure(with: viewModel)
        cell.onRefresh = onRefresh
        cell.onCellTap = onCellTap
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension SliderView: UICollectionViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offset = IndexPath(item: Int(targetContentOffset.pointee.x / frame.width), section: 0)
        onEndDragging?(offset.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SliderView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: bounds.width, height: frame.height)
    }
}
