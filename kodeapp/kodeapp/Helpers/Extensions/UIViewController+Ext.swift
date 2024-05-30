//
//  UIViewController+Ext.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 30.05.2024.
//

import UIKit

extension UIViewController {
    func searchBarImage(color: UIColor = .tertiarySystemFill, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
