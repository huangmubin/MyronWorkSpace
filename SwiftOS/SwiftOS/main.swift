//
//  main.swift
//  SwiftOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Foundation

//var numbers = [Int]()
//for i in 0 ..< 10 {
//    numbers.append(i)
//}
//
//for i in numbers {
//    print(String(i, radix: 2))
//}

let a: Int = Int.max
let b: UInt = UInt.max
let c: Int32 = Int32.max

// 二进制转换
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

// 二进制转换
func binary(text: String) -> Int {
    var value = 0
    for (i,c) in text.characters.enumerate() {
        if c == "1" {
            value = value ^ (1 << (text.characters.count - i))
        } else if c == "0" {
            continue
        } else {
            return 0
        }
    }
    return value
}

print(binary("11"))

//print(String(a, radix: 2))
//print(String(b, radix: 2))
//print(String(c, radix: 2))

//print(binary(0))
//print(String(Int.max, radix: 2))
//print(binary(Int(0)))
//print(binary(UInt(0)))
//print(String(Int8.max, radix: 2))
//print(binary(Int8(0)))
//print(binary(UInt8(0)))
//print(String(Int16.max, radix: 2))
//print(binary(Int16(0)))
//print(binary(UInt16(0)))
//print(String(Int32.max, radix: 2))
//print(binary(Int32(0)))
//print(binary(UInt32(0)))
//print(String(Int64.max, radix: 2))
//print(binary(Int64(0)))
//print(binary(UInt64(0)))





//let file = "/Users/Myron/职业生涯文档/GitHub/MyronWorkSpace/SwiftOS/SwiftOS/TestFile.swift"
//
//func classInterfaceBuilder(file: String) -> String {
//    /// 打开文件
//    if let text = file.read() {
//        // 获取所有单词，字符段
//        var words = [String]()
//        var tmp = ""
//        
//        // 0 普通字符，1 //注释，2 /*注释，3 ""字符串, 4
//        var type = 0
//        /// 遍历文件
//        for c in text.characters {
//            switch type {
//            case 0:
//                switch c {
//                case " ", "\n":
//                    switch tmp {
//                    case "", "\n":
//                        tmp.removeAll(keepCapacity: true)
//                    case "//":
//                        tmp.append(c)
//                        type = 1
//                    case "/*":
//                        tmp.append(c)
//                        type = 2
//                    default:
//                        words.append(tmp)
//                        tmp.removeAll(keepCapacity: true)
//                    }
//                case "\"":
//                    tmp.append(c)
//                    type = 3
//                case "*":
//                    if tmp == "/*" {
//                        type = 2
//                    }
//                    tmp.append(c)
//                case ";":
//                    words.append(tmp)
//                    tmp.removeAll(keepCapacity: true)
//                case "(", "{", ")", "}", "[", "]":
//                    if tmp != "" {
//                        words.append(tmp)
//                        tmp.removeAll(keepCapacity: true)
//                    }
//                    words.append("\(c)")
//                default:
//                    tmp.append(c)
//                }
//            case 1:
//                if c == "\n" {
//                    type = 0
//                    words.append("//")
//                    words.append(tmp.sub(2, end: tmp.characters.count))
//                    tmp.removeAll(keepCapacity: true)
//                } else {
//                    tmp.append(c)
//                }
//            case 2:
//                tmp.append(c)
//                if tmp.hasSuffix("*/") {
//                    words.append("/*")
//                    words.append(tmp.sub(2, end: tmp.characters.count))
//                    tmp.removeAll(keepCapacity: true)
//                }
//            case 3:
//                tmp.append(c)
//                if c == "\"" {
//                    words.append(tmp)
//                    tmp.removeAll(keepCapacity: true)
//                }
//            default:
//                return "Type Error"
//            }
//        }
//        
//        for word in words {
//            print(word)
//        }
//        return "End"
//    } else {
//        return "File Open Error"
//    }
//}
//
//print(classInterfaceBuilder(file))
//print("Done")
