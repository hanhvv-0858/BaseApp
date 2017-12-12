//
//  NPPulseButton.swift
//  NPPulseButton
//
//  Created by Phong Nguyen on 7/24/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit


@IBDesignable
open class UIButtonPulse: UIButton {

    var mainLayer: CAShapeLayer?
    var animationGroup: CAAnimationGroup?
    
    @IBInspectable
    var pulseColor: UIColor = UIColor.clear {
        didSet {
            
        }
    }
    @IBInspectable
    var buttonColor: UIColor = UIColor.clear {
        didSet {
        
        }
    }
    @IBInspectable
    var pulseScale: CGFloat = 0 {
        didSet {
        
        }
    }
    @IBInspectable
    var pulseDuration: CGFloat = 0 {
        didSet {
        
        }
    }
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let pulse = createPulse()
        self.layer.insertSublayer(pulse, below: mainLayer)
        DispatchQueue.global(qos: .default).async {
            self.createAnimationGroup()
            DispatchQueue.main.async {
                pulse.add(self.animationGroup!, forKey: "pulse")
            }
        }
    }
    
    func setup() {
        mainLayer = CAShapeLayer()
        mainLayer?.backgroundColor = buttonColor.cgColor
        mainLayer?.bounds = self.bounds
        mainLayer?.cornerRadius = cornerRadius
        mainLayer?.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        mainLayer?.zPosition = -1
        self.layer.addSublayer(mainLayer!)
    }
    
    public func createPulse() -> CAShapeLayer {
        let pulse = CAShapeLayer()
        pulse.backgroundColor = pulseColor.cgColor
        pulse.contentsScale = UIScreen.main.scale
        pulse.bounds = self.bounds
        pulse.cornerRadius = cornerRadius
        pulse.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        pulse.zPosition = -2
        pulse.opacity = 0
        return pulse
    }
    
    public func createAnimationGroup() {
        animationGroup = CAAnimationGroup()
        animationGroup?.animations = [createScaleAnimation(), createOpacityAnimation()]
        animationGroup?.duration = CFTimeInterval(pulseDuration)
    }
    
    //Using KVC
    public func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = pulseScale
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return scaleAnimation
    }
    //Using KVC
    public func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [0.8, 0.4, 0]
        opacityAnimation.keyTimes = [0, 0.5, 1]
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return opacityAnimation
    }
    
    //Setup buttonColor and conerRadius
    public func setPulseButtonColor(_ buttonColor: UIColor) {
        self.buttonColor = buttonColor
        self.layer.backgroundColor = buttonColor.cgColor
    }
    
    public func setCornerButtonRadius(_ cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        self.layer.cornerRadius = cornerRadius
    }
    

}
