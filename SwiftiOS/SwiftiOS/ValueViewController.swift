//
//  ValueViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ValueViewController: UIViewController {

    var test = Progress(frame: CGRect(x: 100, y: 100, width: UIScreen.mainScreen().bounds.width - 200, height: UIScreen.mainScreen().bounds.width - 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(test)
    }

    // MARK: - Values
    
    @IBOutlet weak var slider: UISlider!
    @IBAction func sliderAction(sender: UISlider) {
        test.value = CGFloat(sender.value)
    }
    @IBAction func aAction(sender: UIButton) {
        test.animationRun?()
        //test.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    @IBAction func bAction(sender: UIButton) {
        
    }
    @IBAction func cAction(sender: UIButton) {
        test.animationStop?()
        //test.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
    }

}
