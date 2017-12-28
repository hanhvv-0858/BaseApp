//
//  Extension+UITableViewCell.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit


/// MARK: - Extension UITableViewCell
extension UITableViewCell {
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class func dequeueCell(_ tableView: UITableView, indexPath: IndexPath) -> Self {
        return tableView.dequeueCell(self, forIndexPath: indexPath)
    }
}

/// MARK: - Extension UITableViewHeaderFooterView
extension UITableViewHeaderFooterView {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class func dequeueReusableHeaderFooterView(_ tableView: UITableView, indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableHeaderFooterView(self)
    }
}
