
# UIWindow

>新增一个窗口对象，只要该对象存在，就会自动显示到最顶层界面。

* 使用

```
var window: UIWindow? 
window = UIWindow()
window?.hidden = false
window?.frame = CGRect(x: 0, y: 0, width: 50, height: 300)
```

* 使用实例

HUD 中使用 window 来在当前视图中弹出一个新的视图。



