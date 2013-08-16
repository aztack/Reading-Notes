至关重要的一个Tip：Tip #1 - Test on old hardware。如果你的应用在老设备和低端安卓上的速度可以接受。那你可以继续。
如果不行，绝对不要用。

Miller's Article about Phongap and HTML5 mobile development
---
- [Phonegap + HTML5 开发经验小结](http://varnow.org/?p=354)
- [Phongap开发问题汇总](http://varnow.org/?p=355)
- [如何减少浏览器的repaint和reflow?](http://varnow.org/?p=232)

Debugging in PhoneGap
---------------------
- iOS6以上的设备支持在Mac Safari中调试设备上的网页和嵌由WebView的程序
- [使用weinre调试Web应用及PhoneGap应用](http://www.donglongfei.com/2012/03/debug-phonegap-app-using-weinre/?utm_source=rss&utm_medium=rss&utm_campaign=debug-phonegap-app-using-weinre)
- [Debugging in PhoneGap](https://github.com/phonegap/phonegap/wiki/Debugging-in-PhoneGap)


禁止PhoneGap中UIWebView上下滚动
--
config.xml:
```xml
<preference name="DisallowOverscroll" value="true" />
```

```objective-c
  self.viewController.webView.scrollView.bounces = NO;
  self.viewController.webView.scrollView.scrollEnabled = NO;
```

在html中`不要`设置meta width=device-height!

```objective-c
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
  ...
  [self.window setRootViewController:self.viewController];
  [self.window addSubview:self.viewController.view];//这样UIWebView中html的100%高度就不包括statusbar了
  [self.window makeKeyAndVisible];

  // aztack
  [[UIApplication sharedApplication] setStatusBarHidden:YES];
  CGRect appBounds = [[UIScreen mainScreen] applicationFrame];

  //调整webView的高度
  CGRect viewport = CGRectMake(0, appBounds.origin.y, screenBounds.size.width, appBounds.size.height);
  self.viewController.view.frame = viewport;
  self.viewController.webView.frame = CGRectMake(0, 0, appBounds.size.width, appBounds.size.height);
}

```

[10 tips for getting that native iOS feel with PhoneGap](http://www.mikedellanoce.com/2012/09/10-tips-for-getting-that-native-ios.html)
---
Check out [phonegap-tips.com](phonegap-tips.com).

- Tip #1 - Test on old hardware

Your app looks and feels great on that shiny new iPad 3 or iPhone 4S, right? Unfortunately, not everyone runs out to drop $500 whenever Apple releases a new toy. Get your hands on a first generation iPad or third generation iPhone. Always test on them first. If your app performs acceptably on on old hardware it is going to be blazing fast on the newer hardware.

- Tip #2 - Use pre-emptive 3D transforms

If an element is going to be transformed in response to user interaction put an identity 3D transform on the element before any user interaction happens, for example:
-webkit-transform: translate3d(0px,0px,0px);
When the user first interacts with the element the initial movement will be much smoother.

- Tip #3 - Show or hide elements with 3D transforms when possible

Invariably you will have some elements that need to be shown or hidden based on user interaction. For example, a modal dialog or menu of some sort. The easiest way to do this is usually display:none or visibility:hidden, however, you can achieve a significant speed increase by using a 3D transform to position the element offscreen. In my experience, using this technique to show or hide menus resulted in a 3-5X speed increase over display:none.

- Tip #4 - Preload images

Even though your images are already stored on the iOS device there will still be a noticeable "pop-in" when the images are first displayed. I found CSS3 caching to be the best method for dealing with this issue. If you are not keen on enumerating and maintaining a list of every background image you use in your app, here is a jQuery plugin that will preload any background image referenced in your CSS.

- Tip #5 - Phark image replacement does not play nice with 3D transforms

Image replacement by setting a large, negative text-indent is great for accessibility since screen readers will find the text and browsers will only display the image. However, the text-indent will make for unbearably choppy 3D transitions in mobile Safari (this is actually related to tip #7). Fortunately, there are alternatives to Phark that perform much better.

- Tip #6 - Velocity scrolling!

Velocity scrolling is a super easy way to get a native feel in the scrollable portions of your app. It is simple to enable it on any scrollable area with a CSS rule:
-webkit-overflow-scrolling: touch;
That's it! However, be warned, Apple's current implementation is a little bit buggy.

- Tip #7 - Respect maximum texture sizes

Each iOS device has a maximum texture size. If you try to smoothly transform an element larger than the maximum texture size, the element will be broken into smaller tiles before the transform is applied, and this a very slow and ugly process.

- Tip #8 - Hide large, off-screen images

If your app displays many large images, hide the images that are off-screen. Otherwise, it doesn't take many large images to unceremoniously crash your app. Both display:none and visibility:hidden work just fine, but tip #3 will not cut it here.

- Tip #9 - Eliminate tap event delays

It takes mobile Safari about a third of a second (300 milliseconds) to decide that a touch start event followed by a touch end event should be synthesized into a click event. Plenty of frameworks, such as jQuery Mobile, have "tap" handling code that can eliminate this delay for you.

- Tip #10 - Disable tap highlighting

Have you ever noticed that translucent gray highlight mobile Safari puts on links and buttons when they are clicked? It is a dead giveaway that your app is not native, but you can get rid of it by making the highlight color completely transparent:
-webkit-tap-highlight-color:rgba(0,0,0,0);
Overall we're loving PhoneGap at Outbox. Hopefully these tips will help make a few more happy PhoneGappers!
```

在JavaScript中响应软键盘隐藏/显示事件
======


思路在原声代码中增加响应键盘隐藏/显示的函数，在这个函数中调用UIWebView实例的`stringByEvaluatingJavaScriptFromString`函数，在其中调用JavaScript中的某个函数。


```objective-c
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
[[NSNotificationCenter defaultCentler]addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];


-(void)onKeyboardHide:(NSNotification *)notification
{
    [self.viewController.webView stringByEvaluatingJavaScriptFromString:@"window.onKeyboardHide && onKeyboardHide()"];
}
```

```javascript
window.onKeyboardHide = function(){
  //响应键盘即将隐藏
};
window.onKeyboardShow = function(){
  //响应键盘即将显示
};
```


PhoneGap splash screen image file name:

```
Default-568h@2x~iphone.png, 640x1136
Default-Landscape@2x~ipad.png, 2048x1496
Default-Landscape~ipad.png, 1024x748
Default-Portrait@2x~ipad.png, 1536x2008
Default-Portrait~ipad.png, 768x1004
Default@2x~iphone.png, 640x1136
Default~iphone.png, 640x960
```

Date.parse不支持横线分割的日期(遇到问题的iOS版本5.1.1)
===

需要将`2013-08-01`改为`2013/08/01`

参见[Invalid date in safari](http://stackoverflow.com/questions/4310953/invalid-date-in-safari)


[Creating apps with PhoneGap: Lessons learned](http://www.adobe.com/devnet/phonegap/articles/creating-apps-with-phonegap-lessons.html)
[Developing Better PhoneGap Apps](http://floatlearning.com/2011/03/developing-better-phonegap-apps/)


JC研究所项目总结
================

- 0.  一定要在初期就要在各种设备上测试样式效果！！
- 1. CSS中尽量使用相对尺寸：em, % 
- 2. font-size:0在有些安卓的webkit上是无效的！
- 3. 按钮设计要足够大！请UI设计同学查一下，移动设备上的按钮有一个最小尺寸。小于改尺寸的按钮是非常难点到的。
- 4. 不要使用需要image sprite。作为一个phonegap项目，图片资源都在本地。使用个毛sprite啊！各种设备对齐背景特么会死人的啊！sprite是为了减少请求数。本地资源不用考虑！
- 5. 输入框是phonegap的硬伤。输入框获取焦点后，webview会无条件上移（整个body都会上移）。输入框的显示和消失是没有js事件的！！需要原生开发
- 6. 不要使用大于半个屏幕的图片，会非常卡，且无解。唯一能缓解的办法是，在图片不显示的时候display:none或者visibility:hidden.蛋疼死了。
- 7. retina屏幕的一个像素相当于一般屏幕的1/4个像素。所以写css的时候如果用px时有个2倍的系数。background-size也得注意。
- 8. 现在最好的移动端webview中滚动列表的解决方案是iScroll。很多坑。需要各种setTimeout，请查看官方。
- 9. phonegap的deviceready有时候是不触发的。device的属性都是null。navigator.connection.type在有些安卓机器上是unkown，无法确定是wifi还是3g、2g。
- 10. Phonegap 在安卓下需要处理back键。因为只有一个activity，所以会出现按back就退出程序的问题。再碰上无法响应backbutton事件，就歇菜。这个问题花费了一天的时间。
- 11. 需要为安卓（或ios）单独创建一个android.css和android.js来处理差异
- 12. 部分尺寸问题可以用zoom来解决
- 13. 就算使用sprite作为背景。设计师将多个图标整齐等宽排列，行列数最好为偶数。builder写css得时候background-position的时候不需要用px为单位。直接用%就可以了。比如两个图标。第二个图标可以直接用50%就好了。这个值永远是正确的，不需要修改 
- 14. Phonegap改名叫Cordova。apache开源项目下。cordova 3.0开始，以前内置的js对象（比如device）都变成以插件形式支持了。默认是没有的！所以js里device.available总是false。又一天费掉了。做iphone版本的时候还是2.9。做android版本升级到3.0.。。。cordova是用命令行生成工程模板的。所以总是最新版。。
- 15. Cordova 3.0 开始。自带插件的package从org.apache.cordova变为org.apache.cordova.core。在cofnig.xml中做更改！官方也没有migration guide，坑爹啊。
- 16. phonegap 在android上是无法向iphone那样在safari里单步调试的。也就是说。如果出了问题，你又不知道哪里出了问题。就得打一堆的alert，console.log。
- 17. 建议以后如果用phonegap开发，一开始就要将要支持的版本（ios，android）的工程都生成出来。js和css文件要拆分细一点，在工程中再根据设备合并需要的文件。这就需要多设备要同时推进。否者就会出现。后做的设备上的js代码和之前的代码有很大差异。目前的状况就是安卓上的index.js已经和ios上的差不少了。这完全违背了用phonegap开发的本意。
- 18. phonegap在低端安卓设备上非常卡。至少在测试机和我的小米1上，点击列表页后要1秒才能打开详情页！！
- 19.对于需要原生支持，但又犯不着写一个插件的问题可以通过webview的 loadUrl("javascript:….")的方法，将原生方法获取的信息传给js环境。但从js环境触发原生代码就得写插件了。

