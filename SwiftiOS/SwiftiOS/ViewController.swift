//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class Json {
    
    // MARK: Value
    /// 数据
    var json: AnyObject?
    
    // MARK: Init
    init(_ data: NSData?) {
        if let data = data {
            if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) {
                self.json = json
            }
        }
    }
    
    // 下标访问
    
    subscript(keys: String...) -> AnyObject? {
        if var dic = json as? [String: AnyObject] {
            for (i,key) in keys.enumerate() {
                if i == keys.count-1 {
                    return dic[key]
                } else {
                    if let tmp = dic[key] as? [String: AnyObject] {
                        dic = tmp
                    } else {
                        return nil
                    }
                }
            }
        }
        return nil
    }
    
    // MARK: 函数访问
    
    func array<T>(keys: String...) -> T? {
        
        return nil
    }
    
    func value(key: String, _ null: String = "") -> String {
        if let dic = json as? [String: AnyObject] {
            if let value = dic[key] as? String {
                return value
            }
        }
        return null
    }
    
    func value<T>(key: String, _ null: T) -> T {
        if let dic = json as? [String: AnyObject] {
            if let value = dic[key] as? T {
                return value
            }
        }
        return null
    }
    
}



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = Network.data([
            "name": "Yes",
            "code": 0,
            "double": 0.0,
            "sub": [
                    "a": [
                        "aa": "sub.a.aa"
                    ],
                    "b": [
                        "bb": "sub.b.bb"
                    ]
                ]
                
            ])
        
        let json = Json(data)
        //let name = json["name"]
        //let ty = json.value("sub", [[String:AnyObject]]())
        //let ty = json.array("sub", [String: AnyObject]())
        let ty = json["sub", "a", "aa"]
        print(ty)
        
//        let count = UnsafeMutablePointer<UInt32>.alloc(1)
//        let properties = class_copyPropertyList(Test1.classForCoder(), count)
//        for i in 0 ..< Int(count.memory) {
//            let property = properties[i]
//            
//            let name = String(UTF8String: property_getName(property))
//            let type = String(UTF8String: property_getAttributes(property))
//            print("name = \(name); Attributes = \(type)")
//        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Done")
    }
}

extension UIInterfaceOrientationMask {
    
    func orientations() -> [UIInterfaceOrientation] {
        switch self {
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
}
