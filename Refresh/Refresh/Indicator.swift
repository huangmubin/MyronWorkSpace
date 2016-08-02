//
//  Indicator.swift
//  Refresh
//
//  Created by 黄穆斌 on 16/8/2.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class Indicator: UIView {
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    // MARK: Deploy
    
    var subLayers: [CAShapeLayer] = []
    var trans: CGAffineTransform!
    
    
    let strokeStart: CGFloat = 0.3
    func load() {
        trans = transform
        for i in 0 ..< 12 {
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: frame.width/2, y: frame.height/2))
            path.addLineToPoint(CGPoint(x: frame.width/2, y: 0))
            
            let shape = CAShapeLayer()
            shape.lineCap = kCALineCapRound
            shape.lineWidth = 2
            shape.strokeColor = UIColor.blackColor().CGColor
            shape.frame = bounds
            shape.path = path.CGPath
            shape.strokeStart = strokeStart
            shape.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(i) * CGFloat(M_PI / 6)))
            layer.addSublayer(shape)
            subLayers.append(shape)
        }
    }
    
    func deploy() {
        for (i,shape) in subLayers.enumerate() {
            shape.setAffineTransform(trans)
            
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: frame.width/2, y: frame.height/2))
            path.addLineToPoint(CGPoint(x: frame.width/2, y: 0))
            
            shape.strokeColor = UIColor.blackColor().CGColor
            shape.frame = bounds
            shape.path = path.CGPath
            shape.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(i) * CGFloat(M_PI / 6)))
        }
    }
    
    func show() {
        progress = 0
    }
    
    // MARK: - Values
    
    /// 线条颜色
    @IBInspectable var lineColor: UIColor = UIColor.blackColor() {
        didSet {
            for shape in subLayers {
                shape.strokeColor = lineColor.CGColor
                shape.setNeedsDisplay()
            }
        }
    }
    
    /// 线条显示进度
    @IBInspectable var progress: CGFloat = 1 {
        didSet {
            progress = progress > 1 ? 1 : progress
            progress = progress < 0 ? 0 : progress
            let value = progress * 12
            CATransaction.begin()
            for (i, shape) in subLayers.enumerate() {
                if CGFloat(i) > value {
                    shape.strokeEnd = 0
                } else if CGFloat(i+1) > value {
                    shape.strokeEnd = (value % 1) * 0.7 + 0.3
                } else {
                    shape.strokeEnd = 1
                }
            }
            CATransaction.commit()
        }
    }
    
    // MARK: - Animation
    
    //private let opacitys: [Float] = [1.0, 0.0833333135, 0.166666627, 0.25, 0.333333313, 0.416666627, 0.5, 0.583333313, 0.666666627, 0.75, 0.833333313, 0.916666687]
    private var animating = false
    
    func animation() {
        guard !animating else { return }
        animating = true
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            for i in Int(self.progress * 1000) ... 1000 {
                NSThread.sleepForTimeInterval(0.001)
                dispatch_async(dispatch_get_main_queue()) {
                    self.progress = CGFloat(i) / 1000
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.opacityAnimation()
                self.retateAnimation()
            }
        }
    }
    
    private func retateAnimation() {
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.toValue = NSNumber(float: Float(M_PI*2))
        rotate.duration = 2
        layer.addAnimation(rotate, forKey: "rotate")
    }
    
    private func opacityAnimation() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            for shape in self.subLayers {
                dispatch_async(dispatch_get_main_queue()) {
                    let opacity = CABasicAnimation(keyPath: "opacity")
                    opacity.fromValue = NSNumber(float: 1)
                    opacity.toValue = NSNumber(float: 0)
                    opacity.duration = 1
                    opacity.repeatCount = 10000000
                    shape.addAnimation(opacity, forKey: "opacity")
                }
                NSThread.sleepForTimeInterval(0.0833333135)
            }
        }
    }
    
    func stopAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            for shape in self.subLayers {
                shape.removeAllAnimations()
            }
            self.animating = false
        }
        for shape in subLayers {
            CATransaction.begin()
            shape.strokeEnd = 0.3
            CATransaction.commit()
        }
        CATransaction.commit()
    }
}
