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
class Progress: UIView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
        //UIColor(colorLiteralRed: <#T##Float#>, green: <#T##Float#>, blue: <#T##Float#>, alpha: <#T##Float#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    func load() {
        self.backgroundColor = UIColor.darkGrayColor()
        
        
        //let gradient = gradientLayer(bounds, colors: [UIColor.blueColor().CGColor, UIColor.yellowColor().CGColor])
        //let gradient = gradientLayer(CGRect(x: 0, y: 0, width: bounds.width * 2, height: bounds.height), colors: <#T##[CGColor]#>, point: <#T##(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat)#>, locations: <#T##[NSNumber]#>)
        
        //layer.addSublayer(gradient)
        deploy()
    }
    
    func width(value: CGFloat, method: (CGFloat,CGFloat) ->CGFloat) {
        let a = method(value, CGFloat(100.0))
        print(a)
    }
    
    // MARK: - Values
    
    @IBInspectable var _type: Int = 0 {didSet{ type = ProgressType(rawValue: _type) ?? type }}
    var type: ProgressType = .ColorLine
    
    @IBInspectable var color: UIColor = UIColor.yellowColor()
    var colors: [CGColor] = [UIColor.redColor().CGColor, UIColor.yellowColor().CGColor, UIColor.blueColor().CGColor]
    @IBInspectable var backColor: UIColor = UIColor.blackColor()
    @IBInspectable var lineWidth: CGFloat = 2
    
    @IBInspectable var value: CGFloat = 0.5
    
    // MARK: - Layers
    
    private var backLayer: CAShapeLayer!
    private var progressLayer: CAShapeLayer!
    
    // MARK: - Methods
    
    func deploy() {
        backLayer?.removeFromSuperlayer()
        progressLayer?.removeFromSuperlayer()
        
        switch type {
        case .ColorLine:
            func makeLayer() -> CAShapeLayer {
                let newlayer = CAShapeLayer()
                newlayer.frame = bounds
                newlayer.lineWidth = lineWidth
                newlayer.lineCap = kCALineCapRound
                
                let path = UIBezierPath()
                path.moveToPoint(CGPoint(x: 0, y: bounds.height/2))
                path.addLineToPoint(CGPoint(x: bounds.width, y: bounds.height/2))
                
                newlayer.path = path.CGPath
                layer.addSublayer(newlayer)
                return newlayer
            }
            
            backLayer = makeLayer()
            backLayer.strokeColor = backColor.CGColor
            
            progressLayer = makeLayer()
            progressLayer.strokeColor = color.CGColor
            progressLayer.strokeEnd = 0.5
        }
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
