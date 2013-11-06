<!DOCTYPE>标签的定义与用法
==========================
类似题目：严格模式与混杂模式-如何触发这两种模式，如何判断是在混杂模式

HTML 5
HTML 4.01 - strict/transitional/frameset
XHTML 1.0 - strict/transitional/frameset
XHTML 1.1
```
类型           | 所有HTML元素和属性  | presentational和deprecated的元素  | frameset
strict        | √                   | ×                                 | ×
transitional  | √                   | √                                 | ×
frameset      | √                   | √                                 | √
```

```
<!DOCTYPE HTML>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
```

助记：
<!DOCTYPE html PUBLIC "?" "?">

触发IE6的quirks模式：在doctype前加xml生命
触发IE7的quirks模式：在xml声明和doctype之间再加上一行html注释

判断是在混杂模式
```javascript
if(document.compatMode == 'CSS1Compat'){
    alert("Standards mode");
}else{
    alert("Quirks mode");
}
```

```
    W3C   DTD HTML 4.01   EN
-//    //              //
```

```
http://www.w3.org/TR/______/______.dtd
html4			strict/loose/frameset

xhtml1/DTD/xhtml1-	strict/transitional/frameset
xhtml11/DTD/xhtml11
```

你真的了解HTML吗?
=================

如何理解HTML结构的语意化
==========================

HTML5的新加的内容
================

http://html5test.com/

```
Parsing Rules
  HTML5 tokenizer
  HTML5 tree buiding

Canvas
Video
Audio
Forms
User interaction
History and navigation
Microdata
Web application
Security
Location and Orientation
Communication
  Cross-document messaging
  Server-Sent Events
  WebSocket
Files
  File API
Storage
  Session Storage
  Local Storage
  IndexedDB
Workers
  Web Workers
  Shared Workers
Notification
  Web Notification
```

简单记几个

```

WebSocket
Video

New Form Elements

Canvas
Local Storage
Audio
Notification
Geolocation


```

助记: `WV N CLANG`
> 注意：两个N，一个是Notification。另一个不好记忆，是New Form Element。用N助记有些牵强。其实应该用F(orms)助记

说几条XHTML规范的内容
=====================
 
* 标签名必须用小写字母。
* 所有标签都必须被关闭，包括空标签。
* 属性值必须加引号。
* 用Id属性代替name属性。
* 所有XHTML文档必须进行文件类型声明。
* 

典型错误师范：`<P name=ID>XHTML`


CSS引入的方式有哪些? link和@import的区别是
==========================================
link是HTML的引入机制
@import是CSS的引入机制
前者的性能优于后者

参考：[don’t use @import | High Performance Web Sites](http://www.stevesouders.com/blog/2009/04/09/dont-use-import/)

写出一个上传文件的form表单和input
=================================
```html
<form action="upload.php" method="post" enctype="multipart/form-data">
  <input type="file"/>
</form>
```

如果form中有`input[type=file]`，那么enctype必须为`multipart/form-data`
默认为`application/x-www-form-urlencoded`

enctype = application/x-www-form-urlencoded
    |multipart/form-data"
    |application/json
    |application/json-patch+json

参考：[What does enctype='multipart/form-data' mean?](http://stackoverflow.com/questions/4526273/what-does-enctype-multipart-form-data-mean)


如何使用`label`标签
====================

