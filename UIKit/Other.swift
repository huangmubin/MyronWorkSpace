//
//  Other.swift
//  
//
//  Created by 黄穆斌 on 16/8/6.
//
//

import UIKit

// MARK: UIViewController

/// 根据 View 获取他的 ViewController
func superViewController(view: UIView) -> UIViewController? {
    var responder: UIResponder? = view
    while responder != nil {
        responder = responder?.nextResponder()
        if responder?.isKindOfClass(UIViewController.self) == true {
            break
        }
    }
    return responder as? UIViewController
}

// UIInterfaceOrientationMask 转换成为 [UIInterfaceOrientation]
func orientations(mask: UIInterfaceOrientationMask) -> [UIInterfaceOrientation] {
    switch mask {
    case UIInterfaceOrientationMask.Portrait:
        return [UIInterfaceOrientation.Portrait]
    case UIInterfaceOrientationMask.LandscapeRight:
        return [UIInterfaceOrientation.LandscapeRight]
    case UIInterfaceOrientationMask.LandscapeLeft:
        return [UIInterfaceOrientation.LandscapeLeft]
    case UIInterfaceOrientationMask.PortraitUpsideDown:
        return [UIInterfaceOrientation.PortraitUpsideDown]
    case UIInterfaceOrientationMask.Landscape:
        return [UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight]
    case UIInterfaceOrientationMask.All:
        return [UIInterfaceOrientation.Portrait, UIInterfaceOrientation.PortraitUpsideDown, UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight]
    case UIInterfaceOrientationMask.AllButUpsideDown:
        return [UIInterfaceOrientation.Portrait, UIInterfaceOrientation.PortraitUpsideDown, UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight]
    default:
        return []
    }
}

// MARK: Swift

// 二进制转换: IntegerType 转换成为 String
func binary<T: IntegerType>(value: T) -> String {
    var bit: Int
    var binary: String
    switch value.self {
    case is Int:
        bit = String(Int.max, radix: 2).characters.count
        binary = String(value as! Int, radix: 2)
    case is Int16:
        bit = String(Int16.max, radix: 2).characters.count
        binary = String(value as! Int16, radix: 2)
    case is Int32:
        bit = String(Int32.max, radix: 2).characters.count
        binary = String(value as! Int32, radix: 2)
    case is Int64:
        bit = String(Int64.max, radix: 2).characters.count
        binary = String(value as! Int64, radix: 2)
    case is Int8:
        bit = String(Int8.max, radix: 2).characters.count
        binary = String(value as! Int8, radix: 2)
    case is UInt:
        bit = String(UInt.max, radix: 2).characters.count
        binary = String(value as! UInt, radix: 2)
    case is UInt16:
        bit = String(UInt16.max, radix: 2).characters.count
        binary = String(value as! UInt16, radix: 2)
    case is UInt32:
        bit = String(UInt32.max, radix: 2).characters.count
        binary = String(value as! UInt32, radix: 2)
    case is UInt64:
        bit = String(UInt64.max, radix: 2).characters.count
        binary = String(value as! UInt64, radix: 2)
    case is UInt8:
        bit = String(UInt8.max, radix: 2).characters.count
        binary = String(value as! UInt8, radix: 2)
    default:
        return ""
    }
    var prefix = ""
    for _ in 0 ..< bit - binary.characters.count {
        prefix += "0"
    }
    return prefix + binary
}

// 二进制转换: String 转成为 Int
func binary(text: String) -> Int {
    var value = 0
    for (i,c) in text.characters.enumerate() {
        if c == "1" {
            value = value ^ (1 << (text.characters.count - i - 1))
        } else if c == "0" {
            continue
        } else {
            return 0
        }
    }
    return value
}