//
//  String+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 29/11/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

public extension String {
    
    /// Removes specified characters from string
    public func eln_removingCharacters(in characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }
 
    /// Returns a string with first letter uppercased.
    public func eln_uppercasingFirstLetter(with locale: Locale? = nil) -> String {
        guard characters.count > 0 else {
            return self
        }

        let firstLetterIndex = index(after: startIndex)
        let firstLetter = substring(to: firstLetterIndex).uppercased(with: locale)
        let remainingLetters = substring(from: firstLetterIndex)

        return firstLetter.appending(remainingLetters)
    }
    
    /// Returns number value from decimal number strings.
    public var eln_numberValue: NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        var number = formatter.number(from: self)

        if number == nil {
            formatter.decimalSeparator = ".";
            number = formatter.number(from: self)
        }

        if number == nil {
            formatter.decimalSeparator = ",";
            number = formatter.number(from: self)
        }

        return number
    }
    
}
