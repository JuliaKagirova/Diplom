//
//  SaveManager.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit
import RealmSwift
import Realm
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var weathers: [WeatherModel] = []
    
    init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: false
        )
        Realm.Configuration.defaultConfiguration = config
        
        self.weathers = fetchWeathers()
    }
    
    func addWeather(data: WeatherData) {
        let realm = try! Realm()
        let weather = WeatherModel()
        weather.cityName = data.name
        weather.temperature = data.main.temp
        weather.description = data.weather.description
        
        try! realm.write {
            realm.add(weather)
        }
        weathers = fetchWeathers()
    }
    
    func deleteWeather(at index: Int) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(weathers[index])
        }
        weathers = fetchWeathers()
    }
    
    func fetchWeathers() -> [WeatherModel] {
        let realm = try! Realm()
        let weather = WeatherModel()
        return realm.objects(WeatherModel.self).map { $0 }
    }
}
