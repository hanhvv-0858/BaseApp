//
//  MultiCellViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/17/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class MultiCellViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    var cellManagers = [CellManager<BaseCell>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataCell = DataCellTextTableViewCell(name: "Phong")
        //cellManagers.append(CellManager<TextTableViewCell>(cell: TextTableViewCell.self, dataCell: dataCell))
        
    }
}

extension MultiCellViewController {
    
    fileprivate func registerCell() {
        cellManagers.forEach { (cell) in
            tableView.registerCellByNib(cell.cell.type)
        }
    }
}

extension MultiCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellManagers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celldata = cellManagers[indexPath.row].dataCell /// get data
        let cell = cellManagers[indexPath.row].cell.type.dequeueCell(tableView, indexPath: indexPath) /// get cell
        cell.update(cellData: celldata) /// update cell from data
        return cell
    }
}
