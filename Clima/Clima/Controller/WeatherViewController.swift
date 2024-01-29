//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewComponents()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @IBAction func tappedSearchButton(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

    @IBAction func tappedLocationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func prepareViewComponents() {
        locationManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didWeatherUpdate(weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temp
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = lastLocation.coordinate.latitude
            let longitude = lastLocation.coordinate.longitude
            weatherManager.fetchWeatherWithLocation(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty ?? false) {
            return true
        } else {
            textField.placeholder = "Search something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = searchTextField.text {
            weatherManager.fetchWeatherByCityName(cityName: cityName)
        }
        searchTextField.text = ""
    }
}

