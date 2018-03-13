//
//  CRUDViewController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 3/13/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - Model
class Account {
    var email: String?
    var name: String?
    
    init(email: String, name: String) {
        self.email = email
        self.name = name
    }
    
    static func factoryObject(_ acc: DBAccount) -> Account {
        return Account(email: acc.email, name: acc.name)
    }
}

// MARK: - DBObject
class DBAccount: Object {
    
    dynamic var email: String = ""
    dynamic var name: String = ""
    
    convenience init(name: String, email: String) {
        self.init()
        self.name = name
        self.email = email
    }
    
    static func factoryObject(_ acc: Account) -> DBAccount? {
        guard let name = acc.name, let email = acc.email else {
            return nil
        }
        return DBAccount(name: name, email: email)
    }
}

// MARK: - CRUD DB (Data Access Object)
class DAOAccount {
    
    func createDB(_ acc: Account){
        do {
            let realm = try Realm()
            try realm.write {
                if let acc = DBAccount.factoryObject(acc) {
                    realm.add(acc)
                }
            }
        } catch let error as NSError {
            // handle error
            logD(error)
        }
    }
    
    func updateDB(_ acc: Account) {
        do {
            let realm = try Realm()
            try realm.write {
                if let account = realm.objects(DBAccount.type).first {
                    account.name = acc.name!
                    account.email = acc.email!
                }
            }
        } catch let error as NSError {
            // handle error
            logD(error)
        }
    }
    
    func readDB() -> Results<DBAccount>? {
        do {
            let realm = try Realm()
            return realm.objects(DBAccount.type)
        } catch let error as NSError {
            // handle error
            logD(error)
            return nil
        }
    }
    
    func deleteDB() {
        do {
            let realm = try Realm()
            if let acc = realm.objects(DBAccount.type).first {
                try realm.write {
                    realm.delete(acc)
                    return
                }
            }
        } catch let error as NSError {
            // handle error
            logD(error)
        }
    }
}

class CRUDViewController: UIViewController {
    
    var dataSource: Results<DBAccount>!
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var lblAction: UILabel!
    @IBOutlet fileprivate weak var email: UILabel!
    @IBOutlet fileprivate weak var name: UILabel!
    let daoAccount = DAOAccount()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        do {
            let realm = try Realm()
            let accs = realm.objects(DBAccount.type)
            dataSource = accs
            self.tableView.reloadData()
            
        } catch let error as NSError {
            logD(error)
        }
    }
    
    @IBAction fileprivate func createDB(_ sender: Any) {
        let acc = Account(email: "abc@framgia.com", name: "abc")
        daoAccount.createDB(acc)
        lblAction.text = "Create DB"
        self.tableView.reloadData()
    }
    
    @IBAction fileprivate func updateDB(_ sender: Any) {
        daoAccount.updateDB(Account(email: "xyz@framgia.com", name: "xyz"))
        lblAction.text = "Update DB"
        self.tableView.reloadData()
    }
    
    @IBAction fileprivate func readDB(_ sender: Any) {
        guard let accs = daoAccount.readDB() else {
            return
        }
        for acc in accs {
            logD(acc.email)
            logD(acc.name)
//           let realm = try! Realm()
//            try! realm.write {
//                acc.name = "ngu"
//                acc.email = "hoc"
//            }
        }
        
        self.email.text = accs.first?.email
        self.name.text = accs.first?.name
        lblAction.text = "READ DB"
        self.tableView.reloadData()
    }
    
    @IBAction fileprivate func deleteDB(_ sender: Any) {
        daoAccount.deleteDB()
        lblAction.text = "DELETE DB"
        self.tableView.reloadData()
    }
}

extension CRUDViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource[indexPath.row].email
        cell.detailTextLabel?.text = dataSource[indexPath.row].name
        return cell
    }
}
