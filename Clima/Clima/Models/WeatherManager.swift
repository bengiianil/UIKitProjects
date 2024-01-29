//
//  WeatherManager.swift
//  Clima
//
//  Created by Bengi Anıl on 17.01.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate: AnyObject {
    func didWeatherUpdate(weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let baseWeatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=02788af6556bef7b7247adb2ef65ce06&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeatherByCityName(cityName: String) {
        let url = "\(baseWeatherUrl)&q=\(cityName)"
        performRequest(url: url)
    }
    
    func fetchWeatherWithLocation(latitude: Double, longitude: Double) {
        let url = "\(baseWeatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(url: url)
    }
    
    func performRequest(url: String) {
        
        // 1. Create a URL
        if let url = URL(string: url) {
            
            // 2. Create a URLSession
            let urlSession = URLSession(configuration: .default)
            
            // 3. Give URLSession a task
            // let task = urlSession.dataTask(with: url, completionHandler: handle(data:urlResponse:error:))
            let task = urlSession.dataTask(with: url) { data, urlResponse, error in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return // eğer hata varsa fonksiyondan direkt çık, zaten diğer işlemleri yapmana gerek yok
                }
                
                if let unwrappedData = data {
                    if let weather = parseJson(weatherData: unwrappedData) {
                        self.delegate?.didWeatherUpdate(weatherManager: self, weather: weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weatherModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
//    func handle(data: Data?, urlResponse: URLResponse?, error: Error?) {
//        if let error = error {
//            print(error)
//            return // eğer hata varsa fonksiyondan direkt çık, zaten diğer işlemleri yapmana gerek yok
//        }
//
//        if let unwrappedData = data {
//            // .utf8 standart websiteden data çekip encode etme protokolüdür
//            let dataString = String(data: unwrappedData, encoding: .utf8)
//        }
//    }
}
