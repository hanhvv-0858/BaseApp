//
//  UIProgreeBarX.swift
//  DesignableX_IB
//
//  Created by Phong Nguyen on 7/24/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
class CustomProgreeBar: UIView {
    fileprivate let progressLayer: CAShapeLayer = CAShapeLayer()
    fileprivate var progressLabel: UILabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        progressLabel = UILabel()
        super.init(coder: aDecoder)!
        createProgressLayer()
        createLabel()
    }
    
    override init(frame: CGRect) {
        progressLabel = UILabel()
        super.init(frame: frame)
        createProgressLayer()
        createLabel()
    }
    
    
    
    func createLabel() {
        progressLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: 60.0))
        progressLabel.textColor = .white
        progressLabel.textAlignment = .center
        progressLabel.text = "Content"
        progressLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30.0)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        //centerX + centerY
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: progressLabel, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: progressLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    fileprivate func createProgressLayer() {
        let startAngle = CGFloat(Double.pi / 2)
        let endAngle = CGFloat(Double.pi * 2 + Double.pi / 2)
        let centerPoint = CGPoint(x: frame.width/2, y: frame.height/2)
        
        let gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: frame.width/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).cgPath
        progressLayer.backgroundColor = UIColor.red.cgColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.lineWidth = 14.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        
        gradientMaskLayer.mask = progressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    fileprivate func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = [0.0, 1.0]
        let colorTop: AnyObject = UIColor.red.cgColor
        let colorBottom: AnyObject = UIColor.green.cgColor
        let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    
    public func stopProgressView() {
        progressLayer.strokeEnd = 0.0
        progressLayer.removeAllAnimations()
        progressLabel.text = "Content"
    }
    
    public func startProgressView() {
        progressLabel.text = "Loading..."
        progressLayer.strokeEnd = 0.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = kCAFillModeForwards
        progressLayer.add(animation, forKey: "strokeEnd")
    }
    
}
