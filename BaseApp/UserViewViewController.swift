//
//  UserViewViewController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: - Property
    @IBOutlet weak fileprivate var tableView: UITableView!
    weak var viewModel: UserViewModel?
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupUI()
        
    }
    
    // MARK: - Override
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // MARK: - IBAction
    @IBAction fileprivate func login(_ sender: Any) {
        
    }
    
}

// MARK: - Extension UI
extension UserViewController {
    
    fileprivate func registerCell() {
        tableView.registerCell(UserTableViewCell.self)
    }
    
    fileprivate func setupUI() {
        viewModel = UserViewModel(self)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
    fileprivate func updateUI() {
        
    }
}

extension UserViewController: UserModelToViewProtocol {
    func updateUI(infomation: Infomation) {
        

        if let user = Users.responseObject(object: nil) {
            logD(user)
        }
        
        if let user = Users.responseObject(forKey: JSONKey.accessToken, object: nil) {
            logD(user)
        }
        
        if let users = Users.responseCollectionObject(object: nil) {
            logD(users)
        }
        
        if let users = Users.responseCollectionObject(forKey: JSONKey.accessToken, object: nil) {
            logD(users)
        }
        
    }
    
}
// MARK: - Extension Notification
extension UserViewController {
    
}




