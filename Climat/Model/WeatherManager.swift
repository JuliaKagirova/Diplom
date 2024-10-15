//
//  WeatherManager.swift
//  Climat
//
import UIKit
import CoreLocation

//MARK: - Protocol WeatherManagerDelegate

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    //MARK: - Properties
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=04405b54121d2705cff98d43af341e67&units=metric"
    var delegate: WeatherManagerDelegate?
    
    //MARK: - Methods
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees ,longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // 1. Create URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error)  in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let description = decodedData.weather[0].description
            let id = decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(
                conditionId: id,
                cityName: name,
                temperature: temp,
                description: description
            )
            print(weather.conditionName, weather.temperatureString, weather.description)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

