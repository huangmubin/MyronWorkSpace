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

protocol VideoConsoleDelegate: NSObjectProtocol {
    func videoConsoleValueChanged(console: VideoConsole, value: CGFloat, current: CGFloat)
    func videoConsolePlayAction(console: VideoConsole, play: Bool)
    func videoConsoleFullAction(console: VideoConsole, full: Bool)
}

class VideoConsole: UIView {

    // MARK: - Type
    
    enum Type {
        case OneLine
        case TwoLine
    }
    
    var type: Type = .OneLine {
        didSet {
            
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
        leftLabel.font = UIFont.systemFontOfSize(UIFont.systemFontSize() - 4)
        leftLabel.sizeToFit()
        
        rightLabel.text = "00:00:00"
        rightLabel.font = UIFont.systemFontOfSize(UIFont.systemFontSize() - 4)
        rightLabel.sizeToFit()
        
        slipper.backgroundColor = UIColor.clearColor()
        slipper.userInteractionEnabled = false
        slipper.deploy()
        
        addSubview(playButton)
        addSubview(fullButton)
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(slipper)
        
        
    }
    
    private func layout() {
        AutoLayout.remove(playButton)
        AutoLayout.remove(fullButton)
        AutoLayout.remove(leftLabel)
        AutoLayout.remove(rightLabel)
        AutoLayout.remove(slipper)
        
        switch type {
        case .OneLine:
            // 设置 AutoLayout，使用 AutoLayout 类方法。
            AutoLayout(self, playButton)
                .Size(playButton, 30, 30)
                .CenterY()
                .Leading()
            
            AutoLayout(self, fullButton)
                .Size(playButton, 30, 30)
                .CenterY()
                .Trailing()
            
            AutoLayout(self, leftLabel, playButton)
                .add(.CenterX, SEdge: .Trailing, constant: (leftLabel.bounds.width + 15)/2, multiplier: 1)
                .CenterY()
            
            AutoLayout(self, rightLabel, fullButton)
                .add(.CenterX, SEdge: .Leading, constant: -(rightLabel.bounds.width + 15)/2, multiplier: 1)
                .CenterY()
            
            AutoLayout(self, slipper)
                .Height(slipper, 15)
                .Center()
                .second(leftLabel)
                .add(.Leading, SEdge: .CenterX, constant: (leftLabel.bounds.width + 15)/2)
        case .TwoLine:
            break
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
    @IBInspectable var previousImage: UIImage? = UIImage(named: "")
    /// 下一曲按钮图片
    @IBInspectable var nextImage: UIImage? = UIImage(named: "")
    
    
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
    
    var value: CGFloat = 1 {
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
                block.position = CGPoint(x: bounds.width * value, y: bounds.height/2)
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
}

