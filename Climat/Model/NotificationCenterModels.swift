//
//  NotificationCenterModels.swift
//  Climat
//
//  Created by Юлия Кагирова on 24.11.2024.
//

import Foundation

struct NotificationCenterModels {
    enum NotificationName: String {
        case temperatureToggle
        
        var name: Notification.Name {
            return Notification.Name(rawValue: rawValue)
        }
    }
    
    enum NotificationUserInfoKey: String {
        case isOn
    }
    
    enum TemperatureToggleType {
        case celcius
        case fahrenheit
    }
}
