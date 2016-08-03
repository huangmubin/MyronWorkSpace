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
    
    func load() {
        self.backgroundColor = UIColor.darkGrayColor()
        deploy()
    }
    
    // MARK: - Values
    
    @IBInspectable var _type: Int = 0 {didSet{ type = ProgressType(rawValue: _type) ?? type }}
    var type: ProgressType = .ColorLine
    
    @IBInspectable var color: UIColor = UIColor.yellowColor()
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

}
