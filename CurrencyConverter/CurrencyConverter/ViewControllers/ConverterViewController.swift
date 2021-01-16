//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Macbook on 14.01.2021.
//

import UIKit

class ConverterViewController: UIViewController {

    //MARK:Properties
    @IBOutlet weak var startCurrencyPickerView: UIPickerView!
    @IBOutlet weak var endCurrencyPickerView: UIPickerView!
    @IBOutlet weak var startCurrencyLabel: UILabel!
    @IBOutlet weak var endCurrencyLabel: UILabel!
    @IBOutlet weak var startAmountTextField: UITextField!
    @IBOutlet weak var changedAmountLabel: UILabel!
    var currencies = [Currency]()
    var startRate: Double = 1
    var endRate: Double = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFiles()
        self.startCurrencyPickerView.delegate = self
        self.startCurrencyPickerView.dataSource = self
        self.endCurrencyPickerView.delegate = self
        self.endCurrencyPickerView.dataSource = self
        self.startAmountTextField.delegate = self
        configureLabelTextField()
    }
    
    private func loadFiles() -> Void {
        Provider().fetchCurrencyJSON { (res) in
            switch res {
            case .success(let currencyResult):
                self.currencies.append(contentsOf: currencyResult)
                DispatchQueue.main.async {
                    self.startCurrencyPickerView.reloadAllComponents()
                    self.endCurrencyPickerView.reloadAllComponents()
                    self.startCurrencyLabel.text = self.currencies[0].currencyName
                    self.endCurrencyLabel.text = self.currencies[0].currencyName
                    self.startAmountTextField.text = String(self.startRate)
                    self.changedAmountLabel.text = String(self.endRate)
                }
            case .failure(let error):
                print("The error is: \(error)")
            }
        }
    }
    func amountCheck(_ amountOfCurrency: String) {
        let validator: Validator = Validator()
        do {
            let amountChecked = try validator.amountValidator(amountOfCurrency)
            changedAmountLabel.text = String(((Double(amountOfCurrency)! * startRate / endRate) * 1000).rounded() / 1000)
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    func updateAmountLabel() {
        guard let amountOfCurrency = startAmountTextField.text, !amountOfCurrency.isEmpty else {
            changedAmountLabel.text = ""
            return
        }
        amountCheck(amountOfCurrency)
    }
    
    //MARK:Design of the screen
    func configureLabelTextField() -> Void {
        startAmountTextField.textAlignment = .right
        startAmountTextField.layer.borderColor = UIColor.lightGray.cgColor
        startAmountTextField.layer.borderWidth = 1.0
        startAmountTextField.layer.cornerRadius = 5
        changedAmountLabel.textAlignment = .right
        changedAmountLabel.layer.borderColor = UIColor.lightGray.cgColor
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
            startRate = currencies[row].rate
            updateAmountLabel()
        }
        else
        {
            endCurrencyLabel.text = currencies[row].currencyName
            endRate = currencies[row].rate
            updateAmountLabel()
        }
    }
}

extension ConverterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateAmountLabel()
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
