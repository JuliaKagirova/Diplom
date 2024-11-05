//
//  SettingsController.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

class SettingsController: UITableViewController {
    
    //MARK: - Properties
    var toggleButtonChecked = false
    var notificationManager = LocalNotificationsService()
    var coordinator: Coordinator?
    lazy var notificationLink: UIButton = {
        var button = UIButton()
        button.setTitle("Notification.title".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(notificationLinkTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var notificationIcon: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "bell.badge")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var unitsLink: UILabel = {
        var label = UILabel()
        label.text = "Units.title".localized
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let config = UIImage.SymbolConfiguration(pointSize: 30)
    lazy var unitsIcon: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "thermometer.medium", withConfiguration: config)
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var unitsToggle: UISwitch  = {
        var button = UISwitch()
        button.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        customizeButtonNotSelected()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .bg
        title = "SettingsScreen.title".localized
        view.addSubviews(notificationLink, notificationIcon, unitsLink, unitsIcon, unitsToggle)
    }
    
    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
     func customizeButtonSelected() {
        unitsToggle.onTintColor = .systemBlue
        
    }
     func customizeButtonNotSelected() {
        //to celcius
    }
    
    //MARK: - Event Handler
    
    @objc private func notificationLinkTapped(_ sender: Any) {
        notificationManager.requestPermission()
        openSettings()
    }
    @objc private func toggleButtonTapped() {
        if toggleButtonChecked == false {
            toggleButtonChecked = true
            customizeButtonSelected()
        } else {
            toggleButtonChecked = false
            customizeButtonNotSelected()
        }
    }
    
}

//MARK: - Extension Constraints

extension SettingsController {
    func setupConstraints() {
        // Notification Icon
        notificationIcon.centerYAnchor.constraint(equalTo: notificationLink.centerYAnchor)
            .isActive = true
        notificationIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12)
            .isActive = true
        notificationIcon.heightAnchor.constraint(equalToConstant: 30)
            .isActive = true
        notificationIcon.widthAnchor.constraint(equalToConstant: 30)
            .isActive = true
        // Notification Label
        notificationLink.topAnchor.constraint(equalTo: view.topAnchor, constant: 42)
            .isActive = true
        notificationLink.leadingAnchor.constraint(equalTo: notificationIcon.trailingAnchor, constant: 8)
            .isActive = true
        notificationLink.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        // Units Icon
        unitsIcon.centerYAnchor.constraint(equalTo: unitsLink.centerYAnchor)
            .isActive = true
        unitsIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12)
            .isActive = true
        unitsLink.topAnchor.constraint(equalTo: notificationLink.bottomAnchor, constant: 28)
            .isActive = true
        unitsLink.leadingAnchor.constraint(equalTo: unitsIcon.trailingAnchor, constant: 8)
            .isActive = true
        unitsLink.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        // Units Toggle
        unitsToggle.centerYAnchor.constraint(equalTo: unitsLink.centerYAnchor)
            .isActive = true
        unitsToggle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
            .isActive = true
        unitsToggle.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
    }
}

