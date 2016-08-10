//
//  Progress.swift
//  
//
//  Created by 黄穆斌 on 16/8/3.
//
//

import UIKit


class Progress: UIView {
    
    // MARK: - Enum
    
    enum Type: Int {
        case Line
        case ColorLine
        case Round
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    /// 加载时调用的配置
    private func load() {
        self.backgroundColor = UIColor.clearColor()
        deploy()
    }
    
    // MARK: Override
    
    /// 每次修改大小都重载一下视图
    override var frame: CGRect  { didSet { deploy() } }
    /// 每次修改大小都重载一下视图
    override var bounds: CGRect { didSet { deploy() } }
    
    // MARK: - Values
    
    /// 通过 Storyboard 修改进度条类型
    @IBInspectable var _type: Int = 0 {
        didSet {
            type = Type(rawValue: _type) ?? type
        }
    }
    /// 进度条类型
    var type: Type = .Line {
        didSet {
            deploy()
        }
    }
    
    // MARK: Color
    
    /// 进度条颜色
    @IBInspectable var color: UIColor = UIColor.yellowColor() {
        didSet {
            progressLayer.strokeColor = color.CGColor
        }
    }
    
    /// 进度条渐变色颜色，只有在使用渐变色时才会生效
    var colors: [CGColor] = [
        UIColor.redColor().CGColor,
        UIColor.yellowColor().CGColor,
        UIColor.blueColor().CGColor
    ]
    
    /// 进度条背景颜色
    @IBInspectable var backColor: UIColor = UIColor.blackColor() {
        didSet {
            backLayer.strokeColor = backColor.CGColor
        }
    }
    
    // MARK: Layer
    
    @IBInspectable var lineWidth: CGFloat = 2 {
        didSet {
            backLayer.lineWidth      = lineWidth
            progressLayer.lineWidth  = lineWidth
            backLayer.position.y     = bounds.height / 2
            progressLayer.position.y = bounds.height / 2
        }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            progressLayer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 1 {
        didSet {
            progressLayer.shadowRadius = shadowRadius
        }
    }
    
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
    
    private func line() {
        backLayer = makeLineLayer(1)
        backLayer.strokeColor = backColor.CGColor
        layer.addSublayer(backLayer)
        
        progressLayer = makeLineLayer()
        progressLayer.strokeColor   = color.CGColor
        progressLayer.strokeEnd     = value
        progressLayer.shadowOffset  = CGSizeZero
        progressLayer.shadowOpacity = shadowOpacity
        progressLayer.shadowRadius  = shadowRadius
        layer.addSublayer(progressLayer)
    }
    
    private func colorLine() {
        backLayer = makeLineLayer(1)
        backLayer.strokeColor = backColor.CGColor
        layer.addSublayer(backLayer)
        
        progressLayer = makeLineLayer()
        progressLayer.frame.origin.x    = bounds.width*4
        progressLayer.strokeColor       = color.CGColor
        progressLayer.strokeEnd         = value
        progressLayer.shadowOffset      = CGSizeZero
        progressLayer.shadowOpacity     = shadowOpacity
        progressLayer.shadowRadius      = shadowRadius
        
        gradientLayer = gradientLayer(CGRect(x: -bounds.width*4, y: 0, width: bounds.width*5, height: bounds.height), colors: colors + [colors[1], colors[0], colors[1]], point: (0,0.5,1,0.5), locations: [0, 0.2, 0.4, 0.6, 0.8, 1])
        gradientLayer.mask = progressLayer
        layer.addSublayer(gradientLayer)
        
        animationRun = colorLineAnimationRun
        animationStop = colorLineAnimationStop
    }
    
    private func round() {
        backLayer = makeRoundLayer(1)
        backLayer.fillColor     = UIColor.clearColor().CGColor
        backLayer.strokeColor   = backColor.CGColor
        layer.addSublayer(backLayer)
        
        progressLayer = makeRoundLayer()
        progressLayer.fillColor     = UIColor.clearColor().CGColor
        progressLayer.strokeColor   = color.CGColor
        progressLayer.strokeEnd     = value
        progressLayer.shadowOffset  = CGSizeZero
        progressLayer.shadowOpacity = shadowOpacity
        progressLayer.shadowRadius  = shadowRadius
        layer.addSublayer(progressLayer)
    }
    
    // MARK: - Methods
    
    func deploy() {
        print("deploy")
        backLayer?.removeFromSuperlayer()
        progressLayer?.removeFromSuperlayer()
        gradientLayer?.removeFromSuperlayer()
        
        switch type {
        case .Line:
            line()
        case .ColorLine:
            colorLine()
        case .Round:
            round()
        }
    }

    // MARK: - Animation
    
    var animationRun: (() -> Void)?
    var animationStop: (() -> Void)?
    
    // MARK: Color Line
    
    func colorLineAnimationStop() {
        gradientLayer.removeAnimationForKey("colorLine")
        progressLayer.removeAnimationForKey("colorLine2")
    }
    
    func colorLineAnimationRun() {
        print("colorLineAnimationRun")
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
    
    func makeLineLayer(offset: CGFloat = 0) -> CAShapeLayer {
        let newlayer = CAShapeLayer()
        newlayer.frame = bounds
        newlayer.lineWidth = lineWidth
        newlayer.lineCap = kCALineCapRound
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: lineWidth + offset, y: bounds.height/2))
        path.addLineToPoint(CGPoint(x: bounds.width-lineWidth-offset, y: bounds.height/2))
        newlayer.path = path.CGPath
        return newlayer
    }
    
    func makeRoundLayer(offset: CGFloat = 0) -> CAShapeLayer {
        let newlayer = CAShapeLayer()
        newlayer.frame = bounds
        newlayer.lineWidth = lineWidth - offset
        newlayer.lineCap = kCALineCapRound
        
        let path = UIBezierPath()
        path.addArcWithCenter(CGPoint(x: bounds.width/2, y: bounds.height/2), radius: (bounds.width-lineWidth)/2, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        newlayer.path = path.CGPath
        return newlayer
    }
    
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

// MARK: - Table View Header Refresh Protocol
extension Progress: TableViewRefreshProtocol {
    
    /// 运行刷新动画
    func run() {
        value = 1
        animationRun?()
    }
    /// 结束刷新动画
    func end() {
        animationStop?()
        value = 0
    }
}