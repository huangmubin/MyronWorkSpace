//
//  TableView.swift
//  Refresh
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

extension UITableViewDelegate {
    func tableViewRefresh(tableView: TableView) {
        print("TableView Refresh")
    }
    func tableViewUpdate(tableView: TableView) {
        print("TableView Update")
    }
}

class TableView: UITableView {

    // MARK: - Init
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        load()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    private func load() {
        refresh.center.y = 0
        refresh.value = 0
        insertSubview(refresh, atIndex: 0)
    }
    
    // MARK: - Values
    
    @IBInspectable var space: CGFloat = 30
    
    // MARK: Refresh
    
    @IBInspectable var refreshSize: CGFloat {
        set { refresh.size = newValue }
        get { return refresh.size }
    }
    
    @IBInspectable var lineStart: CGFloat  {
        set { refresh.lineStart = newValue }
        get { return refresh.lineStart }
    }
    
    @IBInspectable var indicatorColor: UIColor {
        set { refresh.indicatorColor = newValue }
        get { return refresh.indicatorColor }
    }
    @IBInspectable var textColor: UIColor {
        set { refresh.textColor = newValue }
        get { return refresh.textColor }
    }
    @IBInspectable var loadText: String {
        set { refresh.loadText = newValue }
        get { return refresh.loadText }
    }
    @IBInspectable var loadingText: String {
        set { refresh.loadingText = newValue }
        get { return refresh.loadingText }
    }
    @IBInspectable var stopText: String {
        set { refresh.stopText = newValue }
        get { return refresh.stopText }
    }
    
    // MARK: - Views
    
    var refresh = Refresh(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width))
    
    var refreshing = false
    
    func endRefresh() {
        refresh.stop()
        UIView.animateWithDuration(0.5) {
            self.contentInset.top = 0
            self.refresh.center.y = 0
        }
        refreshing = false
    }
    
    // MARK: - Override
    
    override var contentOffset: CGPoint {
        didSet {
            if refreshing {
                refresh.center.y = contentOffset.y + refreshSize / 2 + space
            } else {
                // 大于 0
                if contentOffset.y > 0 {
                    let offset = contentOffset.y + bounds.height - contentSize.height
                    if offset > space {
                        refreshing = true
                        delegate?.tableViewUpdate(self)
                    }
                    return
                }
                
                // 小于 0
                if contentOffset.y > -(space * 2 + refreshSize) {
                    refresh.center.y = contentOffset.y / 2
                    refresh.value = contentOffset.y / -(space * 2 + refreshSize)
                } else {
                    refreshing = true
                    refresh.value = 1.1
                    self.contentInset.top = self.space * 2 + self.refreshSize
                    refresh.center.y = contentOffset.y + refreshSize / 2 + space
                    delegate?.tableViewRefresh(self)
                }
            }
        }
    }
    
    override var contentSize: CGSize {
        didSet {
            //refreshFoot.center.y = (contentSize.height + space) > bounds.height ? contentSize.height + space : bounds.height + space
        }
    }
}
