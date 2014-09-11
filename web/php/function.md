不定参数
========

```php
function f() {
  $argc = func_num_args();
  $argv = func_get_args();
  $arg0 = func_get_arg(0);
}
```

fn.call & fn.apply
==================
类似javascript中的Function.prototype.call和apply:

```php
call_user_func('f',1,2,3);
call_user_func_array('f',array(1,2,3));
```

调用类实例的方法：
```php
class Klass {  
    function method($c)  
    {  
        echo $c;  
    }  
}  
call_user_func(array("Klass", "method"),123); 
```
