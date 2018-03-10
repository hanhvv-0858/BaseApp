//
//  MainViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

fileprivate class DataSourceCellMainViewController {
    var name: String?
    var viewControllers = [UIViewController]()
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
        
        if checkUser() { /// if co user call API...
            appendData()
        } else {
            gotoLogin() /// if khong co -> Login
        }
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
    @IBAction func btnLogOut(_ sender: Any) {
        /// remove Data
        /// load LoginView
        UserDefaults.standard.removeObject(forKey: KeyAccessToKen.key)
        DatabaseGroup.shared.removeAllRealmData()
        gotoLogin()
    }
}


// MARK: - UI Private Methods Extensions
extension MainViewController {
    
    fileprivate func checkUser() -> Bool {
        return UserDefaults.standard.value(forKey: KeyAccessToKen.key) == nil ? false : true
    }
    
    fileprivate func setupUI() {
        self.navigationItem.title = setupAppVersion()
    }
    
    fileprivate func gotoLogin() {
        let loginVC = LoginViewController.fromStoryboard(.loginRegister)
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
        /// UIView
        let views = DataSourceCellMainViewController()
        views.name = "UIView"
        views.viewControllers.append(ExampleAlertViewController.fromNib())
        views.viewControllers.append(ExampleOpenUIPickerController.fromNib())
        views.viewControllers.append(ExampleHideKeyBoardTextFieldViewController.fromNib())
        views.viewControllers.append(MultiLanguageViewController.fromNib())
        views.viewControllers.append(ExampleTargetClosureViewController.fromNib())
        views.viewControllers.append(ExampleKVOViewController.fromNib())
        views.viewControllers.append(OpenOfficeViewController.fromNib())
        views.viewControllers.append(KeyboardSmart.fromNib())
        views.viewControllers.append(ScrollKeyboardVViewController.fromNib())
        views.viewControllers.append(AnimatgionSegueViewController.fromNib())
        views.viewControllers.append(LoadFileViewController.fromNib())
        /// GameSpriteKit
        let games = DataSourceCellMainViewController()
        games.name = "GameSpriteKit"
        games.viewControllers.append(GameViewController.fromNib())
        /// Database
        let databases = DataSourceCellMainViewController()
        databases.name = "Database"
        databases.viewControllers.append(RealmToDoViewController.fromNib())
        /// TO DO
        self.dataSource.append(views)
        self.dataSource.append(games)
        self.dataSource.append(databases)
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
