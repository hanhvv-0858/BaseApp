//
//  ExampleTargetClosureViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/12/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    
    //typealias DidTapButton = (Button) -> ()
    
    var didTouchUpInside: ((Button) -> ())? {
        didSet {
            if didTouchUpInside != nil {
                addTarget(self, action: #selector(Button.didTouchUpInsideFunc(_:)), for: .touchUpInside)
            }else {
                removeTarget(self, action: #selector(Button.didTouchUpInsideFunc(_:)), for:.touchUpInside)
            }
        }
    }
    
    
    func didTouchUpInsideFunc(_ sender: UIButton){
        if let handler = didTouchUpInside {
            handler(self)
        }
    }
    
}
class ExampleTargetClosureViewController: UIViewController {
    
    var btnRed = UIButton()
    var btnGreen = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        btnGreen.frame.size = CGSize(width: 150, height: 50)
        btnGreen.center = view.center
        btnGreen.backgroundColor = UIColor.green
        
        btnGreen.setTitle("Button Green", for: .normal)
        btnGreen.setTitleColor(.white, for: .normal)
        
        btnRed.frame = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2 + 50, width: 150, height: 50)
        btnRed.backgroundColor = UIColor.red
        btnRed.setTitle("Button Red", for: .normal)
        btnRed.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(btnRed)
        self.view.addSubview(btnGreen)
        
        //Mark: - Using addTarget
        btnRed.addTarget(self, action: #selector(ExampleTargetClosureViewController.btnRedClick(_:)), for: .touchUpInside)
        
        //Mark: Using Target Closures
        btnGreen.didTouchUpInside = {(button) -> Void in
            print("btnGreenClick")
            UIView.animate(withDuration: 4, animations: {() -> Void in
                button.layer.backgroundColor = UIColor.blue.cgColor
                //button.alpha = 0.5
                //button.isHidden = true
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        btnGreen.didTouchUpInside = nil
    }
    
    func btnRedClick(_ sender: UIButton) {
        print("btnRedClick")
        UIView.animate(withDuration: 4, animations: {()-> Void in
            sender.layer.backgroundColor = UIColor.blue.cgColor
            //sender.alpha = 0.5
        }, completion: {value in
            UIView.animate(withDuration: 4, animations: {() -> Void in
                sender.layer.backgroundColor = UIColor.red.cgColor
                //sender.alpha = 1
            })
        })
    }
    
    
}
