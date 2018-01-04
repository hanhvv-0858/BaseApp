//
//  File.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 1/4/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

// MARK: - Process Event
let kCalculatedContentPadding: CGFloat = 10
let kMinimumScrollOffsetPadding: CGFloat = 20

extension UIScrollView {
    
    func keyboard_keyboardWillShow(_ notification:Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let rectNotification = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardRect = convert(rectNotification.cgRectValue , from: nil)
        if keyboardRect.isEmpty {
            return
        }
        
        let state = keyboardState()
        guard let firstResponder = keyboard_findFirstResponderBeneathView(self) else { return}
        state.keyboardRect = keyboardRect
        if !state.keyboardVisible {
            state.priorInset = contentInset
            state.priorScrollIndicatorInsets = scrollIndicatorInsets
            state.priorPagingEnabled = isPagingEnabled
        }
        
        state.keyboardVisible = true
        isPagingEnabled = false
        if self is UIScrollViewSmart {
            state.priorContentSize = contentSize
            if contentSize.equalTo(CGSize.zero) {
                contentSize = keyboard_calculatedContentSizeFromSubviewFrames()
            }
        }
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Float ?? 0.0
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let options = UIViewAnimationOptions(rawValue: UInt(curve))
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options, animations: { [weak self]() -> Void in
            guard let strongSelf = self else {
                return
            }
            strongSelf.contentInset = strongSelf.keyboard_contentInsetForKeyboard()
            let viewableHeight = strongSelf.bounds.size.height - (strongSelf.contentInset.top + strongSelf.contentInset.bottom)
            let point = CGPoint(x: strongSelf.contentOffset.x, y: strongSelf.keyboard_idealOffsetForView(firstResponder, viewAreaHeight: viewableHeight))
            strongSelf.setContentOffset(point, animated: false)
            strongSelf.scrollIndicatorInsets = strongSelf.contentInset
            strongSelf.layoutIfNeeded()
        }) { (finished) -> Void in
        }
    }
    
    func keyboard_keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let rectNotification = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRect = convert(rectNotification.cgRectValue , from: nil)
        if keyboardRect.isEmpty {
            return
        }
        let state = keyboardState()
        if !state.keyboardVisible {
            return
        }
        state.keyboardRect = CGRect.zero
        state.keyboardVisible = false
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Float ?? 0.0
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let options = UIViewAnimationOptions(rawValue: UInt(curve))
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options, animations: { [weak self]() -> Void in
            guard let strongSelf = self else {
                return
            }
            if strongSelf is UIScrollViewSmart {
                strongSelf.contentSize = state.priorContentSize
                strongSelf.contentInset = state.priorInset
                strongSelf.scrollIndicatorInsets = state.priorScrollIndicatorInsets
                strongSelf.isPagingEnabled = state.priorPagingEnabled
                strongSelf.layoutIfNeeded()
            }
        }) { (finished) -> Void in
        }
    }
    
    func keyboard_updateFromContentSizeChange() {
        let state = keyboardState()
        if state.keyboardVisible {
            state.priorContentSize = contentSize
        }
    }
    
    func keyboard_focusNextTextField() -> Bool {
        guard let firstResponder = keyboard_findFirstResponderBeneathView(self) else { return false}
        guard let view = keyboard_findNextInputViewAfterView(firstResponder, beneathView: self) else { return false}
        Timer.scheduledTimer(timeInterval: 0.1, target: view, selector: #selector(becomeFirstResponder), userInfo: nil, repeats: false)
        return true
    }
    
    func keyboard_scrollToActiveTextField() {
        let state = keyboardState()
        if !state.keyboardVisible { return }
        let visibleSpace = bounds.size.height - (contentInset.top + contentInset.bottom)
        let y = keyboard_idealOffsetForView(keyboard_findFirstResponderBeneathView(self), viewAreaHeight: visibleSpace)
        let idealOffset = CGPoint(x: 0, y: y)
        DispatchQueue.main.asyncAfter(deadline: .now() + Double((Int64)(0 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {[weak self] () -> Void in
            self?.setContentOffset(idealOffset, animated: true)
        }
    }
    
    func keyboard_findFirstResponderBeneathView(_ view:UIView) -> UIView? {
        for childView in view.subviews {
            if childView.responds(to: #selector(getter: isFirstResponder)) && childView.isFirstResponder {
                return childView
            }
            let result = keyboard_findFirstResponderBeneathView(childView)
            if result != nil {
                return result
            }
        }
        return nil
    }
    
    func keyboard_updateContentInset() {
        let state = keyboardState()
        if state.keyboardVisible {
            contentInset = keyboard_contentInsetForKeyboard()
        }
    }
    
    func keyboard_calculatedContentSizeFromSubviewFrames() ->CGSize {
        let wasShowingVerticalScrollIndicator = showsVerticalScrollIndicator
        let wasShowingHorizontalScrollIndicator = showsHorizontalScrollIndicator
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        var rect = CGRect.zero
        for view in self.subviews{
            rect = rect.union(view.frame)
        }
        rect.size.height += kCalculatedContentPadding
        showsVerticalScrollIndicator = wasShowingVerticalScrollIndicator
        showsHorizontalScrollIndicator = wasShowingHorizontalScrollIndicator
        return rect.size
    }
    
    func keyboard_idealOffsetForView(_ view:UIView?,viewAreaHeight:CGFloat) -> CGFloat {
        let contentSize = self.contentSize
        var offset:CGFloat = 0.0
        let subviewRect =  view != nil ? view!.convert(view!.bounds, to: self) : CGRect.zero
        var padding = (viewAreaHeight - subviewRect.height)/2
        if padding < kMinimumScrollOffsetPadding {
            padding = kMinimumScrollOffsetPadding
        }
        
        offset = subviewRect.origin.y - padding - self.contentInset.top
        if offset > (contentSize.height - viewAreaHeight) {
            offset = contentSize.height - viewAreaHeight
        }
        if offset < -contentInset.top {
            offset = -contentInset.top
        }
        return offset
    }
    
    func keyboard_contentInsetForKeyboard() -> UIEdgeInsets {
        let state = keyboardState()
        var newInset = contentInset
        let keyboardRect = state.keyboardRect
        newInset.bottom = keyboardRect.size.height - max(keyboardRect.maxY - bounds.maxY, 0)
        return newInset
        
    }
    
    func keyboard_viewIsValidKeyViewCandidate(_ view: UIView)->Bool {
        if view.isHidden || !view.isUserInteractionEnabled {return false}
        if view is UITextField {
            if (view as! UITextField).isEnabled {return true}
        }
        
        if view is UITextView {
            if (view as! UITextView).isEditable {return true}
        }
        return false
    }
    
    func keyboard_findNextInputViewAfterView(_ priorView:UIView,beneathView view:UIView, candidateView bestCandidate: inout UIView?) {
        let priorFrame = convert(priorView.frame, to: priorView.superview)
        let candidateFrame = bestCandidate == nil ? CGRect.zero : convert(bestCandidate!.frame, to: bestCandidate!.superview)
        
        var bestCandidateHeuristic = -sqrt(candidateFrame.origin.x*candidateFrame.origin.x + candidateFrame.origin.y*candidateFrame.origin.y) + ( Float(fabs(candidateFrame.minY - priorFrame.minY)) < .ulpOfOne ? 1e6 : 0)
        
        for childView in view.subviews {
            if keyboard_viewIsValidKeyViewCandidate(childView) {
                let frame = convert(childView.frame, to: view)
                let heuristic = -sqrt(frame.origin.x*frame.origin.x + frame.origin.y*frame.origin.y)
                    + (Float(fabs(frame.minY - priorFrame.minY)) < .ulpOfOne ? 1e6 : 0)
                
                if childView != priorView && (Float(fabs(frame.minY - priorFrame.minY)) < .ulpOfOne
                    && frame.minX > priorFrame.minX
                    || frame.minY > priorFrame.minY)
                    && (bestCandidate == nil || heuristic > bestCandidateHeuristic) {
                    bestCandidate = childView
                    bestCandidateHeuristic = heuristic
                }
            } else {
                keyboard_findNextInputViewAfterView(priorView, beneathView: view, candidateView: &bestCandidate)
            }
        }
    }
    
    func keyboard_findNextInputViewAfterView(_ priorView: UIView,beneathView view: UIView) ->UIView? {
        var candidate: UIView?
        keyboard_findNextInputViewAfterView(priorView, beneathView: view, candidateView: &candidate)
        return candidate
    }
    
    func keyboard_assignTextDelegateForViewsBeneathView(_ obj: AnyObject) {
        func processWithView(_ view: UIView) {
            for childView in view.subviews {
                if childView is UITextField || childView is UITextView {
                    keyboard_initializeView(childView)
                } else {
                    keyboard_assignTextDelegateForViewsBeneathView(childView)
                }
            }
        }
        
        if let timer = obj as? Timer, let view = timer.userInfo as? UIView {
            processWithView(view)
        } else if let view = obj as? UIView {
            processWithView(view)
        }
    }
    
    func keyboard_initializeView(_ view: UIView) {
        if let textField = view as? UITextField,
            let delegate = self as? UITextFieldDelegate, textField.returnKeyType == UIReturnKeyType.default &&
            textField.delegate !== delegate {
            textField.delegate = delegate
            let otherView = keyboard_findNextInputViewAfterView(view, beneathView: self)
            textField.returnKeyType = otherView != nil ? .next : .done
        }
    }
    
    func keyboardState() -> KeyboardState {
        return state != nil ? state! : KeyboardState()
    }
}
class KeyboardState {
    var priorInset = UIEdgeInsets.zero
    var priorScrollIndicatorInsets = UIEdgeInsets.zero
    var keyboardVisible = false
    var keyboardRect = CGRect.zero
    var priorContentSize = CGSize.zero
    var priorPagingEnabled = false
}

extension UIScrollView {
    fileprivate struct AssociatedKeysKeyboard {
        static var key = "KeyBoardSmart"
    }
    
    var state: KeyboardState? {
        get { // get
            let optionalObject = objc_getAssociatedObject(self, &AssociatedKeysKeyboard.key) as AnyObject?
            if let object = optionalObject {
                return object as? KeyboardState
            } else {
                return nil
            }
        }
        set { // set
            objc_setAssociatedObject(self, &AssociatedKeysKeyboard.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
