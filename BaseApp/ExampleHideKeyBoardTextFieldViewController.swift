//
//  ExampleViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/12/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class ExampleHideKeyBoardTextFieldViewController: UIViewController {

    @IBOutlet weak fileprivate var textField1: UITextField!
    @IBOutlet weak fileprivate var textField2: UITextField!
    @IBOutlet weak fileprivate var txt_pickUpData: UITextField!
    fileprivate var myPickerView: UIPickerView!
    fileprivate var pickerData = ["Ha Noi" , "Hai Phong" , "Thai Binh" , "Ninh Binh", "Lao Cai"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.delegate = self
        textField2.delegate = self
        txt_pickUpData.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ExampleHideKeyBoardTextFieldViewController: UITextFieldDelegate {
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- TextFiled Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === txt_pickUpData {
            pickUp(txt_pickUpData)
        }
    }
}

extension ExampleHideKeyBoardTextFieldViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txt_pickUpData.text = pickerData[row]
    }
}

extension ExampleHideKeyBoardTextFieldViewController {
    
    fileprivate func pickUp(_ textField : UITextField){
        // UIPickerView
        myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        myPickerView.delegate = self
        myPickerView.dataSource = self
        myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ExampleHideKeyBoardTextFieldViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ExampleHideKeyBoardTextFieldViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    //MARK:- Button
    @objc fileprivate func doneClick() {
        txt_pickUpData.resignFirstResponder()
    }
    @objc fileprivate func cancelClick() {
        txt_pickUpData.text = ""
        txt_pickUpData.resignFirstResponder()
    }
}
