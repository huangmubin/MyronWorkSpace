//
//  Refresh.swift
//  Refresh
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class Refresh: UIView, IndicatorDelegate {

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
        self.backgroundColor = UIColor.grayColor()
        
        indicator = Indicator(frame: CGRect(x: (bounds.width - size) / 2, y: (bounds.height - size) / 2, width: size, height: size))
        indicator.delegate = self
        indicator.progress = value
        label = UILabel()
        label.textColor = textColor
        setLabelText(loadText)
        
        addSubview(indicator)
        addSubview(label)
    }
    
    // MARK: - Views
    
    var label: UILabel!
    var indicator: Indicator!
    
    // MARK: - Values
    
    // MARK: Size
    
    @IBInspectable var value: CGFloat = 0 {
        didSet {
            if value > 1 {
                indicator.animation()
            } else {
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
    @IBInspectable var lineStart: CGFloat = 0.3 {
        didSet {
            indicator.strokeStart = lineStart
        }
    }
    
    // MARK: Color
    
    @IBInspectable var indicatorColor: UIColor = UIColor.blackColor() {
        didSet {
            indicator.lineColor = indicatorColor
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.grayColor() {
        didSet {
            label.textColor = textColor
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
    
    func stop() {
        setLabelText(stopText)
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
    
    func indicatorStartAnimation() {
        setLabelText(loadingText)
    }
}
