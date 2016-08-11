//
//  Network.swift
//  
//
//  Created by 黄穆斌 on 16/8/4.
//
//

import Foundation

// MARK: - Protocol
protocol NetworkDelegate: NSObjectProtocol {
    func networkDidReceiveResponse(task: Network.Task, completionHandler: (NSURLSessionResponseDisposition) -> Void)
    func networkDidReceiveData(task: Network.Task)
    func networkDidCompleteWithError(task: Network.Task, didCompleteWithError error: NSError?)
}

// MARK: - Network

// MARK: - Network Data
public class Network: NSObject {
    
    // MARK: Task Data Struct
    public class Task {
        var name: String
        var data: NSMutableData?
        var task: NSURLSessionTask?
        var response: NSURLResponse?
        
        var receive: ((name: String, data: NSMutableData?) -> Void)?
        var complete: ((name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)?
        
        init(name: String, data: NSMutableData? = nil) {
            self.name = name
            self.data = data
        }
    }
    
    // MARK: Link Network Data Struct
    
    public class LinkTask {
        var queue: NSOperationQueue = NSOperationQueue()
        var session: NSURLSession!
        var request: NSURLRequest?
        var name: String
        var tasks: [(name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> NSURLRequest?] = []
        
        //
        init(name: String) {
            queue.maxConcurrentOperationCount = 1
            session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: queue)
            self.name = name
        }
        
        deinit {
            print("LinkTask deinit")
        }
    }
    
    // MARK: Values
    
    private var queue = NSOperationQueue()
    var session: NSURLSession!
    var tasks = [Task]()
    weak var delegate: NetworkDelegate?
    
    /// 任务链对象
    var linkTask: LinkTask?
    
    // MARK: Init
    override init() {
        super.init()
        queue.maxConcurrentOperationCount = 1
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: queue)
    }
    
    
}

// MARK: - Methods
extension Network {
    
    // MARK: Task Operations
    
    /// 添加下载任务
    func add(task: Task, request: NSURLRequest) {
        queue.addOperationWithBlock {
            guard !self.tasks.contains({ $0.name == task.name }) else { return }
            task.task = self.session.dataTaskWithRequest(request)
            task.task?.taskDescription = task.name
            self.tasks.append(task)
        }
    }
    
    /// 开始下载任务
    func resume(task: Task) {
        queue.addOperationWithBlock {
            task.task?.resume()
        }
    }
    
    /// 暂停下载任务
    func suspend(task: Task) {
        queue.addOperationWithBlock {
            task.task?.suspend()
        }
    }
    
    /// 取消下载任务
    func cancel(task: Task) {
        queue.addOperationWithBlock {
            task.task?.cancel()
        }
    }
    
    func operation(operation: (Task)->Void, name: String) {
        queue.addOperationWithBlock {
            if let index = self.tasks.indexOf({ $0.name == name }) {
                operation(self.tasks[index])
            }
        }
    }
    
    // MARK: Download
    
    func download(name: String, url: String, method: String = "GET", data: NSData? = nil, header: [String: String]? = nil, body: NSData? = nil, receive: ((name: String, data: NSMutableData?) -> Void)? = nil, complete: ((name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)? = nil) -> Task? {
        
        guard let request = Network.request(url, method: method, header: header, body: body, time: nil) else { return nil }
        
        let task = Task(name: name, data: data == nil ? NSMutableData() : NSMutableData(data: data!))
        
        if data != nil {
            if header == nil {
                request.allHTTPHeaderFields = ["Range": "bytes=\(data!.length)-"]
            } else {
                request.allHTTPHeaderFields!["Range"] = "bytes=\(data!.length)-"
            }
        }
        
        task.receive  = receive
        task.complete = complete
        add(task, request: request)
        resume(task)
        return task
    }
    
    func GET(name: String, url: String, complete: ((name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)?) {
        if download(name, url: url, method: "GET", data: nil, header: nil, receive: nil, complete: complete) == nil {
            complete?(name: name, data: nil, response: nil, error: NSError(domain: "Task Create Error", code: 0, userInfo: ["name":name, "url": url, "type": "GET", "message": "Task Create Error"]))
        }
    }
    
    func GET(name: String, url: String, header: [String: String]?, complete: ((name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)?) {
        if download(name, url: url, method: "GET", data: nil, header: header, receive: nil, complete: complete) == nil {
            complete?(name: name, data: nil, response: nil, error: NSError(domain: "Task Create Error", code: 0, userInfo: ["name":name, "url": url, "type": "GET", "message": "Task Create Error"]))
        }
    }
    
    func POST(name: String, url: String, header: [String: String]?, body: NSData?, complete: ((name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)?) {
        if download(name, url: url, method: "POST", data: nil, header: header, body: body, receive: nil, complete: complete) == nil {
            complete?(name: name, data: nil, response: nil, error: NSError(domain: "Task Create Error", code: 0, userInfo: ["name":name, "url": url, "type": "POST", "message": "Task Create Error"]))
        }
    }
    
    func PUT(name: String, url: String, header: [String: String]?, body: NSData?, complete: ((name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)?) {
        if download(name, url: url, method: "PUT", data: nil, header: header, body: body, receive: nil, complete: complete) == nil {
            complete?(name: name, data: nil, response: nil, error: NSError(domain: "Task Create Error", code: 0, userInfo: ["name":name, "url": url, "type": "PUT", "message": "Task Create Error"]))
        }
    }
    
    func DELETE(name: String, url: String, header: [String: String]?, body: NSData?, complete: ((name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)?) {
        if download(name, url: url, method: "DELETE", data: nil, header: header, body: body, receive: nil, complete: complete) == nil {
            complete?(name: name, data: nil, response: nil, error: NSError(domain: "Task Create Error", code: 0, userInfo: ["name":name, "url": url, "type": "DELETE", "message": "Task Create Error"]))
        }
    }
}

// MARK: - NSURLSessionDelegate
extension Network: NSURLSessionDelegate {
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        let index = tasks.indexOf({ dataTask.taskDescription == $0.name })!
        tasks[index].response = response
        if delegate == nil {
            completionHandler(.Allow)
        } else {
            delegate?.networkDidReceiveResponse(tasks[index], completionHandler: completionHandler)
        }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        let index = tasks.indexOf({ dataTask.taskDescription == $0.name })!
        let task  = tasks[index]
        task.data?.appendData(data)
        task.receive?(name: task.name, data: task.data)
        delegate?.networkDidReceiveData(tasks[index])
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        let index = tasks.indexOf({ task.taskDescription == $0.name })!
        let task = tasks.removeAtIndex(index)
        task.complete?(name: task.name, data: task.data, response: task.response, error: error)
        delegate?.networkDidCompleteWithError(task, didCompleteWithError: error)
    }
    
}

// MARK: - Link Task 任务链方法

extension Network {
        
    /// 创建任务链
    func linkTask(name: String) -> Network {
        if let link = linkTask {
            link.tasks.removeAll()
        }
        linkTask = LinkTask(name: name)
        return self
    }
    
    /// 创建任务链初始请求
    func linkReques(path: String, method: String = "GET", header: [String: String]? = nil, body: NSData? = nil, time: NSTimeInterval? = nil) -> Network {
        self.linkTask?.request = Network.request(path, method: method, header: header, body: body, time: time)
        return self
    }
    
    /// 添加任务链下载任务回调
    func linkAddTask(block: (name: String, data: NSData?, response: NSURLResponse?, error: NSError?) -> NSURLRequest?) -> Network {
        self.linkTask?.tasks.append(block)
        return self
    }
    
    /// 启动任务链
    func linkTaskResume() {
        if let link = linkTask, let request = linkTask?.request {
            link.session.dataTaskWithRequest(request) { [weak self] (data, response, error) in
                if link.tasks.count > 0 {
                    let block = link.tasks.removeFirst()
                    if let newRequest = block(name: link.name, data: data, response: response, error: error) {
                        self?.linkTask?.request = newRequest
                        self?.linkTaskResume()
                        return
                    }
                }
                self?.linkTask?.tasks.removeAll()
                self?.linkTask = nil
                }.resume()
        }
    }
}

// MARK: - Tools
extension Network {
    
    // MARK: Request
    
    /// 创建 Request
    class func request(path: String,
                     method: String,
                     header: [String: String]?  = nil,
                       body: NSData?            = nil,
                       time: NSTimeInterval?    = nil
        ) -> NSMutableURLRequest? {
        
        guard let url = NSURL(string: path) else { return nil }
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = method
        request.HTTPBody = body
        
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let time = time {
            request.timeoutInterval = time
        }
        
        return request
    }
    
    // MARK: Encode
    
    class func encodeURLComponent(url: String?) -> String? {
        return url?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString: "?!@#$^&%*+,:;='\"`<>()[]{}/\\| ").invertedSet)
    }
    
    // MARK: Data
    
    /// 获取状态码
    class func statusCode(response: NSURLResponse?) -> Int {
        if let http = response as? NSHTTPURLResponse {
            return http.statusCode
        }
        return 0
    }
    
    
    /// 获取所有头数据
    class func allHeaderFields(response: NSURLResponse?) -> [NSObject:AnyObject] {
        if let http = response as? NSHTTPURLResponse {
            return http.allHeaderFields
        }
        return [:]
    }
    
    /// 把 NSData 转换成 Json 数据
    class func json(data: NSData?) -> AnyObject? {
        if let json = data {
            if let jsonData = try? NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.AllowFragments) {
                return jsonData
            }
        }
        return nil
    }
    
    /// 把 NSData 转换成 Json 数据，并提取其中某个 Key 对应的 Value 值。
    class func json(data: NSData?, key: String) -> AnyObject? {
        if let json = json(data) as? [String:AnyObject] {
            if let value = json[key] {
                return value
            }
        }
        return nil
    }
    
    /// 把 Json 数据转存成 NSData
    class func data(json: AnyObject) -> NSData? {
        if let data = try? NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted) {
            return data
        }
        return nil
    }
    
}

