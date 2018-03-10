//
//  BaseViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - IBOutlet
    
    // MARK: - Properties
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIWithBase()
        registerObserverWithBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUIWithBase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        removeObserverWithBase()
    }
    
    // MARK: - Override
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
    
    // MARK: - IBAction
    @IBAction func btnX(_ sender: Any) {
        print(#function)
    }
}

// MARK: Delegate
extension BaseViewController: UITextFieldDelegate {
    
}

// MARK: - Call API
extension BaseViewController {
    
}


// MARK: - Methods Extension
extension BaseViewController {
    
    func updateUIWithBase() {
        
    }
    
    func setupUIWithBase() {
        
    }
    
    func registerObserverWithBase() {
        
    }
    
    func removeObserverWithBase() {
        
    }
}
