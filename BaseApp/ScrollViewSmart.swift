//
//  ScrollViewSmart.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 1/4/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

// MARK: - ScrollView
class UIScrollViewSmart: UIScrollView {
    
    // MARK: - Property
    override var contentSize: CGSize {
        willSet(newValue) {
            if newValue.equalTo(contentSize) {
                return
            }
            super.contentSize = newValue
            keyboard_updateFromContentSizeChange()
        }
    }
    
    override var frame: CGRect {
        willSet(newValue) {
            if newValue.equalTo(frame) {
                return
            }
            super.frame = newValue
            keyboard_updateContentInset()
        }
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        registerObserver()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    // MARK: - Override
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(keyboard_assignTextDelegateForViewsBeneathView(_:)), object: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyBoard()
        super.touchesEnded(touches, with: event)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(keyboard_assignTextDelegateForViewsBeneathView(_:)), object: self)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(keyboard_assignTextDelegateForViewsBeneathView(_:)), userInfo: nil, repeats: false)
    }
}

// MARK: - Extension
extension UIScrollViewSmart: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !focusNextTextField() {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UIScrollViewSmart: UITextViewDelegate {
    // TO DO
}

 extension UIScrollViewSmart {
    
    fileprivate func hideKeyBoard() {
        keyboard_findFirstResponderBeneathView(self)?.resignFirstResponder()
    }
    
    fileprivate func contentSizeToFit() {
        contentSize = keyboard_calculatedContentSizeFromSubviewFrames()
    }
    
    fileprivate func focusNextTextField() -> Bool {
        return keyboard_focusNextTextField()
    }
    
    @objc fileprivate func scrollToActiveTextField() {
        return keyboard_scrollToActiveTextField()
    }
    
    fileprivate func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func registerObserver() {
        /// UIKeyboardWillChangeFrame
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboard_keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        
        /// UIKeyboardWillHide
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboard_keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
        
        /// UITextViewTextDidBeginEditing
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: NSNotification.Name.UITextViewTextDidBeginEditing,
                                               object: nil)
        /// UITextFieldTextDidBeginEditing
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: NSNotification.Name.UITextFieldTextDidBeginEditing,
                                               object: nil)
    }
}
