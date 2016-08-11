//
//  main.swift
//  SwiftOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Foundation

//cTestFunction()

//
//
//class Json {
//    
//    // MARK: Value
//    /// 数据
//    var json: AnyObject?
//    
//    // MARK: Init
//    init(_ data: NSData?) {
//        if let data = data {
//            if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) {
//                self.json = json
//            }
//        }
//    }
//    
//    // 下标访问
//    subscript(keys: String...) -> AnyObject? {
//        if var dic = json as? [String: AnyObject] {
//            for (i,key) in keys.enumerate() {
//                if i == keys.count-1 {
//                    return dic[key]
//                } else {
//                    if let tmp = dic[key] as? [String: AnyObject] {
//                        dic = tmp
//                    } else {
//                        return nil
//                    }
//                }
//            }
//        }
//        return nil
//    }
//    
//    // MARK: 函数访问
//    
//    /// 根据字符串列表逐步解压，最后解压出来 [AnyObject] 格式。
//    func array(keys: String...) -> [AnyObject] {
//        if var dic = json as? [String: AnyObject] {
//            for (i, key) in keys.enumerate() {
//                if i == keys.count-1 {
//                    if let tmp = dic[key] as? [AnyObject] {
//                        return tmp
//                    }
//                } else {
//                    if let tmp = dic[key] as? [String: AnyObject] {
//                        dic = tmp
//                    } else {
//                        break
//                    }
//                }
//            }
//        }
//        return []
//    }
//    
//    /// 根据 Key 解压出 String 字段，如果解压不到则返回空字符串
//    func value(key: String, _ null: String = "") -> String {
//        if let dic = json as? [String: AnyObject] {
//            if let value = dic[key] as? String {
//                return value
//            }
//        }
//        return null
//    }
//    
//    /// 根据 Key 解压出 T 类型字段，如果解压不到则返回 null 参数
//    func value<T>(key: String, _ null: T) -> T {
//        if let dic = json as? [String: AnyObject] {
//            if let value = dic[key] as? T {
//                return value
//            }
//        }
//        return null
//    }
//    
//    /// 根据 null 的字符串类型，按照 keys 逐步解压出 T 类型的字段，如果解压不到则返回 null 参数
//    func value<T>(null: T, _ keys: String...) -> T {
//        if var dic = json as? [String: AnyObject] {
//            for (i,key) in keys.enumerate() {
//                if i == keys.count-1 {
//                    if let tmp = dic[key] as? T {
//                        return tmp
//                    }
//                } else {
//                    if let tmp = dic[key] as? [String: AnyObject] {
//                        dic = tmp
//                    } else {
//                        break
//                    }
//                }
//            }
//        }
//        return null
//    }
//}
//
//let data = Network.data([
//    "name": "Yes",
//    "code": 0,
//    "double": 0.0,
//    "sub": [
//        "a": [
//            "aa": "sub.a.aa"
//        ],
//        "b": [
//            "bb": "sub.b.bb"
//        ]
//    ],
//    "arr": [
//        [
//            100,
//            101
//        ],
//        [
//            200,
//            201
//        ],
//        [
//            300,
//            301
//        ]
//    ],
//    "ob": [
//        [
//            "a": "ob.0.a",
//            "b": "ob.0.b",
//            "c": "ob.0.c"
//        ],
//        [
//            "a": "ob.1.a",
//            "b": "ob.1.b",
//            "c": "ob.1.c"
//        ],
//        [
//            "a": "ob.2.a",
//            "b": "ob.2.b",
//            "c": "ob.2.c"
//        ]
//    ]
//])
//
//let json = Json(data)
//let ty = json.value("", "sub", "a", "aa")
//print(ty)
//
//let arr = json.array("ob")
//for a in arr {
//    json.json = a
//    print(json["a"])
//    print(json["b"])
//    print(json["c"])
//    print("next")
//}
//
//print("Done")
