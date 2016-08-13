//
//  main.swift
//  SwiftOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Foundation

//cTestFunction()

let q = Queue<Int>()

for i in 0..<10 {
    q.push(i)
}

for i in 0 ..< 10 {
    print(q.pop())
}
print()
