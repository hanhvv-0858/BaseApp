//
//  Extension+UIViewController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

// MARK: - Load UIViewController
extension UIViewController: ResponseUIViewController {
    
}

// MARK: - Extension Present + Push + Pop
extension UIViewController {
    
    func present(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func popNavigationController<T: UIViewController>(vc: T.Type? = nil, toRoot: Bool = false) {
        if vc == nil { /// toRoot using when vc == nil
            if toRoot {
                navigationController?.popToRootViewController(animated: true)
            } else {
                navigationController?.popViewController(animated: true)
            }
        } else {
            if let popVC = navigationController?.viewControllers.filter({$0 is T}).first {
                navigationController?.popToViewController(popVC, animated: true)
            }
        }
    }
    
    func pushNavigationController(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismissNavigationController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ShowAlert
extension UIViewController {
}

// MARK: - ShowSpinner
extension UIViewController {
    
    func showSpinner() -> UIView {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    func removeSpinner(_ spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
