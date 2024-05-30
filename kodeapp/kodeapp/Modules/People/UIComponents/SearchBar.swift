//
//  SearchBar.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 14.03.2024.
//

import UIKit

final class SearchBar: UISearchBar {

    // MARK: - Public properties

    var filterState: Filters = .standart {
        didSet {
            changeFilterIconColor(with: filterState)
        }
    }

    var isSearching = false {
        didSet {
            changeSearchIconColor()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBar()
        setupTextField()
        setupSearchIcon()
        setupClearButton()
        setupFilterButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup bar

    private func setupBar() {
        searchBarStyle = .minimal
    }

    // MARK: - Setup text field

    private func setupTextField() {
        searchTextField.layer.cornerRadius = 16
        searchTextField.clipsToBounds = true
        searchTextPositionAdjustment = .init(horizontal: 8, vertical: 0)
        tintColor = .accent
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search name, tag...",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.tertiaryLabel
            ])
    }

    // MARK: - Setup icons

    private func setupSearchIcon() {
        setImage(AppConstants.Images.searchNormal, for: .search, state: .normal)
        setPositionAdjustment(.init(horizontal: 10, vertical: 0), for: .search)

    }

    private func setupClearButton() {
        setImage(AppConstants.Images.clearTextField, for: .clear, state: .normal)
        setPositionAdjustment(.init(horizontal: -10, vertical: 0), for: .clear)
    }

    private func setupFilterButton() {
        showsBookmarkButton = true
        setPositionAdjustment(.init(horizontal: -10, vertical: 0), for: .bookmark)
        setImage(AppConstants.Images.filterNormal, for: .bookmark, state: .normal)
    }

    // MARK: - Setup icons changing 

    private func changeFilterIconColor(with state: Filters) {
        switch state {
        case .standart:
            setImage(AppConstants.Images.filterNormal, for: .bookmark, state: .normal)
        case .ascending:
            setImage(AppConstants.Images.filterCheckedAscending, for: .bookmark, state: .normal)
        case .descending:
            setImage(AppConstants.Images.filterCheckedDescending, for: .bookmark, state: .normal)
        }
    }

    private func changeSearchIconColor() {
        if isSearching {
            setImage(AppConstants.Images.searchChecked, for: .search, state: .normal)
        } else {
            setImage(AppConstants.Images.searchNormal, for: .search, state: .normal)
        }
    }

    // MARK: - Public methods

    func showCancelButton() {
        setShowsCancelButton(true, animated: true)
    }

    func hideCancelButton() {
        setShowsCancelButton(false, animated: true)
    }

    func didEndEditing() {
        endEditing(true)
        text = ""
    }
}
