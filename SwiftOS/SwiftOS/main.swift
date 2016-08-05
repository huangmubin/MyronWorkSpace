//
//  main.swift
//  SwiftOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Foundation

let file = "/Users/Myron/职业生涯文档/GitHub/MyronWorkSpace/SwiftOS/SwiftOS/TestFile.swift"

func classInterfaceBuilder(file: String) -> String {
    /// 打开文件
    if let text = file.read() {
        // 获取所有单词，字符段
        var words = [String]()
        var tmp = ""
        
        // 0 普通字符，1 //注释，2 /*注释，3 ""字符串, 4
        var type = 0
        /// 遍历文件
        for c in text.characters {
            switch type {
            case 0:
                switch c {
                case " ", "\n":
                    switch tmp {
                    case "", "\n":
                        tmp.removeAll(keepCapacity: true)
                    case "//":
                        tmp.append(c)
                        type = 1
                    case "/*":
                        tmp.append(c)
                        type = 2
                    default:
                        words.append(tmp)
                        tmp.removeAll(keepCapacity: true)
                    }
                case "\"":
                    tmp.append(c)
                    type = 3
                case "*":
                    if tmp == "/*" {
                        type = 2
                    }
                    tmp.append(c)
                case ";":
                    words.append(tmp)
                    tmp.removeAll(keepCapacity: true)
                case "(", "{", ")", "}", "[", "]":
                    if tmp != "" {
                        words.append(tmp)
                        tmp.removeAll(keepCapacity: true)
                    }
                    words.append("\(c)")
                default:
                    tmp.append(c)
                }
            case 1:
                if c == "\n" {
                    type = 0
                    words.append("//")
                    words.append(tmp.sub(2, end: tmp.characters.count))
                    tmp.removeAll(keepCapacity: true)
                } else {
                    tmp.append(c)
                }
            case 2:
                tmp.append(c)
                if tmp.hasSuffix("*/") {
                    words.append("/*")
                    words.append(tmp.sub(2, end: tmp.characters.count))
                    tmp.removeAll(keepCapacity: true)
                }
            case 3:
                tmp.append(c)
                if c == "\"" {
                    words.append(tmp)
                    tmp.removeAll(keepCapacity: true)
                }
            default:
                return "Type Error"
            }
        }
        
        for word in words {
            print(word)
        }
        return "End"
    } else {
        return "File Open Error"
    }
}

print(classInterfaceBuilder(file))
print("Done")