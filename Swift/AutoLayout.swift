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
    deinit {
        print("AutoLayout deinit")
    }
    /// 设置 superview
    init(_ view: UIView) {
        self.view = view
    }
    
    /// 设置 superview first second
    init(_ view: UIView, _ first: UIView) {
        self.view = view
        self.first = first
        self.second = view
        self.first.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// 设置 superview first second
    init(_ view: UIView, _ first: UIView, _ second: UIView?) {
        self.view = view
        self.first = first
        self.second = second
        self.first.translatesAutoresizingMaskIntoConstraints = false
        self.second?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Views
    
    weak var view: UIView!
    weak var first: UIView!
    weak var second: UIView?
    
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
    func second(view: UIView?) -> AutoLayout {
        self.second = view
        return self
    }
    
    func views(superview: UIView, _ first: UIView, _ second: UIView?) -> AutoLayout {
        self.view = superview
        self.first = first
        self.second = second
        return self
    }
    
    func views(first: UIView, _ second: UIView?) -> AutoLayout {
        self.first = first
        self.second = second
        return self
    }
    
    // MARK: Constraints
    
    var _constrants: [NSLayoutConstraint] = []
    
    func constrants(block: ([NSLayoutConstraint]) -> Void) -> AutoLayout {
        block(_constrants)
        return self
    }
}

// MARK: - 全自定义方法

extension AutoLayout {
    
    /// 自定义方法
    func add(FEdge: NSLayoutAttribute, SEdge: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000, related: NSLayoutRelation = .Equal) -> AutoLayout {
        let constraint = NSLayoutConstraint(item: first, attribute: FEdge, relatedBy: related, toItem: second, attribute: SEdge, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        view.addConstraint(constraint)
        return self
    }
    
    func layout(FEdge: NSLayoutAttribute, SEdge: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000, related: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: first, attribute: FEdge, relatedBy: related, toItem: second, attribute: SEdge, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.firstItem
        constraint.secondItem
        view.addConstraint(constraint)
        return constraint
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
    
    func Width(view: UIView, _ constant: CGFloat, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: related, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant))
        return self
    }
    
    func Height(view: UIView, _ constant: CGFloat, _ related: NSLayoutRelation = .Equal) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: related, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant))
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
    
    // MARK: 中心两边
    
    /// 中心对齐，first.CenterX to second.CenterX && first.CenterY to second.CenterY
    func Center(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterX, relatedBy: .Equal, toItem: second, attribute: .CenterX, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .CenterY, relatedBy: .Equal, toItem: second, attribute: .CenterY, multiplier: multiplier, constant: constant))
        return self
    }
    
    /// 大小一致 Width Height
    func Size(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Width, relatedBy: .Equal, toItem: second, attribute: .Width, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Height, relatedBy: .Equal, toItem: second, attribute: .Height, multiplier: multiplier, constant: constant))
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
    
    /// 左上角对齐
    func LeadingTop(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: second, attribute: .Leading, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: multiplier, constant: constant))
        return self
    }
    /// 右上角对齐
    func TopTrailing(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: second, attribute: .Trailing, multiplier: multiplier, constant: constant))
        return self
    }
    /// 左下角对齐
    func TrailingBottom(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: second, attribute: .Trailing, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
    /// 右下角对齐
    func BottomLeading(constant: CGFloat = 0, _ multiplier: CGFloat = 1) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: second, attribute: .Leading, multiplier: multiplier, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: multiplier, constant: constant))
        return self
    }
}

// MARK: - 三边对齐方法

extension AutoLayout {
    
    /// 前对齐
    func LeadingTopBottom(constant: CGFloat = 0) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: second, attribute: .Leading, multiplier: 1, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: 1, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: 1, constant: -constant))
        return self
    }
    
    /// 后对齐
    func TrailingTopBottom(constant: CGFloat = 0) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: second, attribute: .Trailing, multiplier: 1, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: 1, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: 1, constant: constant))
        return self
    }
    
    /// 上对齐
    func TopLeadingTrailing(constant: CGFloat = 0) -> AutoLayout {
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: second, attribute: .Trailing, multiplier: 1, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: 1, constant: constant))
        view.addConstraint(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: second, attribute: .Leading, multiplier: 1, constant: constant))
        return self
    }
    
    /// 下对齐。 Bottom -= constant; Leading += constant; Trailing -= constant;
    func BottomLeadingTrailing(constant: CGFloat = 0, priority: Float = 1000) -> AutoLayout {
        _constrants.removeAll(keepCapacity: true)
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: second, attribute: .Leading, multiplier: 1, constant: constant))
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: second, attribute: .Trailing, multiplier: 1, constant: -constant))
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: 1, constant: -constant))
        _constrants.forEach {
            $0.priority = priority
            view.addConstraint($0)
        }
        return self
    }
}

// MARK: - 四边对齐的方法

extension AutoLayout {
    
    /// 中心对齐，尺寸变化。CenterX == ; CenterY == ; Width * multiplier + constant; Heigh * multiplier + constant
    func CenterAndSize(constant: CGFloat = 0, _ multiplier: CGFloat = 1, priority: Float = 1000) -> AutoLayout {
        _constrants.removeAll(keepCapacity: true)
        _constrants.append(NSLayoutConstraint(item: first, attribute: .CenterX, relatedBy: .Equal, toItem: second, attribute: .CenterX, multiplier: 1, constant: 0))
        _constrants.append(NSLayoutConstraint(item: first, attribute: .CenterY, relatedBy: .Equal, toItem: second, attribute: .CenterY, multiplier: 1, constant: 0))
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Width, relatedBy: .Equal, toItem: second, attribute: .Width, multiplier: multiplier, constant: constant))
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Height, relatedBy: .Equal, toItem: second, attribute: .Height, multiplier: multiplier, constant: constant))
        _constrants.forEach {
            $0.priority = priority
            view.addConstraint($0)
        }
        return self
    }
    
    /// 四边对齐。 Leading += constant, Trailing -= constant, Top += constant, Bottom -= constant
    func HorizontalVertical(constant: CGFloat = 0, priority: Float = 1000) -> AutoLayout {
        _constrants.removeAll(keepCapacity: true)
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Leading, relatedBy: .Equal, toItem: second, attribute: .Leading, multiplier: 1, constant: constant))
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Trailing, relatedBy: .Equal, toItem: second, attribute: .Trailing, multiplier: 1, constant: -constant))
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Top, relatedBy: .Equal, toItem: second, attribute: .Top, multiplier: 1, constant: constant))
        _constrants.append(NSLayoutConstraint(item: first, attribute: .Bottom, relatedBy: .Equal, toItem: second, attribute: .Bottom, multiplier: 1, constant: -constant))
        _constrants.forEach {
            $0.priority = priority
            view.addConstraint($0)
        }
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
        view.removeConstraints(view.constraints)
     }
    
}