常见里浏览器内核和对应的调试工具
================

Gecko - Firefox - Firebug
Webkit - Chrome/Safari - Chrome Develop Tool
Trident - IE - IE Dev Tool
Presto - Opera - Dragonfly
Blink - Chrome/Opera - Chrome Develop Tool

![浏览器内核时间表](http://upload.wikimedia.org/wikipedia/en/timeline/289e79fa1f4b53cf0adc8128d646766b.png)

IE和W3C的DOM兼容性
==================

- `window.event` ,`function eventHandler(event){}`
- `event.srcElement`, `function eventHandler(event){event.target}`
- `element.attachEvent/detachEvent`, `element.addEventListener/removeEventListener`


DOM怎样添加、移除、移动、复制、创建和查找节点
=============================================


结合<span id="outer"><span id="inner">text</span></span>这段结构，谈谈innerHTML outerHTML innerText之间的区别
====
```
innerHTML 设置或获取位于对象起始和结束标签内的 HTML
outerHTML 设置或获取对象及其内容的 HTML 形式
innerText 设置或获取位于对象起始和结束标签内的文本
outerText 设置(包括标签)或获取(不包括标签)对象的文本
**innerText 和outerText 在读取得时候是一样的，只是在设置的时候outerText 会连带标签一起替换成目标文本**
firefox不支持innerText ，但是可以用textContent作为替代方案。
```

inner不包括标签本身，outer包括标签本身；
HTML返回HTML文本，text取出标签后的文本
所以outerText，先取出包括标签本身的文本，在去掉所有标签。结果和innerText是一样的。但是设置的时候不一样
