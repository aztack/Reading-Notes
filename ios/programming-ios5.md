[Key-Value Programming](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/KeyValueCoding/Articles/Overview.html#//apple_ref/doc/uid/20001838-SW1)
====
KVC是一种通过字符串间接访问对象属性的机制。
key-value observing, Core Data, Cocoa bindings,和scriptability都需要KVC。

比如说如下的一行KVC的代码：
```objective-c
[site setValue:@"sitename" forKey:@"name"];
```

就会被编译器处理成：

```objective-c
SEL sel = sel_get_uid ("setValue:forKey:"); //构造selector
IMP method = objc_msg_lookup (site->isa,sel);//根据从site所属的类中查找selector对应的方法实现
method(site, sel, @"sitename", @"name");//在site对象上，以sitename和name为参数调用上一步查到到的方法
```


[Key-Value Observing](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i)
-------------------

所谓的KVO就是在对象的属性被修改的时候，允许注册的对象的特定函数被调用的机制。（可以用来实现数据绑定）

```objective-c
[bankInstance addObserver:personInstance
  forKeyPath:@"accountBalance"
    option:NSKeyValueObservingOptionNew
      context:NULL];
      
addObserver:forKeyPath:option:context

//opersonInstance需要实现
observeValueForKeyPath:ofObject:change:context
```


