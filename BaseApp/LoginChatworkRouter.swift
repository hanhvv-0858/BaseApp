//
//  LoginRouter.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import FirebaseAuth

class LoginChatworkRouter {
    
    static func loginAnonymous() {
        Auth.auth().signInAnonymously { (user, error) in
            if error == nil {
                
            } else {
                
            }
        }
    }
    
}
