//
//  AppConstants.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 21.03.2024.
//

import UIKit

enum AppConstants {

    enum Color {
        static let accent = UIColor.accent

        static let backgroundPrimary = UIColor.systemBackground
        static let backgroundSecondary = UIColor.secondarySystemBackground

        static let textPrimary = UIColor.label
        static let textSecondary = UIColor.secondaryLabel
        static let textTertiary = UIColor.tertiaryLabel
    }

    enum Fonts {
        static let title = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let titleLarge: UIFont = .systemFont(ofSize: 24, weight: .bold)
        static let titleRegular = UIFont.systemFont(ofSize: 16, weight: .regular)

        static let subtitle: UIFont = .systemFont(ofSize: 17, weight: .regular)
        static let subtitleSemibold: UIFont = .systemFont(ofSize: 17, weight: .semibold)

        static let body: UIFont = .systemFont(ofSize: 13, weight: .regular)
        static let bodyLarge: UIFont = .systemFont(ofSize: 14, weight: .medium)

        static let caption: UIFont = .systemFont(ofSize: 15, weight: .medium)
    }

    enum Images {
        static let back = UIImage(resource: .backIcon)
        static let favorite = UIImage(resource: .favoriteIcon)
        static let phone = UIImage(resource: .phoneIcon)

        static let emptyState = UIImage(resource: .magnyfyingGlass)

        static let radio = UIImage(resource: .radioUnchecked)
        static let radioChecked = UIImage(resource: .radioChecked)

        static let filter = UIImage(resource: .filterIcon).withTintColor(.tertiaryLabel)
        static let filterCheckedAscending = UIImage(resource: .filterIconAsc).withTintColor(AppConstants.Color.accent)
        static let filterCheckedDescending = UIImage(resource: .filterIcon).withTintColor(AppConstants.Color.accent)

        static let search = UIImage(resource: .searchIcon).withTintColor(AppConstants.Color.textTertiary)
        static let searchChecked = UIImage(resource: .searchIcon).withTintColor(AppConstants.Color.textPrimary)
        static let clearTextField = UIImage(resource: .clearIcon).withTintColor(AppConstants.Color.textTertiary)
    }
}
