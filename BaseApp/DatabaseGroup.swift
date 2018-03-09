//
//  File.swift
//  BaseApp
//
//  Created by Phong Nguyen on 3/9/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import RealmSwift

class DatabaseGroup {
    
    static var shared = DatabaseGroup()
    
    func removeAllRealmData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}

