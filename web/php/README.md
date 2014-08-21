PHP中的变量作用域
=================
[Variable Scope in PHP](http://www.cs.ucf.edu/~mikel/Telescopes/scope.htm)

三种作用域: 
本地作用域: only **in this page** or **function** (is the default) 
全局: makes page variables available in functions. 
静态: local to function, doesn't change between invocations.

注意：本地作用域对函数来说就是函数作用域，函数外不可访问。对远程代码来说就是就是页面作用域。
因为在php中可以include一个远程的php！

```php
$a = 123;
function f() {
    static $a;
    $a = 234;
    function a(){
        global $a;
        echo 'a:';
        var_dump($a);
        
        function b(){
            echo 'b:';
            @var_dump($a);
        }
        b();
    }
    return a();
}

f();
echo 'file:';
var_dump($a);
```
输出

```
a:int(123)
b:NULL
file:int(123)

```

   global变量就是真正的global。导出都可以见（函数需要用global说明）。
   函数内声明全局变量：`global $g`，如果没有全局变量`$g`，则会创建一个`$g`。
   
    
   static变量严格地只在声明它的函数里可见：函数内部的函数试图用global声明访问外层函数的局部变量和static变量是行不通的。
   
   局部变量严格地只能在声明它的函数里可见。函数之间pass parameter by value,是拷贝一份。如果要pass by reference要加上&符号来取引用。



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
