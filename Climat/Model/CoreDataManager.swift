//
//  SaveManager.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit
import CoreData

class CoreDataManager {
    
    //MARK: - Properties

    static let shared = CoreDataManager()
    
    var items: [WeatherItem] {
        fetchWeather()
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Methods
    
    func fetchWeather() -> [WeatherItem] {
        let request = WeatherItem.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteWeather(item: WeatherItem) {
        let context = item.managedObjectContext
        context?.delete(item)
        try? context?.save()
    }
    
    private func getItem(weather: WeatherModel) -> WeatherItem? {
        let request = WeatherItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", weather.cityName)
        return (try? context.fetch(request))?.first
    }

    func addWeather(weatherModel: WeatherModel) {
        guard getItem(weather: weatherModel) == nil else { return }
        let weather = WeatherItem(context: context)
        weather.name = weatherModel.cityName
        weather.descr = weatherModel.description
        weather.image = weatherModel.conditionName
        weather.temp = weatherModel.temperature
        try? context.save()
    }
}
