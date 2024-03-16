//
//  SearchBar.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 14.03.2024.
//

import UIKit

final class SearchBar: UISearchBar {

    // MARK: - Public properties

    var isFilterClicked = false {
        didSet {
            changeFilterIconColor()
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
        searchTextField.backgroundColor = .tertiarySystemBackground
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search name, tag, email...",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.tertiaryLabel
            ])
    }

    // MARK: - Setup icons

    private func setupSearchIcon() {
        setImage(UIImage(resource: .searchIcon), for: .search, state: .normal)
        setPositionAdjustment(.init(horizontal: 10, vertical: 0), for: .search)

    }

    private func setupClearButton() {
        setImage(UIImage(resource: .clearIcon), for: .clear, state: .normal)
        setPositionAdjustment(.init(horizontal: -10, vertical: 0), for: .clear)
    }

    private func setupFilterButton() {
        showsBookmarkButton = true
        setPositionAdjustment(.init(horizontal: -10, vertical: 0), for: .bookmark)
        setImage(UIImage(resource: .filterIcon), for: .bookmark, state: .normal)
    }

    // MARK: - Setup icons changing 

    private func changeFilterIconColor() {
        if isFilterClicked {
            setImage(UIImage(resource: .filterIcon).withTintColor(.accent), for: .bookmark, state: .normal)
        } else {
            setImage(UIImage(resource: .filterIcon), for: .bookmark, state: .normal)
        }
    }

    private func changeSearchIconColor() {
        if isSearching {
            setImage(UIImage(resource: .searchIcon).withTintColor(.label), for: .search, state: .normal)
        } else {
            setImage(UIImage(resource: .searchIcon), for: .search, state: .normal)
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
