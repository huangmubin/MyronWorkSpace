//
//  TableView.swift
//  Refresh
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//
/*
 必须添加 MyronWorkSpace -> UIKit
 Progress.swift // 上拉刷新动画
 Refresh.swift  // 下拉刷新动画
 Indicator.swift // 下拉刷新动画用的组件
 */

import UIKit

class TableView: UITableView {
    
    // MARK: - Tableview Delegate
    
    weak var actions: TableViewActions?
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    // MARK: - Load Refresh Protocol
    private var contentInsetBottom: CGFloat = 3
    private func load() {
        // HeaderRefresh
        headerRefresh = Refresh(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        headerRefresh.center.y = 0
        headerRefresh.value = 0
        insertSubview(headerRefresh as! UIView, atIndex: 0)
        
        // FooterRefresh
        let progress = Progress(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        progress.center.y = (contentSize.height > frame.height ? contentSize.height : frame.height) - 1
        progress.value = 0
        progress.backColor = UIColor.clearColor()
        //progress.colors = [UIColor.blueColor().CGColor, UIColor.purpleColor().CGColor, UIColor.whiteColor().CGColor]
        progress._type = 1
        insertSubview(progress, atIndex: 0)
        footerRefresh = progress
        
        // Content
        contentInset.bottom = contentInsetBottom
    }
    
    func deploy() {
        if headerRefresh?.bounds.width != frame.width {
            headerRefresh?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        }
        if footerRefresh?.bounds.width != frame.width {
            footerRefresh?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
            footerRefresh?.center.y = (contentSize.height > frame.height ? contentSize.height : frame.height) - 1
        }
    }

    // MARK: - Views
    
    // MARK: Refresh
    
    var headerRefresh: TableViewRefreshProtocol!
    var footerRefresh: TableViewRefreshProtocol!
    
    // MARK: Empty
    
    var emptyImage: UIImage? {
        didSet {
            _emptyImage.image = emptyImage
        }
    }
    var emptyTitle: String? {
        didSet {
            _emptyTitle.text = emptyTitle ?? "Table View Empty!"
        }
    }
    var emptyTitleColor: UIColor = UIColor.darkGrayColor() {
        didSet {
            _emptyTitle.textColor = emptyTitleColor
        }
    }
    
    
    private lazy var _emptyImage: UIImageView = UIImageView()
    private lazy var _emptyTitle: UILabel = UILabel()
    private var cellSeparatorStyleTmp = UITableViewCellSeparatorStyle.None
    
    private func emptyView(show: Bool) {
        if show {
            emptyDeploy()
            cellSeparatorStyleTmp = self.separatorStyle
            self.separatorStyle = UITableViewCellSeparatorStyle.None
        } else {
            _emptyImage.removeFromSuperview()
            _emptyTitle.removeFromSuperview()
            self.separatorStyle = cellSeparatorStyleTmp
        }
    }
    private func emptyDeploy() {
        _emptyImage.image = emptyImage ?? drawEmptyImage()
        _emptyImage.clipsToBounds = false
        _emptyImage.contentMode = UIViewContentMode.Center
        _emptyTitle.text = emptyTitle ?? "Table View Empty!"
        _emptyTitle.textColor = emptyTitleColor
        insertSubview(_emptyTitle, atIndex: 0)
        insertSubview(_emptyImage, atIndex: 0)
        emptyLayout()
    }
    
    private func emptyLayout() {
        _emptyTitle.sizeToFit()
        _emptyImage.center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        _emptyTitle.center = CGPoint(x: bounds.width/2, y: bounds.height/2+drawSize)
    }
    
    private let drawSize: CGFloat = 36
    private func drawEmptyImage() -> UIImage {
        let drawCenter = CGPoint(x: 18, y: 18)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: drawSize, height: drawSize), false, 0)
        
        let path = UIBezierPath()
        
        /// 绘制圆形
        path.moveToPoint(CGPoint(x: drawSize, y: drawSize/2))
        path.addArcWithCenter(drawCenter, radius: drawSize/2-0.5, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        path.closePath()
        
        path.moveToPoint(CGPointMake(10, 10))
        path.addLineToPoint(CGPointMake(26, 26))
        path.moveToPoint(CGPointMake(10, 26))
        path.addLineToPoint(CGPointMake(26, 10))
        path.moveToPoint(CGPointMake(10, 10))
        path.closePath()
        
        UIColor.darkGrayColor().setStroke()
        path.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - Values
    
    @IBInspectable var refreshSpace: CGFloat = 50
    @IBInspectable var refreshHeaderOpen: Bool = true {
        didSet {
            if refreshHeaderOpen {
                if let view = headerRefresh as? UIView {
                    insertSubview(view, atIndex: 0)
                }
            } else {
                if let view = headerRefresh as? UIView {
                    view.removeFromSuperview()
                }
            }
        }
    }
    @IBInspectable var refreshFooterOpen: Bool = true {
        didSet {
            if refreshFooterOpen {
                if let view = footerRefresh as? UIView {
                    insertSubview(view, atIndex: 0)
                }
            } else {
                if let view = footerRefresh as? UIView {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: Private
    
    private var refreshing: Bool = false
    private var offsetRevert: Bool = false
    
    // MARK: - Methods
    
    func refreshEnd() {
        headerRefresh.end()
        footerRefresh.end()
        UIView.animateWithDuration(0.5) { 
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.contentInsetBottom, right: 0)
        }
        refreshing = false
    }
    
    // MARK: - Override
    
    // MARK: Size
    
    override var bounds: CGRect {
        didSet {
            deploy()
        }
    }
    
    // MARK: Content
    
    override func reloadData() {
        super.reloadData()
        if let data = dataSource {
            if data.numberOfSectionsInTableView == nil {
                if data.tableView(self, numberOfRowsInSection: 0) > 0 {
                    emptyView(false)
                    return
                }
            } else {
                if let section = data.numberOfSectionsInTableView?(self) {
                    for i in 0 ..< section {
                        if data.tableView(self, numberOfRowsInSection: i) > 0 {
                            emptyView(false)
                            return
                        }
                    }
                }
            }
        }
        emptyView(true)
    }
    
    // MARK: Content
    
    override var contentSize: CGSize {
        didSet {
            deploy()
        }
    }
    
    override var contentOffset: CGPoint {
        didSet {
            // 无论如何都在变化
            if contentSize.height > frame.height {
                let offset = contentOffset.y + bounds.height - contentSize.height
                if offset > 0 {
                    footerRefresh?.center.y = offset + contentSize.height - 1
                }
            } else {
                footerRefresh?.center.y = contentOffset.y + bounds.height - 1
            }
            
            // 归位
            if contentOffset.y == 0 || contentOffset.y + bounds.height - contentSize.height == 0 {
                offsetRevert = false
                if !refreshing {
                    headerRefresh?.value = 0
                    footerRefresh?.value = 0
                }
                return
            }
            
            // 正在刷新数据时的操作
            if refreshing || offsetRevert {
                headerRefresh.center.y = contentOffset.y + refreshSpace
                return
            }
            
            if headerRefresh != nil {
                /// 下拉
                if refreshHeaderOpen && contentOffset.y > -(refreshSpace * 2) {
                    headerRefresh.center.y = contentOffset.y / 2
                    headerRefresh.value = contentOffset.y / -(refreshSpace * 2)
                } else {
                    // 设置控制变量
                    refreshing = true
                    offsetRevert = true
                    
                    // 运行动画，调节界面
                    headerRefresh.run()
                    self.contentInset.top = self.refreshSpace * 2
                    headerRefresh.center.y = contentOffset.y + refreshSpace
                    
                    // 调用代理
                    actions?.tableViewRefresh?(self, headOrFootRefresh: true)
                }
                
            }
            
            /// 上拉
            if footerRefresh != nil {
                if refreshFooterOpen && contentOffset.y > 0 {
                    if bounds.height > contentSize.height {
                        if contentOffset.y <= refreshSpace {
                            //print("contentOffset.y / refreshSpace = \(contentOffset.y / refreshSpace)")
                            footerRefresh.value = contentOffset.y / refreshSpace
                        } else {
                            // 设置控制变量
                            refreshing = true
                            offsetRevert = true
                            
                            // 运行动画，调节界面
                            footerRefresh.run()
                            
                            // 调用代理
                            actions?.tableViewRefresh?(self, headOrFootRefresh: false)
                        }
                    } else {
                        let offset = contentOffset.y + bounds.height - contentSize.height
                        if offset > 0 {
                            if offset <= refreshSpace {
                                footerRefresh.value = (offset - contentInsetBottom) / refreshSpace
                            } else {
                                // 设置控制变量
                                refreshing = true
                                offsetRevert = true
                                
                                // 运行动画，调节界面
                                footerRefresh.run()
                                
                                // 调用代理
                                actions?.tableViewRefresh?(self, headOrFootRefresh: false)
                            }
                        }
                    }
                    return
                }
            }
        }
    }
    
}



// MARK: - Protocols

// MARK: Extension UITableViewDelegate

@objc protocol TableViewActions: NSObjectProtocol {
    
    optional func tableViewRefresh(tableView: TableView, headOrFootRefresh head: Bool)
    
}

// MARK: Refresh View

/// 必须同时继承自 UIView
protocol TableViewRefreshProtocol: NSObjectProtocol {
    
    var frame: CGRect { get set }
    var center: CGPoint { get set }
    var bounds: CGRect { get set }
    /// 色调
    var color: UIColor { get set }
    
    /// 进度值
    var value: CGFloat { get set }
    
    /// 运行刷新动画
    func run()
    /// 结束刷新动画
    func end()
    
}