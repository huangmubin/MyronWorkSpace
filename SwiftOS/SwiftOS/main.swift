//
//  main.swift
//  SwiftOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Foundation

//cTestFunction()


// MARK: - Json 数据处理
class Json2 {
    
    // MARK: Value
    /// 数据
    var json: AnyObject? {
        didSet {
            result = json
        }
    }
    var result: AnyObject?
    
    var int: Int? { return result as? Int }
    var double: Double? { return result as? Double }
    var string: String? { return result as? String }
    var array: [Json2] {
        if let value = result as? [AnyObject] {
            var arr = [Json2]()
            for v in value {
                arr.append(Json2(v))
            }
            return arr
        } else {
            return []
        }
    }
    var dictionary: [String: Json2] {
        if var value = result as? [String: AnyObject] {
            for (k, v) in value {
                value[k] = Json2(v)
            }
            return value as! [String: Json2]
        }
        return [:]
    }
    func type<T>(null: T) -> T {
        if let v = result as? T {
            return v
        } else {
            return null
        }
    }
    
    // MARK: Init
    init(_ data: NSData?) {
        if let data = data {
            if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) {
                self.json = json
                self.result = json
            }
        }
    }
    private init(_ data: AnyObject) {
        json = data
        result = data
    }
    
    subscript(keys: AnyObject...) -> Json2 {
        var tmp: AnyObject? = json
        for (i, key) in keys.enumerate() {
            if i == keys.count-1 {
                switch key {
                case is Int:
                    if let data = tmp as? [AnyObject] {
                        let v = key as! Int
                        if v < data.count {
                            result = data[v]
                        }
                    } else {
                        result = nil
                    }
                case is String:
                    if let data = tmp as? [String: AnyObject] {
                        result = data[key as! String]
                    }
                default:
                    result = nil
                }
            } else {
                switch key {
                case is Int:
                    if let data = tmp as? [AnyObject] {
                        let v = key as! Int
                        if v < data.count {
                            tmp = data[v]
                        }
                    }
                case is String:
                    if let data = tmp as? [String: AnyObject] {
                        tmp = data[key as! String]
                    }
                default:
                    tmp = nil
                }
            }
        }
        return self
    }
    
}

let data = Network.data([
    "a": "a.value",
    "b": 2,
    "c": 3.3,
    "d": [
        "a": "d.a.value",
        "b": 42,
        "c": 43.3
    ],
    "e": [
        "e.0.value",
        52,
        53.2,
        [
            "a": "e.3.a.value"
        ]
    ]
])

let json = Json(data)

//print(json["e", 3, "a"].result)
print(json.array("e"))