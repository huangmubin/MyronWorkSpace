//
//  Refresh.swift
//  Refresh
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class Refresh: UIView, IndicatorDelegate, TableViewRefreshProtocol {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    private func load() {
        self.backgroundColor = UIColor.clearColor()
        
        indicator = Indicator(frame: CGRect(x: (bounds.width - size) / 2, y: (bounds.height - size) / 2, width: size, height: size))
        indicator.delegate = self
        indicator.progress = value
        label = UILabel()
        label.textColor = color
        setLabelText(loadText)
        
        addSubview(indicator)
        addSubview(label)
    }
    
    // MARK: - Views
    
    var label: UILabel!
    var indicator: Indicator!
    
    // MARK: - Overrides
    
    override var frame: CGRect {
        didSet {
            indicator?.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
            label?.center = CGPoint(x: bounds.width / 2, y: indicator.frame.maxY + label.bounds.height / 2)
        }
    }
    
    override var bounds: CGRect {
        didSet {
            indicator?.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
            label?.center = CGPoint(x: bounds.width / 2, y: indicator.frame.maxY + label.bounds.height / 2)
        }
    }
    
    // MARK: - Values
    
    // MARK: Size
    
    @IBInspectable var value: CGFloat = 0 {
        didSet {
            if value <= 0 {
                self.label.hidden = true
                indicator.progress = 0
            } else {
                self.label.hidden = false
                indicator.progress = value
            }
        }
    }
    
    @IBInspectable var size: CGFloat = 30 {
        didSet {
            indicator = Indicator(frame: CGRect(x: (bounds.width - size) / 2, y: (bounds.height - size) / 2, width: size, height: size))
            label.center = CGPoint(x: bounds.width / 2, y: indicator.frame.maxY + label.bounds.height / 2)
        }
    }
    
    @IBInspectable var lineStart: CGFloat = 0.5 {
        didSet {
            indicator.strokeStart = lineStart
        }
    }
    
    // MARK: Color
    
    @IBInspectable var color: UIColor = UIColor.grayColor() {
        didSet {
            indicator.lineColor = color
            label.textColor = color
        }
    }
    
    // MARK: Text
    
    @IBInspectable var loadText: String = "Refresh" {
        didSet {
            setLabelText(loadText)
        }
    }
    @IBInspectable var loadingText: String = "Refreshing"
    @IBInspectable var stopText: String = "Done"
    
    // MARK: - Methods
    
    func run() {
        animting = true
        setLabelText(loadingText)
        value = 1
        indicator.animation()
    }
    
    func end() {
        setLabelText(stopText)
        value = 0
        indicator.stopAnimation()
    }
    
    func reload() {
        indicator.progress = 0
        setLabelText(loadText)
    }
    
    private func setLabelText(text: String) {
        label.text = text
        label.sizeToFit()
        label.center = CGPoint(x: bounds.width / 2, y: indicator.frame.maxY + label.bounds.height / 2)
    }
    
    // MARK: - Indicator Delegate
    
    var animting = false
    
    func indicatorStartAnimation() {
        setLabelText(loadingText)
    }
    
    func indicatorEndAnimation() {
        animting = false
    }
}
