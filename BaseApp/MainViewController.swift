//
//  MainViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - Properties
    fileprivate var viewControllers = [UIViewController]()
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
        viewControllers.removeAll()
        tableView.reloadData()
    }
    
    fileprivate func appendData() {
        viewControllers.append(ExampleAlertViewController.fromNib())
        viewControllers.append(ExampleOpenUIPickerController.fromNib())
        viewControllers.append(ExampleHideKeyBoardTextFieldViewController.fromNib())
        viewControllers.append(MultiLanguageViewController.fromNib())
        viewControllers.append(ExampleTargetClosureViewController.fromNib())
        viewControllers.append(ExampleKVOViewController.fromNib())
        viewControllers.append(OpenOfficeViewController.fromNib())
        viewControllers.append(KeyboardSmart.fromNib())
        viewControllers.append(ScrollKeyboardVViewController.fromNib())
        viewControllers.append(AnimatgionSegueViewController.fromNib())
        viewControllers.append(LoadFileViewController.fromNib())
        tableView.reloadData()
    }
    
}

// MARK: - Delegate
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = viewControllers[indexPath.row]
        self.pushNavigationController(vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

extension MainViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(MainTableViewCell.type, forIndexPath: indexPath)
            cell.configUI(viewControllers[indexPath.row].name)
            return cell
    }
}
