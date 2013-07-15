Miller's Article about Phongap and HTML5 mobile development
---
- [Phonegap + HTML5 开发经验小结](http://varnow.org/?p=354)
- [Phongap开发问题汇总](http://varnow.org/?p=355)
- [如何减少浏览器的repaint和reflow?](http://varnow.org/?p=232)

Debugging in PhoneGap
---------------------
- [使用weinre调试Web应用及PhoneGap应用](http://www.donglongfei.com/2012/03/debug-phonegap-app-using-weinre/?utm_source=rss&utm_medium=rss&utm_campaign=debug-phonegap-app-using-weinre)
- [Debugging in PhoneGap](https://github.com/phonegap/phonegap/wiki/Debugging-in-PhoneGap)


禁止PhoneGap中UIWebView上下滚动
--
config.xml:
```xml
<preference name="DisallowOverscroll" value="true" />
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
