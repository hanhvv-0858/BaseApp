//
//  Extension+UITableView.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

/// MARK: - Extension Animation LoadMore
extension UITableView {
    func showLoadMoreFooterView(_ completionHandler: @escaping () -> Void) {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = .gray
        let view = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 50))
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        view.backgroundColor = UIColor.clear
        self.tableFooterView = view
        activityIndicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            completionHandler()
        }
    }
    
    func hideLoadMoreFooterView(){
        UIView.animate(withDuration: 0.3) {
            self.tableFooterView = nil
        }
    }
}

/// MARK: - Loading Animation
extension UITableView {
    
}

/// MARK: - Register
extension UITableView {
    
    func registerCellByNib<T: UITableViewCell>(_ type: T.Type) {
        register(type.nib, forCellReuseIdentifier: type.identifier)
    }
    
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.identifier)
    }
    
    func registerHeaderFooterByNib<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        register(type.nib, forHeaderFooterViewReuseIdentifier: type.identifier)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as! T
    }
}
