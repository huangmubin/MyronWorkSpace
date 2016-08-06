//
//  SecondViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/8/6.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, VideoConsoleDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    var testView: VideoConsole!
    var superview: UIView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        superview = UIView()
        superview.backgroundColor = UIColor.grayColor()
        view.addSubview(superview)
        AutoLayout(self.view, superview).HorizontalVertical(60)
        
        testView = VideoConsole(frame: CGRect(x: 20, y: 100, width: view.bounds.width-40, height: 30))
        testView.delegate = self
        superview.addSubview(testView)
        testView.autoLayoutToSupview(true)
        
        print("Done")
    }
    
    @IBAction func rightAction(sender: UIBarButtonItem) {
        testView.play = !testView.play
    }
    
    
    func videoConsoleFullAction(console: VideoConsole, full: Bool) {
        //console.type = full ? .TwoLine : .OneLine
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
