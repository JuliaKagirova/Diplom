//
//  NotificationCenterDelegate.swift
//  Climat
//
//  Created by Юлия Кагирова on 24.11.2024.
//

import Foundation

protocol NotificationHandlerDelegate {
    func updateDataAfterNotificationHandling(currentType: NotificationCenterModels.TemperatureToggleType)
}

final class NotificationsHandler {
    
    //MARK: - Private Properties

    private weak var delegate: (NotificationHandlerDelegate & AnyObject)?
    
    //MARK: - Init
    
    init(delegate: (NotificationHandlerDelegate & AnyObject)? = nil) {
        self.delegate = delegate
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Methods

    func startObserving() {
        self.subscribeNotifications()
    }
    
    func subscribeNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleNotification(notification:)),
                                               name: NotificationCenterModels.NotificationName.temperatureToggle.name,
                                               object: nil)
    }
    
    //MARK: - Event Handler

    @objc func handleNotification(notification: Notification) {
        if let userInfo = notification.userInfo,
           let isEnabled = userInfo[NotificationCenterModels.NotificationUserInfoKey.isOn] as? Bool {
            self.delegate?.updateDataAfterNotificationHandling(currentType: isEnabled ? .fahrenheit : .celcius)
        }
    }
}
