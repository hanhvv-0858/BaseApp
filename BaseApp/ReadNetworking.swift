//
//  ReadNetworking.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Alamofire
class ReadNetworking {
    
    static let sharedInstance = ReadNetworking()
    private init() {
    }
    
    func start(manager: NetworkReachabilityManager?) {
        manager?.listener = { status in
            switch status {
            case .notReachable:
                break
            case .reachable(.ethernetOrWiFi):
                break
            case .reachable(.wwan):
                break
            case .unknown:
                break
            }
            logD(status)
        }
        manager?.startListening()
    }
}
