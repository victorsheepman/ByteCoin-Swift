//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak private var labelCoin: UILabel!
    @IBOutlet weak private var currencyLabel: UILabel!
    @IBOutlet weak private var pickerCoin: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyLabel.text = coinManager.currencyArray[0]
        coinManager.callAPI(currency: coinManager.currencyArray[0])
    }
}

extension ViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension ViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentCurrency = coinManager.currencyArray[row]
        currencyLabel.text = currentCurrency
        coinManager.callAPI(currency: currentCurrency)
    }
}

extension ViewController:CoinAPiProtocol{
    func getData(coin: Coin) {
        DispatchQueue.main.async {
            let rate = round(100 * coin.rate) / 100
            self.labelCoin.text = String(rate)
            self.labelCoin.reloadInputViews()
        }
    }
}
