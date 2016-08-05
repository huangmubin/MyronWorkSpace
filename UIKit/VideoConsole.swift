//
//  VideoConsole.swift
//  
//
//  Created by 黄穆斌 on 16/8/5.
//
/*
 import file -> MyronWorkSpace/UIKit/AutoLayout.swift
 
 */

import UIKit

@objc protocol VideoConsoleDelegate: NSObjectProtocol {
    func videoConsoleValueChanged(console: VideoConsole, value: CGFloat, current: CGFloat)
    func videoConsolePlayAction(console: VideoConsole, play: Bool)
    func videoConsoleFullAction(console: VideoConsole, full: Bool)
    optional func videoConsolePreviousAndNextAction(console: VideoConsole, previous: Bool)
}

enum VideoConsoleType {
    case OneLine
    case TwoLine
}

class VideoConsole: UIView {

    // MARK: - Type
    
    /// 请设置高为 OneLine: 30; TwoLine: 50
    var type: VideoConsoleType = .OneLine {
        didSet {
            addButtons()
            layout()
            layoutIfNeeded()
        }
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
    
    // 装载时的操作
    private func load() {
        layer.cornerRadius = 4
        backgroundColor = UIColor.darkGrayColor()
        
        playButton.setImage(playImage, forState: .Normal)
        playButton.setImage(stopImage, forState: .Selected)
        playButton.addTarget(self, action: #selector(playAction), forControlEvents: .TouchUpInside)
        
        fullButton.setImage(fullImage, forState: .Normal)
        fullButton.setImage(unFullImage, forState: .Selected)
        fullButton.addTarget(self, action: #selector(fullAction), forControlEvents: .TouchUpInside)
        
        leftLabel.text = "00:00:00"
        leftLabel.textColor = UIColor.whiteColor()
        leftLabel.font = UIFont.systemFontOfSize(UIFont.systemFontSize() - 4)
        leftLabel.sizeToFit()
        
        rightLabel.text = "00:00:00"
        rightLabel.textColor = UIColor.whiteColor()
        rightLabel.font = UIFont.systemFontOfSize(UIFont.systemFontSize() - 4)
        rightLabel.sizeToFit()
        
        previousButton.addTarget(self, action: #selector(previousAction), forControlEvents: .TouchUpInside)
        nextButton.addTarget(self, action: #selector(nextAction), forControlEvents: .TouchUpInside)
        
        slipper.backgroundColor = UIColor.clearColor()
        slipper.userInteractionEnabled = false
        slipper.deploy()
        
        
        // 设置 AutoLayout 中的固定尺寸，使用 AutoLayout 类方法。
        AutoLayout(self)
            .Size(playButton, 30, 30)
            .Size(fullButton, 30, 30)
            .Size(nextButton, 30, 30)
            .Size(previousButton, 30, 30)
            .Height(slipper, 15)
        
        addButtons()
        // 设置相对尺寸
        layout()
        
        
        // 自动设置
        if autoType {
            monitorOrientation(true)
        }
    }
    
    private func addButtons() {
        playButton.removeFromSuperview()
        fullButton.removeFromSuperview()
        leftLabel.removeFromSuperview()
        rightLabel.removeFromSuperview()
        slipper.removeFromSuperview()
        nextButton.removeFromSuperview()
        previousButton.removeFromSuperview()
        
        
        addSubview(playButton)
        addSubview(fullButton)
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(slipper)
        
        switch type {
        case .OneLine:
            break
        case .TwoLine:
            nextButton.setImage(nextImage, forState: .Normal)
            previousButton.setImage(previousImage, forState: .Normal)
            
            addSubview(nextButton)
            addSubview(previousButton)
        }
    }
    
    private func layout() {
        switch type {
        case .OneLine:
            AutoLayout(self, playButton)
                .CenterY()
                .Leading()
            
            AutoLayout(self, fullButton)
                .CenterY()
                .Trailing()
            
            AutoLayout(self, leftLabel, playButton)
                .add(.CenterX, SEdge: .Trailing, constant: (leftLabel.bounds.width + 15)/2, multiplier: 1)
                .CenterY()
            
            AutoLayout(self, rightLabel, fullButton)
                .add(.CenterX, SEdge: .Leading, constant: -(rightLabel.bounds.width + 15)/2, multiplier: 1)
                .CenterY()
            
            AutoLayout(self, slipper)
                .Center()
                .second(leftLabel)
                .add(.Leading, SEdge: .CenterX, constant: (leftLabel.bounds.width + 15)/2)
            
            if let height = heightConstraint {
                height.constant = 30
            }
        case .TwoLine:
            AutoLayout(self, playButton)
                .CenterX()
                .CenterY(-5, 1)
            
            AutoLayout(self, playButton, previousButton)
                .CenterY()
                .HorizontalSpace(10)
            
            AutoLayout(self, nextButton, playButton)
                .CenterY()
                .HorizontalSpace(10)
            
            AutoLayout(self, fullButton)
                .Trailing()
                .second(playButton)
                .CenterY()
            
            AutoLayout(self, leftLabel)
                .CenterY(15, 1)
                .add(.CenterX, SEdge: .Leading, constant: (leftLabel.bounds.width + 15)/2)
            
            AutoLayout(self, rightLabel)
                .CenterY(15, 1)
                .add(.CenterX, SEdge: .Trailing, constant: -(rightLabel.bounds.width + 15)/2)
            
            AutoLayout(self, slipper)
                .CenterX()
                .second(leftLabel)
                .CenterY()
                .add(.Leading, SEdge: .CenterX, constant: (leftLabel.bounds.width + 15)/2)
            
            if let height = heightConstraint {
                height.constant = 50
            }
        }
    }

    // MARK: - Images
    
    /// 播放按钮：播放图片
    @IBInspectable var playImage: UIImage? = UIImage(named: "Play_W")
    /// 播放按钮：暂停图片
    @IBInspectable var stopImage: UIImage? = UIImage(named: "Stop_W")
    /// 全屏按钮：全屏图片
    @IBInspectable var fullImage: UIImage? = UIImage(named: "Full_W")
    /// 全屏按钮：半屏图片
    @IBInspectable var unFullImage: UIImage? = UIImage(named: "UnFull_W")
    
    /// 上一曲按钮图片
    @IBInspectable lazy var previousImage: UIImage? = UIImage(named: "Previous_W")
    /// 下一曲按钮图片
    @IBInspectable lazy var nextImage: UIImage? = UIImage(named: "Next_W")
    
    
    // MARK: - Sub Views
    
    // MAKR: Button And Label
    
    /// 播放按钮
    var playButton: UIButton = UIButton()
    /// 全屏按钮
    var fullButton: UIButton = UIButton()
    /// 左侧时间标签
    var leftLabel: UILabel = UILabel()
    /// 右侧时间标签
    var rightLabel: UILabel = UILabel()
    
    /// 下一曲按钮
    var nextButton: UIButton = UIButton()
    /// 上一曲按钮
    var previousButton: UIButton = UIButton()
    
    // MARK: 滑块
    
    /// 滑块视图
    let slipper: VideoConsoleSlipper = VideoConsoleSlipper()
    
    
    // MARK: - Values
    
    weak var delegate: VideoConsoleDelegate?
    
    // MARK: 滑块
    
    var longer: CGFloat = 100 {
        didSet {
            current = longer * value
        }
    }
    
    var current: CGFloat = 0.1 {
        didSet {
            func format(time: CGFloat) -> String {
                let t = Int(time) % 60
                if t < 10 {
                    return String(format: "0%d", t)
                } else {
                    return String(format: "%d", t)
                }
            }
            
            leftLabel.text = format(current / 3600) + ":" + format(current / 60) + ":" + format(current)
            let t = longer - current
            rightLabel.text = format(t / 3600) + ":" + format(t / 60) + ":" + format(t)
            leftLabel.sizeToFit()
            rightLabel.sizeToFit()
        }
    }
    
    var value: CGFloat = 0 {
        didSet {
            slipper.value = value
            current = longer * value
            delegate?.videoConsoleValueChanged(self, value: value, current: current)
        }
    }
    
    // MARK: Button
    
    /// 当前播放状态
    var play: Bool {
        set {
            playButton.selected = newValue
        }
        get {
            return playButton.selected
        }
    }
    /// 当前全屏状态
    var full: Bool {
        set {
            fullButton.selected = newValue
        }
        get {
            return fullButton.selected
        }
    }
    
    // MARK: - Actions
    
    func playAction(sender: UIButton) {
        sender.selected = !sender.selected
        delegate?.videoConsolePlayAction(self, play: sender.selected)
    }
    
    func fullAction(sender: UIButton) {
        sender.selected = !sender.selected
        delegate?.videoConsoleFullAction(self, full: sender.selected)
    }
    
    func nextAction(sender: UIButton) {
        delegate?.videoConsolePreviousAndNextAction?(self, previous: false)
    }
    
    func previousAction(sender: UIButton) {
        delegate?.videoConsolePreviousAndNextAction?(self, previous: true)
    }
    
    // MARK: - Override
    
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != nil {
                let color = backgroundColor ?? UIColor.clearColor()
                backgroundColor = nil
                layer.backgroundColor = color.CGColor
            }
        }
    }
    
    // MARK: - Touchs
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let x = touches.first!.locationInView(slipper).x
        switch x {
        case -20 ..< 0:
            value = 0
        case 0 ..< slipper.bounds.width:
            value = x / slipper.bounds.width
        case slipper.bounds.width ..< slipper.bounds.width + 20:
            value = 1
        default:
            break
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let x = touches.first!.locationInView(slipper).x
        switch x {
        case -20 ..< 0:
            value = 0
        case 0 ..< slipper.bounds.width:
            value = x / slipper.bounds.width
        case slipper.bounds.width ..< slipper.bounds.width + 20:
            value = 1
        default:
            break
        }
    }
    
    
    // MARK: - Slipper
    
    class VideoConsoleSlipper: UIView {
        
        // MARK: Layers
        
        let back: CAShapeLayer = CAShapeLayer()
        let line: CAShapeLayer = CAShapeLayer()
        let block: CAShapeLayer = CAShapeLayer()
        
        // MARK: Values
        
        var backColor: UIColor = UIColor.blackColor()
        var lineColor: UIColor = UIColor.whiteColor()
        var blockColor: UIColor = UIColor.whiteColor()
        
        var lineWidth: CGFloat = 2
        
        var value: CGFloat = 1 {
            didSet {
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                line.strokeEnd = value
                block.position.x = value * bounds.width
                CATransaction.commit()
            }
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
        
        // MARK: Methods
        
        func deploy() {
            
            let _ = {
                back.frame = bounds
                back.strokeColor = backColor.CGColor
                back.lineCap = kCALineCapRound
                back.lineWidth = lineWidth
                
                let path = UIBezierPath()
                path.moveToPoint(CGPoint(x: 0, y: bounds.height/2))
                path.addLineToPoint(CGPoint(x: bounds.width, y: bounds.height/2))
                back.path = path.CGPath
                layer.addSublayer(back)
            }()
            
            
            let _ = {
                line.frame = bounds
                line.strokeColor = lineColor.CGColor
                line.lineCap = kCALineCapRound
                line.lineWidth = lineWidth
                line.strokeEnd = value
                
                let path = UIBezierPath()
                path.moveToPoint(CGPoint(x: 0, y: bounds.height/2))
                path.addLineToPoint(CGPoint(x: bounds.width, y: bounds.height/2))
                line.path = path.CGPath
                layer.addSublayer(line)
            }()
            
            let _ = {
                block.frame.size = CGSize(width: bounds.height, height: bounds.height)
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                block.position = CGPoint(x: bounds.width * value, y: bounds.height/2)
                CATransaction.commit()
                block.fillColor = blockColor.CGColor
                
                block.shadowOffset = CGSizeZero
                block.shadowOpacity = 0.5
                block.shadowRadius = 1
                
                let offset = (block.bounds.size.width - lineWidth + 1) / 2
                let path = UIBezierPath(roundedRect: CGRect(x: offset, y: 0, width: (lineWidth + 1), height: block.bounds.height), cornerRadius: (lineWidth + 1) / 2)
                block.path = path.CGPath
                layer.addSublayer(block)
            }()
        }
    }
    
    // MARK: - 自动化处理
    
    // MARK: 方向
    
    /// 是否根据屏幕方向自动变化单行或双行
    @IBInspectable var autoType: Bool = true {
        didSet {
            if autoType {
                monitorOrientation(true)
            } else {
                monitorOrientation(false)
            }
        }
    }
    private var notify: Bool = false
    private func monitorOrientation(add: Bool) {
        if add {
            if !notify {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(orientationDidChanged), name: UIDeviceOrientationDidChangeNotification, object: nil)
                notify = true
            }
        } else {
            NSNotificationCenter.defaultCenter().removeObserver(self)
            notify = false
        }
        
    }
    func orientationDidChanged() {
        if autoType {
            switch UIDevice.currentDevice().orientation {
            case .LandscapeLeft, .LandscapeRight:
                type = .TwoLine
            default:
                type = .OneLine
            }
        } else {
            monitorOrientation(false)
        }
    }
    
    // MARK: 位置
    
    weak var view: UIView?
    
    /// 高度约束
    weak var heightConstraint: NSLayoutConstraint?
    weak var leadingConstraint: NSLayoutConstraint?
    weak var trailingConstraint: NSLayoutConstraint?
    weak var bottomConstraint: NSLayoutConstraint?
    
    /// 给父视图添加自动约束，请确认没有给该视图添加高度约束，或已将高度约束赋予 heightConstraint，否则将会失效。
    func autoLayoutToSupview() {
        if let superView = superview {
            if superView !== view {
                if heightConstraint == nil {
                    let c: CGFloat = type == .OneLine ? 30 : 50
                    AutoLayout(self)
                        .Height(self, c)
                        .constrants { self.heightConstraint = $0[0] }
                }
                view = superView
                AutoLayout(view!, self).Bottom().Leading().Trailing().constrants {
                    self.bottomConstraint = $0[0]
                    self.leadingConstraint = $0[1]
                    self.trailingConstraint = $0[2]
                }
            }
        }
    }
}

