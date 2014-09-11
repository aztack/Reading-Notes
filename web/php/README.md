字符串常用操作
==============
- PHP中双引号里的变量会被插值。单引号不会。
- 引号可以跨行。


`preg_match_all($pattern,$subject,$matches,$flag)`
第三个参数是返回值。是一个数组。数组元素是匹配到的内容。相当于一个二维表。
$flag 默认是 `PREG_PATTERN_ORDER`,这导致匹配到的内容在表中的位置有些诡异。
要和其他语言一致，建议使用`PREG_SET_ORDER`

见[preg_match_all](http://php.net/manual/en/function.preg-match-all.php)



数组常用操作
============

HTTP相关
========
