//
//  ValueViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ValueViewController: UIViewController {

    var test = Progress(frame: CGRect(x: 30, y: 30, width: UIScreen.mainScreen().bounds.width - 60, height: UIScreen.mainScreen().bounds.width - 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(test)
    }

    // MARK: - Values
    
    @IBOutlet weak var slider: UISlider!
    @IBAction func sliderAction(sender: UISlider) {
        
    }
    @IBAction func aAction(sender: UIButton) {
        
    }
    @IBAction func bAction(sender: UIButton) {
        
    }
    @IBAction func cAction(sender: UIButton) {
        
    }

}
