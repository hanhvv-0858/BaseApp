//
//  SegueAnimations.swift
//  DesignableX_IB
//
//  Created by Phong Nguyen on 7/24/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//
import UIKit

class ScaleSegue: UIStoryboardSegue {
    
    override func perform() {
        animation()
    }
    
    func animation() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = fromViewController.view.center
        fromViewController.view.superview?.addSubview(toViewController.view)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { _ in
            fromViewController.present(toViewController, animated: false, completion: nil)
        })
    }
}


class UnwindScaleSegue: UIStoryboardSegue {
    
    override func perform() {
        animation()
    }
    
    func animation() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        fromViewController.view.superview?.insertSubview(toViewController.view, at: 0)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        }, completion: { _ in
            fromViewController.dismiss(animated: false, completion: nil)
        })
    }
}

class ProceedToAppStoryboardSegue: UIStoryboardSegue {
    
    override func perform() {
        animation()
    }
    
    func animation() {
        let fromViewController = self.source
        let toViewController = self.destination
        
        fromViewController.view.addSubview(toViewController.view)
        toViewController.view.transform = CGAffineTransform(translationX: source.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        toViewController.view.transform = CGAffineTransform.identity
        }, completion: { _ in
            self.source.present(self.destination, animated: false, completion: nil)
        })
        
    }
}

class NewClass: UIStoryboardSegue {
    
    override func perform() {
        animation()
    }
    
    func animation() {
        let source = self.source
        let destination = self.destination
        
        UIGraphicsBeginImageContext(source.view.bounds.size)
        source.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let sourceImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        destination.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let destinationImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let sourceImageView: UIImageView = UIImageView (image: sourceImage)
        let destinationImageView: UIImageView = UIImageView (image: destinationImage)
        source.view.addSubview(sourceImageView)
        source.view.addSubview(destinationImageView)
        destinationImageView.transform = CGAffineTransform(translationX: destinationImageView.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 1.0, animations: { () in
            sourceImageView.transform = CGAffineTransform(translationX: -sourceImageView.frame.size.width, y: 0)
            destinationImageView.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { _ in
            source.present(destination, animated: true, completion: nil)
        })
    }
    
}
