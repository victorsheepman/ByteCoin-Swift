//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinAPiProtocol{
    func getData(coin:Coin)
}

struct CoinManager {
    
    private let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    private let apiKey = "7E50C838-0409-4771-8C74-80BB50D37298"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate:CoinAPiProtocol!
   
    func callAPI(currency:String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {fatalError()}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {return }
            
            if httpResponse.statusCode == 200 {
                guard let datos  = data else {return}
                print(datos)
                
                do {
                    let exchangeRate = try JSONDecoder().decode(Coin.self, from: datos)
                    self.delegate.getData(coin: exchangeRate)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            
        }.resume()
    }
    
}
