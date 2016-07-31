//
//  View.swift
//  
//
//  Created by 黄穆斌 on 16/7/31.
//
//

import UIKit

class View: UIView {
    
    /// 视图圆角: 统一圆角
    @IBInspectable var cornerRadius: CGFloat = 0
    /// 视图圆角: x 左上角, y 右上角, h 左下角, w 右下角, 设置后 cornerRadius 失效
    @IBInspectable var cornerRadius2: CGRect? = CGRectZero
    
    /// 阴影透明度以及扩展程序
    @IBInspectable var shadowOpacity: CGFloat = 0
    
    
//    /// 视图圆角
//    @IBInspectable var cornerRadius: CGFloat = 0
//    
//    /// 阴影透明度
//    @IBInspectable var shadowOpacity: Float = 0
//    
//    ///
//    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
//    
//    @IBInspectable var A: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
//    @IBInspectable var B: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    
//    @IBInspectable var offsetW: CGFloat = 0
//    @IBInspectable var offsetH: CGFloat = 0
//    @IBInspectable var radius: CGFloat = 0
//    @IBInspectable var masks: Bool = false
    
    override func drawRect(rect: CGRect) {
        
//        layer.cornerRadius = cornerRadius
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowOffset = CGSize(width: offsetW, height: offsetH)
//        layer.shadowRadius = radius
//        layer.masksToBounds = masks
    }

}
