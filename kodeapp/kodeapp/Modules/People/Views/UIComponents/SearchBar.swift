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
        searchTextField.layer.cornerRadius = Spec.TextField.cornerRadius
        searchTextField.clipsToBounds = true
        searchTextPositionAdjustment = Spec.TextField.textPositionAdjustment
        tintColor = AppConstants.Color.accent
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search name, tag...",
            attributes: [
                .font: AppConstants.Fonts.title,
                .foregroundColor: AppConstants.Color.textTertiary
            ])
    }

    // MARK: - Setup icons

    private func setupSearchIcon() {
        setImage(AppConstants.Images.search, for: .search, state: .normal)
        setPositionAdjustment(Spec.SearchIcon.positionAdjustment, for: .search)

    }

    private func setupClearButton() {
        setImage(AppConstants.Images.clearTextField, for: .clear, state: .normal)
        setPositionAdjustment(Spec.ClearButton.positionAdjustment, for: .clear)
    }

    private func setupFilterButton() {
        showsBookmarkButton = true
        setPositionAdjustment(Spec.FilterButton.positionAdjustment, for: .bookmark)
        setImage(AppConstants.Images.filter, for: .bookmark, state: .normal)
    }

    // MARK: - Setup icons changing 

    private func changeFilterIconColor(with state: Filters) {
        switch state {
        case .standart:
            setImage(AppConstants.Images.filter, for: .bookmark, state: .normal)
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
            setImage(AppConstants.Images.search, for: .search, state: .normal)
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

// MARK: - UI constants

private enum Spec {
    enum TextField {
        static let cornerRadius: CGFloat = 16
        static let textPositionAdjustment: UIOffset = .init(horizontal: 8, vertical: 0)
    }

    enum SearchIcon {
        static let positionAdjustment: UIOffset = .init(horizontal: 10, vertical: 0)
    }

    enum ClearButton {
        static let positionAdjustment: UIOffset = .init(horizontal: -10, vertical: 0)
    }

    enum FilterButton {
        static let positionAdjustment: UIOffset = .init(horizontal: -10, vertical: 0)
    }
}
