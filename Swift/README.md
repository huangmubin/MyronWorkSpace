
# Swift Code

## Text 

* String 扩展
	* 字符与文件变换功能
	* 字符截取替换功能
	* 正则表达式功能
	
	
## AutoLayout

纯代码 AutoLayout 工具类

* 使用前须知
	1. superview: 父视图，约束需要添加到它身上
	2. first: 第一计算视图，用来添加约束的子视图，对应 firstItem
	3. second: 第二计算子视图，对应 secondItem，假如不设置，默认是 superview
	4. 约束计算公式： first = second * multiplier + constant

* Use
	1. 使用初始化以及相应的 View 方法设置 superview, first, second
	2. 使用 constraints 方法获取当前记录的约束。
	3. 使用 clearConstrants 方法清理约束
	4. 添加单一约束时不会清理 _constraints， 添加多约束时会自动先进行清理。

## Color

* UIColor 扩展
    * 简易的颜色创建方法
    * 获取颜色值
    * 新增更多常用色

## CGSize

* CGRect 扩展
    * 添加多个 CGRect 变化方法

## Network

* 简易的网络封装

## GCD

* GCD 简易封装和收集
