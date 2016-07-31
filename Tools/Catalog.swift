/**
 * 介绍：
    目录插入小工具
    可以给 MarkDown 文档插入目录。
    插入后保存在原文件当中。
    目录插入的位置默认是文档开头，但是可以通过在 MarkDown 文件中添加 <!--Catalog--> 来指定目录插入的位置。
 * 使用：
    1. 修改 let file = "/Users/Myron/职业生涯文档/GitHub/MyronWorkSpace/Notes/Test.md" 为进行插入的文件路径。
    2. 打开终端，进行输入 $ 后面的内容
    3. $ cd <程序所在文件目录>
    4. $ swiftc Catalog.swift && ./Catalog && rm ./Catalog
 
 
 */

import Foundation

let file = "/Users/Myron/职业生涯文档/GitHub/MyronWorkSpace/Notes/Test.md"

// MARK: - Extension String

extension String {
    
    // MARK: 从文档中获取字符串和保存成文档
    
    /// 文件操作: 把路径读取成字符串
    func read() -> String? {
        if let data = NSData(contentsOfFile: self) {
            if let text = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
                return text
            }
        }
        return nil
    }
    
    /// 文件操作: 把字符串保存成文档
    func save(path: String) -> Bool {
        if let data = dataUsingEncoding(NSUTF8StringEncoding) {
            return data.writeToFile(path, atomically: true)
        } else {
            return false
        }
    }
    
    // MARK: 字符截取
    
    /// 根据范围获取字符串
    func sub(start: Int, end: Int) -> String {
        return substringWithRange(startIndex.advancedBy(start) ..< startIndex.advancedBy(end))
    }
    
    /// 根据范围替代字符串
    mutating func replace(start: Int, end: Int, text: String) {
        replaceRange(startIndex.advancedBy(start) ..< startIndex.advancedBy(end), with: text)
    }
    
    // MARK: 正则表达式
    
    /// 正则表达式: 查询是否符合规则
    func regex(pattern: String) -> Bool {
        if let regular = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive) {
            let result = regular.numberOfMatchesInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count))
            return result > 0
        }
        return false
    }
    
    /// 正则表达式: 查询第一个符合条件的字符串范围
    func regex1(pattern: String) -> (start: Int, end: Int)? {
        if let regular = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive) {
            let result = regular.rangeOfFirstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count))
            if result.length > 0 {
                return (result.location, result.location + result.length)
            }
        }
        return nil
    }
    
    /// 正则表达式: 返回所有符合规则的范围
    func regex2(pattern: String) -> [(start: Int, end: Int)] {
        var ranges = [(start: Int, end: Int)]()
        if let regular = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive) {
            let result = regular.matchesInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count))
            for range in result {
                ranges.append((range.range.location, range.range.location + range.range.length))
            }
        }
        return ranges
    }
    
}

// MARK: - 主体程序

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
        } else {
            print("File save error.")
        }
        //        print("-----")
        //        print(catalogText)
    } else {
        print("Can't fine catalog.")
    }
} else {
    print("Read File Error")
}
//print("Done")