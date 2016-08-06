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
        //performSegueWithIdentifier("ValueViewControlller", sender: nil)
        
        
<<<<<<< Updated upstream
        let a = 0
        print(String(a, radix: 2))
=======
        let time: NSTimeInterval = 10
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
        
        /*
         /// 进行定时，倒数设定的时间之后，调用完成块或调用隐藏方法。
         private func delayDismiss(time: NSTimeInterval?, completion: HUDCompletedBlock?) {
         guard let time = time else { return }
         guard time > 0 else { return }
         var timeOut = time
         timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
         dispatch_source_set_timer(timer!, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0)
         dispatch_source_set_event_handler(timer!) {
         if timeOut <= 0 {
         dispatch_async(dispatch_get_main_queue()) {
         HUD.dismiss()
         completion?()
         }
         } else {
         timeOut -= 1
         }
         }
         dispatch_resume(timer!)
         }
         */
>>>>>>> Stashed changes
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
<<<<<<< Updated upstream
        print("Done")
    }
    
=======
//        testView = VideoConsole(frame: CGRect(x: 20, y: 100, width: view.bounds.width-40, height: 30))
//        testView.delegate = self
//        view.addSubview(testView)
//        testView.autoLayoutToSupview()
        
        
        print("Done")
    }
    
    var layout: NSLayoutConstraint!
    
    func videoConsoleFullAction(console: VideoConsole, full: Bool) {
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
    
    
>>>>>>> Stashed changes
}
