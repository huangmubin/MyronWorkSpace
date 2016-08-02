//
//  ViewController.swift
//  Refresh
//
//  Created by 黄穆斌 on 16/8/2.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let indicator = Indicator(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.backgroundColor = UIColor.clearColor()
        indicator.deploy()
        view.addSubview(indicator)
    }

    @IBAction func sliderAction(sender: UISlider) {
        indicator.progress = CGFloat(sender.value)
    }
    
    @IBAction func aAction(sender: AnyObject) {
        indicator.animation()
    }
    
    @IBAction func bAction(sender: AnyObject) {
        indicator.show()
    }

    @IBAction func cAction(sender: AnyObject) {
        indicator.stopAnimation()
    }

}

