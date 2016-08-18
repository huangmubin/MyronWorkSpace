//
//  Explorer.swift
//  
//
//  Created by 黄穆斌 on 16/8/15.
//
//

import Foundation

// MARK: - 资源管理器
/**
 功能列表：
    1. 根据名称储存文件
    2. 根据名称读取文件
    3. 检索文件目录
    4. 获取文件大小
    5. 自动删除缓存文件
 
 文件结构：
    1. video
    2. image
    3. file
 
 */
class Explorer {

    // MARK: Init
    
    static let shared = Explorer()
    private init() {
        print(NSHomeDirectory())
        if !manager.fileExistsAtPath("\(NSHomeDirectory())/Library/Preferences/Explorer_File_Tmp.plist") {
            NSUserDefaults.standardUserDefaults().addSuiteNamed("Explorer_File_Tmp")
        }
        indexTmp = NSUserDefaults(suiteName: "Explorer_File_Tmp")!
        
        clearTmp()
    }
    
    // MARK: - Data
    
    private var indexTmp: NSUserDefaults!
    private var lock: NSLock = NSLock()
    
    private var manager = NSFileManager.defaultManager()
    private var save = "\(NSHomeDirectory())/Documents/Explorer_Folder/Save/"
    private var tmp = "\(NSHomeDirectory())/Documents/Explorer_Folder/Tmp/"
    
    // MARK: - Methods
    
    /// 保存数据; data: 要保存的数据; replace: 如果存在是否覆盖，默认 false; names: 文件名 ...要自定义的路径...
    private func save(name: String, data: NSData?, paths: [String]? = nil, replace: Bool = false) -> Bool {
        lock.lock()
        let folder = spliceName(paths)
        let path = save + folder + name
        var result: Bool? = false
        if replace {
            result = data?.writeToFile(path, atomically: true)
        } else {
            if manager.fileExistsAtPath(path) {
                result = true
            } else {
                do {
                    try manager.createDirectoryAtPath(save + folder, withIntermediateDirectories: true, attributes: nil)
                } catch { }
                result = data?.writeToFile(path, atomically: true)
            }
        }
        lock.unlock()
        return result == true
    }
    
    /// 保存临时数据; data: 要保存的数据; names: 文件名 ...要自定义的路径; time: 保存时间; replace: 是否覆盖;
    private func save(name: String, data: NSData?, time: Double, paths: [String]? = nil, replace: Bool = false) -> Bool {
        lock.lock()
        let folder = spliceName(paths)
        let path = tmp + folder + name
        var result: Bool? = false
        if replace {
            result = data?.writeToFile(path, atomically: true)
        } else {
            if manager.fileExistsAtPath(path) {
                result = true
            } else {
                do {
                    try manager.createDirectoryAtPath(tmp + folder, withIntermediateDirectories: true, attributes: nil)
                } catch { }
                //result = manager.createFileAtPath(path, contents: data, attributes: nil)
                result = data?.writeToFile(path, atomically: true)
            }
        }
        if result == true {
            indexTmp.setObject(["time": NSDate().timeIntervalSince1970 + time, "name": name, "folder": folder], forKey: folder + name)
        }
        lock.unlock()
        return result == true
    }
    
    /// 持久化临时数据
    private func saveTmpData(name: String, paths: [String]? = nil, toPaths: [String]? = nil, toName: String? = nil) -> Bool {
        lock.lock()
        let folder = spliceName(paths)
        let tofolder = toPaths == nil ? folder : spliceName(toPaths)
        let toname = toName ?? name
        
        var result = false
        
        if let _ = indexTmp.objectForKey(folder + name) as? [String: AnyObject] {
            do {
                try manager.createDirectoryAtPath(save + tofolder, withIntermediateDirectories: true, attributes: nil)
                try manager.moveItemAtPath(tmp + folder + name, toPath: save + tofolder + toname)
                indexTmp.removeObjectForKey(folder + name)
                result = true
            } catch {
                result = false
            }
        }
        lock.unlock()
        return result
    }
    
    /// 获取
    private func read(isTmp: Bool = false, name: String, paths: [String]? = nil) -> NSData? {
        lock.lock()
        let data = NSData(contentsOfFile: (isTmp ? tmp : save) + spliceName(paths) + name)
        lock.unlock()
        return data
    }
    
    /// 先从本地读，再从临时读
    private func readAll(name: String, paths: [String]? = nil) -> NSData? {
        lock.lock()
        var result: NSData? = nil
        if let data = NSData(contentsOfFile: tmp + spliceName(paths) + name) {
            result = data
        } else if let data = NSData(contentsOfFile: save + spliceName(paths) + name) {
            result = data
        }
        lock.unlock()
        return result
    }
    
    /// 移动文件
    private func move(name: String, paths: [String]? = nil, toName: String?, toPaths: [String]? = nil) -> Bool {
        lock.lock()
        let toname = toName ?? name
        let path = spliceName(paths)
        let topath = spliceName(toPaths)
        var result = false
        if !(toname == name && path == topath) {
            do {
                try manager.moveItemAtPath(save + path + name, toPath: save + topath + toname)
                result = true
            } catch { }
        }
        lock.unlock()
        return result
    }
    
    /// 拷贝文件
    private func copy(name: String, paths: [String]? = nil, toName: String?, toPaths: [String]? = nil) -> Bool {
        lock.lock()
        let toname = toName ?? name
        let path = spliceName(paths)
        let topath = spliceName(toPaths)
        var result = false
        if !(toname == name && path == topath) {
            do {
                try manager.copyItemAtPath(save + path + name, toPath: save + topath + toname)
                result = true
            } catch { }
        }
        lock.unlock()
        return result
    }
    
    /// 删除文件
    private func delete(isTmp: Bool = false, name: String, paths: [String]? = nil) -> Bool {
        lock.lock()
        var result = false
        do {
            try manager.removeItemAtPath((isTmp ? tmp : save) + spliceName(paths) + name)
            if isTmp {
                indexTmp.removeObjectForKey(spliceName(paths) + name)
            }
            result = true
        } catch { }
        return result
    }
    
    // MARK: - Tmp
    
    private func extendTmpTime(name: String, paths: [String]? = nil, time: Double) {
        lock.lock()
        let key = spliceName(paths) + name
        if let object = indexTmp.objectForKey(key) as? [String: AnyObject] {
            if let time = object["time"] as? Double, let name = object["name"] as? String, let folder = object["folder"] as? String {
                indexTmp.setObject(["time": time, "name": name, "folder": folder], forKey: key)
            }
        }
        lock.unlock()
    }
    
    /// 清理 Tmp 文件
    private func clearTmp() {
        lock.lock()
        if let file = NSDictionary(contentsOfFile: "\(NSHomeDirectory())/Library/Preferences/Explorer_File_Tmp.plist") {
            let now = NSDate().timeIntervalSince1970
            for (k, o) in file {
                if let key = k as? String, let object = o as? [String: AnyObject] {
                    if let time = object["time"] as? Double, let name = object["name"] as? String, let folder = object["folder"] as? String {
                        if time <= now {
                            if let _ = try? manager.removeItemAtPath("\(NSHomeDirectory())/Documents/Explorer_Folder/Tmp/" + folder + name) {
                                indexTmp.removeObjectForKey(key)
                                continue
                            }
                        }
                    }
                    indexTmp.removeObjectForKey(key)
                }
            }
        }
        lock.unlock()
    }
    
    // MARK: Tools
    
    /// 拼接路径和名称
    private func spliceName(paths: [String]?) -> String {
        guard let paths = paths else { return "" }
        var path = ""
        for i in paths {
            path += "\(i)/"
        }
        return path
    }
    
    /// 获取文件夹大小，MB单位
    private func folderSize(isTmp: Bool = false, paths: [String]? = nil, traverseSub: Bool = true) -> Double {
        lock.lock()
        let path = (isTmp ? tmp : save) + spliceName(paths)
        var allsize: Int = 0
        var files: [String] = []
        if traverseSub {
            if let file = manager.subpathsAtPath(path) {
                files = file
            }
        } else {
            if let file = try? manager.contentsOfDirectoryAtPath(path) {
                files = file
            }
        }
        for file in files {
            if let attributes = try? manager.attributesOfItemAtPath(path + file) {
                if attributes[NSFileType] as? String != NSFileTypeDirectory {
                    if let size = attributes[NSFileSize] as? Int {
                        allsize += size
                    }
                }
            }
        }
        lock.unlock()
        return Double(allsize) / 1000000
    }
    
    /// 获取某个文件的大小
    private func fileSize(isTmp: Bool = false, name: String, paths: [String]? = nil) -> Double {
        lock.lock()
        let path = (isTmp ? tmp : save) + spliceName(paths) + name
        var fileSize = 0
        if let attributes = try? manager.attributesOfItemAtPath(path) {
            if attributes[NSFileType] as? String != NSFileTypeDirectory {
                if let size = attributes[NSFileSize] as? Int {
                    fileSize = size
                }
            }
        }
        lock.unlock()
        return Double(fileSize) / 1000000
    }
    
}

// MARK: - Interface

extension Explorer {
    
    // MARK: Shared Method
    
    /// 保存数据; name: 文件名; data: 要保存的数据; paths: 自定义的路径; replace: 如果存在是否覆盖，默认 false;
    class func save(name: String, data: NSData?, paths: [String]? = nil, replace: Bool = false) -> Bool {
        return Explorer.shared.save(name, data: data, paths: paths, replace: replace)
    }
    
    /// 保存临时数据; name: 文件名; data: 要保存的数据; paths: 自定义的路径; replace: 如果存在是否覆盖，默认 false;
    class func save(name: String, data: NSData?, time: Double, paths: [String]? = nil, replace: Bool = false) -> Bool {
        return Explorer.shared.save(name, data: data, time: time, paths: paths, replace: replace)
    }
    
    /// 获取
    class func read(isTmp: Bool = false, name: String, paths: [String]? = nil) -> NSData? {
        return Explorer.shared.read(isTmp, name: name, paths: paths)
    }
    
    /// 先从本地读，再从临时读
    class func readAll(name: String, paths: [String]? = nil) -> NSData? {
        return Explorer.shared.readAll(name, paths: paths)
    }
    
    /// 移动文件
    class func move(name: String, paths: [String]? = nil, toName: String?, toPaths: [String]? = nil) -> Bool {
        return Explorer.shared.move(name, paths: paths, toName: toName, toPaths: toPaths)
    }
    
    /// 拷贝文件
    class func copy(name: String, paths: [String]? = nil, toName: String?, toPaths: [String]? = nil) -> Bool {
        return Explorer.shared.copy(name, paths: paths, toName: toName, toPaths: toPaths)
    }
    
    /// 删除文件
    class func delete(isTmp: Bool = false, name: String, paths: [String]? = nil) -> Bool {
        return Explorer.shared.delete(isTmp, name: name, paths: paths)
    }
    
    // MARK: - Tmp
    
    class func saveTmpData(name: String, paths: [String]? = nil, toPaths: [String]? = nil, toName: String? = nil) -> Bool {
        return Explorer.shared.saveTmpData(name, paths: paths, toPaths: toPaths, toName: toName)
    }
    
    class func extendTmpTime(name: String, paths: [String]? = nil, time: Double) {
        Explorer.shared.extendTmpTime(name, paths: paths, time: time)
    }
    
    /// 获取文件夹大小，MB单位
    class func folderSize(isTmp: Bool = false, paths: [String]? = nil, traverseSub: Bool = true) -> Double {
        return Explorer.shared.folderSize(isTmp, paths: paths, traverseSub: traverseSub)
    }
    
    /// 获取某个文件的大小
    class func fileSize(isTmp: Bool = false, name: String, paths: [String]? = nil) -> Double {
        return Explorer.shared.fileSize(isTmp, name: name, paths: paths)
    }

    
    /// 获取 URL
    class func url(isTmp: Bool = false, name: String, paths: [String]? = nil) -> NSURL? {
        var path = isTmp ? shared.tmp : shared.save
        path += shared.spliceName(paths) + name
        return NSURL(string: path)
    }
    
    // MARK: - Tools
    
    /// 获取某个文件夹大小，非 Explorer 管理，非线程安全
    class func folderSize(paths: [String]? = nil, traverseSub: Bool = true) -> Double {
        let path = NSHomeDirectory() + Explorer.shared.spliceName(paths)
        var allsize: Int = 0
        var files: [String] = []
        if traverseSub {
            if let file = NSFileManager.defaultManager().subpathsAtPath(path) {
                files = file
            }
        } else {
            if let file = try? NSFileManager.defaultManager().contentsOfDirectoryAtPath(path) {
                files = file
            }
        }
        for file in files {
            if let attributes = try? NSFileManager.defaultManager().attributesOfItemAtPath(path + file) {
                if attributes[NSFileType] as? String != NSFileTypeDirectory {
                    if let size = attributes[NSFileSize] as? Int {
                        allsize += size
                    }
                }
            }
        }
        return Double(allsize) / 1000000
    }
    
    /// 获取某个文件大小，非 Explorer 管理，非线程安全
    class func fileSize(name: String, paths: [String]? = nil) -> Double {
        let path = NSHomeDirectory() + Explorer.shared.spliceName(paths)
        var fileSize = 0
        if let attributes = try? NSFileManager.defaultManager().attributesOfItemAtPath(path) {
            if attributes[NSFileType] as? String != NSFileTypeDirectory {
                if let size = attributes[NSFileSize] as? Int {
                    fileSize = size
                }
            }
        }
        return Double(fileSize) / 1000000
    }
    
}