//
//  Progress.swift
//  
//
//  Created by 黄穆斌 on 16/8/3.
//
//

import UIKit

enum ProgressType: Int {
    case ColorLine
}

class Progress: UIView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    private func load() {
        self.backgroundColor = UIColor.clearColor()
        deploy()
    }
    
    // MARK: Override
    
    override var frame: CGRect {
        didSet {
            deploy()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            deploy()
        }
    }
    
    // MARK: - Values
    
    @IBInspectable var _type: Int = 0 {didSet{ type = ProgressType(rawValue: _type) ?? type }}
    var type: ProgressType = .ColorLine
    
    // MARK: Color
    @IBInspectable var color: UIColor = UIColor.yellowColor()
    
    /// 渐变色颜色
    var colors: [CGColor] = [
        UIColor.redColor().CGColor,
        UIColor.yellowColor().CGColor,
        UIColor.blueColor().CGColor
    ]
    
    @IBInspectable var backColor: UIColor = UIColor.blackColor()
    
    // MARK: Layer
    
    @IBInspectable var lineWidth: CGFloat = 2
    @IBInspectable var shadowOpacity: Float = 1
    @IBInspectable var shadowRadius: CGFloat = 1
    
    
    @IBInspectable var value: CGFloat = 1 {
        didSet {
            CATransaction.begin()
            progressLayer.strokeEnd = value
            CATransaction.commit()
        }
    }
    
    // MARK: Animation
    
    @IBInspectable var animationSpeed: CFTimeInterval = 3
    
    // MARK: - Layers
    
    private var backLayer: CAShapeLayer!
    private var progressLayer: CAShapeLayer!
    private var gradientLayer: CAGradientLayer!
    
    // MARK: - Draw
    
    func colorLine() {
        func makeLayer() -> CAShapeLayer {
            let newlayer = CAShapeLayer()
            newlayer.frame = bounds
            newlayer.lineWidth = lineWidth
            newlayer.lineCap = kCALineCapRound
            
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: lineWidth, y: bounds.height/2))
            path.addLineToPoint(CGPoint(x: bounds.width-lineWidth, y: bounds.height/2))
            
            newlayer.path = path.CGPath
            return newlayer
        }
        
        backLayer = makeLayer()
        backLayer.strokeColor = backColor.CGColor
        layer.addSublayer(backLayer)
        
        progressLayer = makeLayer()
        progressLayer.frame.origin.x = bounds.width*4
        progressLayer.strokeColor = color.CGColor
        progressLayer.strokeEnd = value
        progressLayer.shadowOpacity = shadowOpacity
        progressLayer.shadowOffset = CGSizeZero
        progressLayer.shadowRadius = shadowRadius
        
        gradientLayer = gradientLayer(CGRect(x: -bounds.width*4, y: 0, width: bounds.width*5, height: bounds.height), colors: colors + [colors[1], colors[0], colors[1]], point: (0,0.5,1,0.5), locations: [0, 0.2, 0.4, 0.6, 0.8, 1])
        gradientLayer.mask = progressLayer
        layer.addSublayer(gradientLayer)
        
        animationRun = colorLineAnimationRun
        animationStop = colorLineAnimationStop
    }
    
    // MARK: - Methods
    
    func deploy() {
        backLayer?.removeFromSuperlayer()
        progressLayer?.removeFromSuperlayer()
        gradientLayer?.removeFromSuperlayer()
        
        switch type {
        case .ColorLine:
            colorLine()
        }
    }

    // MARK: - Animation
    
    var animationRun: (() -> Void)!
    var animationStop: (() -> Void)!
    
    // MARK: Color Line
    
    func colorLineAnimationStop() {
        gradientLayer.removeAnimationForKey("colorLine")
        progressLayer.removeAnimationForKey("colorLine2")
    }
    
    func colorLineAnimationRun() {
        let colorLine = CABasicAnimation(keyPath: "position.x")
        colorLine.toValue = gradientLayer.bounds.width / 2
        colorLine.repeatCount = 1000000
        colorLine.duration = animationSpeed
        gradientLayer.addAnimation(colorLine, forKey: "colorLine")
        
        let colorLine2 = CABasicAnimation(keyPath: "position.x")
        colorLine2.toValue = bounds.width / 2
        colorLine2.repeatCount = 1000000
        colorLine2.duration = animationSpeed
        progressLayer.addAnimation(colorLine2, forKey: "colorLine2")
    }
    
    // MARK: - Tools
    
    func gradientLayer(frame: CGRect, colors: [CGColor], point: (x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) = (0.5, 0, 0.5, 1),locations: [NSNumber] = [0, 1]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: point.x1, y: point.y1)
        gradient.endPoint = CGPoint(x: point.x2, y: point.y2)
        return gradient
    }
    
}
