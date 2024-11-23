//
//  SaveManager.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit
import CoreData

final class CoreDataManager {
    
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
    
    func getItem(weather: WeatherModel) -> WeatherItem? {
        let request = WeatherItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", weather.id)
        return (try? context.fetch(request))?.first
    }
    
    func addWeather(weatherModel: WeatherModel) {
        guard getItem(weather: weatherModel) == nil else { return }
        let weather = WeatherItem(context: context)
        weather.id = weatherModel.id
        weather.name = weatherModel.cityName
        weather.descr = weatherModel.description
        weather.image = weatherModel.conditionName
        weather.temp = weatherModel.temperature
        try? context.save()
    }
    
    func updateData(_ model: WeatherModel) {
        guard let item = getItem(weather: model) else { return }
        deleteWeather(item: item)
        addWeather(weatherModel: model)
    }
}

