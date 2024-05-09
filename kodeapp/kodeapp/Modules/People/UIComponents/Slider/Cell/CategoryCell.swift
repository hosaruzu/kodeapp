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

    // MARK: - View model

    private var viewModel: PeopleViewViewModel? {
        didSet {
            if let viewModel,
               viewModel.isLoaded {
                isLoading = false
                refreshControl.endRefreshing()
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

    func configure(with viewModel: PeopleViewViewModel?) {
        self.viewModel = viewModel
    }
}

// MARK: - Setup table view

private extension CategoryCell {

    func setupTableViewDelegatesAndRegistration() {
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
        contentView.addSubviews([tableView])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
        tableView.reloadData()
        isLoading = true
        onRefresh?()
    }
}

// MARK: - UITableViewDataSource

extension CategoryCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 9 : viewModel?.itemsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeue(SkeletonCell.self, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeue(PersonTableViewCell.self, for: indexPath)
            guard let viewModel = viewModel?.cellViewModelFor(indexPath) else { fatalError("No view model") }
            cell.setup(with: viewModel)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension CategoryCell: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let person = viewModel?.itemFor(indexPath),
           !isLoading {
            onCellTap?(person)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
}
