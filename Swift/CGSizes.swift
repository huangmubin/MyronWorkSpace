//
//  CGSize.swift
//  
//
//  Created by 黄穆斌 on 16/8/3.
//
//

import UIKit

enum Direction {
    case Top
    case Down
    case Left
    case Right
}

extension CGRect {
    
    func width(method: (CGFloat, CGFloat) -> CGFloat, _ value: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: method(width, value), height: height)
    }
    
    func height(method: (CGFloat, CGFloat) -> CGFloat, _ value: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: width, height: method(height, value))
    }
    
    func offsetX(method: (CGFloat, CGFloat) -> CGFloat, _ value: CGFloat) -> CGRect {
        return CGRect(x: method(origin.x, value), y: origin.y, width: width, height: height)
    }
    
    func offsetY(method: (CGFloat, CGFloat) -> CGFloat, _ value: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: method(origin.y, value), width: width, height: height)
    }
    
}
