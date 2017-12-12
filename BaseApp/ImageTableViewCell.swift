//
//  ImageTableViewCell.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/17/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

struct CellDataImageTableViewCell {
    var nameAvatar: String?
}

class ImageTableViewCell: BaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ImageTableViewCell {
    typealias DataCell = CellDataImageTableViewCell
    func update(cellData: CellDataImageTableViewCell) {
        if let nameAvatar = cellData.nameAvatar {
            imageView?.image = UIImage(named: nameAvatar)
        }
    }
    
}
