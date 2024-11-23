//
//  WeatherModel.swift
//  Climat

import UIKit

struct WeatherModel: Identifiable, Equatable {
    
    var id: String
    var conditionId: String
    var cityName: String
    var temperature: Double
    var description: String
    var date: String
    var dateArray: [String]
    var descriptionArray: [String]
    var tempArray: [Double]
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var tempFar: String {
        return String(format: "%.1f", (temperature * 1.8 + 32))
    }
    
    var conditionName: String {
        ""
        //        switch conditionId {
        //        case 200...232:
        //            return "cloud.bolt"
        //        case 300...321:
        //            return "cloud.drizzle"
        //        case 500...531:
        //            return "cloud.rain"
        //        case 600...622:
        //            return "cloud.snow"
        //        case 701...781:
        //            return "cloud.fog"
        //        case 800:
        //            return "sun.max"
        //        case 801...804:
        //            return "cloud.bolt"
        //        default:
        //            return "cloud"
        //        }
    }
}
