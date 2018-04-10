//
//  MainViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
import Firebase

fileprivate class DataSourceCellMainViewController {
    var name: String?
    var viewControllers = [UIViewController]()
    
    init(_ name: String) {
        self.name = name
    }
}

class MainViewController: BaseViewController {
    
    // MARK: - Properties
    fileprivate var dataSource = [DataSourceCellMainViewController]()
    // MARK: - @IBOutlet
    @IBOutlet weak fileprivate var tableView: UITableView!
    
    // MARK: - Lifecycle View
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfUserIsLoggedIn()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeData() /// remove de khong giu tham chieu toi View.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Override
    
    // MARK: - IBAction
}


// MARK: - UI Private Methods Extensions
extension MainViewController {
    
    fileprivate func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            appendData()
        }
    }
    
    @objc fileprivate func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            logD(error)
        }
        gotoLogin()
    }
    
    fileprivate func setupUI() {
        self.navigationItem.title = setupAppVersion()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        self.tableView.tableFooterView = UIView()
    }
    
    fileprivate func gotoLogin() {
        let loginVC = LoginViewController()
        self.present(loginVC)
    }
    
    fileprivate func setupAppVersion() -> String {
        return AppInfo.appName + " " + AppInfo.version + "(" + AppInfo.build + ")"
    }
    
    fileprivate func registerCell() {
        tableView.registerCellByNib(MainTableViewCell.type)
    }
    
    fileprivate func removeData() {
        dataSource.removeAll()
        tableView.reloadData()
    }
    
    fileprivate func appendData() {
        tableView.reloadData()
    }
    
}

// MARK: - Delegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = dataSource[indexPath.section].viewControllers[indexPath.row]
        self.pushNavigationController(vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension MainViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].name
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].viewControllers.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(MainTableViewCell.type, forIndexPath: indexPath)
            cell.configUI(dataSource[indexPath.section].viewControllers[indexPath.row].name)
            return cell
    }
}
