//
//  UserTableViewCell.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var userName: UILabel!
    @IBOutlet fileprivate weak var email: UILabel!
    @IBOutlet fileprivate weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
}

extension UserTableViewCell {
    
    fileprivate func setupUI() {
        
    }
    
    public func updateUICell() {
    
    }
}


