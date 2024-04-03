//
//  Avatar.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 21.03.2024.
//

import UIKit

final class Avatar: UIImageView {

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }
}
