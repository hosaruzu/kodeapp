//
//  UIImageView+Ext.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 01.04.2024.
//

import UIKit

extension UIImageView {

    func setImage(_ id: String, size: AppConstants.ImageSize, indicator: Loadable? = nil) async {
        guard let imageData = try? await ImageLoader.shared.downloadImage(id, size: size) else { return }
        indicator?.stop()
        self.image = UIImage(data: imageData)
    }
}
