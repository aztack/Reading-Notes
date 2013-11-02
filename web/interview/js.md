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

编写一个函数实现功能
===================

parseQueryString
----------------

验证email
---------

将url解析为host,path,query等
-----------------------------
