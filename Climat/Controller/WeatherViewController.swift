//
//  ViewController.swift
//  Climat

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    //MARK: - Private Properties
    
    private lazy var conditionImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .black
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
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "21"
        label.textColor = .black
        label.font = .systemFont(ofSize: 46, weight: .heavy)
        return label
    }()
    
    private lazy var cLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "°C"
        label.textColor = .black
        label.font = .systemFont(ofSize: 46, weight: .bold)
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "London"
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Search..."
        field.font = .systemFont(ofSize: 22, weight: .medium)
        field.textColor = .systemGray2
        field.borderStyle = .roundedRect
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
        view.addSubview(bgView)
        view.addSubview(conditionImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(cLabel)
        view.addSubview(cityLabel)
        view.addSubview(searchTextField)
        view.addSubview(locationPressed)
        view.addSubview(searchPressed)
    }
   
    //MARK: - Event Handler
    
    @objc private func locationButtonPressed() {
        locationManager.requestLocation()
    }
}

//MARK: - Extension UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @objc private func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
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

extension WeatherViewController:  WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription )
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
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

extension WeatherViewController {
    
    private func setupConstraints() {
        bgView.topAnchor.constraint(equalTo: view.topAnchor)
            .isActive = true
        bgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        bgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            .isActive = true
        
        searchTextField.centerYAnchor.constraint(equalTo: locationPressed.centerYAnchor)
            .isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: locationPressed.trailingAnchor)
            .isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        
        locationPressed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        locationPressed.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        locationPressed.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        locationPressed.widthAnchor.constraint(equalToConstant: 50)
            .isActive = true
        
        searchPressed.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor)
            .isActive = true
        searchPressed.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor)
            .isActive = true
        searchPressed.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        searchPressed.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        searchPressed.widthAnchor.constraint(equalToConstant: 50
        ).isActive = true
        
        conditionImageView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 26)
            .isActive = true
        conditionImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        conditionImageView.widthAnchor.constraint(equalToConstant: 100)
            .isActive = true
        conditionImageView.heightAnchor.constraint(equalToConstant: 120)
            .isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 16)
            .isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: cLabel.leadingAnchor, constant: -16)
            .isActive = true
        
        cLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 16)
            .isActive = true
        cLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            .isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 26)
            .isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            .isActive = true
    }
    
}





