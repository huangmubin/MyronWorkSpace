//
//  Other.swift
//  
//
//  Created by 黄穆斌 on 16/8/6.
//
//

import UIKit


/// 根据 View 获取他的 ViewController
func superViewController(view: UIView) -> UIViewController? {
    var responder: UIResponder? = view
    while responder != nil {
        responder = responder?.nextResponder()
        if responder?.isKindOfClass(UIViewController.self) == true {
            break
        }
    }
    return responder as? UIViewController
}