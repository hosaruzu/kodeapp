//
//  CategoryCell.swift
//  SlideTabs
//
//  Created by Artem Tebenkov on 08.05.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {

    // MARK: - Callbacks

    var onRefresh: (() -> Void)?
    var onCellTap: ((Person) -> Void)?

    // MARK: - Skeleton loading toggle

    private var isLoading = true {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Subviews

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let emptyStateView = EmptyStateView()

    // MARK: - View model

    private var viewModel: PeopleViewViewModel? {
        didSet {
            if let viewModel,
               viewModel.isLoaded {
                isLoading = false
                refreshControl.endRefreshing()
                tableView.bounces = !viewModel.inSearchMode
            }
        }
    }

    private var category: Departments = .all {
        didSet {
            if let viewModel {
                if viewModel.categorizedPeopleIsEmpty(category) {
                    emptyStateView.show()
                    tableView.isHidden = true
                } else {
                    emptyStateView.hide()
                    tableView.isHidden = false
                }
            }
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableViewDelegatesAndRegistration()
        setupRefreshControl()
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(with viewModel: PeopleViewViewModel?, category: Departments) {
        self.viewModel = viewModel
        self.category = category
        tableView.reloadData()
    }
}

// MARK: - Setup table view

private extension CategoryCell {

    func setupTableViewDelegatesAndRegistration() {
        tableView.contentInset = Spec.TableView.contentOffset
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PersonTableViewCell.self)
        tableView.register(SkeletonCell.self)
    }
}

// MARK: - Setup subviews

private extension CategoryCell {

    func setupSubviews() {
        contentView.addSubviews([tableView, emptyStateView])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            emptyStateView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emptyStateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spec.EmptyStateView.top)
        ])
    }
}

// MARK: - Setup refresh control

private extension CategoryCell {
    func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
    }

    @objc
    func onRefresh(_ sender: UIRefreshControl) {
        guard let viewModel else { return }
        if !viewModel.inSearchMode {
            isLoading = true
            onRefresh?()
        }
    }

}

// MARK: - UITableViewDataSource

extension CategoryCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return Spec.Cell.amount }
        return viewModel.itemsCount(for: category, inSearchMode: viewModel.inSearchMode) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeue(SkeletonCell.self, for: indexPath)
            return cell
        } else {
            guard let viewModel,
                  let cellViewModel = viewModel.cellViewModelFor(
                    indexPath,
                            department: category,
                    inSearchMode: viewModel.inSearchMode)
            else {
                fatalError("Can't make cellViewModel")
            }
            let cell = tableView.dequeue(PersonTableViewCell.self, for: indexPath)
            cell.setup(with: cellViewModel)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension CategoryCell: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let inSearchMode = viewModel?.inSearchMode else { return }
        if let person = viewModel?.itemFor(
            indexPath, department: category,
            inSearchMode: inSearchMode),
           !isLoading {
            onCellTap?(person)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Spec.Cell.height
    }
}

// MARK: - UI constants

private enum Spec {
    enum TableView {
        static let contentOffset: UIEdgeInsets = .init(top: 16, left: 0, bottom: 0, right: 0)
        static let tableViewCellHeight: CGFloat = 84
        static let numberOfShimmerCells: Int = 9
    }

    enum Cell {
        static let height: CGFloat = 84
        static let amount: Int = 9
    }

    enum EmptyStateView {
        static let top: CGFloat = 80
    }
}
