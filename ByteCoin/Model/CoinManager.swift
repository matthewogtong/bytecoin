//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C76EAF0D-C79C-4A00-86EC-C47014728F8E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        performRequest(with: url)
        
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    let stringData = String(data: safeData, encoding: String.Encoding.utf8)
                    
                    guard let stringData = stringData else {
                        return
                    }
                    
                    print(stringData)
                }
                
            }
            task.resume()
        }
    }
}
