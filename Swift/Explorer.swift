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
    init() {
        //
        print(NSHomeDirectory())
        if !manager.fileExistsAtPath("\(NSHomeDirectory())/Library/Preferences/Explorer_File_Tmp.plist") {
            NSUserDefaults.standardUserDefaults().addSuiteNamed("Explorer_File_Tmp")
        }
        indexTmp = NSUserDefaults(suiteName: "Explorer_File_Tmp")!
        
        clearTmp()
    }
    
    private var indexTmp: NSUserDefaults!
    
    // MARK: - Data
    
    private var manager = NSFileManager.defaultManager()
    private var save = "\(NSHomeDirectory())/Documents/Explorer_Folder/Save/"
    private var tmp = "\(NSHomeDirectory())/Documents/Explorer_Folder/Tmp/"
    
    // MARK: - Methods
    
    /// 保存数据; data: 要保存的数据; replace: 如果存在是否覆盖，默认 false; names: 文件名 ...要自定义的路径...
    private func save(name: String, data: NSData?, paths: [String]? = nil, replace: Bool = false) -> Bool {
        let path = save + spliceName(paths) + name
        
        if replace {
            if data?.writeToFile(path, atomically: true) == true {
                return true
            }
        } else {
            if manager.fileExistsAtPath(path) {
                return true
            } else {
                if data?.writeToFile(path, atomically: true) == true {
                    return true
                }
            }
        }
        return false
    }
    
    /// 保存临时数据; data: 要保存的数据; names: 文件名 ...要自定义的路径; time: 保存时间; replace: 是否覆盖;
    private func save(name: String, data: NSData?, time: Double, paths: [String]? = nil, replace: Bool = false) -> Bool {
        let folder = spliceName(paths)
        let path = tmp + folder + name
        
        if replace {
            if data?.writeToFile(path, atomically: true) == true {
                indexTmp.setObject(["time": NSDate().timeIntervalSince1970 + time, "name": name, "folder": folder], forKey: folder + name)
                return true
            }
        } else {
            if manager.fileExistsAtPath(path) {
                return true
            } else {
                if data?.writeToFile(path, atomically: true) == true {
                    indexTmp.setObject(["time": NSDate().timeIntervalSince1970 + time, "name": name, "folder": folder], forKey: folder + name)
                    return true
                }
            }
        }
        return false
    }
    
    /// 获取
    private func read(tmp: Bool = false, name: String, paths: [String]? = nil) -> NSData? {
        return NSData(contentsOfFile: (tmp ? self.tmp : save) + spliceName(paths) + name)
    }
    
    /// 移动文件
    private func move(name: String, paths: [String]? = nil, toName: String?, toPaths: [String]? = nil) -> Bool {
        let toname = toName ?? name
        let path = spliceName(paths)
        let topath = spliceName(toPaths)
        if !(toname == name && path == topath) {
            do {
                try manager.moveItemAtPath(save + path + name, toPath: save + topath + toname)
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    /// 拷贝文件
    private func copy(name: String, paths: [String]? = nil, toName: String?, toPaths: [String]? = nil) -> Bool {
        let toname = toName ?? name
        let path = spliceName(paths)
        let topath = spliceName(toPaths)
        if !(toname == name && path == topath) {
            do {
                try manager.copyItemAtPath(save + path + name, toPath: save + topath + toname)
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    /// 删除文件
    private func delete(tmp: Bool = false, name: String, paths: [String]? = nil) -> Bool {
        do {
            try manager.removeItemAtPath((tmp ? self.tmp : save) + spliceName(paths) + name)
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - Tmp
    /// 清理 Tmp 文件
    private func clearTmp() {
        if let file = NSDictionary(contentsOfFile: "\(NSHomeDirectory())/Library/Preferences/Explorer_File_Tmp.plist") {
            let now = NSDate().timeIntervalSince1970
            for (k, o) in file {
                let key = k as! String
                let object = o as! [String: AnyObject]
                if let time = object["time"] as? Double {
                    if time <= now {
                        if let name = object["name"] as? String, let folder = object["folder"] as? String {
                            if let _ = try? manager.removeItemAtPath("\(NSHomeDirectory())/Documents/Explorer_Folder/Tmp/" + folder + name) {
                                indexTmp.removeObjectForKey(key)
                            }
                        } else {
                            indexTmp.removeObjectForKey(key)
                        }
                    }
                } else {
                    indexTmp.removeObjectForKey(key)
                }
            }
        }
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
    
}