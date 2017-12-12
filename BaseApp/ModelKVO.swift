//
//  ModelKVO.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/12/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

class ModelKVO: NSObject {
    
    //KVO need dynamic
    dynamic var createAt = Date()
    dynamic var updateAt = Date()
}

class ViewModelKVO: NSObject {
    
    var model: ModelKVO
    
    init(model: ModelKVO) {
        self.model = model
        super.init()
    }
    
    lazy private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return dateFormatter
    }()
    
    // cho phep viewController lay thoi gian
    var createAt: String {
        return dateFormatter.string(from: model.createAt)
    }
    var updateAt: String {
        return dateFormatter.string(from: model.updateAt)
    }
    
    //cap nhat thoi gian
    func updateTime() {
        model.updateAt = Date()
    }
    
}
