//
//  Swipe.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 12/28/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

@objc protocol SwipeDelegate: NSObjectProtocol {
    @objc optional func swipeShouldAnimateTabBar(_ swiper: Swipe) -> Bool
    @objc optional func swipeTransitionDimAmount(_ swiper: Swipe) -> CGFloat
}

class Swipe: NSObject {
    private(set) weak var panRecognizer: UIPanGestureRecognizer?
    fileprivate var delegate: SwipeDelegate?
    @IBOutlet weak var navigationController: UINavigationController!
    fileprivate var animator: SwipeAnimation?
    fileprivate var interactionController: UIPercentDrivenInteractiveTransition?
    fileprivate var duringAnimation: Bool = false
    
    deinit {
        panRecognizer?.removeTarget(self, action: #selector(Swipe.pan))
        if let panRecognizer = panRecognizer {
            navigationController?.view.removeGestureRecognizer(panRecognizer)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit(_ navigationController: UINavigationController? = nil) {
        if  let navigationController = navigationController {
            self.navigationController = navigationController
        }
        let panRecognizer = SwipeGestureRecognizer(target: self, action: #selector(self.pan))
        panRecognizer.direction = .right
        panRecognizer.maximumNumberOfTouches = 1
        panRecognizer.delegate = self
        navigationController?.view.addGestureRecognizer(panRecognizer)
        self.panRecognizer = panRecognizer
        animator = SwipeAnimation()
        animator?.delegate = self
    }
}

extension Swipe {
    
    @objc func pan(_ recognizer: UIPanGestureRecognizer) {
        guard let view = navigationController?.view else {
            return
        }
        let translation: CGPoint = recognizer.translation(in: view)
        let distance: CGFloat = translation.x > 0 ? translation.x / (view.bounds.width) : 0
        if recognizer.state == .began {
            if navigationController!.viewControllers.count > 1 && !duringAnimation {
                interactionController = UIPercentDrivenInteractiveTransition()
                interactionController?.completionCurve = .easeOut
                navigationController?.popViewController(animated: true)
            }
        } else if recognizer.state == .changed {
            interactionController?.update(distance)
        }
        else if recognizer.state == .ended || recognizer.state == .cancelled {
            if distance > 1/2 {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
                duringAnimation = false
            }
            interactionController = nil
        }
    }
    
    @objc func sloppySwiperShouldAnimateTabBar() {}
    @objc func sloppySwiperTransitionDimAmount() {}
}

extension Swipe: SwipeAnimationDelegate {
    func animatorShouldAnimateTabBar(_ animator: SwipeAnimation) -> Bool {
        if delegate?.responds(to: #selector(Swipe.sloppySwiperShouldAnimateTabBar)) == true {
            return delegate?.swipeShouldAnimateTabBar?(self) ?? false
        } else {
            return true
        }
    }
    
    func animatorTransitionDimAmount(_ animator: SwipeAnimation) -> CGFloat {
        if delegate?.responds(to: #selector(Swipe.sloppySwiperTransitionDimAmount)) == true {
            return delegate?.swipeTransitionDimAmount?(self) ?? 0
        } else {
            return 0.1
        }
    }
}


extension Swipe: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if navigationController.viewControllers.count > 1 {
            return true
        }
        return false
    }
}

extension Swipe: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return animator
        }
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if animated {
            duringAnimation = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        duringAnimation = false
        if navigationController.viewControllers.count <= 1 {
            panRecognizer?.isEnabled = false
        } else {
            panRecognizer?.isEnabled = true
        }
    }
}

