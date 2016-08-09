//
//  ViewController.swift
//  TableView
//
//  Created by 黄穆斌 on 16/8/3.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: TableView!
    var number = 10
    @IBAction func leftAction(sender: UIBarButtonItem) {
        number = number == 10 ? 0 : 10
        tableView.reloadData()
    }
    
    @IBAction func rightAction(sender: UIBarButtonItem) {
        tableView.refreshEnd()
    }
    
    // MARK: - TableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let time = Int(arc4random() % 10)
        var text = "Test Section \(indexPath.section) - Row \(indexPath.row)"
        for _ in 0 ..< time {
            text += "0123456789;  "
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    
}

