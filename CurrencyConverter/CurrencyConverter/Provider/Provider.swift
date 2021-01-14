//
//  Provider.swift
//  CurrencyConverter
//
//  Created by Macbook on 14.01.2021.
//

import Foundation

class Provider {
    public func fetchCurrencyJSON(completition: @escaping(Result<[Currency], Error>) ->()) {
        let fullUrlStr = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
        let url = URL(string: fullUrlStr)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completition(.failure(error))
                return
            }
            do {
                let decoder = JSONDecoder()
                let currencyResult = try decoder.decode([Currency].self, from: data!)
                completition(.success(currencyResult))
            } catch let error as NSError {
                completition(.failure(error))
            }
        }
        task.resume()
    }
}
