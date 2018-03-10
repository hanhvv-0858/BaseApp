//
//  File.swift
//  BaseApp
//
//  Created by Phong Nguyen on 3/9/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import RealmSwift

var offlineRealm : Realm {
    let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                         appropriateFor: nil, create: false)
    let url = documentDirectory.appendingPathComponent("drafts.realm")
    var config = Realm.Configuration()
    config.fileURL = url
    let realm = try! Realm(configuration: config)
    return realm
}

// Define your models like regular Swift classes
class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}
class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var picture: Data? = nil // optionals supported
    let dogs = List<Dog>()
}


class DatabaseGroup {
    
    static var shared = DatabaseGroup()
    
    fileprivate init() {}
    
    func removeAllRealmData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func addOfflineRealm() {
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("name of dog: \(myDog.name)")
        print("age of dog: \(myDog.age)")

        try! offlineRealm.write {
            offlineRealm.add(myDog)
            logD(offlineRealm.objects(Dog.type).count)
        }
        
    }
    
    func removeOfflineRealm() {
        try! offlineRealm.write {
            offlineRealm.deleteAll()
            logD(offlineRealm.objects(Dog.type).count)
        }
        
    }
}
