//
//  CGSize.swift
//  
//
//  Created by 黄穆斌 on 16/8/3.
//
//

import UIKit

extension CGRect {
    
    func width(value: CGFloat, _ method: (CGFloat, CGFloat) -> CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: method(width, value), height: height)
    }
    
}
