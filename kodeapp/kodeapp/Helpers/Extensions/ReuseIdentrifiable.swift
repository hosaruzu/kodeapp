//
//  ReuseIdentrifiable.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 16.03.2024.
//

import UIKit

protocol ReuseIdentrifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentrifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentrifiable {}

extension UITableView {
    func dequeue<T: UITableViewCell>(
        _ cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellType.reuseIdentifier,
            for: indexPath) as? T else {
            fatalError("Can't dequeue \(cellType.self) as \(self) cell")
        }
        return cell
    }

    func register<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}
