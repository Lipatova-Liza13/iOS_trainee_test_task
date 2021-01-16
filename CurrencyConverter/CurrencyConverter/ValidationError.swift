//
//  ValidationError.swift
//  CurrencyConverter
//
//  Created by Macbook on 15.01.2021.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}
