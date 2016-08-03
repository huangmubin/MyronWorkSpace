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
    
    @IBAction func leftAction(sender: UIBarButtonItem) {
    }
    
    @IBAction func rightAction(sender: UIBarButtonItem) {
        tableView.refreshEnd()
    }
    
    // MARK: - TableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Test Section \(indexPath.section) - Row \(indexPath.row)"
        return cell
    }
    
    
}

