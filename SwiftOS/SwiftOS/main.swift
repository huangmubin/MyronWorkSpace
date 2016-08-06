//
//  main.swift
//  SwiftOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Foundation

struct Stack<T> {
    private var _value = [T]()
    subscript(i: Int) -> T {
        set { _value[i] = newValue }
        get { return _value[i] }
    }
    
    mutating func pop() -> T? {
        if _value.count > 0 {
            return _value.removeLast()
        } else {
            return nil
        }
    }
    mutating func push(v: T) {
        _value.append(v)
    }
    mutating func empty() {
        _value.removeAll(keepCapacity: true)
    }
    
    func top() -> T? {
        return _value.last
    }
    func count() -> Int {
        return _value.count
    }
    
    func isEmpty() -> Bool {
        return _value.count == 0
    }
}

let file = "/Users/Myron/职业生涯文档/GitHub/MyronWorkSpace/SwiftOS/SwiftOS/TestFile.swift"

func classInterfaceBuilder(file: String) -> String {
    
    // MARK: Type
    
    enum Type {
        case Normal     // 普通字符
        case Comments1  // / / 备注
        case Comments2(Int)  // / * * / 备注
        case Quote // “”
    }
    
    
    // MARK: File
    
    /// 打开文件
    guard let text = file.read() else { return "File Open Error" }
    
    // MARK: Values
    
    // 获取所有单词，字符段
    var words = [String]()
    var tmp = ""
    var type = Type.Normal
    
    // MARK: Func
    
    func appendWord() {
        if !tmp.isEmpty {
            words.append(tmp)
            tmp.removeAll(keepCapacity: true)
        }
    }
    
    func appendWordButNotLast() {
        if tmp.characters.count > 1 {
            words.append(tmp.sub(0, end: tmp.characters.count-1))
        }
        tmp.removeAll(keepCapacity: true)
    }
    
    func normalCharacters(c: Character, index: Int) {
        switch c {
        case " ", "\n":
            appendWord()
        case "/":
            if tmp.hasSuffix("/") {
                appendWordButNotLast()
                words.append("//")
                type = .Comments1
            } else {
                let next = text.sub(index+1, end: index+2)
                if next != "/" && next != "*" {
                    appendWordButNotLast()
                    words.append("\(c)")
                } else {
                    tmp.append(c)
                }
            }
        case "*":
            if tmp.hasSuffix("/") {
                appendWordButNotLast()
                words.append("/*")
                type = .Comments2(0)
            } else {
                tmp.append(c)
            }
        case "\"":
            appendWordButNotLast()
            tmp.append(c)
            type = .Quote
        case "(", ")", "{", "}", "[", "]":
            appendWord()
            words.append("\(c)")
        case "+", "-", "*", "=", "%", "!", ",", ";", ":", ">", "<", "^", "&", "|":
            appendWord()
            words.append("\(c)")
        default:
            tmp.append(c)
        }
    }
    
    func comments1Character(c: Character) {
        if c == "\n" {
            if tmp.isEmpty {
                words.append(" ")
            } else {
                words.append(tmp)
            }
            tmp.removeAll(keepCapacity: true)
            type = .Normal
        } else {
            tmp.append(c)
        }
    }
    
    func comments2Character(c: Character, value: Int) {
        switch c {
        case "*":
            if tmp.hasSuffix("/") {
                type = .Comments2(value + 1)
            }
            tmp.append(c)
        case "/":
            if tmp.hasSuffix("*") {
                if value > 0 {
                    type = .Comments2(value - 1)
                } else {
                    type = .Normal
                    tmp.append(c)
                    appendWord()
                    return
                }
            }
            tmp.append(c)
        default:
            tmp.append(c)
        }
    }
    
    func quoteCharacter(c: Character) {
        if c == "\"" {
            if !tmp.hasSuffix("\\") {
                tmp.append(c)
                appendWord()
                type = .Normal
                return
            }
        }
        tmp.append(c)
    }
    
    // MARK: Cycle
    //
    for (i,c) in text.characters.enumerate() {
        switch type {
        case .Normal:
            normalCharacters(c, index: i)
        case .Comments1:
            comments1Character(c)
        case .Comments2(let value):
            comments2Character(c, value: value)
        case .Quote:
            quoteCharacter(c)
        }
    }
    
    // MARK: Word Type
    
    enum WordType {
        case Normal
        case Append
        case Value(Int)
        case Class(Int)
        case Func(Int)
        
        case other
    }
    
    // MARK: Word Value
    
    var interface = text
    var lineStart: Bool {
        return interface.hasSuffix("\n")
    }
    interface.removeAll(keepCapacity: true)
    
    var wordType = WordType.Normal
    var stack = Stack<String>()
    var prefix: String {
        var str = ""
        for _ in 0 ..< stack.count() {
            str += "    "
        }
        return str
    }
    
    // MARK: Word Func
    
    func normalWord(w: String) {
        switch w {
        case "//", "/*":
            if lineStart {
                interface = interface + prefix + w
            } else {
                interface = interface + "\n" + prefix + w
            }
            wordType = .Append
        case "import":
            interface = interface + "\n" + prefix + w + " "
            wordType = .Append
        case "var", "let":
            if lineStart {
                interface = interface + prefix + w + " "
            } else {
                interface = interface + w + " "
            }
            wordType = .Value(0)
        case "class":
            interface = interface + prefix + w + " "
            wordType = .Class(0)
        case "func", "init", "enum", "struct":
            print("case func \(w)")
        case "{":
            stack.push("{")
        case "}":
            if let pop = stack.pop() {
                switch pop {
                case "class":
                    interface = interface + prefix + w + "\n"
                default:
                    break
                }
            }
        default:
            break
        }
    }
    
    func appendWords(w: String) {
        interface = interface + w + "\n"
        wordType = .Normal
    }
    
    var tmpValueType = ""
    var tmpStack = Stack<String>()
    
    func valueWord(w: String, v: Int) {
        switch v {
        case 0:
            interface = interface + w
            wordType = .Value(1)
        case 1:
            interface = interface + ": "
            if w == ":" {
                wordType = .Value(2)
            } else {
                wordType = .Value(3)
            }
        case 2:
            interface = interface + w + "\n"
            wordType = .Normal
        case 3:
            if w.hasPrefix("\"") {
                interface = interface + "String\n"
                wordType = .Normal
            } else if let _ = Int(w) {
                interface = interface + "Int\n"
                wordType = .Normal
            } else if let _ = Double(w) {
                interface = interface + "Double\n"
                wordType = .Normal
            } else {
                wordType = .Value(4)
                tmpValueType = w
            }
        case 4:
            if w == "(" {
                wordType = .Value(5)
                tmpStack.push(w)
            } else {
                interface = interface + "Type Error\n"
                wordType = .Normal
            }
        case 5:
            if w == ")" {
                tmpStack.pop()
                if tmpStack.isEmpty() {
                    interface = interface + tmpValueType + "\n"
                    wordType = .Normal
                }
            } else if w == "(" {
                tmpStack.push(w)
            }
        default:
            break
        }
    }
    
    func classWord(w: String, v: Int) {
        switch v {
        case 0:
            interface = interface + w
            wordType = .Class(1)
        case 1:
            if w == "{" {
                stack.push("class")
                interface = interface + w + "\n"
                wordType = .Normal
            } else {
                interface = interface + w + " "
            }
        default:
            break
        }
    }
    
    func funcWord(w: String, v: Int) {
        switch v {
        case 0:
            interface = interface + w
            wordType = .Func(1)
        case 1:
            if w == "{" {
                stack.push("func")
                stack.push(w)
                wordType = .Func(2)
            } else {
                interface = interface + w + " "
            }
        case 2:
            if w == "{" {
                stack.push("inFunc")
                stack.push(w)
            } else if w == "}" {
                //print("InFunc Pop 1 = \(stack.pop())")
                if let pop = stack.pop() {
                    //print("InFunc Pop 2 = \(pop)")
                    if pop == "func" {
                        wordType = .Normal
                    }
                }
            }
        default:
            break
        }
    }
    
    // MARK: Cycle Words
    for w in words {
        switch wordType {
        case .Normal:
            normalWord(w)
        case .Append:
            appendWords(w)
        case .Value(let value):
            valueWord(w, v: value)
        case .Class(let value):
            classWord(w, v: value)
        case .Func(let value):
            funcWord(w, v: value)
        default:
            break
        }
    }
    
    print(interface)
    // MARK: End
    return "End"
}

print(classInterfaceBuilder(file))
print("Done")
