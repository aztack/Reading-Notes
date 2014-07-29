IE CSS Hack 
===========
http://browserhacks.com/
http://www.paulirish.com/2009/browser-specific-css-hacks/
http://css-tricks.com/how-to-create-an-ie-only-stylesheet/

- .all IE{property:value\9;} //常用
- .gte IE 8{property:value\0;}
- .lte IE 7{*property:value;} //常用
- .IE 8/9{property:value\0;}
- .IE 9{property:value\9\0;}
- .IE 7{+property:value;} //常用
- .IE 6{_property:value;} //常用
- .not IE{property//:value;}
- lte：就是Less than or equal to的简写，也就是小于或等于的意思。

>- lt ：就是Less than的简写，也就是小于的意思。
>- gte：就是Greater than or equal to的简写，也就是大于或等于的意思。
>- gt ：就是Greater than的简写，也就是大于的意思。
>- !  ：就是不等于的意思，跟javascript里的不等于判断符相同

CSS Hack Targeting IE8 and Below
----
```css
div {
  border: 2px solid #aaa; /* for all browsers */
  border: 2px solid #f009; /* IE8 and below - red border */
}
```

CSS Hack Targeting IE7 and Below
----
```css
div {
  border: 2px solid #aaa; /* for all browsers */
  border: 2px solid #f009; /* IE8 and below - red border */
  *border: 2px solid #0f0; /* IE7 and below - green border */
}
```

CSS Hack Targeting IE6 and Below
----
```css
div {
  border: 2px solid #aaa; /* for all browsers */
  border: 2px solid #f009; /* IE8 and below - red border */
  *border: 2px solid #0f0; /* IE7 and below - green border */
  _border: 2px solid #00f; /* IE6 and below - blue border */
}
```

Other
=====

- [Internet Explorer User Agent Style Sheets](http://www.iecss.com/)
- [A modern, HTML5-ready alternative to CSS resets](http://necolas.github.io/normalize.css/)

[CSS3 Transitions, Transforms, Animation, Filters and more!](http://css3.bradshawenterprises.com/)

CSS3 过渡，变换，动画，滤镜

- 过渡在一定时间里完成，所以要有时长：`transition-duration`
- 过渡是一种变化，所以要有谁在变化的：`transition-property`
- 既然有变化，就得描述如何变化：`transition-timing-function`
- `transition-delay`是过渡的延时

```
transition:  [ <transition-property> ||
               <transition-duration> ||
               <transition-timing-function> ||
               <transition-delay> ]
```

时长很好理解。`transition-property`是什么呢？它能是什么呢？这里是MDN对它的解释：[transition-property](https://developer.mozilla.org/en-US/docs/Web/CSS/transition-property)

这里是css属性中可以作为`transition-property`的完整列表：[list of animatable properties](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_animated_properties?redirectlocale=en-US&redirectslug=CSS%2FCSS_animated_properties)



Tools：
[Ceaser CSS Easing Tool](http://matthewlein.com/ceaser/)
