
====
<!--Catalog-->
<!--Myron Catalog Start-->

* [ iOS Human Interface Guidelines](#Myron_Catalog_0)
    * [ Overview](#Myron_Catalog_1)
        * [Design Principles](#Myron_Catalog_2)
                * [Aesthetic Integrity](#Myron_Catalog_3)
                * [Consistency](#Myron_Catalog_4)
                * [Direct Manipulation](#Myron_Catalog_5)
                * [Feedback](#Myron_Catalog_6)
                * [Metaphors](#Myron_Catalog_7)
                * [User Control](#Myron_Catalog_8)
        * [What's New in iOS 10](#Myron_Catalog_9)
                * [Widgets on the Search screen and Home screen. ](#Myron_Catalog_10)
                * [Integration with Messages. ](#Myron_Catalog_11)
                * [Integration with Siri. ](#Myron_Catalog_12)
                * [Expanded Notifications. ](#Myron_Catalog_13)
        * [Interface Essentials](#Myron_Catalog_14)

<!--Myron Catalog End-->




















====
<h5 id="Myron_Catalog_0"> </h5>
# iOS Human Interface Guidelines

The world’s most advanced mobile OS offers everything you need to design beautiful, engaging apps that radiate power and simplicity.

> 翻译

iOS 人性化界面指引手册

世界上最先进的移动系统会提供一切你需要的东西，让你设计漂亮，有趣，而且性能强大操作简单的应用。


```
human: 人的，人类，人族
human interface: 人性化界面
guidelines: 指导方针，指南
mobile: 手机，移动的，移动电话
offer: 提供，供应; offers(第三人称单数)
engage: 从事，吸引住，兴趣，有趣的; engaging(现在分词)
radiate: 放射，流露，发光
simplicity: 简单（性），容易（性），朴素，简朴
```
---
<h5 id="Myron_Catalog_1"> </h5>
## Overview

> 翻译

预览
<h5 id="Myron_Catalog_2"> </h5>
###Design Principles

![](https://developer.apple.com/ios/human-interface-guidelines/images/ios_overview.png)

As an app designer, you have the opportunity to deliver a killer product that rises to the top of the App Store charts. To do so, you'll need to meet high expectations for quality and functionality.


> 翻译

设计准则

对于一个应用设计者来说，你有机会发表一个杀手级的项目，直接升到 App Store 排行榜的榜首。想要这样，你需要满足更高期待的品质和实用性。

```
principle: 原则，准则
opportunity: 机会，时机
deliver: 交付，发表，兑现
killer: 杀手
rise: 上升，提高; rises(第三人称单数)
chart: 图表，排行榜，航海图
to do so: 这样做
meet: 满足，见面，会见
expectation: 期望，估计，预期
quality: 质量，性质，品质
functionality: 实用，功能性的，设计目的，设计功能
```

Three primary themes differentiate iOS from other platforms:

> 翻译

iOS 跟其他平台有三个主要的差别：

```
primary: 主要的，基本的，初级的
theme: 主题，题材，话题
differentiate: 区别，差异，分化，差异化
platform: 平台，月台，讲台
```

* Clarity. Throughout the system, text is legible at every size, icons are precise and lucid, adornments are subtle and appropriate, and a sharpened focus on functionality motivates the design. Negative space, color, fonts, graphics, and interface elements subtly highlight important content and convey interactivity.

> 翻译

清晰。这是贯穿于整个系统的设计理念，文本在任何尺寸下都非常清晰，图标是准确而且易懂的，装饰不易察觉而且非常合适，并且引导着用户的注意力集中在功能上。拒绝空洞，色彩，字体，图像，以及界面元素都巧妙的高亮着重要的内容以及表达出其交互性。

```
clarity: 清晰，明确，清澈
throughout: 普及，遍及，自始至终
legible: 清晰可见，易读的
precise: 准确的，确切的
lucid: 表达清楚的，易懂的，清晰的
adornment: 装饰，花瓶，修饰
subtle: 不易察觉的，不明显的，精巧的，细微的
appropriate: 挪用，非法占有；恰当的，合适的
sharpen: 尖锐的，加剧，磨尖
focus: 焦点，专注
motivate: 激发，推动，促使
negative: 否定，拒绝，底片，负片
graphics: 图像，绘图，图形，显卡
element: 要素
subtly: 巧妙地，精巧地
convey: 表达，运动，传达
interactivity: 交互性，互动性
```

* Deference. Fluid motion and a crisp, beautiful interface help people understand and interact with content while never competing with it. Content typically fills the entire screen, while translucency and blurring often hint at more. Minimal use of bezels, gradients, and drop shadows keep the interface light and airy, while ensuring that content is paramount.

> 翻译

顺从。流畅的手势以及透彻，漂亮的界面有助于用户理解并且跟内容进行交互而不是与其竞争。内容通常会充满整个屏幕，而半透明跟阴影常常用来暗示更多。劲量少使用边框，倾斜，以及阴影，保持界面光亮通透，让内容保持最高地位。

```
deference: 尊重，顺从
fluid: 流动，流畅的
motion: 运动，动作，手势
crisp: 脆的，易脆的
compete: 竞争，较量; competing(现在分词)
typically: 往往，经典的，通常
fill: 填满
entire: 全部，完整的
translucency: 半透明度
blur: 模糊化; blurring(现在分词)
often: 常常
hint: 暗示，启示，线索
minimal: 极小的，最简单派艺术作品
bezel: 边框
gradient: 倾斜度，渐变
drop: 下落，下降，减少，落下
airy: 通风的，无忧无虑的
while: 尽管，在 … 期间
paramount: 首长，最高，至为重要
```

* Depth. Distinct visual layers and realistic motion convey hierarchy, impart vitality, and facilitate understanding. Touch and discoverability heighten delight and enable access to functionality and additional content without losing context. Transitions provide a sense of depth as you navigate through content.


> 翻译

纵深。清晰的视觉图层以及智能的手势传递层级，给予生命力并促使它更易懂。触碰可增添发送的喜悦，启动访问功能来增加内容而不是失去内容。在提供的屏幕纵深中过度让你在各个内容之间进行浏览。

```
depth: 纵深，深刻，深渊，厚度
distinct: 清晰的，独特的
visual: 可视化，看得见的
realistic: 现实的，现实主义，明智的
motion: 运动，手势
convey: 表达，传输，输送
impart: 传授，给予
vitality: 活力，生命力，热情
facilitate: 促进，促使，使容易
discover: 找到，查明; discoverability: 可发现性
heighten: 提高
delight: 高兴，快乐，使高兴
without: 没有，无，不用
transition: 过渡，转换
navigate: 导航，航行，浏览
```


To maximize impact and reach, keep the following principles in mind as you imagine your app’s identity.


> 翻译

要达到最大化的影响力，在你想象的应用特征中保持准守下面的原则。

```
maximize: 最大化
impact: 冲击，撞击，影响力
reach: 达到，达成
follow: 跟随; following(现在分词)
principle: 原理，法则
mind: 注意，当心，听从，心灵
imagine: 想，想象
identity: 身份，特征
```


<h5 id="Myron_Catalog_3"> </h5>
#####Aesthetic Integrity
Aesthetic integrity represents how well an app’s appearance and behavior integrate with its function. For example, an app that helps people perform a serious task can keep them focused by using subtle, unobtrusive graphics, standard controls, and predictable behaviors. On the other hand, an immersive app, such as a game, can deliver a captivating appearance that promises fun and excitement, while encouraging discovery.


> 翻译

整体美感

整体美感考虑的是如何很好的将应用的显示以及行为跟他的功能结合起来。例如，一个帮助用户执行严肃任务的应用，需要保持用户的注意力，不张扬的图形，标准的按钮，以及可预见的行为。在另一方面来看，一个沉浸式的应用，比如游戏，则可以发布一些有吸引力的显示方式让其有趣而且激动人心，并鼓励用户去进行挖掘。

```
aesthetic: 美学，审美
integrity: 完整，完好
represent: 代表，描述
how well: 有多好
integrate: 完全的，成为一体，加入
serious: 不好的，严重的，严肃的
task: 工作，任务
subtle: 不易察觉，精细的，微妙的
unobtrusive: 不张扬的，不招摇的
standard: 规范，普通，标准的
predictable: 可预见的，可预料的
hand: 手，指针
On the other hand: 另一方面来说
immersive: 沉浸式
deliver: 交付，发表
captivate: 迷人的，有吸引力的; captivating(现在分词)
promise: 承诺
excitement: 兴奋，激动
encourage: 鼓励，促使，支持; encouraging(现在分词)
discovery: 发现，fajue
```


<h5 id="Myron_Catalog_4"> </h5>
#####Consistency
A consistent app implements familiar standards and paradigms by using system-provided interface elements, well-known icons, standard text styles, and uniform terminology. The app incorporates features and behaviors in ways people expect.


> 翻译

一致性

一个一致性的应用实现会实现熟悉的标准，以及使用系统提供的界面元素范例，众所周知的图标，标准的文本风格，以及一致的术语。应用包含的特性以及行为都是用于期待的方式。

```
consistency: 一致性
familiar: 熟悉
paradigm: 范例
well known: 众所周知的
uniform: 一致的，制服
terminology: 术语
incorporate: 包含，合并，结合
expect: 期待，预计，期盼
```


<h5 id="Myron_Catalog_5"> </h5>
#####Direct Manipulation
The direct manipulation of onscreen content engages people and facilitates understanding. Users experience direct manipulation when they rotate the device or use gestures to affect onscreen content. Through direct manipulation, they can see the immediate, visible results of their actions.


> 翻译

直接操作

在屏幕上直接操作内容会吸引住用户并让他们更容易理解。当用户旋转设备或使用手势来影响屏幕内容是非常好的用户体验。通过直接操作，他们可以立即看到他们行为的视图化结果。

```
direct: 直接
onscreen: 在屏幕上
manipulation: 操作，操控
engage: 从事，吸引住
facilitate: 促使，使容易
affect: 影响
immediate: 立即的
```


<h5 id="Myron_Catalog_6"> </h5>
#####Feedback
Feedback acknowledges actions and shows results to keep people informed. The built-in iOS apps provide perceptible feedback in response to every user action. Interactive elements are highlighted briefly when tapped, progress indicators communicate the status of long-running operations, and animation and sound help clarify the results of actions.


> 翻译

反馈

反馈行为确认并显示结果，可以保持用户的认知。內建的 iOS 应用都在响应所有用户的行为时提供了很明显的反馈。交互元素会在点击的时候短暂的高亮，进度指示显示长时运行的操作状态，还有动画以及声音来辅助表明行为结果。

```
acknowledge: 承认，认识，确认
inform: 通知，告知，有学问的，有见识的; informed(过去分词和过去式)
built in: 嵌入式，內建
perceptible: 可察觉到的，看得出的
briefly: 简要地，简短的
progress: 进度，进展
indicator: 指示物，指标，指示灯
communicate: 沟通，传达
clarify: 阐明，澄清，净化
```


<h5 id="Myron_Catalog_7"> </h5>
#####Metaphors
People learn more quickly when an app’s virtual objects and actions are metaphors for familiar experiences—whether rooted in the real or digital world. Metaphors work well in iOS because people physically interact with the screen. They move views out of the way to expose content beneath. They drag and swipe content. They toggle switches, move sliders, and scroll through picker values. They even flick through pages of books and magazines.


> 翻译

比喻

当应用的对象跟行为几乎都是来自于熟悉体验的隐喻时，不论根源是来自于现实或数字世界，他们都能很容易的理解更多的内容。隐喻行为可以 iOS 上很好的运行的基础是人们身体与界面之间的交互。他们移动视图到公开的内容之下。拖动后者滑动内容。切换开关，移动滑块，以及滚动选择器的值。甚至会在书页和杂志的页面之间浏览。

```
virtual: 几乎，事实上，实际上
metaphor: 隐喻，比喻
familiar: 熟悉，常见的
experience: 经验，经历，体验
whether: 是否，可能的选择
root: 根源
real: 现实
digital: 数字的，数字化
physically: 身体上，肉体上
expose: 暴露，公开
beneath: 在 ... 下面
toggle: 开关，切换
switche: 转换，交换机
slider: 滑块，滑动条
picker: 选择器
flick: 电影，浏览，轻弹
magazine: 杂志
```


<h5 id="Myron_Catalog_8"> </h5>
#####User Control
Throughout iOS, people—not apps—are in control. An app can suggest a course of action or warn about dangerous consequences, but it’s usually a mistake for the app to take over the decision-making. The best apps find the correct balance between enabling users and avoiding unwanted outcomes. An app can make people feel like they’re in control by keeping interactive elements familiar and predictable, confirming destructive actions, and making it easy to cancel operations, even when they’re already underway.


> 翻译

用户控制

在 iOS 中，是用户在进行控制，而不是应用。应用可以构建一个确定的行为，或对危险行后果的警告，但是它通常是用来接管错误决策的一种错误行为。最好的应用会在允许用户操作跟防止不必要的错误之间做好平衡。应用应该要能让用户感觉他们正持续的与熟悉并可预见的元素进行交互和控制，可以确认破坏性的行为，并且很容易的对它进行取消，哪怕它已经在进行中了。

```
suggest: 建设
course: 当然
warn: 警告
dangerous: 有危险的，不安全的
consequence: 后果，推论，结局
usually: 通常
mistake: 失误，错误
decision: 决定，决策，果断
make: 生产，制作; making(现在分词)
decision making: 决策，做出决策的过程
correct: 纠正，改正
balance: 平衡
avoid: 避免，防止，回避; avoiding(现在分词)
unwanted: 不需要，多余的
outcome: 结果，结局，成果
predictable: 可预见的
confirm: 确认
destructive: 破坏性的
underway: 进行中
```

---
<h5 id="Myron_Catalog_9"> </h5>
###What's New in iOS 10
With iOS 10, you can build more powerful apps than ever. As you explore these changes to see how they can benefit your app, pay special attention to the design guidance.


> 翻译

在 iOS 10 中，你可以比以前构建更多更强大的应用。如果你想要探索这些改变如何对你的应用更加有益，你需要特别注意一下设计指导。

```
explore: 探索
benefit: 优势，益处
special: 特别节目，专门的，特别的
guidance: 指引，指导
```

![](https://developer.apple.com/ios/human-interface-guidelines/images/whatsnew_widgets.png)
<h5 id="Myron_Catalog_10"> </h5>
#####Widgets on the Search screen and Home screen. 
A widget provides timely, useful information or app-specific functionality without the need to open an app. In the past, people added widgets to Notification Center for quick access. Now, people add widgets to the Search screen, which is accessed by swiping to the right on the Home screen and the Lock screen. You can also show a widget above the quick action list that appears when people use 3D Touch to press your app icon on the Home screen. The design and behavior of widgets has also changed. Be sure to review and update your existing designs accordingly. See [Widgets](https://developer.apple.com/ios/human-interface-guidelines/extensions/widgets/).


> 翻译

搜索界面跟主界面的小工具

小工具可以及时的提供有用的信息或应用特定的功能，而不需要打开应用。在过去，人们增加小工具到 Notification Center(通知中心)来快速的访问。现在，人们增加小工具到搜索界面，只需要在主界面跟锁屏界面右滑就可以访问。你还可以显示一个小工具在快速行为列表中，他们会在用户使用 3D Touch 来按下你的应用图标的时候，在主界面上显示出来。定义跟表现小工具的方式也改变了。请按此查看并更新你现在的设计。[Widgets](https://developer.apple.com/ios/human-interface-guidelines/extensions/widgets/)

```
widget: 小工具，小装置
search: 搜索
provide: 提供，供应
timely: 及时的，适时的
past: 过去，昔日，经过
above: 在 ... 上面，上文，前述
behavior: 行为，态度，行动，表现
press: 按，压力，按下
accordingly: 因此，所以，于是
```



![](https://developer.apple.com/ios/human-interface-guidelines/images/whatsnew_messaging.png)<h5 id="Myron_Catalog_11"> </h5>
#####Integration with Messages. 
Apps can integrate with Messages by implementing a messaging extension that appears below a conversation in Messages and lets people share app-specific content with friends. Apps can share text, photos, videos, stickers, and even interactive content, such as an in-message game. See [Messaging](https://developer.apple.com/ios/human-interface-guidelines/extensions/messaging/).



> 翻译

信息一体化

应用可以跟信息一体化，以实现信息扩张，让自己显示在信息会话下面，并可以让用户分析应用特定的内容给朋友。应用可以分享文字，图片，视频，贴纸，甚至交互内容，比如基于信息的游戏。[Messaging](https://developer.apple.com/ios/human-interface-guidelines/extensions/messaging/)

```
integration: 一体化
below: 在下面，在 ... 下面
conversation: 交谈，会话
sticker: 贴纸，黏贴标签，商标贴纸，不干胶
```



![](https://developer.apple.com/ios/human-interface-guidelines/images/whatsnew_siri.png)<h5 id="Myron_Catalog_12"> </h5>
#####Integration with Siri. 
Apps can integrate with Siri and let people use their voice to perform specific types of app-specific actions, such as making calls, sending messages, and starting workouts. See Siri.


> 翻译

与 Siri 一体化

应用可以跟 Siri 一体化，来让用户使用他们的声音来执行特定类型的应用特殊功能。比如拨打电话，发送消息，开始训练。[Siri](https://developer.apple.com/ios/human-interface-guidelines/features/siri/)

```
workout: 健身，练习
```

![](https://developer.apple.com/ios/human-interface-guidelines/images/whatsnew_notifications.png)
<h5 id="Myron_Catalog_13"> </h5>
#####Expanded Notifications. 
You can enhance notifications with an expanded detail view that opens when people use 3D Touch to press your notification or swipe your notification down on an unlocked device. Use this view to give people quick access to more information about a notification and the ability to take immediate action without leaving their current context. See Notifications.

> 翻译

扩展通知

你可以扩展细节视图来增强通知信息，以在用户使用 3D Touch 来点击你的通知，或在没有锁屏的应用上滑动你的通知时显示。使用这一视图来给用户快速访问更多有关该通知的信息，以及立即处理的能力，而不需要用户离开他们当前的内容。[Notifications](https://developer.apple.com/ios/human-interface-guidelines/features/notifications/)

```
expand: 扩大，扩展
enhance: 提高，增强
ability: 才能，能力
immediate: 立即，即刻
```



---

<h5 id="Myron_Catalog_14"> </h5>
###Interface Essentials

Most iOS apps are built using components from UIKit, a programming framework that defines common interface elements. This framework lets apps achieve a consistent appearance across the system, while at the same time offering a high level of customization. UIKit elements are flexible and familiar. They’re adaptable, enabling you to design a single app that looks great on any iOS device, and they automatically update when the system introduces appearance changes. The interface elements provided by UIKit fit into three main categories:


> 翻译

界面元素

大多数 iOS 应用都是使用 UIKit 组件构建的，那是一个定义了常见界面元素的编程框架。这个框架让应用实现一个与系统保持一致性的内容，而且还可以同时提供更高级的定制内容。UIKit 元素非常具有适应力，而且让人熟悉。他们可变现也很强，允许你定义一个在 iOS 设备上看起来很棒的独特应用，而且还可以在系统引进显示变化的时候自动更新。UIKit 提供的界面元素主要符合以下三个分类：

```
essential: 要素，必需品，基本的
component: 成分，组件，部件
common: 常见的，通常的，普通的
achieve: 完成，实现，成功
consistent: 一致性，一贯性，前后一致
across: 横过，遍及，在 ... 对面
offer: 出价，提供，供应; offering(现在分词)
customization: 定制
flexible: 能适应新情况的，灵活的，有弹性的
adaptable: 有适应能力的，能适应的
introduce: 介绍，引进
fit: 符合，合身，合适的
category: 种类; categories(复数)
```



**Bars.** Tell people where they are in your app, provide navigation, and may contain buttons or other elements for initiating actions and communicating information.

**Views. **Contain the primary content people see in your app, such as text, graphics, animations, and interactive elements. Views can enable behaviors such as scrolling, insertion, deletion, and arrangement.

**Controls. **Initiate actions and convey information. Buttons, switches, text fields, and progress indicators are examples of controls.


> 翻译

栏：告诉用户他们在你的应用位置，提供导航，也许还会包含按钮或其他用于初始化行为跟通讯信息的元素。

视图：包含应用给用户看到的主要内容，比如文本，图像，动画以及交互元素。视图可以允许比如滚动，插入，删除以及整理的行为。

控制器：初始化行为以及表达信息。比如按钮，控制器，文本输入框以及进度指示器都是控制器的例子。

```
bar: 条，栏，酒吧
initiate: 开创，引发，开始，启动; initiating(现在分词)
communicate: 通讯，沟通; communicating(现在分词)
primary: 主要的
arrangement: 安排，布置，整理
convey: 表达，传达
field: 领域
progress: 进展，进步，进程
indicator: 指示器
example: 例子
```

In addition to defining the interface of iOS, UIKit defines functionality your app can adopt. Through this framework, for example, your app can respond to gestures on the touchscreen and enable features such as drawing, accessibility, and printing.

iOS tightly integrates with other programming frameworks and technologies too, such as Apple Pay, HealthKit, and ResearchKit, enabling you to design amazingly powerful apps.


> 翻译

除了定义 iOS 的界面以外，UIKit 还定义了你的应用可以使用的功能。而且遍布该框架的每个地方，比如，你的应用可以在触摸屏上响应手势，允许例如绘制，访问以及打印的特征。

iOS 也可以跟其他编程框架跟技术紧密的结合，比如 Apple Pay, HealthKit 以及 ResearchKit, 它们能让你来定义一个令人惊叹的强大的应用。

```
define: 明确，定义
adopt: 采用
touchscreen: 触摸屏
accessibility: 可访问性
print: 打印; printing(现在分词)
tightly: 紧紧地
amazingly: 令人惊讶的
```

---



