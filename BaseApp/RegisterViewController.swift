//
//  RegisterViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/12/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class RegisterViewController: UIViewController, GIDSignInUIDelegate {
    
    let signInButton = GIDSignInButton(frame: CGRect(x: 12, y: 100, width: 200, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        view.backgroundColor = UIColor.white
        self.view.addSubview(signInButton)
        setupGIDSignInButton()
    }
    
    
    fileprivate func setupGIDSignInButton() {
        signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        logD(nil)
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
        logD(nil)
    }
}


extension RegisterViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        logD(#function)
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        logD(#function)
    }
    
    
}
