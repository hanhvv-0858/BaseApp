//
//  Extension+UIAlertController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 12/12/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func showAlert(_ controller: UIViewController, title: String?, message: String?, buttonTitle: String = "OK") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        DispatchQueue.main.async(execute: { () -> Void in
            controller.present(alertController, animated: true, completion: nil)
        })
    }
    
    class func showAlertWithIcon(_ controller: UIViewController, title: String?, message: String?, buttonTitle:String) {
        let lb:UILabel = UILabel(frame: CGRect(x: 130, y: -10, width: 80, height: 80))
        lb.font = UIFont(name: "FontAwesome", size: 18)
        lb.text = "\u{f00c}"
        lb.textColor = UIColor(red: 0/255, green: 118/255, blue: 255/255, alpha: 1)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.addSubview(lb)
        controller.present(alertController, animated: true, completion: nil)
        let delayTime = DispatchTime.now() + DispatchTimeInterval.seconds(2)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            controller.dismiss(animated: true, completion: { () -> Void in
            })
        })
    }
    
    
    class func showAlertWithAction(_ controller: UIViewController, title: String?, message: String?, buttonTitle: String = "OK", okHandle: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { action -> Void in
            okHandle?(action)
        })
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel) { UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async(execute: { () -> Void in
            controller.present(alertController, animated: true, completion: nil)
        })
        
    }
}
