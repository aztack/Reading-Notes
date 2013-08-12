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

Cocoa中的事件不像.NET那样通过继承实现。而是通过代理和protocol实现的。你实现某个*Delegate的部分接口，Cocoa会在适当的时候调用。大多数是optional的。.NET则是通过重写父类的onEvent方法实现的。如果你没有重写，则调用父类的方法。

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

`UITableView`的`dequeueReusableCellWithIdentifier:`是怎么工作的？
====
官方文档：

> For performance reasons, a table view's data source should generally reuse UITableViewCell objects when it assigns cells to rows in its tableView:cellForRowAtIndexPath: method. A table view maintains a queue or list of UITableViewCell objects that the data source has marked for reuse. Call this method from your data source object when asked to provide a new cell for the table view. This method dequeues an existing cell if one is available or creates a new one using the class or nib file you previously registered. If no cell is available for reuse and you did not register a class or nib file, this method returns nil.

> If you registered a class for the specified identifier and a new cell must be created, this method initializes the cell by calling its initWithStyle:reuseIdentifier: method. For nib-based cells, this method loads the cell object from the provided nib file. If an existing cell was available for reuse, this method calls the cell’s prepareForReuse method instead.

出于性能考虑，table view的数据源应该在 tableView:cellForRowAtIndexPath 中重用 UITableViewCell对象。每个table view 维护一个 UITableViewCell 实例的队列或者列表。当队列中有可用对象时，这个方法会将队头对象出队并返回，如果没有可用对象，则根据你事先注册的class或者nib文件创建一个并返回。如果你没有注册，则返回nil。

如果你为特定的identifier注册了一个class。当需要创建的cell的时候，这个方法会调用 initWithStyle:reuseIdentifier: 方法创建一个cell。对于基于nib的cell，这个方法加载你提供的nib文件以创建cell。如果有可复用的cell，那么这个方法则会调用cell的 prepareForReuse方法。

下面是SO上的一个帖子：[iPhone - dequeueReusableCellWithIdentifier usage](http://stackoverflow.com/questions/2928873)

> The purpose of dequeueReusableCellWithIdentifier is to use less memory. If the screen can fit 4 or 5 table cells, then with reuse you only need to have 4 or 5 table cells allocated in memory even if the table has 1000 entries.

我的理解：
UITableView实例维护一个cell复用队列。当第一次创建table view的时候，根据一屏显示的cell的数目，比如说5个，创建出5个cell。当向下滚动的时候，第六个cell露出一部分，此时屏幕上有6个cell，有的只显示了一部分。这是table view会再创建第六个。此时队列中有六个可服用的cell。继续向下滚动（此时一屏最多显示六个），调用dequeueReusableCellWithIdentifier会返回队列中的第一个cell。返回的这个cell有着你创建它时的text和高度。虽然你可以不改变这些属性直接返回cell。但通常都会的。这样一来，内存中只有6个cell。

下面的帖子印证了我的想法：
[UITableView dequeueReusableCellWithIdentifier Theory](http://stackoverflow.com/questions/3552343)

> When a cell disappears from the screen it will be put in the TableView reuse que. When a new cell is needed it looks in the que if a cell with the same identifier is available, it invokes prepareForReuse method on that cell and it removes itself from the que.

接下来我的问题是：identifier做什么用呢？

看下面一段代码：这段代码说明UITableView中的复用队列中的cell是被打上了identifier的标签。`dequeueReusableCellWithIdentifier`会在队列中查找第一个标记有identifier的cell并返回。

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIndentifier1 = @"SimpleTableIdentifier1";
    static NSString *SimpleTableIndentifier2 = @"SimpleTableIdentifier2";
    NSString *ident = indexPath.row % 2 == 0 ? SimpleTableIndentifier1 : SimpleTableIndentifier2;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if(cell == nil) {
        NSLog(@"%d",indexPath.row);
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: SimpleTableIndentifier1];
    }
    NSString *text = [NSString stringWithFormat:@"%@ %d",self.tableData[indexPath.row],indexPath.row];
    cell.textLabel.text = text;
    return cell;
}
```

下面是 《Beginning iOS6 Development》中的一段话：

> This string(这里只identifier) will be used as a key to represent the type of our table cell. Our table will use only a single
type of cell.

所以identifier可以理解为cell的类型。
