jQuery如何检测DOM ready?
========================

1.`DOMContentLoaded`事件的浏览器注册一个处理函数`DOMContentLoaded`；E注册`onreadystatechange`事件的处理函数
2.两面两种情况都会用onload事件做一个fallback处理
3.在IE中还需要定时检测`document.documentElement.doScroll('left')`是否调用成功。一旦成功，就说明dom ready了。
[参考](http://www.cnblogs.com/yupeng/archive/2012/03/16/2397263.html)


常见里浏览器内核和对应的调试工具
================

- Gecko - Firefox - Firebug
- Webkit - Chrome/Safari - Chrome Develop Tool
- Trident - IE - IE Dev Tool
- Presto - Opera - Dragonfly
- Blink - Chrome/Opera - Chrome Develop Tool

![浏览器内核时间表](http://upload.wikimedia.org/wikipedia/en/timeline/289e79fa1f4b53cf0adc8128d646766b.png)

IE和W3C的DOM兼容性
==================

- `window.event` ,`function eventHandler(event){}`
- `event.srcElement`, `function eventHandler(event){event.target}`
- `element.attachEvent/detachEvent`, `element.addEventListener/removeEventListener`


DOM怎样添加、移除、移动、复制、创建和查找节点
=============================================
[](http://www.w3.org/TR/REC-DOM-Level-1/idl-definitions.html)
```javascript
parentNode.appendChild(node);
parentNode.insertBefore(newNode,refNode);
parentNode.replaceChild(newNode,oldNode);
node.parentNode.removeChild(node);
node.cloneNode();
document.createElement("<div>");
document.createDocumentFragment();

node.getElementById('id');
node.getElementsByTagName('div');
node.getElementsByClassName('name');
node.querySelector('selector');
node.querySelectorAll('selector');

```

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

异步加载JavaScript脚本的方案
============================

1. defer
2. async
3. dynamic create script tag

```javascript
function loadScript(src,callback) {
	var script = document.createElement("script"),
		loaded = false;

	script.type = "text/javascript";
	script.src = src;
	script.onload = function(){
		//重点记忆这里
		if(!loaded && (!this.readyState || this.readyState == "complete")){
			loaded = true;
			callback();
		}
	};
	document.getElementsByTagName("head")[0].appendChild(script);
}
```

[Dynamically inject javascript file - why do most examples append to head?](http://stackoverflow.com/questions/12113412/dynamically-inject-javascript-file-why-do-most-examples-append-to-head/12113657#12113657)

如何解决Ajax跨域的问题
======================

鼠标事件对象的坐标属性
=====================
[参考](https://github.com/aztack/Reading-Notes/blob/master/web/event.md)
[Interface MouseEvent (introduced in DOM Level 2)](http://www.w3.org/TR/DOM-Level-2-Events/events.html#Events-MouseEvent)
```
// Introduced in DOM Level 2:
interface MouseEvent : UIEvent {
  readonly attribute long             screenX;
  readonly attribute long             screenY;
  readonly attribute long             clientX;
  readonly attribute long             clientY;
  readonly attribute boolean          ctrlKey;
  readonly attribute boolean          shiftKey;
  readonly attribute boolean          altKey;
  readonly attribute boolean          metaKey;
  readonly attribute unsigned short   button;
  readonly attribute EventTarget      relatedTarget;
  void               initMouseEvent(in DOMString typeArg, 
                                    in boolean canBubbleArg, 
                                    in boolean cancelableArg, 
                                    in views::AbstractView viewArg, 
                                    in long detailArg, 
                                    in long screenXArg, 
                                    in long screenYArg, 
                                    in long clientXArg, 
                                    in long clientYArg, 
                                    in boolean ctrlKeyArg, 
                                    in boolean altKeyArg, 
                                    in boolean shiftKeyArg, 
                                    in boolean metaKeyArg, 
                                    in unsigned short buttonArg, 
                                    in EventTarget relatedTargetArg);
};
```

W3C的鼠标事件对象中与坐标相关的属性有：

- `clientX/Y`：相对viewport的坐标
- `screenX/Y`：相对屏幕的坐标

所以，要获得鼠标相对于被点击元素的坐标。需要用`event.clientX/Y - element.offset.left`
这个offset怎么求呢？`offset = event.target.getBoundingClientRect()`
