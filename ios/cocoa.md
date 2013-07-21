AppDelegate
===========
`AppDelegate`是Xcode自动创建的一个类。你可以改成任意名字。然后在 main.m中创建`UIApplicationMain`实例的代码中指定要创建的delegate。

`AppDelegate`其实就一个实现了若干接口的类。暂时抛开接口不谈，那其实就是一堆方法而已。


ViewController
==============
`ViewController`是某个View的Controller（废话..）。View对应一个xib文件，在identity inspector面板为这个view指定对应的Controller，即`Custom Controller`。这样 `view-xib-view_controller`就对应起来了。这个对应关系保存在xib文件中。

Difference between AppDelegate.m and View Controller.m
===

> `ViewController.h/m` define a view controller class that manages a hierarchy of views(screen and controls in it)  basically, one screen of an application. You might have multiple screens that each have their own view controller. `ViewController` is responsible of controlling the connection between your model and your view

`Module` -> `ViewController` -> `View`(Screen,Controls or Views)

> `AppDelegate.h/m` define a class that manages the application overall. The app will create one instance of that class and send that object messages that let the delegate influence the app's behavior at well-defined times. 

> `ViewController` -> `Form.cs`, `AppDelegate` -> `Program.cs`

`AppDelegate` is responsible for the `life-cycle` of your application. What to do when the user press the home button and exit your app, what to do when the app enter background. Things like this.

Avoid calling AppDelegate method from ViewController.
Keep AppDelegate for the following:

- `initialization`: whatever needs to be done on the very first launch (after an install or an update)
- `data migration` from version to version (e.g. if you use CoreData and migrations)
- `configuration of objects linked via IBOutlets from MainWindow.xib`
- determining the `initial orientation` to launch in
- `saving uncommitted data/state` prior to the application being terminated or entering background mode
- `registering for the Apple Push Notification Service` and `sending the device token` to our server
- `opening one of the supported application URLs` (e.g. maps://)
- 

Cocoa中的事件处理与.NET中的事件处理设计上的不同之处
===
.NET/VCL/MFC中的设计是通过继承已有类，并重写响应的事件响应函数来处理事件的。
比如，你在子类中重写CustomApplication::onExit，来处理程序退出事件。
本质上讲，CustomApplication的实例，就是程序对应的唯一Application实例。

Cocoa中的设计，你编写一个实现了`UIApplicationDelegate`接口的AppDelegate类，在其中实现类似onExit这样的接口，来处理事件的。
UIApplication会在适当的时候，调用delegate的响应方法。你的AppDelegate还可以实现其他接口，从而同时响应其他事件。
本质上讲，AppDelegate只是一个实现了某些借口的任何类，并不是UIApplication的子类。而UIApplication的唯一实例也是事先由框架实现好的。


Load data from plist
====================

```objective-c
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                    NSUserDomainMask, YES); 
self.plistFile = [[paths objectAtIndex:0]
                    stringByAppendingPathComponent:@"example.plist"];

self.plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFile];
if (!plist) {
    self.plist = [NSMutableDictionary new];
    [plist writeToFile:plistFile atomically:YES];
}
````

Access `User-Defined-RunTime-Attribute` in code
====

在IB中，你可以为拖放到界面编辑器中控件设置自定义属性，类似Delphi和.NET中的Tag。
在代码中，可以这样获取自定义属性的值：

```objective-c
id value = [control valueForKey:key];
```

Fadein UIImageView
===

```objective-c
- (void)fadeInImage 
{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:1.0];
    imageView.alpha = 1.0;
    [UIView commitAnimations];

}
```
