//
//  SettingsView.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 4/11/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

class SettingsView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()

    let button = UIButton().with {
        $0.backgroundColor = UIColor.gray
        $0.layer.opacity = 0.5
        $0.addTarget(self, action: #selector(hideSettingsView), for: .touchUpInside)
    }
    
    var eventClick: ((Int) -> Void)?
    let items = ["Settings", "Terms & privacy policy", "Send Feedback", "Help", "Switch Account", "Cancel"]
    var tableViewBottonConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func hideSettingsView() {
        self.tableViewBottonConstraint?.isActive = false
        self.tableViewBottonConstraint?.constant = -self.tableView.bounds.height
        self.tableViewBottonConstraint?.isActive = true
        UIView.animate(withDuration: 0.3, animations: {
            self.button.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
        }
    }
    
    fileprivate func setupView() {
        addSubview(tableView)
        button.alpha = 0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        tableViewBottonConstraint = tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        tableViewBottonConstraint?.constant = -self.tableView.bounds.height
        tableViewBottonConstraint?.isActive = true
        layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(CellSettingsView.type, forIndexPath: indexPath)
        cell.updateCell(title: items[indexPath.row], imgName: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventClick?(indexPath.row)
    }
    
}
