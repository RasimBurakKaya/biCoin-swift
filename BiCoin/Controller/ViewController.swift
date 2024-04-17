//
//  ViewController.swift
//  BiCoin
//
//  Created by Rasim Burak Kaya on 17.04.2024.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CoinManagerDelegate {


    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var coinManager = CoinManager()
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {//satır sayısını oluşturduk.
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { //This method expects a String as an output. The String is the title for a given row. When the PickerView is loading up, it will ask its delegate for a row title and call the above method once for every row. So when it is trying to get the title for the first row, it will pass in a row value of 0 and a component (column) value of 0.
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {//This will get called every time when the user scrolls the picker. When that happens it will record the row number that was selected.
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }
    func updateCurrencyAndRate(price: String, currency: String) {
        self.currencyLabel.text = currency
        self.bitcoinLabel.text = price
        
    }
   
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
    
}

