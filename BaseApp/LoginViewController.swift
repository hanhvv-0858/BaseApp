//
//  LoginViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction fileprivate func login(_ sender: Any) {
        guard let username = tfUserName.text, let password = tfPassWord.text else {
            return
        }
        let keyAccessToken = username + password
        UserDefaults.standard.set(keyAccessToken, forKey: KeyAccessToKen.key)
        dismiss()
    }
}
