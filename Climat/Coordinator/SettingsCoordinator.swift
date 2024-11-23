//
//  SettingsCoordinator.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

final class SettingsCoordinator: SettingsBaseCoordinator {
    
    //MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    //MARK: - Methods
    
    func start() -> UIViewController {
        let settingsVC = SettingsController()
        settingsVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: settingsVC)
        return rootViewController
    }
    
    func showSettingsScreen() {
        
    }
}
