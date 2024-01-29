//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5C3018E3-FD03-4A8E-9F2A-143A47F660D1"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(with currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"

        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, urlResponse, error in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                }
                if let unwrappedData = data {
                    if let price = parseJson(data: unwrappedData) {
                        let coinPrice = String(format: "%.2f", price)
                        self.delegate?.didUpdatePrice(price: coinPrice, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let price = decodedData.rate
            return price
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
