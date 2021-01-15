//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Macbook on 14.01.2021.
//

import Foundation

struct Currency: Codable {
    let currencyName: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey {
        case currencyName = "cc"
        case rate
    }
}
