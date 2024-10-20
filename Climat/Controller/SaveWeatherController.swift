//
//  SaveWeatherController.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

class SaveWeatherController: UITableViewController {
    
    //MARK: - Properties
    
    var coordinator: Coordinator?
    var items = CoreDataManager.shared.items
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.reloadData()
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.refreshControl = refreshControll
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Methods
    
    func setupUI() {
        view.backgroundColor = .bg
        title = "SaveScreen.title".localized
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.id)
    }
    
    //MARK: - Event Handler
    
    @objc func refresh(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.id,
                                                       for: indexPath) as? WeatherTableViewCell
        else {
            return UITableViewCell()
        }
        let model = CoreDataManager.shared.items[indexPath.row]
        let modelForCell = WeatherModel(
            conditionId: model.faultingState,
            cityName: model.name ?? "",
            temperature: model.temp,
            description: model.descr ?? ""
        )
        cell.configWeatherArray(weather: modelForCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteWeather(item: CoreDataManager.shared.items[indexPath.row])
            tableView.reloadData()
        } else if editingStyle == .insert {
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
