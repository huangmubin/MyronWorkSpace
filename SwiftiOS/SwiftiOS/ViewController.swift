//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SpeakViewDelegate {
    
    var speakView: SpeakView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speakView = SpeakView(type: SpeakViewType.Button("Test"))
        speakView.autoLayoutToSuperView(self.view, space: 50)
        speakView.delegate = self
    }
    
    func speakViewTextFieldEnd(text: String) {
        print("speakViewTextFieldEnd = \(text)")
    }
    
    func add() {
        print("add")
    }
    
    @IBAction func leftAction(sender: UIBarButtonItem) {
        print(speakView.showButton.frame)
    }
    @IBAction func rightAction(sender: UIBarButtonItem) {
        speakView.showAction()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Done")
        
    }
    
}
