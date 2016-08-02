//
//  Button.swift
//  
//
//  Created by 黄穆斌 on 16/8/2.
//
//

import UIKit

class Button: UIButton {
    
    // MARK: - Values
    
    var backView: UIView?
    
    @IBInspectable var corner: CGFloat = 0
    @IBInspectable var opacity: Float = 0
    @IBInspectable var offset: CGSize = CGSizeZero
    @IBInspectable var radius: CGFloat = 0
    @IBInspectable var note: String = ""
    @IBInspectable var color: UIColor = UIColor.whiteColor() {
        didSet {
            backView?.layer.backgroundColor = selected ? tintColor.CGColor : color.CGColor
            setTitleColor(color, forState: .Selected)
        }
    }
    
    @IBInspectable var type: Bool = false {
        didSet {
            if type {
                if backView == nil {
                    backView = UIView(frame: bounds)
                    backView?.userInteractionEnabled = false
                    backView?.backgroundColor = UIColor.clearColor()
                    addSubview(backView!)
                    if imageView != nil {
                        bringSubviewToFront(imageView!)
                    }
                }
                backView?.layer.backgroundColor = selected ? tintColor.CGColor : color.CGColor
                backView?.layer.cornerRadius = corner
                backView?.layer.shadowOpacity = opacity
                backView?.layer.shadowOffset = offset
                backView?.layer.shadowRadius = radius
            }
        }
    }
    
    // MARK: - Override
    
    override var selected: Bool {
        didSet {
            if type {
                for view in subviews {
                    if view is UIImageView && view !== imageView {
                        view.removeFromSuperview()
                    }
                }
                backView?.layer.backgroundColor = selected ? tintColor.CGColor : color.CGColor
            }
        }
    }
    
    override var highlighted: Bool {
        didSet {
            if type {
                for view in subviews {
                    if view is UIImageView && view !== imageView {
                        view.removeFromSuperview()
                    }
                }
                UIView.animateWithDuration(0.2) {
                    self.backView?.alpha = self.highlighted ? 0.2 : 1
                }
            }
        }
    }
    
    override var frame: CGRect {
        didSet {
            backView?.frame = bounds
        }
    }
    
    override var bounds: CGRect {
        didSet {
            backView?.frame = bounds
        }
    }
    
    
}
