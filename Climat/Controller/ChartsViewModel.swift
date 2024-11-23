//
//  ChartsViewModel.swift
//  Climat
//
//  Created by Юлия Кагирова on 24.11.2024.
//

import UIKit

final class ChartsViewModel: ObservableObject {
    
    struct TempModel: Identifiable {
        let id = UUID()
        let temp: Double
        let time: String
    }
    
    //MARK: - Properties
    
    var tempModels: [TempModel] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    private(set) var currentWeatherModel: WeatherModel?
    
    //MARK: - Init
    
    init(currentWeatherModel: WeatherModel? = nil) {
        self.currentWeatherModel = currentWeatherModel
    }
    
    //MARK: - Private Methods
    
    private func mapTempModels() {
        guard let model = currentWeatherModel  else { return }
        self.tempModels = model.tempArray.prefix(12).enumerated().compactMap { (index, value) in
            if let date = model.dateArray[index].dayMonthTimeString() {
                return TempModel(temp: value, time: date)
            } else {
                return nil
            }
        }
    }
    
    //MARK: - Methods
    
    func updateWeatherModel(_ weatherModel: WeatherModel) {
        self.currentWeatherModel = weatherModel
        self.mapTempModels()
    }
}
