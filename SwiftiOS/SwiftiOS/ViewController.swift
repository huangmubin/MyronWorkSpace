//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

// 1. 设置响应的数据类型
class AClass: JsonModel {
    var code: Int = -1
    var message: String = "Error"
    var result: [BClass] = []
    var types: [CClass] = []
    var test: BClass = BClass()
}

class CClass: JsonModel {
    var type: Bool = false
}

class BClass: JsonModel {
    var data: Int = 0
    var name: String = ""
    var types: [CClass] = []
}

class ViewController: UIViewController{
    
    var a = AClass()
    var data: NSData!
    
func jsonModelExample() {
    // 2. 设置数据类型键值对
    JsonModel.types = ["result": BClass(), "types": CClass(), "test": BClass()]
    
    // 3. 初始化最外层类
    let json = AClass()
    
    
let data = Network.data([
    "code": 10,
    "message": "OK",
    "test": [
        "data": 202,
        "name": "r-2",
        "types": [
            ["type": 1, "Error Property": "Error!"],
            ["type": 0]
        ]
    ],
    "result": [
        [
            "data": 100,
            "name": "r-0",
            "types": [
                ["type": 0]
            ]
        ]
    ],
    "types": [
        ["type": 0]
    ]
])
    
    // 4. 使用 setModel 方法将网络接收到 NSData 格式的 json 数据传入。
    json.setModel(data)
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JsonModel.types = ["result": BClass(), "types": CClass(), "test": BClass()]
        data = Network.data([
            "code": 10,
            "message": "OK",
            "test": [
                "data": 202,
                "name": "r-2",
                "types": [
                    ["type": 1, "Error Property": "Error!"],
                    ["type": 0]
                ]
            ],
            "result": [
                [
                    "data": 100,
                    "name": "r-0",
                    "types": [
                        ["type": 0]
                    ]
                ]
            ],
            "types": [
                ["type": 0]
            ]
        ])
        a.setModel(data)
    }
    
    @IBAction func leftAction(sender: UIBarButtonItem) {
        print(a)
        print("Yes")
        
    }
    @IBAction func rightAction(sender: UIBarButtonItem) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
func networkExample() {
    let network = Network()
    let url = "http://www.xxxx.com/xxxx/xx.png" // 链接地址
    let taskName = "Examplt" // 任务名称，同一名称的任务未调用完毕，无法再次调用。
    let header = ["name": "value"] // 请求头设置
    let body = Network.data(["name": "value"]) // 通过类方法，将字典转换成为 Json 数据。
    
    /// 普通返回类型完整调用方法，部分参数有默认值，如果为空可以不设置，详细查看方法列表
    network.POST(taskName, url: url, header: header, body: body) { (name, data, response, error) in
        /* ... */
    }
    
    /// Response 返回类型完整调用方法，方法名称大小写不同，部分参数有默认值，如果为空可以不设置，详细查看方法列表
    network.Post(taskName, url: url, header: header, body: body) { (response) in
        /* ... */
    }
    
    /// 简便方法
    Network().Get("G", url: url) { (response) in
        /* ... */
    }
}
    
func networkLinkExample() {
    let network = Network()
    let url = "http://www.xxxx.com/xxxx/xx.png" // 链接地址
    let taskName = "Examplt" // 任务名称，同一名称的任务未调用完毕，无法再次调用。
    let header = ["name": "value"] // 请求头设置
    let body = Network.data(["name": "value"]) // 通过类方法，将字典转换成为 Json 数据。
    
    /**
     Link 调用步骤
     1. linkTask 设置 标示符
     2. linkRequest 设置第一个调用的 NSURLRequest 信息。(已设置默认参数，可根据情况不写参数，简洁代码)
     3. linkAddTask / linkAddTaskR 自选返回格式来设置请求回调操作，并返回 NSURLRequest 开启下一步调用。如果返回 nil，则到此中断调用，不执行下一步调用。
     4. linkTaskResume 开始任务
     */
    
    network.linkTask(taskName)
        .linkRequest(url, method: "GET", header: header, body: body, time: nil).linkAddTask { (name, data, response, error) -> NSURLRequest? in
            /* ... */
            return Network.request(url, method: "GET", header: header, body: body, time: nil)
        }.linkAddTaskR { (response) -> NSURLRequest? in
            /* ... */
            return Network.request(url, method: "GET", header: header, body: body, time: nil)
        }.linkAddTaskR { (response) -> NSURLRequest? in
            /* ... */
            return Network.request(url, method: "GET", header: header, body: body, time: nil)
        }.linkTaskResume()
}

func jsonExample(data: NSData?) {
    
    // 将 Json 数据装入
    var json: Json
    json = Json(data)       // 初始化网络获取到的 NSData 格式的 Json 数据
    json = Json(json.json!) // 初始化已经解压好的 Json 数据
    json.json = json        // 直接传入已经解压好的 Json 数据
    
    // 利用下标进行读取，然后要求返回相应类型的 optional 值
    let name1 = json["result"]["name"].string
    let name2 = json["result", "name"].string
    let data1 = json["result", "data"].int
    
    // 利用下标进行读取，然后根据调用 type 方法，返回设置的值类型，如果获取失败，则返回传入的值。
    let name3 = json["result", "name"].type("") // 返回 name 否则 “”
    let data2 = json["result", "data"].type(-1) // 返回 data 否则 -1
    
    // 函数调用法
    let array = json.array("result", "types") // types 需要是一个数组，否则返回 []
    let value = json.value(0, "result", "data") // 返回 Int 类型 data，否则返回 0
}
    
}
