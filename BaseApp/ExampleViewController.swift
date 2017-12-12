//
//  ExampleViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/12/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak fileprivate var textField1: UITextField!
    @IBOutlet weak fileprivate var textField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.delegate = self
        textField2.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    //called when users tap out of textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}
