
# Myron Work Space

* 前言

这是我的工作空间，记录了我所有的代码以及工作日记。
当然，这是从 2016-07-31 日开始的，过去的就让他过去吧。
希望能对你有所帮助，也希望，能对以后的我有所帮助。

* Preface

I hope my github will be helpful to you.

# Swift Code

## Extension

### String

* 正则表达式 Regular expression

# UIKit Views

## View

* 可通过 Storyboard 设置圆角，阴影等属性的 View.

# Note

* 正则表达式笔记 Regular Expression Note

# Tools

## Catalog.swift

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

