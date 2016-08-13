
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

### 设计思路

#### 来源

不管 AutoLayout 的类库封装得多么华丽，本质上，都还是对苹果的 NSLayoutConstraint 类的一个封装。所以关键还是要搞懂这个初始化方法。
```
NSLayoutConstraint
convenience init(item view1: AnyObject,
            attribute attr1: NSLayoutAttribute,
         relatedBy relation: NSLayoutRelation,
               toItem view2: AnyObject?,
            attribute attr2: NSLayoutAttribute,
      multiplier multiplier: CGFloat,
                 constant c: CGFloat)
```

* view1: 约束对象，你如果在 Storyboard 上用过 Autolayout, 这就是你按住 command 键拉出一条线的那个视图。
* att1: 约束属性，就是高度，中心，头尾这些。
* relation: 关系，有等于，大于小于。
* view2: 作为参考对象的视图。
* attr2: 参考对象的哪一条变用来作为参考。
* multiplier: 倍数
* constant: 差额

用关系式来表达就是
```
view1.att1 relation view2.attr2 * multiplier + constant
或者
view1.att1 (==, >=, <=) view2.attr2 * mulitiplier + constant
```

所以要完成一个约束，
* 有三个关键对象要搞清楚
* superview: 这是以上约束中没有的参数，但是，这是最重要的，就是你的约束要添加的视图，也就是 view1 跟 view2 的共同父类。
* view1: 添加约束的视图。
* view2: 参考视图。
* 一种关系必须明确
* relation: 是等于，还是大于，还是小于？
* 两个属性要知道
* att1: 要进行约束的那条边
* att2: 用来参考的那条边

#### AutoLayout

因此，开始封装的时候，我需要解决三个问题。
* 如何确定三个对象。
* 如何选择他们的边关系。
* 如何输入倍数和差额。
当然，三个问题，都有前提：优雅。

##### 三个对象：数据结构设计
解决三个对象的问题，使用 weak 防止循环引用等问题。second 并非所有情况都必须，所以设置为 optional 类型。

```
weak var view: UIView!
weak var first: UIView!
weak var second: UIView?
```

初始化的时候就需要指定这些 view, 当然也可以通过相应方法进行变更。所有的方法都会返回 self。于是就可以进行链式编程。

```
init(_ view: UIView)
init(_ view: UIView, _ first: UIView)
init(_ view: UIView, _ first: UIView, _ second: UIView?)

func superview(view: UIView) -> AutoLayout
func first(view: UIView) -> AutoLayout
func second(view: UIView?) -> AutoLayout
func views(superview: UIView, _ first: UIView, _ second: UIView?) -> AutoLayout
func views(first: UIView, _ second: UIView?) -> AutoLayout
```

##### 边关系与输入关系：函数方法

必须要承认，有时候，封装并不是把复杂的东西弄简单，有可能是把简单的东西弄复杂，因为实际目的是为了让使用的过程变得简单。

所以我选择通过苦力解决问题……

通过程序目录，你可以看到有很多个 MARK：

* // MARK: - 全自定义方法
* // MARK: - 单边设置方法
* // MARK: - 三边对齐方法
* // MARK: - 四边对齐的方法

每次……这些方法，就如同他们的名字以及备注一样，就是帮你写那些复杂的代码。
比如 
```
// 设置 first 与 superview 的 top 边对齐。
func Top(constant: CGFloat = 0, _ multiplier: CGFloat = 1, _ related: NSLayoutRelation = .Equal, priority: Float = 1000) -> AutoLayout
// 设置中心与大小一致
func CenterAndSize(constant: CGFloat = 0, _ multiplier: CGFloat = 1, priority: Float = 1000) -> AutoLayout
```

##### 完全自定义

如果你想设置的条件比较复杂，那可以用这两个方法。
```
func add(FEdge: NSLayoutAttribute, SEdge: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000, related: NSLayoutRelation = .Equal) -> AutoLayout
func layout(FEdge: NSLayoutAttribute, SEdge: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: Float = 1000, related: NSLayoutRelation = .Equal) -> NSLayoutConstraint
```

##### 为了优雅

你可以看到，以上两个函数完整的调用应该是这样的。
```
/// 设置 view1 与 superview 的 Top 边对齐
AutoLayout(superview, view1).Top(0, 1, .Equal, priority: 1000)
/// 设置 view1 与 superview 的 CenterX, CenterY, Height, Width 对齐
AutoLayout(superview, view1).CenterAndSize(0, 1, priority: 1000)
```
已经非常省事了有木有！！！
但是还不够，因为实际上，差额我们设置得还比较多，倍数也还行，但是经常都是会差额 = 0，倍数 = 1，后面那个优先度就更不用说了，基本上都是 1000 来用的。
所以，我给函数都写了默认参数。实际上，如果只是表示相等，那么调用的时候就是这样。
```
/// 设置 view1 与 superview 的 Top 边对齐
AutoLayout(superview, view1).Top()
/// 设置 view1 与 superview 的 CenterX, CenterY, Height, Width 对齐
AutoLayout(superview, view1).CenterAndSize()
```

##### 获取 Layout

当然啦，如果只是简单的设置，那么还不过。有时候，我们需要获取某一个 Layout 的，以便于程序后期的动画等变化。
所以，// MARK: Constraints 部分就很有必要了。
简单的说，所有设置边的函数，都会把设置完的边按顺序添加到 `var _constrants: [NSLayoutConstraint]` 属性当中，你当然可以直接调用，也可以通过 `func constrants(block: ([NSLayoutConstraint]) -> Void) -> AutoLayout` 方法来获取，这样就不会打破链式结构。

>需要注意的是，除非你设计的是单边的约束，否则其他方法都会自动清空 _constrants ，所以你每次调用完后，只能够获取到最后一次添加的那几条约束了。
具体约束顺序在每个函数的备注里都有。

实际使用
```
AutoLayout(superview, view1)
    .Top()
    .Leading()
    .Trailing()
    .Bottom()
    .constrants { (layouts) in
        // layouts[0] = top
        // layouts[1] = leading
        // layouts[2] = trailing
        // layouts[3] = bottom
    }
AutoLayout(superview, view1)
    .HorizontalVertical()
    .constrants { (layouts) in
        // layouts[0] = leading
        // layouts[1] = trailing
        // layouts[2] = top
        // layouts[3] = bottom
    }
```

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

## Type

* 新建的数据类型