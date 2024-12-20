//
//  WeatherModel.swift
//  Climat

import UIKit

struct WeatherModel {
    
    let id = UUID().uuidString
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var farenheitTemp: String {
        return String(temperature * 1.80 + 32.00)
       // f = C * 1.8000 + 32.00
    }
    var farenheitTempString: String {
        return String(format: "%.1f", farenheitTemp)
    }
}
