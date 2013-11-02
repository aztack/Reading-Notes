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
