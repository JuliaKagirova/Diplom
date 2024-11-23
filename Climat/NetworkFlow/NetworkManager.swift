//
//  NetworkManager.swift
//  Climat
//
import UIKit
import CoreLocation

//MARK: - Protocol NetworkManagerDelegate

protocol NetworkManagerDelegate {
    func didUpdateWeather(_ weatherManager: NetworkManager, weather: WeatherModel)
    func didFailWithError(error: NSError)
}

struct NetworkManager {
    
    //MARK: - Properties
    
    let weatherURLtoC =
    "http://api.openweathermap.org/data/2.5/forecast?&appid=04405b54121d2705cff98d43af341e67"
    var delegate: NetworkManagerDelegate?
    
    //MARK: - Methods
    
    func fetchWeather(cityName: String, isMetric: Bool = true) {
        let units: String = isMetric ? "metric" : "imperial"
        let urlString = "\(weatherURLtoC)&units=\(units)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, isMetric: Bool = true) {
        let units: String = isMetric ? "metric" : "imperial"
        let urlString = "\(weatherURLtoC)&units=\(units)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func downloadWeatherByHour(city: String,
                               isMetric: Bool = true,
                               completion: @escaping (WeatherModel) -> Void) {
        let units: String = isMetric ? "metric" : "imperial"
        let urlStringToC =  "http://api.openweathermap.org/data/2.5/forecast?&appid=04405b54121d2705cff98d43af341e67&units=\(units)"
        if let url = URL(string: "\(urlStringToC)&q=\(city)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error)  in
                if error != nil {
                    print("Network manager error with hourly task: \(error.debugDescription)")
                    return
                }
                if let safeData = data {
                    DispatchQueue.main.async {
                        if let weather = self.parseJson(safeData) {
                            completion(weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error)  in
                if error != nil {
                    self.delegate?.didFailWithError(error: error! as NSError)
                    return
                }
                if let safeData = data {
                    DispatchQueue.main.async {
                        if let weather = self.parseJson(safeData) {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ weatherCodable: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherCodable.self, from: weatherCodable)
            let temp = decodedData.list[0].main.temp
            let description = decodedData.list[0].weather[0].description
            let name = decodedData.city.name
            let date = decodedData.list[0].dtTxt
            let icon = decodedData.list[0].weather[0].icon
            let dateArray = decodedData.list.compactMap {$0.dtTxt}
            let descrArray = decodedData.list.compactMap { $0.weather[0].description}
            let temperatureArray = decodedData.list.compactMap { $0.main.temp}
            let id = String(decodedData.city.id)
            
            let weather = WeatherModel(
                id: id,
                conditionId: icon,
                cityName: name,
                temperature: temp,
                description: description,
                date: date,
                dateArray: dateArray,
                descriptionArray: descrArray,
                tempArray: temperatureArray
            )
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error as NSError)
            return nil
        }
    }
}
