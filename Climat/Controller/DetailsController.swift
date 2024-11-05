//
//  DetailsController.swift
//  Climat
//
//  Created by Юлия Кагирова on 24.10.2024.
//

import UIKit

class DetailsController: UIViewController {
    
    //MARK: - Private Properties
    
 
    
    
    
    //MARK: - Properties
    
    var currentWeather: WeatherModel?
    var searchVC = SearchWeatherController()
    static let headerIdent = "header"
    static let hourForcast = "hour"
    static let dayForcast = "day"
    
    var forCastTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DetailHeaderView.self, forHeaderFooterViewReuseIdentifier: headerIdent)
        table.register(HourForcastTableViewCell.self, forCellReuseIdentifier: hourForcast)
//        table.register(DayForcastTableViewCell.self, forCellReuseIdentifier: dayForcast)
        return table
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        addSubview()
        constraints()
        
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .bg
        title = "DetailsScreen.title".localized
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupTableView() {
//        forCastTableView.dataSource = self
        forCastTableView.delegate = self
        forCastTableView.refreshControl = UIRefreshControl()
        forCastTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
    }
    
    private func addSubview() {
        view.addSubviews(forCastTableView)
    }
    
    //MARK: - Event Handler
    
    @objc func reloadTableView() {
        forCastTableView.reloadData()
        forCastTableView.refreshControl?.endRefreshing()
    }
}

//MARK: - Extension Constraints

extension DetailsController {
    private func constraints() {
        forCastTableView.topAnchor.constraint(equalTo: view.topAnchor)
            .isActive = true
        forCastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            .isActive = true
        forCastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            .isActive = true
        forCastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            .isActive = true
    }
}

//MARK: - Extension UITableViewDataSource


//MARK: - Extension

extension DetailsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailsController.headerIdent) as! DetailHeaderView
        return headerView
    }
    
}


