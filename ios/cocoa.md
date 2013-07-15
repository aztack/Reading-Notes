AppDelegate
===========
`AppDelegate`是Xcode自动创建的一个类。你可以改成任意名字。然后在 main.m中创建`UIApplicationMain`实例的代码中指定要创建的delegate。

`AppDelegate`其实就一个实现了若干接口的类。暂时抛开接口不谈，那其实就是一堆方法而已。


ViewController
==============
`ViewController`是某个View的Controller（废话..）。View对应一个xib文件，在identity inspector面板为这个view指定对应的Controller，即`Custom Controller`。这样 `view-xib-view_controller`就对应起来了。这个对应关系保存在xib文件中。


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
