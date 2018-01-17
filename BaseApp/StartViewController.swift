//
//  StartViewController.swift
//  iOSTraining82017
//
//  Created by Guest User on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//
import UIKit

final class StartViewController: BaseViewController {
//
//    // MARK: - IBOutlet
//    @IBOutlet weak fileprivate var activityIndicator: ActivityIndicator!
//
//    // MARK: - Varialbes
//
//    // MARK: - View Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.activityIndicator.startAnimating()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        checkApp()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    // MARK: - Override
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    }
//}
//
//// MARK: - Methods extensions
//extension StartViewController {
//
//    fileprivate func checkApp() {
//        if checkUser() {
//            self.perform(#selector(StartViewController.gotoMainApp), with: nil, afterDelay: 1)
//        } else {
//            self.perform(#selector(StartViewController.gotoLogin), with: nil, afterDelay: 1)
//        }
//    }
//
//    fileprivate func checkUser() -> Bool {
//        return UserDefaults.standard.value(forKey: KeyAccessToKen.key) == nil ? false : true
//    }
//
//    /// fileprivate not using Objc
//
//    @objc fileprivate func gotoLogin() {
//        let loginVC = LoginViewController.fromStoryboard(StoryboardName.LoginRegister)
//        self.present(loginVC)
//    }
//
//    @objc fileprivate func gotoMainApp() {
//        let mainNC = MainNavigationController.fromStoryboard(StoryboardName.MainApp)
//        self.present(mainNC)
//    }
}
