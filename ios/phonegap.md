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
===

思路在原声代码中增加响应键盘隐藏/显示的函数，在这个函数中调用UIWebView实例的`stringByEvaluatingJavaScriptFromString`函数，在其中调用JavaScript中的某个函数。

```objective-c
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
[[NSNotificationCenter defaultCentler]addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];

...

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
