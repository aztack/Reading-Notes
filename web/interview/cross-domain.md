JavaScript跨域总结与解决办法
============================
[原文](http://www.cnblogs.com/rainman/archive/2011/02/20/1959325.html)

【iframe法、属性传值法】通过没有跨域限制的属性值进行单向数据传递
- 利用iframe和location.hash
- window.name实现的跨域数据传输
- document.domain + iframe的设置【同主域不同子域】

【`<script>`标签法】
- 动态创建script
- JSONP

【相对`正统`的解决方案】
- 使用HTML5 postMessage
- 利用flash(crossdomain.xml)
- 设置`Access-Control-Allow-Origin`

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
----------

> 利用flash的URLLoader，也可以轻松实现跨域数据交互。只要站点B的跨域策略文件(crossdomain.xml)中包含了站点A，A站就可以获取B站的数据，提交数据给B站。我们可以把JS和flash的交互封装一下，更方便的使用 -- [也谈跨域数据交互解决方案](http://www.imququ.com/post/cross-origin-resource-sharing.html)


下面的方法就有些复杂了

[利用iframe和location.hash](http://www.cnblogs.com/rainman/archive/2011/02/20/1959325.html#m3)
---------------------------
通过在iframe的src中增加#hash可以做到像目标域单向传递hash中的数据。如果要得到返回结果就需要再次用到#hash。
在最初创建iframe的地方也只能通过定时器的方式查看hash是否发生变化。这种方法相应速度比较慢。

A域下From.html中创建iframe指向B域下Target.html#hash，Target中无法直接修改parent.location.hash(FF可以）。这么在
Target中再次创建iframe指向A域下的Proxy.html。Proxy和From同域，可以修改hash值。From中定时查看自己的hash值。

[window.name实现的跨域数据传输](http://www.cnblogs.com/rainman/archive/2011/02/21/1960044.html)
-------------------------------

这种方法本质上和上面的修改hash方法一样，只不过window.name不会有ui上的表现

[document.domain+iframe的设置](http://www.cnblogs.com/rainman/archive/2011/02/20/1959325.html#m1)
------------------------------

```javascript
  //http://chat.a.com/data.html
  document.domain = "a.com";
```

```javascript
  //http://a.com/index.html
  document.domain = 'a.com';
  var ifr = document.createElement('iframe');
  ifr.src = 'http://chat.a.com/data.html';
  ifr.style.display = 'none';
  document.body.appendChild(ifr);
  ifr.onload = function(){
      var targetDoc = ifr.contentDocument || ifr.contentWindow.document;
      //using targetDoc...
  }
```


上面都是前端的跨域解决方案，如果可以修改目标站点的后端代码或服务器配置，可以使用下面正统的做法：

终极解决方案：Cross-Origin Resource Sharing
----------

> 实际上，除了IE6、IE7，大部分现代浏览器已经支持了跨域资源共享（Cross-Origin Resource Sharing）标准，这可谓是跨域Ajax的终极解决方案。有了这个标准，只需要在Response Header里加上这么一条，就可以轻松跨域了：

> Access-Control-Allow-Origin: http://hello-world.example
这个header定义允许哪些域跟自己交互，如果定义为*就表示允许任何域，这么做当然是不推荐的。在除IE之外的标准浏览器，这样就可以跨域Ajax了。对于IE，需要换用新增的XDomainRequest对象来发送请求，其它都类似。另外还有几个header可以用来设置允许的提交方式等信息，如果要支持认证或者提交xml等格式的数据给服务器，则需要预请求，[这里](https://developer.mozilla.org/En/HTTP_access_control)有更多说明

原文来自[imququ](http://www.imququ.com/post/cross-origin-resource-sharing.html)

