//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Macbook on 14.01.2021.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet weak var startCurrencyPickerView: UIPickerView!
    @IBOutlet weak var endCurrencyPickerView: UIPickerView!
    @IBOutlet weak var startCurrencyLabel: UILabel!
    @IBOutlet weak var endCurrencyLabel: UILabel!
    @IBOutlet weak var startAmountTextField: UITextField!
    @IBOutlet weak var changedAmountLabel: UILabel!
    var currencies = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFiles()
        self.startCurrencyPickerView.delegate = self
        self.startCurrencyPickerView.dataSource = self
        self.endCurrencyPickerView.delegate = self
        self.endCurrencyPickerView.dataSource = self
        self.startAmountTextField.delegate = self
    }
    
    private func loadFiles() -> Void {
        Provider().fetchCurrencyJSON { (res) in
            switch res {
            case .success(let currencyResult):
                self.currencies.append(contentsOf: currencyResult)
                DispatchQueue.main.async {
                    self.startCurrencyPickerView.reloadAllComponents()
                    self.endCurrencyPickerView.reloadAllComponents()
                }
            case .failure(let error):
                print("The error is: \(error)")
            }
        }
    }
}

extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].currencyName
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == startCurrencyPickerView
        {
            startCurrencyLabel.text = currencies[row].currencyName
        }
        else
        {
            endCurrencyLabel.text = currencies[row].currencyName
        }
    }
}

extension ConverterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLabel(textField: startAmountTextField)
    }
    func updateLabel(textField: UITextField) {
        guard let labelText = startAmountTextField.text else {return}
        changedAmountLabel.text = labelText
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == startAmountTextField {
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
}
