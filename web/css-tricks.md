去掉移动设备上<a>的outline
====
网上搜到的`a:focus{outline:0;}`不管用。可能是touch的时候focus还未出发。
```css
a { -webkit-tap-highlight-color: rgba(0,0,0,0); }
```

devicePixelRatio大于2的设备用css画1px的直线
====

`border:1px solid #ccc;`
在devicePixelRatio等于2的设备上会被画成难看的2个像素直线。
用1px的背景图也无济于事。那么只能用能画出半个像素的css来实现：比如 1px的渐变，box-shadow。

要画出1px的水平直线，需要画一个从上到下的1px高的渐变，上0.5px是要画的颜色，比如#e6e6e6，下0.5px是背景色，比如白色。
要注意的是，加上`-webkit-linear-gradient`因为有些低版本的webkit内核浏览器需要-webkit前缀。

```sass
@mixin border-bottom-1px() {
	background-image: linear-gradient(90deg, #e6e6e6, #e6e6e6 50%, #fff 50%);
	background-image: -webkit-linear-gradient(90deg, #e6e6e6, #e6e6e6 50%, #fff 50%); /* 低版本webkit兼容 */
	background-size: 100% 1px;
	background-repeat: no-repeat;
	background-position: bottom;
}

@mixin border-bottom-1px-dpr2() {
	border-bottom: 1px solid rgba(230,230,230,.6);
	@media (-webkit-min-device-pixel-ratio: 2) {
		border-bottom: none;/* 去掉上面画的1px边框，否者会和下面背景重叠 */
		@include border-bottom-1px();
	}
}
```

还有一种更简单的方法：将一个像素高的元素（伪元素）`scaleY(0.5)`，如果是垂直方向就`scaleX(0.5)`

```css
.line:before {
	content: "";
	display: block;
	height: 1px;
	border-bottom: 1px solid #e6e6e6;
	-webkit-transform: translate3d(0,6px,0) scaleY(0.5); /* 关键 */
}
```

去掉没有src的<img>的边框
====
img标签如果没有src或者src为空（[千万不要为空](http://www.nczonline.net/blog/2009/11/30/empty-image-src-can-destroy-your-site/))时，浏览器会自动加上一个灰色边框，影响美观。下面的方法可以去掉。

```css
.photo[src=''] {
	content:''; /* 关键 */
	display: inline-block;
	text-align: center;
	background: url(../images/img-placeholder-bg.png) repeat 0 0;
	background-size: 3px 3px;
}
/* css的属性匹配没有"!="，但是可以用not来代替 */
.photo:not([src='']) {
	display:inline-block; /* 关键 */
}
```
