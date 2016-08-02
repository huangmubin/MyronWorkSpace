//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Done")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var abutton: Button!
    @IBOutlet weak var bbutton: Button!
    @IBOutlet weak var cbutton: Button!
    @IBOutlet weak var dbutton: Button!

    
    @IBAction func abuttonAction(sender: Button) {
        sender.selected = !sender.selected
    }
    
    @IBAction func bbuttonAction(sender: Button) {
        sender.selected = !sender.selected
        
    }
    
    @IBAction func cbuttonAction(sender: Button) {
        sender.selected = !sender.selected
        
        
    }
    
    @IBAction func dbuttonAction(sender: Button) {
        sender.selected = !sender.selected
        
    }
    
    @IBAction func ebuttonAction(sender: UIButton) {
        sender.selected = !sender.selected
//        print("frame: \(sender.frame); layer: \(sender.layer.frame); image: \(sender.imageView?.frame)")
//        for image in sender.subviews {
//            print(image)
//        }
//        print("--------------- Done ---------------")
    }
    
    @IBAction func fbuttonAction(sender: UIButton) {
//        print("frame: \(sender.frame); layer: \(sender.layer.frame); image: \(sender.imageView?.frame)")
//        for image in sender.subviews {
//            print(image)
//        }
//        print("--------------- Done ---------------")
    }
    
}

