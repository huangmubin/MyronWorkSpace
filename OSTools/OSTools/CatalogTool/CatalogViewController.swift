//
//  ViewController.swift
//  OSTools
//
//  Created by 黄穆斌 on 16/8/2.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import Cocoa

class CatalogViewController: NSViewController {
    
    @IBOutlet var pathTextView: NSTextView!
    
    @IBOutlet weak var resultTextField: NSTextField!
    
    @IBAction func insertAction(sender: NSButton) {
        if var text = pathTextView.string {
            if !text.hasSuffix("\n") {
                text += "\n"
            }
            var paths = [String]()
            var start = 0
            var end   = 0
            for (i, c) in text.characters.enumerate() {
                if c == "\n" {
                    end = i
                    let path = text.sub(start, end: end)
                    if !path.isEmpty {
                        paths.append(path)
                    }
                    //print("T = \(text.sub(start, end: end)); \(path.isEmpty)")
                    start = i + 1
                }
            }
            var result = ""
            for path in paths {
                result += insertCatalog(path)
                result += "; "
            }
            resultTextField.stringValue = result
            //print(paths)
        } else {
            resultTextField.stringValue = "没有检测到文档。"
        }
    }
    
    func insertCatalog(file: String) -> String {
        // MARK: 获取文本内容
        if var text = file.read() {
            // MARK: 检查是否已经有生成目录，有的话去除目录
            if let range = text.regex1("<!--Myron Catalog Start-->[\\u0000-\\uFFFF]*<!--Myron Catalog End-->") {
                //print(text.sub(range.start, end: range.end))
                text.replace(range.start, end: range.end, text: "")
                
                var range = text.regex1("<h5 id=\"Myron_Catalog_[0-9]+\"> </h5>")
                while range != nil {
                    text.replace(range!.start, end: range!.end, text: "")
                    range = text.regex1("<h5 id=\"Myron_Catalog_[0-9]+\"> </h5>")
                }
            }
            
            // MARK: 获取目录文本范围
            let ranges = text.regex2("\n#+[^\n]*\n")
            if ranges.count > 0 {
                
                // MARK: 给目录打上标记
                var jumpIndex = 0
                var catalog = text
                catalog.removeAll(keepCapacity: true)
                
                catalog += "<!--Myron Catalog Start-->\n\n"
                
                // MARK: 创建目录文本内容
                var insetTab = 0
                for range in ranges {
                    let catalogText = text.sub(range.start+1, end: range.end-1)
                    insetTab = 0
                    for c in catalogText.characters {
                        if c == "#" && insetTab == 0 {
                            insetTab = 1
                        } else if c == "#" && insetTab == 1 {
                            catalog += "    "
                        } else if insetTab == 1 {
                            catalog += "* ["
                            insetTab = 2
                            catalog.append(c)
                        } else {
                            catalog.append(c)
                        }
                    }
                    catalog += "](#Myron_Catalog_\(jumpIndex))\n"
                    jumpIndex += 1
                }
                //print(catalog)
                // 打上结束标记
                catalog += "\n<!--Myron Catalog End-->\n\n"
                
                // MARK: 插入文本内容
                jumpIndex = 0
                var catalogText = ""
                var insetIndex = 0
                for range in ranges {
                    catalogText += text.sub(insetIndex, end: range.start)
                    catalogText += "<h5 id=\"Myron_Catalog_\(jumpIndex)\"> </h5>"
                    jumpIndex += 1
                    insetIndex = range.start
                }
                catalogText += text.sub(ranges.last!.start, end: text.characters.count)
                
                // MARK: 检查是否有目录标记，有的话把目录插入到相应位置，否则插入到前面
                if let range = catalogText.regex1("<!--Catalog-->") {
                    //print(catalogText.sub(range.start, end: range.end))
                    catalogText.replace(range.end-1, end: range.end, text: ">\n" + catalog)
                }
                
                
                // MARK: 保存文件
                if catalogText.save(file) {
                    print("Catalog is insert done, Thank you!")
                    return "Catalog is insert done, Thank you!"
                } else {
                    print("File save error.")
                    return "File save error."
                }
            } else {
                print("Can't fine catalog.")
                return "Can't fine catalog."
            }
        } else {
            print("Read File Error")
            return "Read File Error"
        }
    }
}