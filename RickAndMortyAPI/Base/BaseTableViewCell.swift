//
//  BaseTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 11.11.2020.
//

import Foundation
import UIKit

class BaseTableViewCell: UITableViewCell {
    @objc func setupConstraints() {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupConstraints()
    }
}
