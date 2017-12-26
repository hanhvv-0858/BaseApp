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
        logD(AppInfo.appName)
        setupUI()
        registerCell()
        appendData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Override
    
}


// MARK: - UI Private Methods Extensions
extension MainViewController {
    
    fileprivate func setupUI() {
        self.navigationItem.title = setupAppVersion()
    }
    
    fileprivate func setupAppVersion() -> String {
        return AppInfo.appName + " " + AppInfo.version + "(" + AppInfo.build + ")"
    }
    
    fileprivate func registerCell() {
        tableView.registerCellByNib(MainTableViewCell.self)
    }
    
    fileprivate func appendData() {
        viewControllers.append(ExampleAlertViewController.fromNib())
        viewControllers.append(ExampleOpenUIPickerController.fromNib())
        viewControllers.append(ExampleViewController.fromNib())
        viewControllers.append(MultiLanguageViewController.fromNib())
        viewControllers.append(ExampleTargetClosureViewController.fromNib())
        viewControllers.append(ExampleKVOViewController.fromNib())
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
        let cell = tableView.dequeueCell(MainTableViewCell.self, forIndexPath: indexPath)
            cell.configUI(viewControllers[indexPath.row].className)
            return cell
    }
}
