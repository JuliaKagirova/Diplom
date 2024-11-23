//
//  MainCoordinator.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

enum AppFlow {
    case search
    case save
    case settings
}

final class MainCoordinator: MainBaseCoordinator {
    
    //MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var searchWeatherCoordinator: SearchWeatherBaseCoordinator = SearchWeatherCoordinator()
    lazy var saveWeatherCoordinator: SaveWeatherBaseCoordinator = SaveWeatherCoordinator()
    lazy var settingsCoordinator: SettingsBaseCoordinator = SettingsCoordinator()
    lazy var rootViewController: UIViewController = UITabBarController()
    
    //MARK: - Methods
    
    func start() -> UIViewController {
        let searchWeatherViewController = searchWeatherCoordinator.start()
        searchWeatherCoordinator.parentCoordinator = self
        searchWeatherCoordinator.navigationRootViewController?.navigationBar.tintColor = .white
        searchWeatherViewController.tabBarItem = UITabBarItem(
            title: "SearchScreen.title".localized,
            image: UIImage(systemName: "location.magnifyingglass"),
            tag: 0
        )
        
        let saveWeatherViewController = saveWeatherCoordinator.start()
        saveWeatherCoordinator.parentCoordinator = self
        saveWeatherViewController.tabBarItem = UITabBarItem(
            title: "SaveScreen.title".localized,
            image: UIImage(systemName: "checkmark.icloud"),
            tag: 1
        )
        
        let settingsViewController = settingsCoordinator.start()
        settingsCoordinator.parentCoordinator = self
        settingsViewController.tabBarItem = UITabBarItem(
            title: "SettingsScreen.title".localized,
            image: UIImage(systemName: "gearshape.2"),
            tag: 2
        )
        (rootViewController as? UITabBarController)?.tabBar.backgroundColor = .tabbar
        (rootViewController as? UITabBarController)?.tabBar.tintColor = .selected
        (rootViewController as? UITabBarController)?.tabBar.unselectedItemTintColor = .unselected
        (rootViewController as? UITabBarController)?.tabBar.layer.cornerRadius = 30
        (rootViewController as? UITabBarController)?.tabBar.itemWidth = 50
        (rootViewController as? UITabBarController)?.viewControllers = [
            searchWeatherViewController,
            saveWeatherViewController,
            settingsViewController,
        ]
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .search:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .save:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        case .settings:
            (rootViewController as? UITabBarController)?.selectedIndex = 2
        }
    }
    func resetToRoot() -> Self {
        searchWeatherCoordinator.resetToRoot()
        moveTo(flow: .search)
        return self
    }
}
