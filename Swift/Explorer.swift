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
enum FileType {
    case Image
    case Video
    case Other
    case Tmp
}

class Explorer {

    // MARK: Init
    
    static let shared = Explorer()
    init() {
        //
        print(NSHomeDirectory())
        if !manager.fileExistsAtPath("\(NSHomeDirectory())/Library/Preferences/Explorer_File_Index.plist") {
            NSUserDefaults.standardUserDefaults().addSuiteNamed("Explorer_File_Index")
            NSUserDefaults.standardUserDefaults().addSuiteNamed("Explorer_File_Save")
            NSUserDefaults.standardUserDefaults().addSuiteNamed("Explorer_File_Tmp")
        }
        indexPlist = NSUserDefaults(suiteName: "Explorer_File_Index")!
        indexSave = NSUserDefaults(suiteName: "Explorer_File_Save")!
        indexTmp = NSUserDefaults(suiteName: "Explorer_File_Tmp")!
        
        clearTmp()
    }
    
    private var indexPlist: NSUserDefaults!
    private var indexSave: NSUserDefaults!
    private var indexTmp: NSUserDefaults!
    
    // MARK: - Data
    
    struct File {
        var name: String
        var type: String
        var path: String
        var time: Double
    }
    
    // MARK: Private
    
    private var manager = NSFileManager.defaultManager()
    private var index = [File]()
    
    // MARK: - Methods
    
    /// 保存数据; data: 要保存的数据; replace: 如果存在是否覆盖，默认 false; names: 文件名 ...要自定义的路径...
    func save(name: String, data: NSData?, paths: [String]? = nil, replace: Bool = false) -> Bool {
        let path = "\(NSHomeDirectory())/Documents/Explorer_Folder/Save/" + spliceName(paths) + name
        
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
    func save(name: String, data: NSData?, time: Double, paths: [String]? = nil, replace: Bool = false) -> Bool {
        let folder = spliceName(paths)
        let path = "\(NSHomeDirectory())/Documents/Explorer_Folder/Tmp/" + folder + name
        
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
                    indexTmp.setObject(["time": NSDate().timeIntervalSince1970 + time, "name": name, "folder": folder], forKey: name)
                    return true
                }
            }
        }
        return false
    }
    
    func read(tmp: Bool = false, name: String, paths: [String]? = nil) -> NSData? {
        if tmp {
            return NSData(contentsOfFile: "\(NSHomeDirectory())/Documents/Explorer_Folder/Tmp/" + spliceName(paths) + name)
        } else {
            return NSData(contentsOfFile: "\(NSHomeDirectory())/Documents/Explorer_Folder/Save/" + spliceName(paths) + name)
        }
    }
    
    // MARK: Private
    
    /// 拼接路径和名称
    private func spliceName(paths: [String]?) -> String {
        guard let paths = paths else { return "" }
        var path = ""
        for i in paths {
            path += "\(i)/"
        }
        return path
    }
    
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
    
}