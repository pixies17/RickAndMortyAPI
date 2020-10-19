//
//  TableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 13.10.2020.
//

import Foundation
import SnapKit
import SDWebImage

final class TableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let cellId = "TableViewCell"
    
    var model: CharacterModel?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        
        addSubview(nameLabel)
        
        return nameLabel
    }()
    
    lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        statusLabel.textColor = .white
        
        addSubview(statusLabel)
        
        return statusLabel
    }()
    
    lazy var speciesLabel: UILabel = {
        let speciesLabel = UILabel()
        speciesLabel.font = statusLabel.font.withSize(14)
        speciesLabel.textColor = .white
        
        addSubview(speciesLabel)
        
        return speciesLabel
    }()
    
    lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = statusLabel.font.withSize(14)
        genderLabel.textColor = .white
        
        addSubview(genderLabel)
        
        return genderLabel
    }()
    
    lazy var originLabel: UILabel = {
        let originLabel = UILabel()
        originLabel.font = statusLabel.font.withSize(14)
        originLabel.textColor = .white
        originLabel.numberOfLines = 0
        
        addSubview(originLabel)
        
        return originLabel
    }()
    
    lazy var characterImage: UIImageView = {
        let characterImage = UIImageView()
       
        addSubview(characterImage)
        
        return characterImage
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        setupLayout()
    }
}

// MARK: - Configuration

extension TableViewCell {
    func setupConstraints() {
        
        characterImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.size.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.top)
            make.leading.equalTo(characterImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        speciesLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(speciesLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        originLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(nameLabel)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
        }
    }
    
    func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        characterImage.layer.cornerRadius = characterImage.frame.size.width/2
        characterImage.clipsToBounds = true
    }
    
    func configure(with model: CharacterModel) {
        nameLabel.text = "Имя: " + model.name
        statusLabel.text = "Статус: " + model.status
        speciesLabel.text = "Вид: " + model.species
        genderLabel.text = "Пол: " + model.gender
        originLabel.text = "Место рождения: " + model.origin.name
        characterImage.sd_setImage(with: URL(string: model.imageUrl), completed: nil)
    }
}
