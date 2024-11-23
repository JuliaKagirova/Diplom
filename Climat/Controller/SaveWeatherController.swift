//
//  SaveWeatherController.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

final class SaveWeatherController: UITableViewController {
    
    //MARK: - Private Properties
    private var currentTemperatureType: NotificationCenterModels.TemperatureToggleType = .celcius
    
    private lazy var temperatureNotificationService: NotificationsHandler = {
        let service = NotificationsHandler(delegate: self)
        return service
    }()
    
    private lazy var networkManager: NetworkManager = {
        let manager = NetworkManager(delegate: self)
        return manager
    }()
    
    //MARK: - Properties
    
    weak var coordinator: Coordinator?
    var items = CoreDataManager.shared.items
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        temperatureNotificationService.startObserving()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Methods
    
    func setupUI() {
        view.backgroundColor = .bg
        title = "SaveScreen.title".localized
        tableView.register(SaveWeatherTableViewCell.self, forCellReuseIdentifier: SaveWeatherTableViewCell.id)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SaveWeatherTableViewCell.id,
            for: indexPath) as? SaveWeatherTableViewCell,
              let modelId = CoreDataManager.shared.items[indexPath.row].id else {
            return UITableViewCell()
        }
        let model = CoreDataManager.shared.items[indexPath.row]
        let modelForCell = WeatherModel(
            id: modelId,
            conditionId: model.image ?? "no icon",
            cityName: model.name ?? "",
            temperature: model.temp,
            description: model.descr ?? "",
            date: model.date ?? "no date here",
            dateArray: [],
            descriptionArray: [],
            tempArray: []
        )
        cell.configWeatherArray(weather: modelForCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteWeather(item: items[indexPath.row])
            items.remove(at: indexPath.row)
            tableView.reloadData()
        } else if editingStyle == .insert { }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = CoreDataManager.shared.items[indexPath.row]
        let modelForCell = WeatherModel(
            id: model.id ?? "",
            conditionId: model.image ?? "no icon",
            cityName: model.name ?? "",
            temperature: model.temp,
            description: model.descr ?? "",
            date: model.date ?? "no date here",
            dateArray: [],
            descriptionArray: [],
            tempArray: []
        )
        let detailsVC = DetailsViewController(city: modelForCell.cityName)
        detailsVC.title = model.name
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - Extension Notification Handler Delegate

extension SaveWeatherController: NotificationHandlerDelegate {
    func updateDataAfterNotificationHandling(currentType: NotificationCenterModels.TemperatureToggleType) {
        currentTemperatureType = currentType
        CoreDataManager.shared.items.forEach { weatherItem in
            guard let name = weatherItem.name else { return }
            let isMetric = currentType == .celcius
            self.networkManager.fetchWeather(cityName: name, isMetric: isMetric)
        }
    }
}

//MARK: - Extension Network Manager Delegate

extension SaveWeatherController: NetworkManagerDelegate {
    func didUpdateWeather(_ weatherManager: NetworkManager, weather: WeatherModel) {
        CoreDataManager.shared.updateData(weather)
        tableView.reloadData()
    }
    
    func didFailWithError(error: NSError) {
        print(error)
    }
}
