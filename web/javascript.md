http://dmitrysoshnikov.com/ecmascript/chapter-2-variable-object/#phases-of-processing-the-context-code

执行上下文代码分为两个基本的步骤：
- 1.进入执行上下文环境(execution context)
- 2.执行代码

第一阶段：进入执行上下文环境
----

在进入执行上下文环境时（执行代码之前），填充VO的属性：

- 为每个形参在VO上创建一个属性，并用传入的值赋值
- 为每个函数声明在VO上创建一个属性，并用对应函数赋值
- 为每个变量声明在VO上创建一个属性，初始值为undefined

第二阶段：执行代码
----

执行代码可能会修改上面创建的VO属性的值

http://dmitrysoshnikov.com/ecmascript/chapter-4-scope-chain/#function-life-cycle

- 闭包=函数体+[[scope]]
- [[scope]] 是在函数的internal的属性。在函数被创建的时候创建。包含所在上下文的‘作用域’（Scope）
- 某个函数执行时的 Scope = AO + [[scope]]


测验题目 http://dmitrysoshnikov.com/ecmascript/the-quiz/

第九题解释：

```javascript
({
  x: 10,
  foo: function () {
    function bar() {
      console.log(x);
      console.log(y);
      console.log(this.x);
    }
    with (this) {
      var x = 20;
      var y = 30;
      bar.call(this);
    }
  }
}).foo();
```

当进入foo的执行上下文时：
```
scope chain(foo) = [
	global,
	{bar:<function>,x:undefined,y:undefined}
]
```
但执行了with语句后
```
scope chain(foo) = [
	global,
	{bar:<function>,x:undefined,y:undefined},//AO(foo)
	{x:10,foo:<function>}//匿名对象
]
```
在with语句中，执行了`var x=20`和`var y = 30`之后
```
scope chain(foo) = [
	global,
	{bar:<function>,x:undefined,y:30},//AO(foo)
	{x:20,foo:<function>}//匿名对象
]
```
当执行bar.call(this)，进入bar的执行上下文时：
```
scope chain(bar) = [
	global,
	{bar:<function>,x:undefined,y:30},//AO(foo)
	{}//AO(bar)
]
```
注意，这里不包含with语句加入的匿名对象。因为除了AO(bar)，
上面的AO(foo)和global才是AO.[[scope]]，是在bar创建的时候就确定了。
所以在bar中：
`console.log(x)`中的x在AO(foo)中找到，值为undefined
`console.log(y)`中的y在AO(foo)中找到，值为30
`console.log(this.x)`中的this是匿名对象，所以this.x为20
