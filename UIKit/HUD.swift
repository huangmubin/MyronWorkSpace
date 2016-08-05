//
//  HUD.swift
//
//
//  Created by 黄穆斌 on 16/8/1.
//
//  Coye from Chakery/HUD https://github.com/Chakery/HUD.
//  只做学习使用。

import UIKit

// MARK: - Type

/// 设定返回类型
public typealias HUDCompletedBlock = () -> Void

/// HUD 弹出视图的类型
public enum HUDType {
    case Loading
    case Success
    case Error
    case Info
    case None
}

// MARK: - Interface
extension HUD {
    
    /// 打开提示窗口
    public class func show(type: HUDType, text: String, time: NSTimeInterval? = nil, completion: HUDCompletedBlock? = nil) {
        /// 取消原来的窗口
        dismiss()
        
        /// 注册屏幕旋转监听
        shared.registerDeviceOrientationNotification()
        
        /// 创建主题视图
        var none = false
        let window = UIWindow()
        window.backgroundColor = UIColor.clearColor()
        let main = UIView()
        main.layer.cornerRadius = 10
        main.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        /// 绘制头部图片
        var image = UIImage()
        var head  = UIView()
        
        switch type {
        case .Success, .Error, .Info:
            image = shared.image(type)
        default:
            break
        }
        
        switch type {
        case .Loading:
            head = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
            (head as! UIActivityIndicatorView).startAnimating()
            head.translatesAutoresizingMaskIntoConstraints = false
            main.addSubview(head)
        case .Success, .Error, .Info:
            head = UIImageView(image: image)
            head.translatesAutoresizingMaskIntoConstraints = false
            main.addSubview(head)
        default:
            none = true
        }
        
        /// 绘制文本
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(13)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        main.addSubview(label)
        
        /// 调节尺寸
        var height: CGFloat = 0
        height = label.frame.height + (none ? 30 : 70)
        let frame = CGRect(x: 0, y: 0, width: label.frame.width + 50, height: height)
        window.frame = frame
        main.frame = frame
        
        /// 添加头视图的约束
        if !none {
            main.addConstraint(NSLayoutConstraint(item: head, attribute: .CenterY, relatedBy: .Equal, toItem: main, attribute: .CenterY, multiplier: 0.6, constant: 0))
            
            main.addConstraint(NSLayoutConstraint(item: head, attribute: .CenterX, relatedBy: .Equal, toItem: main, attribute: .CenterX, multiplier: 1, constant: 0))
            
            main.addConstraint(NSLayoutConstraint(item: head, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: shared.drawSize))
            
            main.addConstraint(NSLayoutConstraint(item: head, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: shared.drawSize))
        }
        
        // 添加标签的约束
        main.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: main, attribute: .CenterY, multiplier: none ? 1 : 1.5, constant: 0))
        main.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: main, attribute: .CenterX, multiplier: 1, constant: 0))
        main.addConstraint(NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 90))
        main.addConstraint(NSLayoutConstraint(item: label, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0))
        
        // 放置视图
        window.windowLevel = UIWindowLevelAlert
        window.center = shared.center
        window.hidden = false
        window.addSubview(main)
        shared.windows.append(window)
        
        shared.delayDismiss(time, completion: completion)
    }
    
    /// 关闭视图
    public class func dismiss() {
        if shared.timer != nil {
            dispatch_source_cancel(shared.timer!)
            shared.timer = nil
        }
        shared.removeDeviceOrientationNotification()
        shared.windows.removeAll(keepCapacity: true)
    }
}

// MARK: - HUD Object

public class HUD: NSObject {
    
    // MARK: Single
    private static let shared = HUD()
    private override init() {}
    
    // MARK: Values
    ///
    var windows: [UIWindow] = []
    /// 计时用的线程
    var timer: dispatch_source_t?
    /// 显示图片
    private var _image: (checkmark: UIImage?, Cross: UIImage?, Info: UIImage?) = (nil, nil, nil)
    
    /// 获取屏幕中心点位置
    private var center: CGPoint {
        let root = UIApplication.sharedApplication().keyWindow!.subviews.first!
        if root.bounds.width > root.bounds.height {
            return CGPoint(x: root.bounds.height/2, y: root.bounds.width/2)
        } else {
            return root.center
        }
    }
    
    // MARK: Methods
    
    /// 进行定时，倒数设定的时间之后，调用完成块或调用隐藏方法。
    private func delayDismiss(time: NSTimeInterval?, completion: HUDCompletedBlock?) {
        guard let time = time else { return }
        guard time > 0 else { return }
        var timeOut = time
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
        dispatch_source_set_timer(timer!, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0)
        dispatch_source_set_event_handler(timer!) {
            if timeOut <= 0 {
                dispatch_async(dispatch_get_main_queue()) {
                    HUD.dismiss()
                    completion?()
                }
            } else {
                timeOut -= 1
            }
        }
        dispatch_resume(timer!)
    }
    
    // MARK: Notification
    
    /// 注册屏幕旋转通知
    private func registerDeviceOrientationNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HUD.transformWindow(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    /// 移除屏幕旋转通知
    private func removeDeviceOrientationNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /// 判断新的屏幕方向，并对所有的弹出视图进行，屏幕旋转
    @objc private func transformWindow(notify: NSNotification) {
        var rotation: CGFloat = 0
        switch UIDevice.currentDevice().orientation {
        case .Portrait:
            rotation = 0
        case .PortraitUpsideDown:
            rotation = CGFloat(M_PI)
        case .LandscapeLeft:
            rotation = CGFloat(M_PI_2)
        case .LandscapeRight:
            rotation = CGFloat(M_PI_2*3)
        default:
            break
        }
        let center = self.center
        windows.forEach {
            $0.center = center
            $0.transform = CGAffineTransformMakeRotation(rotation)
        }
    }
    
    // MARK: Draw
    
    /// 显示颜色
    var drawColor = UIColor.whiteColor()
    
    /// 绘图用常量
    private let drawSize: CGFloat = 36
    private let drawCenter = CGPoint(x: 18, y: 18)
    
    /// 绘制图形
    private func draw(type: HUDType) {
        let path = UIBezierPath()
        
        /// 绘制圆形
        path.moveToPoint(CGPoint(x: drawSize, y: drawSize/2))
        path.addArcWithCenter(drawCenter, radius: drawSize/2-0.5, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        path.closePath()
        
        /// 绘制图形内的内容，按 drawSize = 36 尺寸进行绘制，具体代码后期更改
        switch type {
        case .Success: // draw checkmark
            path.moveToPoint(CGPointMake(10, 18))
            path.addLineToPoint(CGPointMake(16, 24))
            path.addLineToPoint(CGPointMake(27, 13))
            path.moveToPoint(CGPointMake(10, 18))
            path.closePath()
        case .Error: // draw X
            path.moveToPoint(CGPointMake(10, 10))
            path.addLineToPoint(CGPointMake(26, 26))
            path.moveToPoint(CGPointMake(10, 26))
            path.addLineToPoint(CGPointMake(26, 10))
            path.moveToPoint(CGPointMake(10, 10))
            path.closePath()
        case .Info:
            path.moveToPoint(CGPointMake(18, 6))
            path.addLineToPoint(CGPointMake(18, 22))
            path.moveToPoint(CGPointMake(18, 6))
            path.closePath()
            
            UIColor.whiteColor().setStroke()
            path.stroke()
            
            let path = UIBezierPath()
            path.moveToPoint(CGPointMake(18, 27))
            path.addArcWithCenter(CGPointMake(18, 27), radius: 1, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
            path.closePath()
            
            UIColor.whiteColor().setFill()
            path.fill()
        default: break
        }
        
        drawColor.setStroke()
        path.stroke()
    }
    
    
    /// 获取图片
    private func image(type: HUDType) -> UIImage {
        switch type {
        case .Error:
            if _image.Cross == nil {
                UIGraphicsBeginImageContextWithOptions(CGSizeMake(drawSize, drawSize), false, 0)
                draw(.Error)
                _image.Cross = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
            return _image.Cross!
        case .Info:
            if _image.Info == nil {
                UIGraphicsBeginImageContextWithOptions(CGSizeMake(drawSize, drawSize), false, 0)
                draw(.Info)
                _image.Info = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
            return _image.Info!
        default:
            if _image.checkmark == nil {
                UIGraphicsBeginImageContextWithOptions(CGSizeMake(drawSize, drawSize), false, 0)
                draw(.Success)
                _image.checkmark = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
            return _image.checkmark!
        }
    }
}
