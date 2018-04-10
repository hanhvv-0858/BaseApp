
//
//  CellSettingsView.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 4/11/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit


class CellSettingsView: UITableViewCell {
    
    let icon = UIImageView()
    let title = UILabel().with {
        $0.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    fileprivate func reset() {
        
    }
    
    func updateCell(title: String, imgName: String) {
        self.title.text = title
        self.icon.image = UIImage(named: imgName)
    }
    
    
    fileprivate func setupUI() {
        self.addSubview(icon)
        self.addSubview(title)
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        title.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 12).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
    }
    
}


