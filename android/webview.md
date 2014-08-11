`text-overflow:ellipsis`不起作用
================================

```html
<a style="width:2em;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;">
  <div>...</div>
  文字文字文字
</a>
```
某些版本的安卓Webkit无法正常为上面的结构加省略号。因为里面有一个div。去掉div或者改为下面的接口就可以了

```html
<a>
  <div>...</div>
  <span style="width:2em;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;">文字文字文字</span>
</a>
```


一个奇怪的问题，原因未知
========================
为<a>增加背景图，display设置为inline-block，伪装成一个按钮。
会出现偶尔能点击，大多数时候点击不上的问题。LogCat报错：
`IMGSRV(2600): :0: GetPTLAFormat: Invalid format`

解决办法就是将背景图以<img>的形式放到<a>里。
猜测是某些安卓webkit对背景图支持有问题。

使用Chrome远程调试WebView中的页面
=================================
https://developer.chrome.com/devtools/docs/remote-debugging

`chrome://inspect/#devices`

```java
if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
    WebView.setWebContentsDebuggingEnabled(true);
}
```

使用[Weinre](http://people.apache.org/~pmuellr/weinre-docs/latest/)远程调试Android WebView
=================================
```sh
> npm instal weinre
> weinre --httpPort 8080 --boundHost 192.168.1.xxx
```

```html
<script sample type="text/javascript" src="http://192.168.1.xxx:8080/target/target-script-min.js"></script>

```

浏览器打开 `http://192.168.xxx:8080/`开始调试
