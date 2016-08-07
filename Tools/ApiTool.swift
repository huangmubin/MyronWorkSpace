//
//  ApiTool.swift
//  
//
//  Created by 黄穆斌 on 16/8/7.
//
//
/*
 需要 
 Swift -> Type.swift
 Swift -> Text.swift
 */

import Foundation

// MARK: - Api Tool
class ApiTool {
    
    // MARK: Values
    
    var path: String
    var text: String = ""
    
    enum StackType {
        case Class
        case Value
        case Func
        case Note
        case Other
    }
    
    private var lines = [String]()
    private var allWords = [[String]]()
    private var stack = Stack<StackType>()
    private var apis = ""
    
    // MARK: Init
    
    init(path: String) {
        self.path = path
    }
    
    // MARK: Main
    
    func main() -> String {
        guard readFile() else { return "File open error." }
        guard clipLines() else { return "Clip line error."}
        guard linesAnalysis() else { return "Lines analysis error."}
        guard apiPush() else { return "Api push error" }
        
        print(apis)
        
        return "Done"
    }
    
    // MARK: Methods
    
    private func readFile() -> Bool {
        if let file = path.read() {
            text = file
            return true
        } else {
            return false
        }
    }
    
    private func clipLines() -> Bool {
        lines.removeAll(keepCapacity: true)
        var tmp = ""
        for c in text.characters {
            if c == "\n" {
                var append = false
                for t in tmp.characters {
                    if t != " " {
                        append = true
                    }
                }
                if append {
                    lines.append(tmp)
                }
                tmp.removeAll(keepCapacity: true)
            } else {
                tmp.append(c)
            }
        }
        var append = false
        for t in tmp.characters {
            if t != " " {
                append = true
            }
        }
        if append {
            lines.append(tmp)
        }
        return true
    }
    
    private func linesAnalysis() -> Bool {
        for line in lines {
            var words = [String]()
            for word in clipWords(line) {
                words.append(word)
            }
            allWords.append(words)
        }
        
        var l = 0
        var w = 0
        while l < allWords.count {
            while w < allWords[l].count {
                if allWords[l][w] == ";" {
                    if w + 1 < allWords[l].count {
                        allWords[l].removeAtIndex(w)
                        var new = [String]()
                        while w < allWords[l].count {
                            new.append(allWords[l].removeAtIndex(w))
                        }
                        allWords.insert(new, atIndex: l+1)
                    } else {
                        allWords[l].removeAtIndex(w)
                    }
                } else if w + 1 < allWords[l].count {
                    switch allWords[l][w] {
                    case "/":
                        if allWords[l][w+1] == "/" || allWords[l][w+1] == "*" {
                            allWords[l][w] = allWords[l][w] + allWords[l][w+1]
                            allWords[l].removeAtIndex(w+1)
                        }
                    case "*":
                        if allWords[l][w+1] == "/" {
                            allWords[l][w] = allWords[l][w] + allWords[l][w+1]
                            allWords[l].removeAtIndex(w+1)
                        } else if allWords[l][w+1] == "=" {
                            allWords[l][w] = allWords[l][w] + allWords[l][w+1]
                            allWords[l].removeAtIndex(w+1)
                        }
                    case "&", "|":
                        if allWords[l][w+1] == allWords[l][w] {
                            allWords[l][w] = allWords[l][w] + allWords[l][w+1]
                            allWords[l].removeAtIndex(w+1)
                        }
                    case "+", "/":
                        if allWords[l][w+1] == "=" {
                            allWords[l][w] = allWords[l][w] + allWords[l][w+1]
                            allWords[l].removeAtIndex(w+1)
                        }
                    case "-":
                        if allWords[l][w+1] == "=" || allWords[l][w+1] == ">" {
                            allWords[l][w] = allWords[l][w] + allWords[l][w+1]
                            allWords[l].removeAtIndex(w+1)
                        }
                    default:
                        break
                    }
                }
                w += 1
            }
            w = 0
            l += 1
        }
        return true
    }
    
    private func apiPush() -> Bool {
        enum Type {
            case Normal
            case NoteLine
            case NoteBlock
            case Value(Int)
            case Class
            case Function(Int)
            case OtherBlock
            
            case other
        }
        var type = Type.Normal
        
        func normal(word: String) {
            switch word {
            case "//":
                type = .NoteLine
            case "/*":
                type = .NoteBlock
                stack.push(.Note)
            case "var", "let":
                type = .Value(0)
            case "class":
                type = .Class
            case "func":
                type = .Function(0)
            case "{":
                stack.push(.Other)
                type = .OtherBlock
            case "}":
                let pre = prefix()
                if apis.hasSuffix(pre) {
                    for _ in 0 ..< 4 {
                        apis.removeAtIndex(apis.endIndex.predecessor())
                    }
                }
                stack.pop()
            default:
                break
            }
            
            switch type {
            case .OtherBlock:
                break
            default:
                apis = apis + word + " "
            }
        }
        
        func noteBlock(word: String) {
            if word == "*/" {
                stack.pop()
                type = .Normal
            }
            apis = apis + word + " "
        }
        func value(word: String, value: Int) {
            switch value {
            case 0:
                if word == ":" {
                    type = .Value(1)
                    apis = apis.sub(0, end: apis.characters.count-1) + ": "
                } else if word == "=" {
                    type = .Value(2)
                    apis = apis.sub(0, end: apis.characters.count-1) + ": "
                } else {
                    apis = apis + word + " "
                }
            case 1:
                if word == "=" {
                    type = .Value(10)
                } else if word == "{" {
                    stack.push(.Other)
                    type = .OtherBlock
                } else {
                    apis = apis + word + " "
                }
            case 2:
                if word.hasPrefix("\"") {
                    apis = apis + "String"
                } else if let _ = Int(word) {
                    apis = apis + "Int"
                } else if let _ = Double(word) {
                    apis = apis + "Double"
                } else {
                    apis = apis + "Type Error"
                }
                type = .Value(3)
            case 3:
                if word == "?" {
                    apis = apis + "?"
                } else if word == "{" {
                    stack.push(.Other)
                    type = .OtherBlock
                }
                type = .Value(10)
            default:
                if word == "{" {
                    stack.push(.Other)
                    type = .OtherBlock
                }
            }
        }
        func classFunc(word: String) {
            if word == "{" {
                apis = apis + word
                stack.push(.Class)
                type = .Normal
            } else {
                apis = apis + word + " "
            }
        }
        func function(word: String, value: Int) {
            switch value {
            case 0:
                if word == "{" {
                    stack.push(.Func)
                    type = .Function(1)
                } else {
                    apis = apis + word + " "
                }
            case 1:
                if word == "{" {
                    stack.push(.Func)
                } else if word == "}" {
                    stack.pop()
                    if stack.top() != StackType.Func {
                        type = .Normal
                    }
                }
            default:
                break
            }
        }
        func otherBlock(word: String) {
            if word == "{" {
                stack.push(.Other)
            } else if word == "}" {
                stack.pop()
                if stack.top() != StackType.Other {
                    type = .Normal
                }
            }
        }
        
        for words in allWords {
            for word in words {
                switch type {
                case .Normal:
                    normal(word)
                case .NoteLine:
                    apis = apis + word + " "
                case .NoteBlock:
                    noteBlock(word)
                case .Value(let v):
                    value(word, value: v)
                case .Class:
                    classFunc(word)
                case .Function(let v):
                    function(word, value: v)
                case .OtherBlock:
                    otherBlock(word)
                default:
                    break
                }
            }
            
            switch type {
            case .NoteLine:
                type = .Normal
                apis = apis + "\n" + prefix()
            case .Value(let v):
                if v == 10 || v == 3 {
                    type = .Normal
                }
                apis = apis + "\n" + prefix()
            case .Function, .Class, .OtherBlock:
                break
            default:
                apis = apis + "\n" + prefix()
            }
        }
        
        return true
    }
    
    // MARK: Tools
    
    private func clipWords(line: String) -> [String] {
        var tmp = ""
        var inString = false
        var words = [String]()
        for c in line.characters {
            if inString {
                if c == "\"" && !tmp.hasSuffix("\\") {
                    tmp.append(c)
                    words.append(tmp)
                    tmp.removeAll(keepCapacity: true)
                    inString = false
                } else {
                    tmp.append(c)
                }
            } else {
                switch c {
                case " ":
                    if !tmp.isEmpty {
                        words.append(tmp)
                        tmp.removeAll(keepCapacity: true)
                    }
                case "\"":
                    if tmp.characters.count > 1 {
                        words.append(tmp.sub(0, end: tmp.characters.count-1))
                    }
                    tmp.removeAll(keepCapacity: true)
                    tmp.append(c)
                    inString = true
                case "+", "-", "*", "/", "=", ">", "<",
                     "?", "!",
                     ":", ";", ",",
                     "^", "|", "&",
                     "{", "}", "[", "]", "(", ")":
                    if !tmp.isEmpty {
                        words.append(tmp)
                        tmp.removeAll(keepCapacity: true)
                    }
                    words.append("\(c)")
                default:
                    tmp.append(c)
                }
            }
        }
        if !tmp.isEmpty {
            words.append(tmp)
        }
        return words
    }
    
    private func prefix() -> String {
        var pre = ""
        for _ in 0 ..< stack.count() {
            pre += "    "
        }
        return pre
    }
}
