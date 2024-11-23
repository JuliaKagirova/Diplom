//
//  WeatherData.swift
//  Climat

import UIKit

//struct WeatherData: Codable {
//    let name: String
//    let main: Main
//    let weather: [Weather]
//}
//
//struct Main: Codable {
//    let temp: Double
//}

//struct Weather: Codable {
//    let id: Int
//    let description: String
//}

// MARK: - WeatherCodable
struct WeatherCodable: Codable {
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let sys: Sys
    let dtTxt: String
    let rain, snow: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, sys
        case dtTxt = "dt_txt"
        case rain, snow
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let description, icon: String
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}
