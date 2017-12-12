//
//  ObservableStatus.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

enum BoolState {
    case anyState
    case onlyTrue
    case onlyFalse
}

class Observable<T> {
    fileprivate var _switches: [ObservableSwitch] = []
    fileprivate var _value: T? = nil
    var valueDidChange:(()->())?
    var value: T {
        set {
            _value = newValue
            for s in self._switches {
                s.validate()
            }
            valueDidChange?()
        }
        get {
            return _value!
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addSignal( toSwitch: ObservableSwitch,_ signal: @escaping () -> Bool) {
        for s in self._switches where s === toSwitch {
            s.addSignal(signal)
            return
        }
        
        toSwitch.addSignal(signal)
        self._switches.append(toSwitch)
    }
}

/// Observable change
class ObservableSwitch {
    fileprivate var signals: [() -> Bool] = []
    fileprivate var boolState: BoolState
    var action:((_ status: Bool)->())?
    
    init(_ boolState: BoolState) {
        self.boolState = boolState
    }
    
    fileprivate func addSignal(_ signal: @escaping () -> Bool) {
        self.signals.append(signal)
    }
    
    fileprivate func validate() {
        var result = true
        for check in signals {
            if (result && !check()) {
                result = false
                break
            }
        }

        if boolState == .anyState {
            action?(result)
        }
        else if boolState == .onlyTrue && result {
            action?(true)
        }
        else if boolState == .onlyFalse && !result {
            action?(false)
        }
    }
}
