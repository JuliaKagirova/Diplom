//
//  DetailsViewController.swift
//  Climat
//
//  Created by Юлия Кагирова on 06.11.2024.
//

import UIKit
import SwiftUI
import CoreData

final class DetailsViewController: UIViewController {
    
    //MARK: - Private Properties
    
    private let city: String
    private var model: WeatherModel?
    private var collectionView: UICollectionView!
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.bounds.width, height: view.frame.height)
    }
    
    private lazy var todayLabel: UILabel = {
        var label = UILabel()
        label.text = "DetailScreen.todayLabel".localized
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chartNameLabel: UILabel = {
        var label = UILabel()
        label.text = "DetailScreen.tempOfTheDay".localized
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var networkManager: NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    private lazy var notificationHandler: NotificationsHandler = {
        let notificationHandlerService = NotificationsHandler(delegate: self)
        return notificationHandlerService
    }()
    
    private lazy var chartsViewModel: ChartsViewModel = {
        let viewModel = ChartsViewModel(currentWeatherModel: self.model)
        return viewModel
    }()
    
    private var temperatureType: NotificationCenterModels.TemperatureToggleType = .celcius
    
    //MARK: - Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var settingsVC = SettingsController()
    
    //MARK: - Init
    
    init(city: String) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupConstraints()
        downloadWeather()
        setupChart()
        notificationHandler.startObserving()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .bg
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .bg
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28)
            .isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200)
            .isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            .isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            .isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherByHourCell.self, forCellWithReuseIdentifier: WeatherByHourCell.reuseId)
    }
    
    private func setupChart() {
        let controller = UIHostingController(rootView: ChartsView(viewModel: chartsViewModel))
        guard let chartView = controller.view else { return }
        contentView.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.topAnchor.constraint(equalTo: chartNameLabel.bottomAnchor, constant: 24)
            .isActive = true
        chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            .isActive = true
        chartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            .isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 400)
            .isActive = true
    }
    
    private func downloadWeather() {
        networkManager.downloadWeatherByHour(city: city,
                                             isMetric: self.temperatureType == .celcius) { [weak self] weatherModel in
            self?.model = weatherModel
            self?.chartsViewModel.updateWeatherModel(weatherModel)
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - Extension Constraints

extension DetailsViewController {
    
    private func setupConstraints() {
        
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(todayLabel, chartNameLabel)
        
        //content view
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        
        //today label
        todayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28)
            .isActive = true
        todayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            .isActive = true
        
        //precipitation label
        chartNameLabel.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 150)
            .isActive = true
        chartNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            .isActive = true
    }
}

//MARK: - Extension UICollectionViewDataSource

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherByHourCell.reuseId, for: indexPath) as! WeatherByHourCell
        let metricIndicator = temperatureType == .celcius ? "°C" : "°F"
        cell.descriptionLabel.text = model?.descriptionArray[indexPath.row]
        cell.tempLabel.text = "\(model?.tempArray[indexPath.row] ?? 00 )" + metricIndicator
        
        if let date = model?.dateArray[indexPath.row].stringFromDate() {
            cell.dateLabel.text = date
        }
        return cell
    }
}

//MARK: - Extension UICollectionViewDelegate

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 100)
    }
}

// MARK: - NotificationHandlerDelegate

extension DetailsViewController: NotificationHandlerDelegate {
    func updateDataAfterNotificationHandling(currentType: NotificationCenterModels.TemperatureToggleType) {
        self.temperatureType = currentType
        self.downloadWeather()
    }
}
