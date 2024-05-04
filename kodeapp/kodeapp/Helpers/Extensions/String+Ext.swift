//
//  String+Ext.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 01.04.2024.
//

import UIKit

extension String {

    // MARK: - Dates

    func convertDate(inputDate: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd MMMM YYYY"
        if let date = dateFormatterInput.date(from: inputDate) {
            return dateFormatterOutput.string(from: date)
        } else {
            return nil
        }
    }

    func yearsSinceDate(inputDate: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: inputDate) {
            let calendar = Calendar.current
            let years = calendar.dateComponents([.year], from: date, to: Date()).year
            return years
        } else {
            return nil
        }
    }

    // MARK: - Define Width

    func defineWidth() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 15, weight: .medium)
        let attributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attributes).width
    }
}
