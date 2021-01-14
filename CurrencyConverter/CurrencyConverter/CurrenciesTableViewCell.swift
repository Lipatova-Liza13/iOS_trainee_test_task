//
//  CurrenciesTableViewCell.swift
//  CurrencyConverter
//
//  Created by Macbook on 14.01.2021.
//

import UIKit

class CurrenciesTableViewCell: UITableViewCell {

    //MARK:Сonnect nib file
    static let identifier = "CurrenciesTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CurrenciesTableViewCell", bundle: nil)
    }
    
    //MARK:Properties
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var setCurrencies: Currency! {
        didSet {
            currencyLabel.text = setCurrencies.currencyName
            rateLabel.text = String(setCurrencies.rate)
        }
    }
}
