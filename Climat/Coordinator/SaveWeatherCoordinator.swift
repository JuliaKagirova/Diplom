//
//  SaveWeatherCoordinator.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

class SaveWeatherCoordinator: SaveWeatherBaseCoordinator {
    
    //MARK: - Properties

    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    //MARK: - Methods

    func start() -> UIViewController {
        let saveVC = SaveWeatherController()
        saveVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: saveVC)
        return rootViewController
    }
    
    func showSaveWeatherScreen() {
        
    }
    

}
