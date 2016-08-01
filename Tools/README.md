
# Tools

## Catalog.swift

* 更新: 修改 file 为 files 字符串数组。可一次性修改多个文件。

* markdown 目录插入程序 Markdown catalog inset tool
* Use
    * 修改文件的 file 变量为 markdown 文件路径。
    * 终端输入
    * cd <文件夹路径>
    * swiftc Catalog.swift && ./Catalog && rm ./Catalog
* 示例
    * 修改前 Test.md
    * 终端操作
    * 修改后 Test.md
    
```
// 修改前 Test.md

<!--Catalog-->

# 标题1
    正文
# 标题2
    正文
## 标题2.1
    正文
```

![](https://github.com/huangmubin/MyronWorkSpace/blob/master/Image/屏幕快照%202016-07-31%20上午11.02.25.png?raw=true)


```
// 修改后 Test.md

<!--Catalog-->
<!--Myron Catalog Start-->

* [ 标题1](#Myron_Catalog_0)
* [ 标题2](#Myron_Catalog_1)
    * [ 标题2.1](#Myron_Catalog_2)

<!--Myron Catalog End-->
<h5 id="Myron_Catalog_0"> </h5>
# 标题1
    正文
<h5 id="Myron_Catalog_1"> </h5>
# 标题2
    正文
<h5 id="Myron_Catalog_2"> </h5>
## 标题2.1
    正文
```

