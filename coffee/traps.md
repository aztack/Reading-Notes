避免在代码中出现不必要的匿名函数调用和_result
---------------------------------------------

```coffeescript
    f = (eles,fields) ->
        for ele in eles
            d = {}
            for field in fields
                [k,v] = field.split ':'
                d[k] = v
```
上面的代码会被编译成下面的JS

```javascript
    var f;
    
    f = function(eles, fields) {
      var d, ele, field, k, v, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = eles.length; _i < _len; _i++) {
        ele = eles[_i];
        d = {};
        _results.push((function() {
          var _j, _len1, _ref, _results1;
          _results1 = [];
          for (_j = 0, _len1 = fields.length; _j < _len1; _j++) {
            field = fields[_j];
            _ref = field.split(':'), k = _ref[0], v = _ref[1];
            _results1.push(d[k] = v);
          }
          return _results1;
        })());
      }
      return _results;
    };
```
由于在CoffeeScript中没有指定返回值，所以编译器构造了_result,_result1两个返回值作为for-in表达式的结果。
为了去掉它们,可以这么写：

```coffeescript
getValues = (eles, fields) ->
    result = []
    for ele in els
        json = {}
        for field in fields
            [k, f] = field.split ':'
            f = f ? k
            json[k] = if typeof ele[f] is 'function' then ele[f]() else ele.attr(f)
        result.push json
    result
```

编译结果为
```javascript
  getValues = function(eles, fields) {
    var ele, f, field, json, k, result, _i, _j, _len, _len1, _ref;
    result = [];
    for (_i = 0, _len = els.length; _i < _len; _i++) {
      ele = els[_i];
      json = {};
      for (_j = 0, _len1 = fields.length; _j < _len1; _j++) {
        field = fields[_j];
        _ref = field.split(':'), k = _ref[0], f = _ref[1];
        f = f != null ? f : k;
        json[k] = typeof ele[f] === 'function' ? ele[f]() : ele.attr(f);
      }
      result.push(json);
    }
    return result;
  };
```

匿名函数箭头写法和函数输掉用
----------------------------
无参匿名函数可以写成`->`也可以写成`()->`。
后者需要注意与函数调用的括号区别开来

```coffeescript
a -> #a是函数，传入一个匿名函数。此时是省略括号的函数调用
a(->) #同上
#b-> #非法
c ()-> #c是函数，无参匿名函数采用了第二种写法
c(()->) #同上
d() -> #d()为函数调用。返回结果认为是一个函数，并调用，传入一个无参匿名函数
d()(->) #同上
e () -> #e是函数，() -> 是无参匿名函数。这里在括号和箭头之间有了一个空格
e(() ->) #同上
```

```javascript
a(function() {});

a(function() {});

c(function() {});

c(function() {});

d()(function() {});

d()(function() {});

e(function() {});

e(function() {});
```
