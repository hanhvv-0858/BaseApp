//
//  AddToDoViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 3/9/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    var textField: UITextField?
    var doneActionCallBack: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupTextField()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField?.becomeFirstResponder()
    }
    
    func setupTextField() {
        textField = UITextField(frame: .zero)
        textField?.placeholder = "to do something!"
        textField?.delegate = self
        view.addSubview(textField!)
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(AddToDoViewController.doneAction))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(AddToDoViewController.cancelAction))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textField?.contentVerticalAlignment = .center
        textField?.frame = CGRect(x: 12, y: 150, width: self.view.frame.size.width - 24, height: 40)
    }
    
    func doneAction() {
        doneActionCallBack?(textField?.text)
        dismiss(animated: true, completion: nil)
    }
    
    func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension AddToDoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneAction()
        textField.resignFirstResponder()
        return true
    }

}
