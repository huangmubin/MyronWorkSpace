//
//  GCD.swift
//  
//
//  Created by 黄穆斌 on 16/8/5.
//
//

import UIKit

// TODO: - 看到不明所以待验证的 GCD 用法
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

// MARK: - GCD

class GCD: NSObject {

    // MARK: - Values
    
    /// 线程名称
    var name: String!
    /// 线程
    private var queue: dispatch_queue_t!
    /// 调用的内容
    private var waitBlock: dispatch_block_t?
    /// 计时器资源
    private var timerSource: dispatch_source_t?
    /// 计数值
    private var value: Int = 0
    
    // MAKR: - Init
    
    /// name: 队列名称; serial: true 串行队列，false 并发队列;
    init(name: String, serial: Bool = true) {
        super.init()
        self.name = name
        self.queue = dispatch_queue_create(name, serial ? DISPATCH_QUEUE_SERIAL : DISPATCH_QUEUE_CONCURRENT)
    }
    
    // MARK: - Methods
    
    // MARK: 常用方法
    
    /// 给该队列添加一个并发任务(当前线程不会等待这个任务完成)
    func async(block: dispatch_block_t) {
        dispatch_async(queue, block)
    }
    
    /// 给该队列添加一个串行任务(当前线程会等待这个任务完成后才仅需下一个任务)
    func sync(block: dispatch_block_t) {
        dispatch_sync(queue, block)
    }
    
    /// 堵塞该线程，直到前面的任务都完成，然后执行该线程后才继续下一个任务。(只对并发队列有效果，否则只是跟 dispatch_async 一样。)
    func barrier_async(block: dispatch_block_t) {
        dispatch_barrier_async(queue, block)
    }
    
    /// 堵塞该线程以及当前线程，直到前面的任务都完成，然后执行该线程后才继续下一个任务。(只对并发队列有效果，否则只会堵塞当前线程，跟 dispatch_sync 一样。)
    func barrier_sync(block: dispatch_block_t) {
        dispatch_barrier_sync(queue, block)
    }
    
    // MARK: 延迟方法
    
    /// 延迟几秒后调用某方法，注意如果在串行队列中，该方法会堵塞进程，即使使用 cancel 方法，也依然会堵塞到时间结束。而且该方法无法在上一个任务完成之前再次调用，cancel 只能取消最后一次。
    func after(time: NSTimeInterval, block: dispatch_block_t) -> Bool {
        if waitBlock == nil {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time) * Int64(NSEC_PER_SEC))
            waitBlock = block
            dispatch_after(delay, queue) {
                if let block = self.waitBlock {
                    self.waitBlock = nil
                    block()
                }
            }
            return true
        } else {
            return false
        }
    }
    
    /**
     取消当前正在长时间运行的 Block
     */
    func cancelAfter() {
        waitBlock = nil
    }
    
    // MARK: 循环方法
    
    /**
     开启一个循环计时器，每间隔一定时间就调用一次。
     * handlerQueue: 事件分配到哪个队列
     * interval: 间隔时间
     * event: 间隔事件
     * cancel: 取消时的事件处理
     */
    func cycle(handlerQueue: dispatch_queue_t, interval: UInt64, event: dispatch_block_t, cancel: dispatch_block_t) {
        timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, handlerQueue)
        dispatch_source_set_timer(timerSource!, dispatch_walltime(nil, 0), NSEC_PER_SEC * interval, 0)
        dispatch_source_set_event_handler(timerSource!, event)
        dispatch_source_set_cancel_handler(timerSource!, cancel)
        dispatch_resume(timerSource!)
    }
    
    /**
     链式调用
     GCD(name: "Test")
     .cycle()
     .event(10) { print("\(NSThread.currentThread())") }
     .cancelEvent { print("Cancel") }
     .resume()
     */
    func cycle(handlerQueue: dispatch_queue_t? = nil, interval: UInt64 = 1) -> GCD {
        timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, handlerQueue ?? queue)
        dispatch_source_set_timer(timerSource!, dispatch_walltime(nil, 0), NSEC_PER_SEC * interval, 0)
        return self
    }
    /**
     链式调用
     GCD(name: "Test")
     .cycle()
     .event(10) { print("\(NSThread.currentThread())") }
     .cancelEvent { print("Cancel") }
     .resume()
     */
    func interval(interval: UInt64) -> GCD {
        dispatch_source_set_timer(timerSource!, dispatch_walltime(nil, 0), NSEC_PER_SEC * interval, 0)
        return self
    }
    /**
     链式调用
     GCD(name: "Test")
     .cycle()
     .event(10) { print("\(NSThread.currentThread())") }
     .cancelEvent { print("Cancel") }
     .resume()
     */
    func event(event: dispatch_block_t) -> GCD {
        dispatch_source_set_event_handler(timerSource!, event)
        return self
    }
    /**
     链式调用
     GCD(name: "Test")
     .cycle()
     .event(10) { print("\(NSThread.currentThread())") }
     .cancelEvent { print("Cancel") }
     .resume()
     */
    func event(times: UInt, event: dispatch_block_t) -> GCD {
        value = Int(times)
        dispatch_source_set_event_handler(timerSource!) { 
            self.value -= 1
            if self.value > 0 {
                event()
            } else {
                dispatch_source_cancel(self.timerSource!)
                self.timerSource = nil
            }
        }
        return self
    }
    /**
     链式调用
     GCD(name: "Test")
     .cycle()
     .event(10) { print("\(NSThread.currentThread())") }
     .cancelEvent { print("Cancel") }
     .resume()
     */
    func cancelEvent(event: dispatch_block_t) -> GCD {
        dispatch_source_set_cancel_handler(timerSource!, event)
        return self
    }
    /**
     链式调用
     GCD(name: "Test")
     .cycle()
     .event(10) { print("\(NSThread.currentThread())") }
     .cancelEvent { print("Cancel") }
     .resume()
     */
    func resume() -> GCD {
        dispatch_resume(timerSource!)
        return self
    }
    
    func cancel() {
        dispatch_source_cancel(timerSource!)
        timerSource = nil
    }
}

// MARK: - Class Tools

extension GCD {
    
    /// 在主线程中加入任务
    class func main(block: dispatch_block_t) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    /// 在全局并发线程中加入任务
    class func global(block: dispatch_block_t) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
    }
    
    /// 创建一个延迟运行的 GCD 任务，可用 cancel 取消。
    class func after(name: String, time: NSTimeInterval, block: dispatch_block_t) -> GCD {
        let gcd = GCD(name: name, serial: false)
        gcd.after(time, block: block)
        return gcd
    }
    
}