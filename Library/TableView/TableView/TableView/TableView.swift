//
//  TableView.swift
//  Refresh
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

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
        headerRefresh = Refresh(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width))
        headerRefresh.center.y = 0
        headerRefresh.value = 0
        insertSubview(headerRefresh as! UIView, atIndex: 0)
    }

    // MARK: - Views
    
    var headerRefresh: TableViewHeaderRefreshProtocol!
    
    // MARK: - Values
    
    @IBInspectable var refreshSpace: CGFloat = 40
    @IBInspectable var refreshHeaderOpen: Bool = true
    @IBInspectable var refreshFootOpen: Bool = false
    
    // MARK: Private
    
    private var refreshing: Bool = false
    
    // MARK: - Methods
    
    func refreshEnd() {
        headerRefresh.end()
        UIView.animateWithDuration(0.5) { 
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        refreshing = false
    }
    
    // MARK: - Override
    
    override var contentOffset: CGPoint {
        didSet {
            guard contentOffset.y != 0 else { return }
            
            guard headerRefresh != nil else { return }
            
            // 正在刷新数据时的操作
            if refreshing {
                headerRefresh.center.y = contentOffset.y + refreshSpace
                return
            }
            
            // 当前没有在刷新数据
            
            /// 上拉
            if refreshFootOpen && contentOffset.y > 0 {
                let offset = contentOffset.y + bounds.height - contentSize.height
                if offset > refreshSpace {
                    refreshing = true
                    delegate?.tableViewRefresh(self, headOrFootRefresh: false)
                }
                return
            }
            
            /// 下拉
            if refreshHeaderOpen && contentOffset.y > -(refreshSpace * 2) {
                headerRefresh.center.y = contentOffset.y / 2
                headerRefresh.value = contentOffset.y / -(refreshSpace * 2)
            } else {
                refreshing = true
                headerRefresh.run()
                contentInset.top = refreshSpace * 2
                headerRefresh.center.y = contentOffset.y + refreshSpace
                delegate?.tableViewRefresh(self, headOrFootRefresh: true)
            }
        }
    }
    
}
