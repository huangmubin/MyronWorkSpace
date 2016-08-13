//
//  SwiftOther.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/8/14.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

// MARK: - Extension NSObject

extension NSObject {
    
    /// 所有属性名称
    func propertyNames() -> [String] {
        var outCount:UInt32 = 0
        let propers:UnsafeMutablePointer<objc_property_t>! = class_copyPropertyList(self.classForCoder, &outCount)
        var names = [String]()
        for i in 0 ..< Int(outCount) {
            names.append(String(UTF8String: property_getName(propers[i]))!)
        }
        return names
    }
    
    /// 所有方法名称
    func methodNames() -> [String] {
        var outCount:UInt32 = 0
        let methods:UnsafeMutablePointer<objc_property_t>! = class_copyMethodList(self.classForCoder, &outCount)
        var names = [String]()
        for i in 0 ..< Int(outCount) {
            names.append(String(UTF8String: property_getName(methods[i]))!)
        }
        return names
    }
}
