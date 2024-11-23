//
//  CollectionViewCell.swift
//  Climat
//
//  Created by Юлия Кагирова on 07.11.2024.
//

import UIKit

final class WeatherByHourCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let reuseId = "WeatherByHourCell"
    
    lazy var dateLabel: UILabel = {
        var dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = ""
        dateLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 18)
        return dateLabel
    }()
    
    lazy var tempLabel: UILabel = {
        var tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = ""
        tempLabel.textColor = .black
        tempLabel.font = .systemFont(ofSize: 24)
        return tempLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func setupCell() {
        
        self.contentView.addSubviews(dateLabel, tempLabel, descriptionLabel)
        self.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 20
        
        //dateLabel
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
            .isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            .isActive = true
        
        //tempLabel
        tempLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4)
            .isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            .isActive = true
        
        //descriptionLabel
        descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 4)
            .isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            .isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
            .isActive = true
    }
}
