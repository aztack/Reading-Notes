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


eval、create_function和匿名函数
=====================
eval是在所在上线文中执行给定字符串中的代码。这段代码可以方位所在处可见的变量。并且eval的字符串可以return一个值作为eval的返回值。

create_function创建一个lambda对象。相当于一个可以传递的函数对象。


PHP5.3引入匿名函数

匿名函数会创建一个闭包。要想在匿名函数中访问外层的变量要用use来声明，并且use会拷贝一份使用到的对象。除非use引用：

```php
$var = array();
$f1 = function() use($var) {
    var_dump($var);
};
$f2 = function() use(&$var) {
    var_dump($var);
    $var []= 2;
};
$var []= 1;
$f1();
$f2();
var_dump($var)
```

输出

```php
array(0) {
}
array(1) {
  [0] =>
  int(1)
}
array(2) {
  [0] =>
  int(1)
  [1] =>
  int(2)
}

```

对于new出来的实例对象，一律使用use引用。
