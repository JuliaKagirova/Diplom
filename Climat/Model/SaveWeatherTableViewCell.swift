//
//  WeatherTableViewCell.swift
//  Climat
//
//  Created by Юлия Кагирова on 17.10.2024.
//

import UIKit
import CoreData

final class SaveWeatherTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let id = "WeatherTableViewCell"
    
    var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    var weatherTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    var weatherCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        contentView.addSubviews(weatherDescriptionLabel, weatherCityLabel, weatherTempLabel)
        contentView.backgroundColor = .bg
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func configWeatherArray(weather: WeatherModel) {
        weatherDescriptionLabel.text = weather.description
        weatherCityLabel.text = weather.cityName
        weatherTempLabel.text = weather.temperatureString
    }
    
    func setupConstraints() {
        // city
        weatherCityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
            .isActive = true
        weatherCityLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        
        //description
        weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherCityLabel.bottomAnchor, constant: 16)
            .isActive = true
        weatherDescriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        
        //temperature
        weatherTempLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
            .isActive = true
        weatherTempLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            .isActive = true
    }
}
