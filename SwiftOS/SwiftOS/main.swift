//
//  main.swift
//  SwiftOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Foundation

//cTestFunction()

let net = Network()

net.linkTask("Test")
    .linkReques("https://github.com/huangmubin/huangmubin.github.io/archive/master.zip")
    .linkAddTask { (name, data, response, error) -> NSURLRequest? in
        print("Test 1 \(NSThread.currentThread()): error = \(error)")
        if error == nil {
            return Network.request("https://github.com/huangmubin/huangmubin.github.io/archive/master.zip", method: "GET")
        } else {
            return nil
        }
    }
    .linkAddTask { (name, data, response, error) -> NSURLRequest? in
        print("Test 2 \(NSThread.currentThread()): error = \(error)")
        if error == nil {
            return Network.request("https://github.com/huangmubin/huangmubin.github.io/archive/master.zip", method: "GET")
        } else {
            return nil
        }
    }
    .linkAddTask { (name, data, response, error) -> NSURLRequest? in
        print("Test 3 \(NSThread.currentThread()): error = \(error)")
        if error == nil {
            return Network.request("https://github.com/huangmubin/huangmubin.github.io/archive/master.zip", method: "GET")
        } else {
            return nil
        }
    }
    .linkAddTask { (name, data, response, error) -> NSURLRequest? in
        print("Test 4 \(NSThread.currentThread()): error = \(error)")
        if error == nil {
            return Network.request("https://github.com/huangmubin/huangmubin.github.io/archive/master.zip", method: "GET")
        } else {
            return nil
        }
    }
    .linkAddTask { (name, data, response, error) -> NSURLRequest? in
        print("Test 5 \(NSThread.currentThread()): error = \(error)")
        if error == nil {
            return Network.request("https://github.com/huangmubin/huangmubin.github.io/archive/master.zip", method: "GET")
        } else {
            return nil
        }
    }
    .linkAddTask { (name, data, response, error) -> NSURLRequest? in
        print("Test 6 \(NSThread.currentThread()): error = \(error)")
        if error == nil {
            return Network.request("https://github.com/huangmubin/huangmubin.github.io/archive/master.zip", method: "GET")
        } else {
            return nil
        }
    }.linkTaskResume()