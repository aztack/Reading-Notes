[Smarty中文文档](http://www.smarty.net/docs/zh_CN/what.is.smarty.tpl)
**业务逻辑**和**显示逻辑**分离，是Smarty的一个设计理念

显示用的逻辑代码，例如：
- 包含 其他模板
- 交替设置表格每行的颜色
- 把变量转为 大写字母
- 循环遍历数组并 显示出来

快速入门
========

注释
----
{* comments *}

注释不能嵌套


输出变量
--------

```php
<span>{$name}</span>
```

循环
----
smarty中有两中循环结构。
1. section

```html
<!DOCTYPE html>
<html>
<body>
	<ul>
	{section name=id loop=5}
		<li>{var_dump($smarty.section)}</li>
	{/section}
	</ul>
</body>
</html>
```

```
array (size=1)
  'id' => 
    array (size=14)
      'name' => string 'id' (length=2)
      'loop' => int 5
      'show' => boolean true
      'max' => int 5
      'step' => int 1
      'start' => int 0
      'total' => int 5
      'index' => int 0
      'iteration' => int 1
      'rownum' => int 1
      'index_prev' => int -1
      'index_next' => int 1
      'first' => boolean true
      'last' => boolean false
```

2. foreach

条件判断
--------

调用函数
--------


如何设置模板路径
----------------
