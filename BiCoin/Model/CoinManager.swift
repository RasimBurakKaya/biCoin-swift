//
//  CoinManager.swift
//  BiCoin
//
//  Created by Rasim Burak Kaya on 17.04.2024.
//

import Foundation
protocol CoinManagerDelegate{
    func updateCurrencyAndRate(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "a9e784fc-f4a0-4966-87b7-59bccd9ab0a8"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String){
               let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
               
               if let url = URL(string: urlString) {
                   
                   let session = URLSession(configuration: .default)
                   
                   let task = session.dataTask(with: url) { (data, response, error) in
                       if error != nil {
                           self.delegate?.didFailWithError(error: error!)
                           return
                       }
                       if let safeData = data{
                           DispatchQueue.main.async {
                               if let bitcoinPrice = self.parseJSON(safeData){
                                   let priceString = String(format: "%.2f", bitcoinPrice)
                                   self.delegate?.updateCurrencyAndRate(price: priceString, currency: currency)
                               }
                               
                           }
                       }
                   }
                   task.resume()
               }
           }
    
    func parseJSON(_ coinData: Data) -> Double?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
      
    }
    }
