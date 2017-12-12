//
//  TextTableViewCell.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/17/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

struct DataCellTextTableViewCell {
    var name: String?
}

class TextTableViewCell: BaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TextTableViewCell {
    typealias DataCell = DataCellTextTableViewCell
    func update(cellData: DataCellTextTableViewCell) {
        self.textLabel?.text = cellData.name
    }
}
