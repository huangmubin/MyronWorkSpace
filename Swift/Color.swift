//
//  Color.swift
//  
//
//  Created by 黄穆斌 on 16/8/3.
//
//

import UIKit

extension UIColor {
    
    // MARK: - Init
    
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    // MARK: - Value
    
    func get() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let r = UnsafeMutablePointer<CGFloat>.alloc(1)
        let g = UnsafeMutablePointer<CGFloat>.alloc(1)
        let b = UnsafeMutablePointer<CGFloat>.alloc(1)
        let a = UnsafeMutablePointer<CGFloat>.alloc(1)
        self.getRed(r, green: g, blue: b, alpha: a)
        return (r.memory, g.memory, b.memory, a.memory)
    }
    
}