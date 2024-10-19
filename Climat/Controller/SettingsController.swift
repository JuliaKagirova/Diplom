//
//  SettingsController.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

class SettingsController: UITableViewController {
    
    //MARK: - Properties
    
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
        
        view.addSubview(notificationLink)
        view.addSubview(notificationIcon)
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
}

//MARK: - Extension Constraints

extension SettingsController {
    func setupConstraints() {
        //Icon
        notificationIcon.centerYAnchor.constraint(equalTo: notificationLink.centerYAnchor)
            .isActive = true
        notificationIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12)
            .isActive = true
        notificationIcon.heightAnchor.constraint(equalToConstant: 30)
            .isActive = true
        notificationIcon.widthAnchor.constraint(equalToConstant: 30)
            .isActive = true
        //Label
        notificationLink.topAnchor.constraint(equalTo: view.topAnchor, constant: 42)
            .isActive = true
        notificationLink.leadingAnchor.constraint(equalTo: notificationIcon.trailingAnchor, constant: 8)
            .isActive = true
        notificationLink.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
            .isActive = true
        notificationLink.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
    }
}

