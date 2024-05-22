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

    enum ImageSize: String {
        case small = "60x60"
        case big = "120x120"
    }
}

