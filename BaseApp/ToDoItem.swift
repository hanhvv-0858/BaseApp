//
//  ToDoItem.swift
//  BaseApp
//
//  Created by Phong Nguyen on 3/9/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import RealmSwift

class ToDoItem: Object {
    dynamic var name = ""
    dynamic var finished = false
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

