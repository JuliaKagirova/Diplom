//
//  WeatherTableViewCell.swift
//  Climat
//
//  Created by Юлия Кагирова on 17.10.2024.
//

import UIKit
import CoreData

class WeatherTableViewCell: UITableViewCell {

    //MARK: - Properties

    static let id = "WeatherTableViewCell"
    
    var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Life Cycle
        
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(weatherDescriptionLabel)
        setupConstraints()
        self.selectionStyle = .default
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWeatherArray(weather: WeatherModel) {
//        postAuthor.text = post.author
        weatherDescriptionLabel.text = weather.description
//        postImage.image = UIImage(named: post.image)
//        postLikes.text = "Likes: \(post.likes)"
//        viewCounter = Int(post.views)
//        postViews.text = "Views: \(viewCounter)"
    }
    
    func setupConstraints() {
        weatherDescriptionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        weatherDescriptionLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    
    
    
    //MARK: - Event Handler
    


}

//MARK: - Extension


