//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String)
    
    func didFailWithError(error: Error)
    
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C76EAF0D-C79C-4A00-86EC-C47014728F8E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let lastPrice = self.parseJSON(coinData: safeData) {
                        
                        let priceString = String(format: "%.2f", lastPrice)
                        self.delegate?.didUpdatePrice(self, price: priceString, currency: currency)
                    }
                }
                
            }
            task.resume()
        }
        
    }
    
    func parseJSON(coinData: Data) -> Double? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
        
            return decodedData.rate
        } catch {
            return nil
        }
        
    }
}
