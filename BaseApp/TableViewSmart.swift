//
//  TableViewSmart.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 1/4/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit


// MARK: - TableView
class UITableViewSmart: UITableView, UITextViewDelegate {
    
    override var frame: CGRect {
        willSet {
            super.frame = frame
        }
        
        didSet {
            if hasAutomaticKeyboardAvoidingBehaviour() {return}
            TPKeyboardAvoiding_updateContentInset()
        }
    }
    
    override var contentSize: CGSize {
        willSet(newValue) {
            if hasAutomaticKeyboardAvoidingBehaviour() {
                super.contentSize = newValue
                return
            }
            
            if newValue.equalTo(contentSize) {
                return
            }
            super.contentSize = newValue
        }
        
        didSet {
            TPKeyboardAvoiding_updateContentInset()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView(_:)), object: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.TPKeyboardAvoiding_findFirstResponderBeneathView(self)?.resignFirstResponder()
        super.touchesEnded(touches, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView(_:)), object: self)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView(_:)), userInfo: nil, repeats: false)
    }
    
    func hasAutomaticKeyboardAvoidingBehaviour()->Bool {
        if #available(iOS 8.3, *) {
            if self.delegate is UITableViewController {
                return true
            }
        }
        return false
    }
    
    func focusNextTextField()->Bool {
        return self.TPKeyboardAvoiding_focusNextTextField()
    }
    
    func scrollToActiveTextField() {
        return self.TPKeyboardAvoiding_scrollToActiveTextField()
    }
}

extension UITableViewSmart: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !self.focusNextTextField() {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UITableViewSmart {
    fileprivate func setup() {
        if hasAutomaticKeyboardAvoidingBehaviour() { return }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TPKeyboardAvoiding_keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TPKeyboardAvoiding_keyboardWillHide(_:)),
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
