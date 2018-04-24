//
//  Extension_TabarController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 4/24/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    func setBadges(badgeValues: [Int]) {
        for view in self.tabBar.subviews where view is CustomTabBadge {
            view.removeFromSuperview()
        }
        for index in 0...badgeValues.count-1 where badgeValues[index] != 0 {
            if  badgeValues.indices.contains(index) {
                addBadge(index: index, value: badgeValues[index])
            }
        }
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        self.positionBadges()
    }
    
    private func addBadge(index: Int, value: Int) {
        let badgeView = CustomTabBadge()
        badgeView.clipsToBounds = true
        badgeView.textColor = UIColor.white
        badgeView.textAlignment = .center
        badgeView.font = UIFont.systemFont(ofSize: 8)
        badgeView.text = String(value)
        badgeView.backgroundColor = UIColor(red: 220/255.0, green: 21/255.0, blue: 25/255.0, alpha:1.0)
        badgeView.tag = index
        tabBar.addSubview(badgeView)
        self.positionBadges()
    }
    
    private func positionBadges() {
        var tabbarButtons = self.tabBar.subviews.filter { (view: UIView) -> Bool in
            return view.isUserInteractionEnabled // only UITabBarButton are userInteractionEnabled
        }
        tabbarButtons = tabbarButtons.sorted(by: { $0.frame.origin.x < $1.frame.origin.x })
        for view in self.tabBar.subviews where view is CustomTabBadge {
            if let badgeView = view as? CustomTabBadge {
                self.positionBadge(badgeView: badgeView, items:tabbarButtons, index: badgeView.tag)
            }
        }
    }
    
    private func positionBadge(badgeView: UIView, items: [UIView], index: Int) {
        let itemView = items[index]
        let center = itemView.center
        let xOffset: CGFloat = 15
        let yOffset: CGFloat = -14
        badgeView.frame.size = CGSize(width: 16, height: 16)
        badgeView.center = CGPoint(x: center.x + xOffset, y: center.y + yOffset)
        badgeView.layer.cornerRadius = badgeView.bounds.width/2
        badgeView.layer.borderWidth = 1
        badgeView.layer.borderColor = UIColor.white.cgColor
        tabBar.bringSubview(toFront: badgeView)
    }
}

class CustomTabBadge: UILabel {}
