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

jQuery#attr和jQuery#prop的区别
===================================

`<div id="id">`包含div节点，id属性节点
对于内置的attribute-- id来说：
div.getAttribute('id')返回属性节点的值，永远是字符串。
div.id返回节点属性的值，永远是字符串。
也就是说相当于浏览器为你实现了：
```javascript
Object.defineProperty(div,'id',{
  get: function(){
     return this.getAttribute('id')
  },
  set: function(value){
    this.setAttribute('id',value + '');
  }
}
```

但是对于自定义的属性节点来说，没有这个特性：
```
div.setAttribute('custom',true)
div.getAttribute('custom') == 'true'
div.custom === undefined
```

需要你自己实现来实现div.id和属性节点之间的同步：
```javascript
Object.defineProperty(div,'custom',{
  get: function(){
     return this.getAttribute('custom')
  },
  set: function(value){
    this.setAttribute('custom',value + '');
  }
}
```

在实现的过程中你会发现，js对象的property和属性节点的名字之间会有不一致。
jquery通过增加了一个映射和propHook来解决：

```javascript
jQuery.propFix: {
	"for": "htmlFor",
	"class": "className"
}
jQuery.each([
	"tabIndex",
	"readOnly",
	"maxLength",
	"cellSpacing",
	"cellPadding",
	"rowSpan",
	"colSpan",
	"useMap",
	"frameBorder",
	"contentEditable"
], function() {
	jQuery.propFix[ this.toLowerCase() ] = this;
});
```


下面是jQuery的源码”

jQuery#prop
```javascript
prop: function( elem, name, value ) {
		var ret, hooks, notxml,
			nType = elem.nodeType;

		// don't get/set properties on text, comment and attribute nodes
		if ( !elem || nType === 3 || nType === 8 || nType === 2 ) {
			return;
		}

		notxml = nType !== 1 || !jQuery.isXMLDoc( elem );

		if ( notxml ) {
			// Fix name and attach hooks
			name = jQuery.propFix[ name ] || name;
			hooks = jQuery.propHooks[ name ];
		}

		if ( value !== undefined ) {
			return hooks && "set" in hooks && (ret = hooks.set( elem, value, name )) !== undefined ?
				ret :
				( elem[ name ] = value );

		} else {
			return hooks && "get" in hooks && (ret = hooks.get( elem, name )) !== null ?
				ret :
				elem[ name ];
		}
	}
```
jQuery#attr

```javascript
attr: function( elem, name, value ) {
		var hooks, ret,
			nType = elem.nodeType;

		// don't get/set attributes on text, comment and attribute nodes
		if ( !elem || nType === 3 || nType === 8 || nType === 2 ) {
			return;
		}

		// Fallback to prop when attributes are not supported
		if ( typeof elem.getAttribute === core_strundefined ) {
			return jQuery.prop( elem, name, value );
		}

		// All attributes are lowercase
		// Grab necessary hook if one is defined
		if ( nType !== 1 || !jQuery.isXMLDoc( elem ) ) {
			name = name.toLowerCase();
			hooks = jQuery.attrHooks[ name ] ||
				( jQuery.expr.match.bool.test( name ) ? boolHook : nodeHook );
		}

		if ( value !== undefined ) {

			if ( value === null ) {
				jQuery.removeAttr( elem, name );

			} else if ( hooks && "set" in hooks && (ret = hooks.set( elem, value, name )) !== undefined ) {
				return ret;

			} else {
				elem.setAttribute( name, value + "" );
				return value;
			}

		} else if ( hooks && "get" in hooks && (ret = hooks.get( elem, name )) !== null ) {
			return ret;

		} else {
			ret = jQuery.find.attr( elem, name );

			// Non-existent attributes return null, we normalize to undefined
			return ret == null ?
				undefined :
				ret;
		}
	}
```

jQuery.attrHooks
  tabindex: Object
  type: Object
  value: Object

jQuery.valHooks
  checkbox: Object
  option: Object
  radio: Object
  select: Object

jQuery.propHooks
  tabindex: Object
