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

// MARK: - 队列

class Queue<T> {
    
    private var _value = [T]()
    
    subscript(i: Int) -> T {
        return _value[i]
    }
    
    func clear() {
        _value.removeAll(keepCapacity: true)
    }
    
    func isEmpty() -> Bool {
        return _value.count == 0
    }
    
    func count() -> Int {
        return _value.count
    }
    
    func top() -> T? {
        return _value.first
    }
    
    func push(v: T) {
        _value.append(v)
    }
    
    func pop() -> T? {
        if _value.count > 0 {
            return _value.removeFirst()
        } else {
            return nil
        }
    }
    
}


// MARK: - Tree

class Tree<T> {
    
    var data: T!
    var left: Tree?
    var right: Tree?
    
    // MARK: 先序遍历
    
    class func preOrder(tree: Tree?) {
        if let tree = tree {
            print(tree.data)
            preOrder(tree.left)
            preOrder(tree.right)
        }
    }
    
    class func preOrder2(tree: Tree?) {
        var tree = tree
        var stack = [Tree]()
        
        while tree != nil || stack.count > 0 {
            while tree != nil {
                print(tree?.data)
                stack.append(tree!)
                tree = tree?.left
            }
            if stack.count > 0 {
                tree = stack.removeLast().right
            }
        }
    }
    
    // MARK: 中序遍历
    
    class func inOrder(tree: Tree?) {
        if let tree = tree {
            inOrder(tree.left)
            print(tree.data)
            inOrder(tree.right)
        }
    }
    
    class func inOrder2(tree: Tree?) {
        var tree = tree
        var stack = [Tree]()
        
        while tree != nil || stack.count > 0 {
            while tree != nil {
                stack.append(tree!)
                tree = tree?.left
            }
            if stack.count > 0 {
                tree = stack.removeLast()
                print(tree?.data)
                tree = tree?.right
            }
        }
    }
    
    // MARK: 后续遍历
    
    class func postOrder(tree: Tree?) {
        if let tree = tree {
            postOrder(tree.left)
            postOrder(tree.right)
            print(tree.data)
        }
    }
    
    
    lazy var visited: Bool = false
    class func postOrder2(tree: Tree?) {
        var tree = tree
        var stack = [Tree]()
        
        while tree != nil || stack.count > 0 {
            while tree != nil && tree?.visited == false {
                stack.append(tree!)
                tree = tree?.left
            }
            if stack.count > 0 {
                tree = stack.removeLast()
                if tree?.visited == true {
                    print(tree?.data)
                } else {
                    if tree?.right != nil {
                        tree?.visited = true
                        stack.append(tree!)
                        tree = tree?.right
                    } else {
                        print(tree?.data)
                        tree = nil
                    }
                }
            }
        }
    }
    
    // MARK: 层序遍历
    
    class func levelOrder(tree: Tree?) {
        guard let tree = tree else { return }
        var queue = [tree]
        while queue.count > 0 {
            let node = queue.removeFirst()
            print(node.data)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        
    }
}

// MAKR: - 二叉查找树

class SearchTree<T> {
    
    var index: T!
    var left: SearchTree?
    var right: SearchTree?
    
    /// 对比条件，必须提供，true 为 $0 > $1，false 为 $0 < $1，nil $0 == $1
    var compare: (T, T) -> Bool?
    
    // MARK: 初始化
    init(index: T, compare: (T, T) -> Bool?) {
        self.compare = compare
        self.index = index
    }
    
    // MARK: 方法
    /// 查找值
    func find(index: T) -> SearchTree? {
        var tree: SearchTree? = self
        while tree != nil {
            if let result = compare(tree!.index, index) {
                if result {
                    tree = tree!.left
                } else {
                    tree = tree!.right
                }
            } else {
                return tree
            }
        }
        return nil
    }
    
    /// 查找最大值
    func max() -> SearchTree? {
        var tree: SearchTree? = self
        while tree?.right != nil {
            tree = tree?.right
        }
        return tree
    }
    
    /// 查找最小值
    func min() -> SearchTree? {
        var tree: SearchTree? = self
        while tree?.left != nil {
            tree = tree?.left
        }
        return tree
    }
    
    /// 插入
    
    /// 删除
    
}

func typeTest() {
    let tree = createTestTree()
    
    Tree.levelOrder(tree)
}
/*
        A
    B       C
  D   E   F   G
 H I J K L M N O
 */
func createTestTree() -> Tree<String> {
    
    let tree = Tree<String>()
    tree.data = "A"
    
    tree.left = Tree<String>()
    tree.left?.data = "B"
    tree.right = Tree<String>()
    tree.right?.data = "C"
    
    tree.left?.left = Tree<String>()
    tree.left?.left?.data = "D"
    tree.left?.right = Tree<String>()
    tree.left?.right?.data = "E"
    
    tree.right?.left = Tree<String>()
    tree.right?.left?.data = "F"
    tree.right?.right = Tree<String>()
    tree.right?.right?.data = "G"
    
    tree.left?.left?.left = Tree<String>()
    tree.left?.left?.left?.data = "H"
    tree.left?.left?.right = Tree<String>()
    tree.left?.left?.right?.data = "I"
    
    tree.left?.right?.left = Tree<String>()
    tree.left?.right?.left?.data = "J"
    tree.left?.right?.right = Tree<String>()
    tree.left?.right?.right?.data = "K"
    
    
    tree.right?.left?.left = Tree<String>()
    tree.right?.left?.left?.data = "L"
    tree.right?.left?.right = Tree<String>()
    tree.right?.left?.right?.data = "M"
    
    tree.right?.right?.left = Tree<String>()
    tree.right?.right?.left?.data = "N"
    tree.right?.right?.right = Tree<String>()
    tree.right?.right?.right?.data = "O"
    
    return tree
}
