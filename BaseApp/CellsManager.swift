//
//  UpdateCell.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/17/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

protocol UpdateCell {
    associatedtype DataCell
    func update(cellData: DataCell)
}

class BaseCell: UITableViewCell {
    
}
extension BaseCell: UpdateCell {
    typealias DataCell = BaseCell
    func update(cellData: BaseCell) {
        fatalError("not using BaseCell")
    }
}

/// manager (cell, data, update cell from data)
struct CellManager<Cell> where Cell: UpdateCell, Cell: UITableViewCell {
    let cell: Cell
    let dataCell: Cell.DataCell
    func update(cell: Cell) {
        cell.update(cellData: dataCell)
    }
}
