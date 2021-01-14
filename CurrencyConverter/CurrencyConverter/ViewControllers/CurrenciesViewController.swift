//
//  CurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Macbook on 14.01.2021.
//

import UIKit

class CurrenciesViewController: UIViewController {

    //MARK:Properties
    @IBOutlet weak var currencyTableView: UITableView!
    var currencies = [Currency]()

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTableView.register(CurrenciesTableViewCell.nib(), forCellReuseIdentifier: CurrenciesTableViewCell.identifier)
        self.currencyTableView.delegate = self
        self.currencyTableView.separatorStyle = .none
        loadFiles()
    }
    
    private func loadFiles() -> Void {
        Provider().fetchCurrencyJSON { (res) in
            switch res {
            case .success(let currencyResult):
                self.currencies.append(contentsOf: currencyResult)
                DispatchQueue.main.async {
                    self.currencyTableView.reloadData()
                }
            case .failure(let error):
                print("The error is: \(error)")
            }
        }
    }
}

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesTableViewCell.identifier, for: indexPath) as! CurrenciesTableViewCell
            cell.setCurrencies = currencies[indexPath.item]
        return cell
    }
}
