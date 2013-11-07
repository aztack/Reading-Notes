- js有那些数据类型

```
There are five primitive data types in JavaScript:

- number
- string
- boolean
- undefined
- null
- Everything that is not a primitive is an object.

助记 SUB N NO
```

typeof
======

```
typeof(NaN) == 'number'
typeof(Infinity) == 'number'

typeof(undefined) == 'undefined'
typeof(null) == 'object'

NaN == NaN //false
NaN != NaN //true
NaN > NaN //false

null == undefined //true
null >= undefined //false
null <= undefined //false
```

编写一个函数实现功能
===================

parseQueryString
----------------

```javascript
function getQueryString(url){
  var a = document.createElement('a'), query, result = {},i,j,pairs,kv,len,k;
  a.href = url;
  query = a.search;
  if (query && query.indexOf('#') ==0 ) {
    pairs = query.substr(1).split('&');
    for(i=0;i<pairs.length;++i) {
      kv = pairs[i].split("=");
      k = kv[0];
      if(k.indexOf('[]')) {
        k = k.replace('[]','');
        if(typeof result[k] == 'undefined') {
          result[k] = [kv[1]];
        } else {
          result[k].push(kv[1]);
        }
      } else {
        result[kv[0]] = kv[1];
      }
    }
  } else return result;
}
```

验证email
---------

将url解析为host,path,query等
-----------------------------

截取字符串abcdefg中的efg
------------------------

```javascript
  var a = "abcdefg", i = a.indexOf("efg");
  if ( i>=0 ) {
    "abcdefg".substring(i);
    "abcdefg".substr(i);
  }
```

解释：本题目是为了考察substr和substring。但是并没有达到目的，出的比较失败。因为截取到最后一个字符，两个函数都可以省略第二个参数。
而二者的区别就在第二个函数。而且被截取字符串是固定的，截取内容是固定的。

知识点：
```javascript
  String.prototype.substring(start,end); //截取字符串[start,end)区间的子串，不包括end。如果end为undefined，则end=字符串长度
  String.prototype.substr(start,length); //从start开始截取length个字符。如果length为undefined。则length=正无穷
```

获取一个object的keys对应的values
--------------------------------

```javascript
  var obj = {a:1,b:2,c:3};
  var values = [];
  
  //传统
  for(var k in obj) {
    if(obj.hasOwnPropery(k)){
      values.push(obj[key]);
    }
  }
  
  //ECMA5+
  values = Object.keys(obj).map(function(k){return obj[key];});
  
  //ECMA6+
  values = Object.keys(obj).map(key => obj[key]);
  //or
  values = []
```

计算字符串的字节长度
--------------------

```javascript
  function getByteLength(str){
    if(!str) return 0;
    var i = 0, len = str.length, bytes = len;
    for(;i < len;++i) {
      if(str.charCodeAt(i)>255) bytes++;
    }
    return bytes;
  }
  
  function getByteLength(str) {
    if(!str) return 0;
    var a = str.match(/[\x00-\xff]/g);
    return str.length + (a ? a.length : 0);
  }
```
