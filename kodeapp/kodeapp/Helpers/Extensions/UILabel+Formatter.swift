//
//  UILabel+Formatter.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 22.03.2024.
//

import UIKit

extension String {
    func formatToPhoneNumber() -> String {
        // Remove non-numeric characters
        let cleanedNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        // Check if the cleanedNumber is empty or not
        guard !cleanedNumber.isEmpty else { return self }
        // Format the number as (XXX) XXX XX XX
        var formattedNumber = "+7 "
        formattedNumber += "("
        formattedNumber += String(cleanedNumber.prefix(3))
        formattedNumber += ") "
        formattedNumber += String(cleanedNumber.dropFirst(3).prefix(3))
        formattedNumber += " "
        formattedNumber += String(cleanedNumber.dropFirst(6).prefix(2))
        formattedNumber += " "
        formattedNumber += String(cleanedNumber.dropFirst(8).prefix(2))
        formattedNumber += " "
        formattedNumber += String(cleanedNumber.dropFirst(10))
        return formattedNumber
    }
}
