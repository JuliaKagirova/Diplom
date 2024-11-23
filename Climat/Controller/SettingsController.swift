//
//  SettingsController.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

final class SettingsController: UITableViewController {
    
    //MARK: - Private Properties
    
    private lazy var notificationLink: UIButton = {
        var button = UIButton()
        button.setTitle("Notification.title".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(notificationLinkTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tempLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.text = "SettingsScreen.changeTemp".localized
        return label
    }()
    
    private lazy var notificationIcon: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "bell.badge")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var tempIcon: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "thermometer.low")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var notificationToggle: UISwitch = {
        var toggle = UISwitch()
        toggle.setOn(false, animated: true)
        toggle.onTintColor = .systemGreen
        toggle.addTarget(self, action: #selector(notificationLinkTapped), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    //MARK: - Properties
    
    var currentWeather: WeatherModel?
    weak var coordinator: Coordinator?
    var notificationManager = LocalNotificationsService()
    
    lazy var tempToggle: UISwitch = {
        var toggle = UISwitch()
        toggle.setOn(false, animated: true)
        toggle.onTintColor = .systemGreen
        toggle.addTarget(self, action: #selector(tempToggleTapped), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .bg
        title = "SettingsScreen.title".localized
        
        view.addSubviews(
            notificationLink,
            notificationIcon,
            tempLabel,
            tempIcon,
            tempToggle,
            notificationToggle
        )
    }
    
    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: - Event Handler
    
    @objc private func notificationLinkTapped(_ sender: Any) {
        notificationManager.requestPermission()
        openSettings()
    }
    
    @objc private func tempToggleTapped() {
        NotificationCenter.default.post(name: NotificationCenterModels.NotificationName.temperatureToggle.name,
                                        object: nil,
                                        userInfo: [
                                            NotificationCenterModels.NotificationUserInfoKey.isOn: tempToggle.isOn
                                        ])
    }
}

//MARK: - Extension Constraints

extension SettingsController {
    func setupConstraints() {
        
        //notification icon
        notificationIcon.centerYAnchor.constraint(equalTo: notificationLink.centerYAnchor)
            .isActive = true
        notificationIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12)
            .isActive = true
        notificationIcon.heightAnchor.constraint(equalToConstant: 30)
            .isActive = true
        notificationIcon.widthAnchor.constraint(equalToConstant: 30)
            .isActive = true
        
        //notification label
        notificationLink.topAnchor.constraint(equalTo: view.topAnchor, constant: 42)
            .isActive = true
        notificationLink.leadingAnchor.constraint(equalTo: notificationIcon.trailingAnchor, constant: 8)
            .isActive = true
        notificationLink.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        
        //changeTemp label
        tempLabel.topAnchor.constraint(equalTo: notificationIcon.bottomAnchor, constant: 22)
            .isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: tempIcon.trailingAnchor, constant: 8)
            .isActive = true
        
        //thermometer icon
        tempIcon.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor)
            .isActive = true
        tempIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12)
            .isActive = true
        tempIcon.heightAnchor.constraint(equalToConstant: 30)
            .isActive = true
        tempIcon.widthAnchor.constraint(equalToConstant: 30)
            .isActive = true
        
        //notification toggle
        notificationToggle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
            .isActive = true
        notificationToggle.centerYAnchor.constraint(equalTo: notificationLink.centerYAnchor)
            .isActive = true
        
        // temp toggle
        tempToggle.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor)
            .isActive = true
        tempToggle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
            .isActive = true
    }
}

