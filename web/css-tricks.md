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
