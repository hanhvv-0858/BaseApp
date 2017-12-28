//
//  SwipeAnimation.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 12/28/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

protocol SwipeAnimationDelegate {
    func animatorShouldAnimateTabBar(_ animator: SwipeAnimation) -> Bool
    func animatorTransitionDimAmount(_ animator: SwipeAnimation) -> CGFloat
}

let navigationTransitionCurve = UIViewAnimationOptions(rawValue: 7 << 16)
class SwipeAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var delegate: SwipeAnimationDelegate?
    weak var toViewController: UIViewController?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if let isInteractive = transitionContext?.isInteractive {
            return isInteractive ? 0.25 : 0.5
        }
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        guard  let delegate = delegate else {
            return
        }
        
        transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        let toViewControllerXTranslation = -transitionContext.containerView.bounds.width * 0.3
        toViewController.view.bounds = transitionContext.containerView.bounds
        toViewController.view.center = transitionContext.containerView.center
        toViewController.view.transform = CGAffineTransform(translationX: toViewControllerXTranslation, y: 0)
        
        fromViewController.view.addLeftSideShadowWithFading()
        let previousClipsToBounds = fromViewController.view.clipsToBounds
        fromViewController.view.clipsToBounds = false
        
        let dimmingView = UIView(frame: toViewController.view.bounds)
        let dimAmount: CGFloat = delegate.animatorTransitionDimAmount(self)
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: dimAmount)
        toViewController.view.addSubview(dimmingView)
        
        let tabBarController = toViewController.tabBarController
        let navController = toViewController.navigationController
        let tabBar = tabBarController?.tabBar
        var shouldAddTabBarBackToTabBarController = false
        let tabBarControllerContainsToViewController = tabBarController?.viewControllers?.contains(toViewController) ?? false
        let tabBarControllerContainsNavController  = tabBarController?.viewControllers?.contains(navController ?? UINavigationController()) ?? false
        let isToViewControllerFirstInNavController: Bool = navController?.viewControllers.first == toViewController
        let shouldAnimateTabBar: Bool = delegate.animatorShouldAnimateTabBar(self)
        if shouldAnimateTabBar && (tabBar != nil) && tabBarControllerContainsToViewController || (isToViewControllerFirstInNavController && tabBarControllerContainsNavController) {
            tabBar?.layer.removeAllAnimations()
            var tabBarRect: CGRect? = tabBar?.frame
            tabBarRect?.origin.x = toViewController.view.bounds.origin.x
            tabBar?.frame = tabBarRect!
            toViewController.view.addSubview(tabBar ?? UIView())
            shouldAddTabBarBackToTabBarController = true
        }
        
        let curveOption = transitionContext.isInteractive ? .curveLinear : navigationTransitionCurve
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [curveOption], animations: {() -> Void in
            toViewController.view.transform = .identity
            fromViewController.view.transform = CGAffineTransform(translationX: (toViewController.view.frame.size.width), y: 0)
            dimmingView.alpha = 0.0
        }, completion: {(_ finished: Bool) -> Void in
            if shouldAddTabBarBackToTabBarController {
                tabBarController?.view.addSubview(tabBar ?? UIView())
                var tabBarRect = tabBar?.frame
                if let originX = tabBarController?.view.bounds.origin.x {
                    tabBarRect?.origin.x = originX
                }
                if let tabBarRect = tabBarRect {
                    tabBar?.frame = tabBarRect
                }
            }
            dimmingView.removeFromSuperview()
            fromViewController.view.transform = .identity
            fromViewController.view.clipsToBounds = previousClipsToBounds
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.toViewController = toViewController
        })
    }
    
}
