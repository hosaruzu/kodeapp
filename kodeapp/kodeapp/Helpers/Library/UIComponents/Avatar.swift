//
//  Avatar.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 21.03.2024.
//

import UIKit

final class Avatar: UIImageView {

    // MARK: - Init

    init(_ image: UIImage = .imagePlaceholder) {
        super.init(frame: .zero)
        setImage(image)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        contentMode = .scaleAspectFit
    }

    // MARK: - Public

    func setImage(_ image: UIImage) {
        self.image = image
    }
}
