//
//  main.swift
//  SwiftOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Foundation
//cTestFunction()

/*
 Text.swift
 */
class JsonFormatTool {
    
    // MARK: Datas
    
    /// 数据内容
    var json: AnyObject!
    var text: String = ""
    /// 结果
    var result: String = ""
    
    // MARK: Main Run
    func main(file: String) -> String {
        guard readFile(file) else { return "Read File Error" }
        guard textAnalysis() else { return "Text Analysis Error" }
        
        return "Done"
    }
    
    // MARK: Actions
    
    private func readFile(file: String) -> Bool {
        /*
        if let data = NSData(contentsOfFile: file) {
            if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) {
                self.json = json
                return true
            }
        }
         */
        if let file = file.read() {
            text = file
            return true
        }
        return false
    }
    
    enum Type {
        case normal
        case string
    }
    
    var stack = [Int]()
    
    private func textAnalysis() -> Bool {
        func space() -> String {
            var s = ""
            for _ in 0 ..< stack.count {
                s += "    "
            }
            return s
        }
        var type = Type.normal
        
        
        
        for c in text.characters {
            switch type {
            case .normal:
                if c == "\"" {
                    result.append(c)
                    type = .string
                } else if c == "," {
                    result.append(c)
                    result += "\n" + space()
                } else if c == "{" || c == "[" {
                    result.append(c)
                    
                    result += "\n" + space()
                } else if c == "]" || c == "}" {
                    
                }
            case .string:
                result.append(c)
                if c == "\"" {
                    type = .string
                }
            }
        }
        
        /*
        if let values = json as? [String: AnyObject] {
            for (key, value) in values {
                print("key = \(key); value = \(value)")
            }
        }
         */
        return false
    }
}

let file = "/Users/Myron/GitHub/MyronWorkSpace/SwiftOS/SwiftOS/TestFile.swift"

//if let data = NSData(contentsOfFile: file) {
//    if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) {
//        print(json)
//    }
//}

let json = JsonFormatTool()
print(json.main(file))

//let data = "{\"code\":0,\"message\":\"Login Success\",\"result\":{\"address\":\"pubPort:48080\",\"secret\":"bxtmXpbutaR0F7DF3BUAmJghLyD8HYV8Y8eDiQodk+3G+nDHmx+Jic/vZ7vxSZtXJBm+jwiZYI3XUWvYEKpwuUVHEWVCkxX4AhqY/7lTXXMHHIHhs8W3uAApRixDuOmJ9tinmwmQRiLFGH3itSE45JnNkv9VkkOTc1DIp0TQsLI="}}"




//{"code":0,"message":"Login Success","result":{"address":"pubPort:48080","secret":"bxtmXpbutaR0F7DF3BUAmJghLyD8HYV8Y8eDiQodk+3G+nDHmx+Jic/vZ7vxSZtXJBm+jwiZYI3XUWvYEKpwuUVHEWVCkxX4AhqY/7lTXXMHHIHhs8W3uAApRixDuOmJ9tinmwmQRiLFGH3itSE45JnNkv9VkkOTc1DIp0TQsLI="}}

//{"code":0,"message":"Subscribe publishes Success","result":[{"publish":{"content":"","creatTime":1470901203882,"pid":2,"ptype":"P","resource_url":"picture/2016-08-11/1/154001","thumbnail_url":"","title":"","uid":1,"updateTime":0,"username":"Test1"},"resourceToken":{"downloadToken":"picture/2016-08-11/1/154001?e=1470905357&token=ies5_gC7r1SKjhmX9BRwfTRnQxT7bSQdQxZPW8mF:Xbr2GISnzAc-DNLUso2CM4aLsOg=","expiredTime":1470905057,"scope":"cardvr-community"},"thumbnail_token":{"expiredTime":0,"scope":"cardvr-community"}},{"publish":{"content":"zzz","creatTime":1470898277434,"pid":1,"ptype":"P","resource_url":"picture/2016-08-11/2/145116","thumbnail_url":"test","title":"title","uid":2,"updateTime":0,"username":"asd"},"resourceToken":{"downloadToken":"picture/2016-08-11/2/145116?e=1470905357&token=ies5_gC7r1SKjhmX9BRwfTRnQxT7bSQdQxZPW8mF:lRp0HajcRxnuIqIcReA4g_bb2_s=","expiredTime":1470905057,"scope":"cardvr-community"},"thumbnail_token":{"expiredTime":0,"scope":"cardvr-community"}}]}

//{"code":0,"message":"Subscribe publishes Success","result":[{"publish":{"content":"Test 002","creatTime":1470969822282,"pid":4,"ptype":"V","resource_url":"http://oatrha4x9.bkt.clouddn.com/video/2016-08-12/1/104202","thumbnail_url":"http://oatrha4x9.bkt.clouddn.com/thumnail/2016-08-12/1/104202","title":"Myron Test 002","uid":1,"updateTime":0,"username":"Test1"},"resourceToken":{"downloadToken":"http://oatrha4x9.bkt.clouddn.com/video/2016-08-12/1/104202?e=1470973427&token=ies5_gC7r1SKjhmX9BRwfTRnQxT7bSQdQxZPW8mF:Y-22sr01ZHTrQcp7NmwMbGymICo=","expiredTime":1470973127,"scope":"cardvr-community"},"thumbnail_token":{"downloadToken":"http://oatrha4x9.bkt.clouddn.com/thumnail/2016-08-12/1/104202?e=1470973427&token=ies5_gC7r1SKjhmX9BRwfTRnQxT7bSQdQxZPW8mF:gPzYpYEtSXP0SF85hoY5Q5SQv8Y=","expiredTime":1470973127,"scope":"cardvr-community"}},{"publish":{"content":"Test 001","creatTime":1470969683688,"pid":3,"ptype":"V","resource_url":"http://oatrha4x9.bkt.clouddn.com/picture/2016-08-12/1/104121","thumbnail_url":"","title":"Myron Test 001","uid":1,"updateTime":0,"username":"Test1"},"resourceToken":{"downloadToken":"http://oatrha4x9.bkt.clouddn.com/picture/2016-08-12/1/104121?e=1470973287&token=ies5_gC7r1SKjhmX9BRwfTRnQxT7bSQdQxZPW8mF:R6b_Ej4JmyAb_UPGa06Lbxrf8Tc=","expiredTime":1470972987,"scope":"cardvr-community"},"thumbnail_token":{"downloadToken":"?e=1470973287&token=ies5_gC7r1SKjhmX9BRwfTRnQxT7bSQdQxZPW8mF:YYISfWnZM_rYUOFoM990HYO5fvU=","expiredTime":1470972987,"scope":"cardvr-community"}},{"publish":{"content":"","creatTime":1470901203882,"pid":2,"ptype":"P","resource_url":"picture/2016-08-11/1/154001","thumbnail_url":"","title":"","uid":1,"updateTime":0,"username":"Test1"},"resourceToken":{"downloadToken":"picture/2016-08-11/1/154001?e=1470973230&token=ies5_gC7r1SKjhmX9BRwfTRnQxT7bSQdQxZPW8mF:Q36x7XuPINuJaPMXQ-2b_04WBeQ=","expiredTime":1470972930,"scope":"cardvr-community"},"thumbnail_token":{"expiredTime":0,"scope":"cardvr-community"}}]}