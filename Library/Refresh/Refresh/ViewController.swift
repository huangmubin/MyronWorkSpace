//
//  ViewController.swift
//  Refresh
//
//  Created by 黄穆斌 on 16/8/2.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func leftAction(sender: UIBarButtonItem) {
    }
    @IBAction func rightAction(sender: UIBarButtonItem) {
        tableView.endRefresh()
    }
    
    @IBOutlet weak var tableView: TableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Test Cell Index = \(indexPath.section) : \(indexPath.row)"
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Other
    
    @IBOutlet weak var refresh: Refresh!
    
    let indicator = Indicator(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
    @IBAction func sliderAction(sender: UISlider) {
        refresh.value = CGFloat(sender.value)
    }
    
    @IBAction func aAction(sender: AnyObject) {
        refresh.value = 1.1
    }
    
    @IBAction func bAction(sender: AnyObject) {
        refresh.reload()
    }

    @IBAction func cAction(sender: AnyObject) {
        refresh.stop()
    }

}

