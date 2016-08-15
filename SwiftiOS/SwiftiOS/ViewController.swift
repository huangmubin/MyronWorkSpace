//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    let image = ImagePlayer()
    
    // MARK: - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Explorer.shared)
        
        view.addSubview(image)
        image.type = ImagePlayerType.Scale(16, 9)
        AutoLayout(self.view, image).Center().Size()
        image.images = [
            UIImage(named: "1")!,
            UIImage(named: "2")!,
            UIImage(named: "3")!,
            UIImage(named: "4")!,
            UIImage(named: "5")!,
        ]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - Action
    
    @IBAction func leftAction(sender: UIBarButtonItem) {
        
    }
    @IBAction func rightAction(sender: UIBarButtonItem) {
        
    }
    
    
}
