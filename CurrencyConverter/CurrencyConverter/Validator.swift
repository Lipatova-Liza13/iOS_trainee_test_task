//
//  Validator.swift
//  CurrencyConverter
//
//  Created by Macbook on 15.01.2021.
//

import Foundation

class Validator {
    func amountValidator(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[0-9]*.?[0-9]+$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid amount of convertible currency")
            }
        } catch {
            throw ValidationError("Invalid amount of convertible currency")
        }
        return value
    }
}
