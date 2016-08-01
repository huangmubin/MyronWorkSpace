//
//  AutoLayout.swift
//  AutoLayout
//
//  Created by 黄穆斌 on 16/8/1.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

// MARK: - 配置内容

class AutoLayout {
    
    // MARK: 初始化
    
    /// 设置 superview
    init(_ view: UIView) {
        self.view = view
    }
    
    /// 设置 superview first second
    init(_ view: UIView, _ first: UIView) {
        self.view = view
        self.first = first
        self.second = view
    }
    
    /// 设置 superview first second
    init(_ view: UIView, _ first: UIView, _ second: UIView) {
        self.view = view
        self.first = first
        self.second = second
    }
    
    // MARK: Valus
    
    weak var view: UIView!
    weak var first: UIView!
    weak var second: UIView!
    
    /// 设置 superview
    func superview(view: UIView) -> AutoLayout {
        self.view = view
        return self
    }
    
    /// 设置 itemview
    func first(view: UIView) -> AutoLayout {
        self.first = view
        return self
    }
    
    /// 设置 toitemview
    func second(view: UIView) -> AutoLayout {
        self.second = view
        return self
    }
    
    func views(superview: UIView, _ first: UIView, _ second: UIView) -> AutoLayout {
        self.view = superview
        self.first = first
        self.second = second
        return self
    }
    
    func views(first: UIView, _ second: UIView) -> AutoLayout {
        self.first = first
        self.second = second
        return self
    }
}

// MARK: - 全自定义方法

extension AutoLayout {
    
    /// 自定义方法
    func layout(FEdge: NSLayoutAttribute, SEdge: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1, related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: FEdge, relatedBy: related, toItem: second, attribute: SEdge, multiplier: multiplier, constant: constant))
        return self
    }
}

// MARK: - 单边设置方法

extension AutoLayout {
    
    func Top(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: related, toItem: second, attribute: .Top, multiplier: multiplier, constant: constant))
        return self
    }
    
    func Bottom(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: related, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
    
    func Leading(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: related, toItem: second, attribute: .Leading, multiplier: multiplier, constant: constant))
        return self
    }
    
    func Trailing(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: related, toItem: second, attribute: .Trailing, multiplier: multiplier, constant: constant))
        return self
    }
    
    func CenterX(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterX, relatedBy: related, toItem: second, attribute: .CenterX, multiplier: multiplier, constant: constant))
        return self
    }
    func CenterY(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterY, relatedBy: related, toItem: second, attribute: .CenterY, multiplier: multiplier, constant: constant))
        return self
    }
    
    func Width(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Width, relatedBy: related, toItem: second, attribute: .Width, multiplier: multiplier, constant: constant))
        return self
    }
    
    func Height(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Height, relatedBy: related, toItem: second, attribute: .Height, multiplier: multiplier, constant: constant))
        return self
    }
    /// 水平距离，first.Leading to second.Trailing
    func HorizontalSpace(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: related, toItem: second, attribute: .Trailing, multiplier: multiplier, constant: constant))
        return self
    }
    
    /// 垂直距离，first.Top to second.Bottom
    func VerticalSpace(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: related, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
}

// MARK: - 双边设置方法

extension AutoLayout {
    
    /// 中心对齐，first.CenterX to second.CenterX && first.CenterY to second.CenterY
    func Center(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterX, relatedBy: .Equal, toItem: second, attribute: .CenterX, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterY, relatedBy: .Equal, toItem: second, attribute: .CenterY, multiplier: multiplier, constant: constant))
        return self
    }
    
    /// 左右两边对齐
    func LeadingTrailing(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: second, attribute: .Leading, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: second, attribute: .Trailing, multiplier: multiplier, constant: constant))
        return self
    }
    
    /// 上下两边对齐
    func TopBottom(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
    
    // MARK: 角对齐
    
    /// 上下两边对齐
    func TopBottom(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
    /// 上下两边对齐
    func TopBottom(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
    /// 上下两边对齐
    func TopBottom(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
    /// 上下两边对齐
    func TopBottom(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
}

// MARK: - 类工具

extension AutoLayout {
    
    class func deploy(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    class func deploy(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    class func remove(view: UIView) {
        if let superview = view.superview {
            for constraint in superview.constraints {
                if constraint.firstItem === view {
                    superview.removeConstraint(constraint)
                    constraint.secondItem
                }
            }
        }
    }
    
}


/*


// MARK: - 完全自定义方法

/// 完全自定义的添加约束方法
func custom(first: UIView, second: UIView, attribute: NSLayoutAttribute, related: NSLayoutRelation, toAttribute: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: attribute, relatedBy: related, toItem: second, attribute: toAttribute, multiplier: multiplier, constant: constant))
    return self
}

/// first to superview: Top, Bottom, Leading(Left), Trailing(Right)
func layouts(T: CGFloat?, B: CGFloat?, L: CGFloat?, R: CGFloat?) -> AutoLayout {
    if let value = T {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: value))
    }
    if let value = B {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: value))
    }
    if let value = L {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: value))
    }
    if let value = R {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: value))
    }
    return self
}

/// first to superview: CenterX, CenterY, Height, Width
func layouts(X: CGFloat?, Y: CGFloat?, H: CGFloat?, W: CGFloat?) -> AutoLayout {
    if let value = X {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: value))
    }
    if let value = Y {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: value))
    }
    if let value = H {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: value))
    }
    if let value = W {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: value))
    }
    return self
}



// MARK: - 同边对齐方法

// MARK: - 距离空间方法


// MARK: - 宽高方法

// MARK: Super View
/// 设置 superView width
func superWidth(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant))
    return self
}

/// 设置 superview height
func superHeight(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant))
    return self
}

// MARK: Sub View

/// 设置某个子视图的 width
func subWidth(view: UIView, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant))
    return self
}

/// 设置某个子视图的 height
func subHeight(view: UIView, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant))
    return self
}

// MARK: - first 与 superview 约束对齐方法

/// first to superview
func top(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: _multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func bottom(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: _multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func leading(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: _multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func trailing(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: _multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func centerX(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: _multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func centerY(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: _multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func width(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: _multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func height(constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: _multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func top(multiplier: CGFloat, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func bottom(multiplier: CGFloat, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func leading(multiplier: CGFloat, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func trailing(multiplier: CGFloat, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func centerX(multiplier: CGFloat, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func centerY(multiplier: CGFloat, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func width(multiplier: CGFloat, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: multiplier, constant: constant))
    _multiplier = 1
    return self
}

/// first to superview
func height(multiplier: CGFloat, _ constant: CGFloat) -> AutoLayout {
    view.addConstraint(NSLayoutConstraint(item: first, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: multiplier, constant: constant))
    _multiplier = 1
    return self
}

// MARK: - first to second

*/