//
//  TableViewSmart.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 1/4/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit


// MARK: - TableView
class UITableViewSmart: UITableView {
    
    override var frame: CGRect {
        willSet(newValue) {
            if newValue.equalTo(frame) {
                return
            }
            super.frame = frame
        }
        didSet {
            if hasAutomaticKeyboardAvoidingBehaviour() {return}
            keyboard_updateContentInset()
        }
    }
    
    override var contentSize: CGSize {
        willSet(newValue) {
            if newValue.equalTo(contentSize) {
                return
            }
            if hasAutomaticKeyboardAvoidingBehaviour() {
                super.contentSize = newValue
                return
            }
            super.contentSize = newValue
        }
        didSet {
            keyboard_updateContentInset()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        registerObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerObserver()
    }
    
    override func awakeFromNib() {
        registerObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            cancelPerform()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyBoard()
        super.touchesEnded(touches, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        callPerform()
    }
}

extension UITableViewSmart: UITextFieldDelegate {
    
    fileprivate func cancelPerform() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(keyboard_assignTextDelegateForViewsBeneathView(_:)), object: self)
    }
    
    fileprivate func callPerform() {
        cancelPerform()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(keyboard_assignTextDelegateForViewsBeneathView(_:)), userInfo: nil, repeats: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !focusNextTextField() {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UITableViewSmart: UITextViewDelegate {
    
}

extension UITableViewSmart {
    
    fileprivate func hideKeyBoard() {
        keyboard_findFirstResponderBeneathView(self)?.resignFirstResponder()
    }
    
    fileprivate func hasAutomaticKeyboardAvoidingBehaviour()->Bool {
        if #available(iOS 8.3, *) {
            if self.delegate is UITableViewController {
                return true
            }
        }
        return false
    }
    
    fileprivate func focusNextTextField()->Bool {
        return keyboard_focusNextTextField()
    }
    
    @objc fileprivate func scrollToActiveTextField() {
        return keyboard_scrollToActiveTextField()
    }
    
    fileprivate func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func registerObserver() {
        if hasAutomaticKeyboardAvoidingBehaviour() { return }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboard_keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboard_keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: NSNotification.Name.UITextViewTextDidBeginEditing,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: NSNotification.Name.UITextFieldTextDidBeginEditing,
                                               object: nil)
    }
}
