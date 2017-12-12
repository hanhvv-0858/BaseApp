//
//  MultiLanguageViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/12/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
import Localize_Swift

class MultiLanguageViewController: UIViewController {

    @IBOutlet weak fileprivate var textLabel: UILabel!
    @IBOutlet weak fileprivate var changeButton: UIButton!
    @IBOutlet weak fileprivate var resetButton: UIButton!
    
    var actionSheet: UIAlertController!
    
    let availableLanguages = Localize.availableLanguages()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setText()
    }
    
    // Add an observer for LCLLanguageChangeNotification on viewWillAppear. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Localized Text
    
    @objc func setText(){
        textLabel.text = "Hello world".localized()
        changeButton.setTitle("Change".localized(using: "Button"), for: UIControlState.normal)
        resetButton.setTitle("Reset".localized(using: "Button"), for: UIControlState.normal)
    }
    
    // MARK: IBActions
    @IBAction fileprivate func doChangeLanguage(_ sender: AnyObject) {
        actionSheet = UIAlertController(title: nil, message: "Switch Language", preferredStyle: UIAlertControllerStyle.actionSheet)
        for language in availableLanguages {
            let displayName = Localize.displayNameForLanguage(language)
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                Localize.setCurrentLanguage(language)
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction fileprivate func doResetLanguage(_ sender: AnyObject) {
        Localize.resetCurrentLanguageToDefault()
    }

}
