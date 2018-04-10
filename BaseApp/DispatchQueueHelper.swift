//
//  DispatchQueueHelper.swift
//  iOSTraining82017
//
//  Created by Nguyen Phong on 8/23/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class DispatchQueueHelper {
    fileprivate let dispatchQueue: DispatchQueue
    fileprivate let dispatchSemaphore: DispatchSemaphore
    open var broken: Bool = false
    
    public init(label: String, value: Int) {
        guard !label.isEmpty, value > 0 && value < 10 else {
            dispatchQueue = DispatchQueue(label: "DispatchQueueDefault")
            dispatchSemaphore = DispatchSemaphore(value: 1)
            return
        }
        dispatchQueue = DispatchQueue(label: label)
        dispatchSemaphore = DispatchSemaphore(value: value)
    }
}

extension DispatchQueueHelper {
    
    fileprivate func wait(_ completion: @escaping() -> Void) {
        if self.broken {
            return
        }
        DispatchQueue.main.async(execute: completion)
        _ = self.dispatchSemaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
    fileprivate func resume(_ completion: ((Bool) -> Void)?, finished: Bool) {
        completion?(finished)
        dispatchSemaphore.signal()
    }
}
