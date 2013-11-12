[jQuery 2.0.3](http://code.jquery.com/jquery-2.0.3.js)
[jQuery download](http://jquery.com/download/)

写一个`jQuery.each`
===================

```javascript
jQuery.each = function(obj, callback, args) {
  var value,
      i = 0,
      length = obj.length,
      isArray = isArraylike(obj);

  if (args) {
      //先判断是不是array，然后采用for-i的形式遍历
      if (isArray) {
          for (; i < length; i++) {
              value = callback.apply(obj[i], args);
              if (value === false) {
                  break;
              }
          }
      } else {
        //然后默认是object，采用for—in的形式遍历
          for (i in obj) {
              value = callback.apply(obj[i], args);

              if (value === false) {
                  break;
              }
          }
      }

      // A special, fast, case for the most common use of each
  } else {
      if (isArray) {
          for (; i < length; i++) {
              value = callback.call(obj[i], i, obj[i]);

              if (value === false) {
                  break;
              }
          }
      } else {
          for (i in obj) {
              value = callback.call(obj[i], i, obj[i]);

              if (value === false) {
                  break;
              }
          }
      }
  }

  return obj;
};
```

jQuery#proxy和jQuery#delegate的区别
===================================
```javascript
//jQuery#proxy是将fn绑定到context上，返回一个函数
//这个函数被调用时的this指向context
jQuery.fn.proxy = function(fn,context){};

//jQuery#delegate实质上时是在元素上监听eventName事件
//当event.target匹配selector时调用callback
jQuery.fn.delegate = function(selector,eventName,callback){};
```
