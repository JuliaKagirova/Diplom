//
//  DetailHeaderView.swift
//  Climat
//
//  Created by Юлия Кагирова on 25.10.2024.
//

import UIKit

class DetailHeaderView: UITableViewHeaderFooterView {

    private lazy var cityLabel: UILabel = {
        var label = UILabel()
        label.text = "City Name"  //searchVC.searchTextField.text
        label.font = .systemFont(ofSize: 26)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempMin: UILabel = {
        var label = UILabel()
        label.text = "Temp Min:"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempMinLabel: UILabel = {
        var label = UILabel()
        label.text = "15"  //searchVC.searchTextField.text
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempMax: UILabel = {
        var label = UILabel()
        label.text = "Temp Max:" 
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempMaxLabel: UILabel = {
        var label = UILabel()
        label.text = "19"  //searchVC.searchTextField.text
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Life Cycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Private Methods
    
    private func setupUI() {
        addSubviews(cityLabel, tempMin, tempMinLabel,tempMax, tempMaxLabel)
    }
}

//MARK: - Extension Constraints

extension DetailHeaderView {
    
    private func constraints() {
        //cityLabel
        cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
            .isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            .isActive = true
        
        //tempMin
        tempMin.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        tempMin.topAnchor.constraint(equalTo: cityLabel.bottomAnchor,constant: 32)
            .isActive = true
        
        //tempMinLabel
        tempMinLabel.leadingAnchor.constraint(equalTo: tempMin.trailingAnchor, constant: 8)
            .isActive = true
        tempMinLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor,constant: 32)
            .isActive = true
        
        //tempMax
        tempMax.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        tempMax.topAnchor.constraint(equalTo: tempMin.bottomAnchor,constant: 20)
            .isActive = true
        
        //tempMaxLabel
        tempMaxLabel.leadingAnchor.constraint(equalTo: tempMax.trailingAnchor, constant: 8)
            .isActive = true
        tempMaxLabel.topAnchor.constraint(equalTo: tempMin.bottomAnchor,constant: 20)
            .isActive = true
    }
}


