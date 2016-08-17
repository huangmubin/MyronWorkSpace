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
    
    var datas = [Int]()
    var lock = NSLock()
    var lock1 = NSLock()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Explorer.shared.delete(name: "")
//        lock.lock()
//        print("lock 1")
//        lock1.lock()
//        print("lock 2")
//        lock1.unlock()
//        lock.unlock()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Start")
    }
    
    // MARK: - Action
    
    @IBAction func leftAction(sender: UIBarButtonItem) {
        
    }
    @IBAction func rightAction(sender: UIBarButtonItem) {
        
    }
    
    
}
