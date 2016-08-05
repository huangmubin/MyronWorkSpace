//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VideoConsoleDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //performSegueWithIdentifier("ValueViewControlller", sender: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        testView = VideoConsole(frame: CGRect(x: 20, y: 100, width: view.bounds.width-40, height: 30))
        testView.delegate = self
        view.addSubview(testView)
        testView.autoLayoutToSupview()
        
        ///Users/Myron/Desktop/TestVideo.mp4
//        AutoLayout(self.view, testView)
//            .Height(testView, 50)
//            .constrants({
//                self.layout = $0[0]
//            })
//            .Center()
//            .Leading(20)
//            .Trailing(-20)
        //testView.backgroundColor = UIColor.blackColor()
        
        print("Done")
    }
    
    var layout: NSLayoutConstraint!
    
    func videoConsoleFullAction(console: VideoConsole, full: Bool) {
//        if console.type == VideoConsoleType.OneLine {
//            console.type = .TwoLine
//        } else {
//            console.type = .OneLine
//        }
        
        console.type = full ? .TwoLine : .OneLine
        print("videoConsoleFullAction \(full)")
        
    }
    
    func videoConsolePlayAction(console: VideoConsole, play: Bool) {
        print("videoConsolePlayAction \(play)")
    }
    
    func videoConsoleValueChanged(console: VideoConsole, value: CGFloat, current: CGFloat) {
        print("videoConsoleValueChanged \(value)")
    }
    
    func videoConsolePreviousAndNextAction(console: VideoConsole, previous: Bool) {
        print("videoConsolePreviousAndNextAction \(previous)")
    }
    
    var testView: VideoConsole!
    
    
}

