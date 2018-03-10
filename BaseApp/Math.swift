//
//  Math.swift
//  BaseApp
//
//  Created by Phong Nguyen on 3/10/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import SpriteKit

/**
 
 Returns a "smoothed" position between the starting and ending points.
 
 - Parameter start: The starting CGPoint.
 - Parameter end:   The destination CGPoint.
 - Parameter percent: Percentage of distance to move between the start and end.
 Range is between 0.0 meaning 0% and 1.0 meaning 100%.
 
 - Returns: CGPoint calculated to be percentToMove distance between startPoint and endPoint.
 
 **/
func Smooth(start: CGFloat, end: CGFloat, percent: CGFloat) -> CGFloat {
    return (start * (1 - percent)) + end * percent
}

/**
 Returns a random Integer between and including the values supplied for min and max.
 
 - Parameter min: The minimum value that should be retured.
 - Parameter max: The maximum value that should be returned.
 
 - Returns: Integer between and including the values supplied for min and max.
 **/
func RandomIntegerBetween(min: Int, max: Int) -> Int {
    return Int(UInt32(min) + arc4random_uniform(UInt32(max - min + 1)))
}


/**
 Returns a random CGFloat betwen and including the values supplied for min and max.
 
 - Parameter min: The minimum value that should be returned.
 - Parameter max: The maximum value that should be returned.
 
 - Returns: CGFloat between and including the values supplied for min and max.
 **/
func RandomFloatRange(min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
}


func AngleBetween(targetPosition: CGPoint, currentPosition: CGPoint) -> CGFloat {
    let deltaX = targetPosition.x - currentPosition.x
    let deltaY = targetPosition.y - currentPosition.y
    
    return CGFloat(atan2(Float(deltaY), Float(deltaX))) - DegreesToRadians(degrees: 90)
}

func DistanceBetween(first: CGPoint, second: CGPoint) -> CGFloat {
    return CGFloat(hypotf(Float(second.x - first.x), Float(second.y - first.y)))
}

func DegreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * .pi / 180.0
}

func RadiansToDegrees(radians: CGFloat) -> CGFloat {
    return radians * 180.0 / .pi
}
