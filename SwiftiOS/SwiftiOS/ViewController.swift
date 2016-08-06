//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VideoConsoleDelegate {
    
    var timer: dispatch_source_t?
    
    private func delayDismiss(time: NSTimeInterval?, completion: HUDCompletedBlock?) {
        guard let time = time else { return }
        guard time > 0 else { return }
        var timeOut = time
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
        dispatch_source_set_timer(timer!, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0)
        dispatch_source_set_event_handler(timer!) {
            print("delayDismiss \(timeOut); \(NSThread.currentThread())")
            if timeOut <= 0 {
                dispatch_async(dispatch_get_main_queue()) {
                    HUD.dismiss()
                    self.timer = nil
                    completion?()
                }
            } else {
                timeOut -= 1
            }
        }
        dispatch_resume(timer!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        delayDismiss(10) { 
//            print("delayDismiss End; \(NSThread.currentThread())")
//        }
        TestGCD()
        //performSegueWithIdentifier("ValueViewControlller", sender: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        /*
        testView = VideoConsole(frame: CGRect(x: 20, y: 100, width: view.bounds.width-40, height: 30))
        testView.delegate = self
        view.addSubview(testView)
        testView.autoLayoutToSupview()
        */
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
    
    
    // 创建 计时器 dispatch_source_t
    var source: dispatch_source_t? = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
    // 计数
    var sourceTimes = 10
    //
    func TestGCD() {
        GCD(name: "Test").cycle().event(10) { 
            print("\(NSThread.currentThread())")
        }.cancelEvent { 
            print("Cancel")
        }.resume()
        
        /*
        // 设置 dispatch_source_t 为从现在开始每秒调用一次
        dispatch_source_set_timer(source!, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0)
        dispatch_source_set_timer(source!, dispatch_walltime(nil, 0), NSEC_PER_SEC * 2, 0)
        // 设置调用时的处理
        dispatch_source_set_event_handler(source!) {
            // 打印当前线程，以及计数值，然后减1.
            print("\(self.sourceTimes): \(NSThread.currentThread())")
            self.sourceTimes -= 1
            // 如果计数结束则 释放 或 cancel, 都会导致停止，但是释放不会调用 cancel handler
            if self.sourceTimes <= 0 {
                //self.source = nil
                dispatch_source_cancel(self.source!)
            }
        }
        // 调用 cancel 的时候的处理
        dispatch_source_set_cancel_handler(source!) { 
            print("source Cancel: \(NSThread.currentThread())")
            self.source = nil
        }
        // 启动 source 监听
        dispatch_resume(source!)
        */
    }
}

extension ViewController {
    
    /*
     var queue: dispatch_queue_t
     // 创建串行队列
     queue = dispatch_queue_create("A Serial Queue", DISPATCH_QUEUE_SERIAL)
     // 创建并行队列
     queue = dispatch_queue_create("A Concurrent", DISPATCH_QUEUE_CONCURRENT)
     // 获取程序主队列
     queue = dispatch_get_main_queue()
     // 获取程序全局队列
     queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
     */
    /*
    // dispatch_async(queue: dispatch_queue_t, block: dispatch_block_t)
    // 异步执行方法，不会堵塞当前的线程，但是运行顺序将不可控。
    
    print("Test Start in \(NSThread.currentThread()).")
    for i in 0 ..< 10 {
        dispatch_async(dispatch_get_main_queue()) {
            print("Test \(i) Run in \(NSThread.currentThread()).")
        }
    }
    print("Test End in \(NSThread.currentThread()).")
    */
    
    
    
    /*
     dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
     dispatch_source_set_timer(timer!, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0)
     dispatch_source_set_event_handler(timer!) {
     print("delayDismiss \(timeOut); \(NSThread.currentThread())")
     if timeOut <= 0 {
     dispatch_async(dispatch_get_main_queue()) {
     HUD.dismiss()
     self.timer = nil
     completion?()
     }
     } else {
     timeOut -= 1
     }
     }
     dispatch_resume(timer!)*/
    
}