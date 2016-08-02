//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    
    func textViewDidChange(textView: UITextView) {
        print("ViewController \(textView.text)")
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        print("ViewController textViewDidBeginEditing")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let gray = UIView()
//        gray.backgroundColor = UIColor.grayColor()
//        view.addSubview(gray)
//        /// 约束出 gray.frame = CGRect(x: 50, y: 50, width: view.frame.width-100, height: view.frame.height-100) 的效果
//        
//        func use0() { // 基础使用方法，添加并获取 NSLayoutConstraint
//            let _ = AutoLayout(view, gray).layout(.Top, SEdge: .Top, constant: 50, multiplier: 1, priority: 1000, related: .Equal)
//            let _ = AutoLayout(view, gray).layout(.Bottom, SEdge: .Bottom, constant: -50, multiplier: 1, priority: 1000, related: .Equal)
//            let _ = AutoLayout(view, gray).layout(.Leading, SEdge: .Leading, constant: 50, multiplier: 1, priority: 1000, related: .Equal)
//            let _ = AutoLayout(view, gray).layout(.Trailing, SEdge: .Trailing, constant: -50, multiplier: 1, priority: 1000, related: .Equal)
//        }
//        
//        func use1() { // 单独添加一条约束
//            AutoLayout(view, gray)
//                .add(.Top, SEdge: .Top, constant: 50, multiplier: 1, priority: 1000, related: .Equal)
//                .add(.Bottom, SEdge: .Bottom, constant: -50, multiplier: 1, priority: 1000, related: .Equal)
//                .add(.Leading, SEdge: .Leading, constant: 50, multiplier: 1, priority: 1000, related: .Equal)
//                .add(.Trailing, SEdge: .Trailing, constant: -50, multiplier: 1, priority: 1000, related: .Equal)
//        }
//        
//        func use2() { // 快捷方法，中心对齐, 高跟宽进行运算
//            AutoLayout(view, gray).CenterAndSize(-100)
//        }
//        
//        func use3() { // 快捷方法，上下左右进行运算，只能进行 constant 运行
//            AutoLayout(view, gray)
//                .HorizontalVertical(50)
//                .constrants({
//                    for con in $0 {
//                        print(con.constant)
//                    }
//                })
//        }
//        
//        func use4() {
//            AutoLayout(view, gray)
//                .Width(gray, view.frame.width - 100)
//                //.LeadingTopBottom(50)
//                .TrailingTopBottom(50)
//        }
//        
//        func use5() {
//            AutoLayout(view, gray)
//                .Height(gray, view.frame.height-100)
//                .TopLeadingTrailing(50)
//                //.BottomLeadingTrailing(50)
//        }
//        
//        use5()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Done")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

