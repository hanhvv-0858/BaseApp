//
//  ExampleAlertViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/11/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class ExampleAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

 
    @IBAction fileprivate func actionAlert(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            //your code here
        }
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            //your code here
        }
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
//        self.present(alertController, animated: true, completion:{ () -> Void in
//            //your code here
//        })
        
    }
    
    @IBAction fileprivate func actionSheet(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            //your code here
        }
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            //your code here
        }
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:{ () -> Void in
            //your code here
        })
        
    }
    
    @IBAction fileprivate func actionAlertWithForm(_ sender: AnyObject) {
        
        /// create object
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            //your code here
        }
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            let userName = alertController.textFields![0].text
            let password = alertController.textFields![1].text
            self.doSomething(userName, password: password)
        }
        /// add
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        alertController.addTextField(configurationHandler: {(textField : UITextField!) in
            textField.placeholder = "User Name"
            textField.isSecureTextEntry = false
        })
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        })
        
        self.present(alertController, animated: true, completion:{ () -> Void in
            //your code here
        })
    }
    
    @objc func doSomething(_ userName: String?, password: String?) {
        logD("username: \(userName ?? "")  password: \(password ?? "")")
    }

}
