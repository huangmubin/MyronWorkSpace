//
//  TableViewProtocol.swift
//  TableView
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class ddd: UIView {
    
}
// MARK: - Protocol

// MARK: New

/// 必须同时继承自 UIView
protocol TableViewHeaderRefreshProtocol: NSObjectProtocol {
    
    var frame: CGRect { get set }
    var center: CGPoint { get set }
    
    /// 色调
    var color: UIColor { get set }
    
    /// 进度值
    var value: CGFloat { get set }
    
    /// 运行刷新动画
    func run()
    /// 结束刷新动画
    func end()
    
}

// MARK: Extension

extension UITableViewDelegate {
    
    func tableViewRefresh(tableView: TableView, headOrFootRefresh head: Bool) {
        print("TableView Refresh \(head)")
    }
    
}