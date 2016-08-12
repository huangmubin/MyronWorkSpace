//
//  Type.swift
//  
//
//  Created by 黄穆斌 on 16/8/7.
//
//

import Foundation


// MARK: - 堆栈

class Stack<T> {
    
    private var _value = [T]()
    
    subscript(i: Int) -> T {
        set {
            _value[i] = newValue
        }
        get {
            return _value[i]
        }
    }
    
    func isEmpty() -> Bool {
        return _value.isEmpty;
    }
    
    func empty() {
        _value.removeAll(keepCapacity: true)
    }
    
    func copy() -> [T] {
        return _value;
    }
    
    func push(v: T) {
        _value.append(v)
    }
    
    func pop() -> T? {
        if _value.count > 0 {
            return _value.removeLast()
        } else {
            return nil
        }
    }
    
    func top() -> T? {
        return _value.last
    }
    
    func count() -> Int {
        return _value.count
    }
}
