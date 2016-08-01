//
//  View.swift
//  
//
//  Created by 黄穆斌 on 16/7/31.
//
//

import UIKit

/**
 需要把背景颜色设置为 UIColor.clearColor()
 */
class View: UIView {
    
    // MARK: - Values
    
    /// 视图圆角: x 左上角, y 右上角, h 右下角, w 左下角
    @IBInspectable var cornerRadius: CGRect = CGRectZero { didSet { setNeedsDisplay() } }
    /// 阴影透明度
    @IBInspectable var shadowOpacity: Float = 0 { didSet { setNeedsDisplay() } }
    /// 阴影扩展
    @IBInspectable var shadowRadius: CGFloat = 0 { didSet { setNeedsDisplay() } }
    /// 阴影偏移
    @IBInspectable var shadowOffset: CGSize = CGSizeZero { didSet { setNeedsDisplay() } }
    /// 视图颜色
    @IBInspectable var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    
    // MARK: - Draw
    
    override func drawRect(rect: CGRect) {
        backgroundColor = UIColor.clearColor()
        layer.backgroundColor = UIColor.clearColor().CGColor
        let path = roundedPath(rect.size, a: cornerRadius.origin.x, b: cornerRadius.origin.y, c: cornerRadius.height, d: cornerRadius.width)
        color.setFill()
        path.fill()
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.masksToBounds = clipsToBounds
    }
    
    // MARK: - Drawer
    
    func roundedPath(size: CGSize, a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: a))
        path.addArcWithCenter(CGPoint(x: a, y: a), radius: a, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI_2) * 3, clockwise: true)
        path.addLineToPoint(CGPoint(x: size.width - b, y: 0))
        path.addArcWithCenter(CGPoint(x: size.width - b, y: b), radius: b, startAngle: CGFloat(M_PI_2) * 3, endAngle: CGFloat(M_PI_2) * 4, clockwise: true)
        path.addLineToPoint(CGPoint(x: size.width, y: size.height - c))
        path.addArcWithCenter(CGPoint(x: size.width - c, y: size.height - c), radius: c, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true)
        path.addLineToPoint(CGPoint(x: d, y: size.height))
        path.addArcWithCenter(CGPoint(x: d, y: size.height - d), radius: d, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true)
        path.closePath()
        return path
    }

}
