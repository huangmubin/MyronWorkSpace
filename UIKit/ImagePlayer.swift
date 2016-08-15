//
//  ImagePlayer.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/8/15.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit
/**
 图片播放器
 需加入 AutoLayout.swift
 */

// MARK: - Enum

enum ImagePlayerType {
    case Full
    case Scale(CGFloat, CGFloat)
}

enum ImagePlayerScrollType {
    case Horizontal
    case Vertical
}

// MARK:

class ImagePlayer: UIView {
    
    // MARK: - Interface
    
    /// 占位符图片
    var placeholderImage: UIImage? = UIImage(named: "5")
    
    /// 图片大小类型
    var type: ImagePlayerType = ImagePlayerType.Full {
        didSet {
            deploy()
        }
    }
    /// 滚动方向
    var scrollType: ImagePlayerScrollType = ImagePlayerScrollType.Horizontal
    
    /// 图片数据
    var images: [UIImage] = [] {
        didSet {
            if index < images.count {
                imageView1.image = images[index]
            } else {
                imageView1.image = nil
            }
        }
    }
    
    /// 当前坐标
    var index: Int = 0
    
    // MARK: - Init
    
    init() {
        super.init(frame: CGRectZero)
        load()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    private func load() {
        self.backgroundColor = UIColor.redColor()
        
        imageView1.image = placeholderImage
        imageView2.image = placeholderImage
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureAction)))
        
        deploy()
    }
    
    private func deploy() {
        imageView1.removeFromSuperview()
        imageView2.removeFromSuperview()
        addSubview(imageView2)
        addSubview(imageView1)
        
        switch type {
        case .Full:
            AutoLayout(self, imageView1).Size()
            AutoLayout(self, imageView2).Size()
        case .Scale(let w, let h):
            AutoLayout(self, imageView1).Width().second(imageView1)
                .add(.Height, SEdge: .Width, constant: 0, multiplier: h / w)
            AutoLayout(self, imageView2).Width().second(imageView1)
                .add(.Height, SEdge: .Width, constant: 0, multiplier: h / w)
        }
        
        switch scrollType {
        case .Horizontal:
            image1Center = AutoLayout(self, imageView1).Center()._constrants[0]
            image2Center = AutoLayout(self, imageView2).Center()._constrants[0]
        case .Vertical:
            image1Center = AutoLayout(self, imageView1).Center()._constrants[1]
            image2Center = AutoLayout(self, imageView2).Center()._constrants[1]
        }
    }
    
    // MARK: - Views
    
    private let imageView1 = UIImageView()
    private let imageView2 = UIImageView()
    
    // MARK: - Layouts
    
    private var image1Center: NSLayoutConstraint!
    private var image2Center: NSLayoutConstraint!
    
    // MARK: - Gesture
    
    @objc private func panGestureAction(sender: UIPanGestureRecognizer) {
        let offset = sender.translationInView(self)
        print(offset)
        switch sender.state {
        case .Began:
            panBegan(offset)
        case .Changed:
            panChanged(offset)
        default:
            panOther(offset)
        }
    }
    
    private func panBegan(offset: CGPoint) {
        var space: CGFloat
        var line : CGFloat
        switch scrollType {
        case .Horizontal:
            space = offset.x
            line = self.bounds.width
        case .Vertical:
            space = offset.y
            line = self.bounds.height
        }
        
        if space >= 0 {
            if index > 0 {
                self.image1Center.constant = space
                self.image2Center.constant = space - line
                self.layoutIfNeeded()
            } else {
                self.image1Center.constant = space
                self.image2Center.constant = space + line
                self.layoutIfNeeded()
            }
        } else {
            if index < images.count - 1 {
                self.image1Center.constant = space
                self.image2Center.constant = space + line
                self.layoutIfNeeded()
            } else {
                self.image1Center.constant = space
                self.image2Center.constant = space - line
                self.layoutIfNeeded()
            }
        }
    }
    
    private func panChanged(offset: CGPoint) {
        var space: CGFloat
        var line : CGFloat
        switch scrollType {
        case .Horizontal:
            space = offset.x
            line = self.bounds.width
        case .Vertical:
            space = offset.y
            line = self.bounds.height
        }
        
        if space >= 0 {
            if index > 0 {
                UIView.animateWithDuration(0.1) {
                    self.image1Center.constant = space
                    self.image2Center.constant = space - line
                    self.layoutIfNeeded()
                }
            } else {
                space *= 0.5
                UIView.animateWithDuration(0.1) {
                    self.image1Center.constant = space
                    self.image2Center.constant = space + line
                    self.layoutIfNeeded()
                }
            }
        } else {
            if index < images.count - 1 {
                UIView.animateWithDuration(0.1) {
                    self.image1Center.constant = space
                    self.image2Center.constant = space + line
                    self.layoutIfNeeded()
                }
            } else {
                space *= 0.5
                UIView.animateWithDuration(0.1) {
                    self.image1Center.constant = space
                    self.image2Center.constant = space - line
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    
    private func panOther(offset: CGPoint) {
        var line: CGFloat
        switch scrollType {
        case .Horizontal:
            if index > 0 && index < images.count-1 {
                line = self.bounds.width
            } else {
                line = -self.bounds.width
            }
        case .Vertical:
            if index > 0 && index < images.count-1 {
                line = self.bounds.height
            } else {
                line = -self.bounds.height
            }
        }
        
        if image1Center.constant < -line/2 {
            UIView.animateWithDuration(0.25) {
                self.image1Center.constant = -line
                self.image2Center.constant = 0
                self.layoutIfNeeded()
            }
        } else if image1Center.constant < 0 {
            UIView.animateWithDuration(0.25) {
                self.image1Center.constant = 0
                self.image2Center.constant = line
                self.layoutIfNeeded()
            }
        } else if image1Center.constant < line/2 {
            UIView.animateWithDuration(0.25) {
                self.image1Center.constant = 0
                self.image2Center.constant = -line
                self.layoutIfNeeded()
            }
        } else {
            UIView.animateWithDuration(0.25) {
                self.image1Center.constant = line
                self.image2Center.constant = 0
                self.layoutIfNeeded()
            }
        }
    }
}
