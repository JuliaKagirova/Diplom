//
//  SearchWeatherCoordinator.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

class SearchWeatherCoordinator: SearchWeatherBaseCoordinator {
    
    //MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    //MARK: - Methods

    func start() -> UIViewController {
        let searchVC = SearchWeatherController()
        searchVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: searchVC)
        return rootViewController
    }
    
    func showSearchWeatherScreen() {
        
    }
}
 
