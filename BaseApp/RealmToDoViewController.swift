//
//  RealmToDoViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 3/9/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit
import RealmSwift

class RealmToDoViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    var items = [Results<ToDoItem>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        setupNavigationBar()
        // data append
        var todos: Results<ToDoItem> {
            get {
                let predicate = NSPredicate(format: "finished == false", argumentArray: nil)
                let realm = try! Realm()
                return realm.objects(ToDoItem.self).filter(predicate)
            }
        }
        
        var finished: Results<ToDoItem> {
            get {
                let predicate = NSPredicate(format: "finished == true", argumentArray: nil)
                let realm = try! Realm()
                return realm.objects(ToDoItem.self).filter(predicate)
            }
        }
        items.append(todos)
        items.append(finished)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonAction))
    }
    
    @objc fileprivate func addButtonAction() {
        let AddToDoVC = AddToDoViewController()
        AddToDoVC.doneActionCallBack = { text in
            guard let text = text else {
                return
            }
            
            if text.utf16.count > 0 {
                let newToDoItem = ToDoItem()
                newToDoItem.name = text
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(newToDoItem)
                }
                self.tableView.reloadData()
            }
        }
        let nav = UINavigationController(rootViewController: AddToDoVC)
        present(nav, animated: true, completion: nil)
        
    }
}

extension RealmToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var todoItem: ToDoItem
        todoItem = items[indexPath.section][indexPath.row]
        let realm = try! Realm()
        try! realm.write {
            todoItem.finished = !todoItem.finished
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Add action to delete our item
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            let realm = try! Realm()
            try! realm.write {
                realm.delete(self.items[indexPath.section][index.row])
            }
            tableView.deleteRows(at: [index], with: .fade)
        }
        delete.backgroundColor = UIColor.red

        let finish = UITableViewRowAction(style: .normal, title: "Change") { (action, index) in
            var todoItem: ToDoItem
            todoItem = self.items[indexPath.section][indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                todoItem.finished = !todoItem.finished
            }
            self.tableView.reloadData()
        }
        
        finish.backgroundColor = UIColor(red: 24/255, green: 116/255, blue: 205/255, alpha: 1)

        return [finish, delete]
    }
}

extension RealmToDoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if items[section].isEmpty {
                return nil
            }
            return "To-Do"
        default:
            if items[section].isEmpty {
                return nil
            }
            return "Finished"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            let todoItem = items[indexPath.section][indexPath.row]
            let attributedText = NSMutableAttributedString(string: todoItem.name)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 0, range: NSMakeRange(0, attributedText.length))
            cell.textLabel?.attributedText = attributedText

        default:
            let todoItem = items[indexPath.section][indexPath.row]
            let attributedText = NSMutableAttributedString(string: todoItem.name)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributedText.length))
            cell.textLabel?.attributedText = attributedText
        }
        return cell
    }
}





