//
//  Type.swift
//  
//
//  Created by 黄穆斌 on 16/8/7.
//
//

//import UIKit

// MARK: - 堆栈
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