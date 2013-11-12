JavaScript跨域总结与解决办法
============================
[原文](http://www.cnblogs.com/rainman/archive/2011/02/20/1959325.html)

解决方案
1、document.domain+iframe的设置
2、动态创建script
3、利用iframe和location.hash
4、window.name实现的跨域数据传输
5、使用HTML5 postMessage
6、利用flash

什么是跨域
----------
JavaScript出于安全方面的考虑，不允许跨域调用其他页面的对象。但在安全限制的同时也给注入iframe或是ajax应用上带来了不少麻烦。这里把涉及到跨域的一些问题简单地整理一下：

首先什么是跨域，简单地理解就是*因为JavaScript同源策略的限制，非同域名下无法互操作js对象。
同域指 `protocol://xxx.name.com:port` 中protocol,name.com,port三个部分都相同才叫同域。

特别注意两点：
第一，**如果是协议和端口造成的跨域问题“前台”是无能为力的**
第二：在跨域问题上，域仅仅是通过“URL的首部”来识别而不会去尝试判断相同的ip地址对应着两个域或两个域是否在同一个ip上。
“URL的首部”指window.location.protocol +window.location.host，也可以理解为“Domains, protocols and ports must match”。

首先讲好理解的：

动态创建script标签
------------------

动态创建标签的本质和在页面中使用script标签引用外域的脚本是一样的

JSONP
-----

JSONP 本质上和上面一样。只不过上面是在script.onload事件中做后续处理，JSONP是服务器用生成的数据作为参数，调用url中提供的回调函数

someWindow.postMessage
----------------------

> postMessage是HTML5引入的window之间通讯机制：

假设window A主动向window B post消息（B可以是A的iframe或frame或A open出来的）
同时B中的代码也是你可以修改的。

```javascript
//A 中代码, http://www.exmaple.com
B.postMessage("move!","http://chat.example.com");
A.addEventListener("message",function(e){
  console.log(e.data);
});
```

```javascript
//B 中代码，http://chat.example.com
B.addEventListener("message",function(e){
  console.log(e.data);
  e.source.postMessage("rager that!");
});
```

上面代码，A向B发送 'move!'，B收到消息后返回'rager that!'

使用SWF
=======

> 利用flash的URLLoader，也可以轻松实现跨域数据交互。只要站点B的跨域策略文件(crossdomain.xml)中包含了站点A，A站就可以获取B站的数据，提交数据给B站。我们可以把JS和flash的交互封装一下，更方便的使用 -- [也谈跨域数据交互解决方案](http://www.imququ.com/post/cross-origin-resource-sharing.html)


下面的方法就有些复杂了

[window.name实现的跨域数据传输](http://www.cnblogs.com/rainman/archive/2011/02/21/1960044.html)
[利用iframe和location.hash](http://www.cnblogs.com/rainman/archive/2011/02/20/1959325.html#m3)
[document.domain+iframe的设置](http://www.cnblogs.com/rainman/archive/2011/02/20/1959325.html#m1)
