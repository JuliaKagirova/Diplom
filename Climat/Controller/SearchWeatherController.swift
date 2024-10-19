//
//  SearchWeatherController.swift
//  Climat

import UIKit
import CoreLocation

class SearchWeatherController: UIViewController {
    
    //MARK: - Properties
    var currentWeather: WeatherModel?
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var coordinator: Coordinator?
    
    //MARK: - Private Properties
    
    private lazy var conditionImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .icon
        return view
    }()
    
    private lazy var bgView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "background")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var borderView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor(named: "iconColor")?.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "21"
        label.font = .systemFont(ofSize: 52, weight: .heavy)
        return label
    }()
    
    private lazy var cLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "°C"
        label.font = .systemFont(ofSize: 52, weight: .bold)
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "London"
        label.font = .systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Description"
        label.font = .systemFont(ofSize: 26, weight: .medium)
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Search..."
        field.font = .systemFont(ofSize: 22, weight: .medium)
        field.textColor = .systemBackground
        return field
    }()
    
    private lazy var locationPressed: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "location.circle"), for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var savePressed: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchPressed: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.addSubviews(
                bgView,
                conditionImageView,
                temperatureLabel,
                cLabel,
                cityLabel,
                searchTextField,
                locationPressed,
                searchPressed,
                descriptionLabel,
                borderView,
                savePressed
            )
    }
    
    //MARK: - Event Handler
    
    @objc private func locationButtonPressed() {
        locationManager.requestLocation()
        print("location button pressed")
    }
    
    @objc private func saveButtonPressed() {
        if let currentWeather {
            CoreDataManager.shared.addWeather(weatherModel: currentWeather)
            print("city added to core data")
        } else {
            print("weather didnt saved")
            return
        }
    }
}

//MARK: - Extension UITextFieldDelegate

extension SearchWeatherController: UITextFieldDelegate {
    
    @objc private func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print("search Button Pressed")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type some city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = "  "
    }
}

//MARK: - Extension WeatherManagerDelegate

extension SearchWeatherController:  WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        self.currentWeather = weather
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.descriptionLabel.text = weather.description
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription )
    }
}

//MARK: - CLLocationManagerDelegate

extension SearchWeatherController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - Constraints

extension SearchWeatherController {
    
    private func setupConstraints() {
        //bg
        bgView.topAnchor.constraint(equalTo: view.topAnchor)
            .isActive = true
        bgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        bgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            .isActive = true
        
        //borderView
        borderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        borderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        borderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            .isActive = true
        borderView.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        
        //locationButton
        locationPressed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        locationPressed.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 8)
            .isActive = true
        locationPressed.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        locationPressed.widthAnchor.constraint(equalToConstant: 50)
            .isActive = true
        
        //textField
        searchTextField.centerYAnchor.constraint(equalTo: locationPressed.centerYAnchor)
            .isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: locationPressed.trailingAnchor)
            .isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        
        //searchButton
        searchPressed.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor)
            .isActive = true
        searchPressed.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor)
            .isActive = true
        searchPressed.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -8)
            .isActive = true
        searchPressed.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        searchPressed.widthAnchor.constraint(equalToConstant: 50)
            .isActive = true
        
        //city
        cityLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 87)
            .isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        
        //description
        descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 18)
            .isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        
        //image
        conditionImageView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 26)
            .isActive = true
        conditionImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        conditionImageView.widthAnchor.constraint(equalToConstant: 140)
            .isActive = true
        conditionImageView.heightAnchor.constraint(equalToConstant: 160)
            .isActive = true
        
        //temperature
        temperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20)
            .isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        //C
        cLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20)
            .isActive = true
        cLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 16)
            .isActive = true
        
        //plusButton
        savePressed.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor)
            .isActive = true
        savePressed.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 16)
            .isActive = true
    }
}





