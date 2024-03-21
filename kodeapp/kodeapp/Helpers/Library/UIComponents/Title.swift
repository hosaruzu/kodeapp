//
//  Title.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 21.03.2024.
//

import UIKit

final class Title: UILabel {

    // MARK: - Init

    init(
        font: UIFont = .systemFont(ofSize: 14),
        color: UIColor = .label
    ) {
        super.init(frame: .zero)
        self.font = font
        self.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
