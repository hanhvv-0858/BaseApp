//
//  UserViewModel.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
import Alamofire

protocol UserModelToViewProtocol {
    func updateUI(infomation: Infomation)
}

class UserViewModel: NSObject {
    var user = [User]()
    
    var delegate: UserModelToViewProtocol
    
    init(_ delegate: UserModelToViewProtocol) {
        self.delegate = delegate
    }
    
}


// MARK: - Extension + API
extension UserViewModel {
    fileprivate func getJSON() {
        Alamofire.request("https://httpbin.org/get").responseString { response in
            let infomation = try! JSONDecoder().decode(Infomation.self, from: response.data!)
            self.delegate.updateUI(infomation: infomation)
        }
    }
    
    fileprivate func responseObject() {
        Alamofire.request("https://httpbin.org/get").responseObject { (response: DataResponse<User>) in
            logD(response)
            if let user = response.result.value {
                logD(user)
            }
        }
    }
    
    fileprivate func responseCollectionObject() {
        Alamofire.request("https://example.com/users").responseCollection { (response: DataResponse<[Users]>) in
            logD(response)
        }
    }
}

// MARK: Extension + Delegate
extension UserViewModel: UITableViewDelegate {

}

extension UserViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as?
            UserTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
