//
//  ExampleKVOViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/12/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class ExampleKVOViewController: UIViewController {

    @IBOutlet weak fileprivate var timeLabel: UILabel!
    let viewModelKVO = ViewModelKVO(model: ModelKVO())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addObserver(self, forKeyPath: #keyPath(viewModelKVO.model.updateAt), options: [.old,.new, .initial], context: nil)
        
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(viewModelKVO.model.updateAt))
    }
    
    @IBAction fileprivate func updateTime(_ sender: AnyObject) {
        viewModelKVO.updateTime()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(viewModelKVO.model.updateAt) {
            timeLabel.text = viewModelKVO.updateAt
        }
    }
}
