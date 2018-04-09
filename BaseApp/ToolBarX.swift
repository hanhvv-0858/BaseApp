//
//  ToolbarsX.swift
//  DesignableX_IB
//
//  Created by Phong Nguyen on 7/14/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
open class ToolBarX: UIToolbar {

    
    func createToolbar(titleLeft: String = "Cancel", titleRight: String = "Done"){
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .blackTranslucent
        toolBar.isTranslucent = true
        toolBar.backgroundColor = UIColor.blue
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: titleRight, style: .plain, target: self, action: #selector(ToolBarX.rightClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: titleLeft, style: .plain, target: self, action: #selector(ToolBarX.leftClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
    }
    
    func rightClick() {
        //do something here
    }
    
    func leftClick() {
        //do something here
    }
}
