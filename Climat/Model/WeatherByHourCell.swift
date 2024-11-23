//
//  CollectionViewCell.swift
//  Climat
//
//  Created by Юлия Кагирова on 07.11.2024.
//

import UIKit

final class WeatherByHourCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let reuseId = "PhotoCell"
    
     lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        tempLabel.text = "23.5"
        tempLabel.textColor = .black
        tempLabel.font = .systemFont(ofSize: 18)
        return tempLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
       var label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = "rain"
       label.textColor = .black
       label.font = .systemFont(ofSize: 18)
        return label
   }()
    
    //MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func setupCell() {
        
        self.contentView.addSubviews(imageView,dateLabel, tempLabel, descriptionLabel)
        self.clipsToBounds = true
        contentView.backgroundColor = .orange
        
        //dateLabel
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
            .isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            .isActive = true
        
        //imageView
        imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4)
            .isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            .isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100)
            .isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100)
            .isActive = true
        
        //tempLabel
        tempLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4)
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
