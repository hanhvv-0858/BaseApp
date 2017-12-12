//
//  LogDebug.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

public func logD(_ object: Any? = nil, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    #if !NDEBUG
        let className = (fileName as NSString).lastPathComponent
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let date = formatter.string(from: NSDate() as Date)
        print("⚠️ [\(date)] <\(className)> \(functionName) [#\(lineNumber)] \n\(object ?? "Object is nil")\n")
    #endif
}

public func logDJSON(_ object: AnyObject, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    #if !NDEBUG
        let className = (fileName as NSString).lastPathComponent
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let date = formatter.string(from: NSDate() as Date)
        print("⚠️ [\(date)] <\(className)> \(functionName) [#\(lineNumber)] \n\( printJSON(value: object) ?? "Object is nil")\n")
    #endif
}

private func printJSON(value: AnyObject, prettyPrinted: Bool = true) -> String? {
    let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : nil
    if JSONSerialization.isValidJSONObject(value) {
        do {
            let data = try JSONSerialization.data(withJSONObject: value, options: options!)
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                return string as String
            }
        } catch {
            return nil
        }
    }
    return nil
}
