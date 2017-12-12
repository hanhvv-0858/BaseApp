//
//  RealmManager.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import RealmSwift

struct RealmManager {
    
    static func config() {
        let fileURL = Realm.Configuration.defaultConfiguration.fileURL
        logD("\(String(describing: fileURL))")
        
        // get schema version
        let schemaVersion = UInt64("Config")!
        
        // create config
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < schemaVersion {
                }
        })
        
        // set config
        Realm.Configuration.defaultConfiguration = config
    }
}

