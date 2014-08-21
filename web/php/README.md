PHP中的变量作用域
=================
[Variable Scope in PHP](http://www.cs.ucf.edu/~mikel/Telescopes/scope.htm)

三种作用域: 
本地作用域: only **in this page** or **function** (is the default) 
全局: makes page variables available in functions. 
静态: local to function, doesn't change between invocations.

注意：本地作用域对函数来说就是函数作用域，函数外不可访问。对远程代码来说就是就是页面作用域。
因为在php中可以include一个远程的php！

字符串常用操作
==============
`preg_match_all($pattern,$subject,$matches,$flag)`
第三个参数是返回值。是一个数组。数组元素是匹配到的内容。相当于一个二维表。
$flag 默认是 `PREG_PATTERN_ORDER`,这导致匹配到的内容在表中的位置有些诡异。
要和其他语言一致，建议使用`PREG_SET_ORDER`

见[preg_match_all](http://php.net/manual/en/function.preg-match-all.php)



数组常用操作
============

HTTP相关
========
