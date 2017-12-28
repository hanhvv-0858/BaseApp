//
//  KeyboardSmart.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 1/4/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

class KeyboardSmart: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableViewSmart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
}

extension KeyboardSmart {
    fileprivate func registerCell() {
        tableView.registerCellByNib(KeyboardSmartTableViewCell.type)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension KeyboardSmart: UITableViewDelegate {
    
}

extension KeyboardSmart: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KeyboardSmartTableViewCell.dequeueCell(tableView, indexPath: indexPath)
        cell.tfName.placeholder = "input text" + String(indexPath.row)
        return cell
    }
    
    
}


