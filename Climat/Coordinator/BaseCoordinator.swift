//
//  BaseCoordinator.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

typealias Action = (() -> Void)

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
// MARK: - Tabbar Protocol

protocol SearchWeatherBaseCoordinator: Coordinator {
    func showSearchWeatherScreen()
}

protocol SaveWeatherBaseCoordinator: Coordinator {
    func showSaveWeatherScreen()
}

protocol SettingsBaseCoordinator: Coordinator {
    func showSettingsScreen()
}

protocol MainBaseCoordinator: Coordinator {
    var searchWeatherCoordinator: SearchWeatherBaseCoordinator { get }
    var saveWeatherCoordinator: SaveWeatherBaseCoordinator { get }
    var settingsCoordinator: SettingsBaseCoordinator { get }
    func moveTo(flow: AppFlow)
}


