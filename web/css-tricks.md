页面变灰
========
出现灾难需要默哀时会用到

```css
html {
	filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
	-webkit-filter: grayscale(100%);
}
```
@see https://developer.mozilla.org/en-US/docs/Web/CSS/filter

```
The syntax is:

.filter-me {
  filter: <filter-function> [<filter-function>]* | none
}
```
Where is one of:

blur() 模糊

brightness() 亮度

contrast() 对比度

url() `The url() function takes the location of an XML file that specifies an SVG filter, and may include an anchor to a specific filter element.`

drop-shadow() 投影

grayscale() 灰度

hue-rotate()色调旋转

invert() 反色

opacity() 透明度

sepia() 深褐色彩

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
lazy load图片的时候，图片没有src属性。
img标签如果没有src或者src为空（[千万不要为空](http://www.nczonline.net/blog/2009/11/30/empty-image-src-can-destroy-your-site/))，浏览器会自动加上一个灰色边框，影响美观。下面的方法可以去掉。

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

```javascript
	/**
	 * 图片延时加载
	 */
	! function(window) {
		var $q = function(q, res) {
				if (document.querySelectorAll) {
					res = document.querySelectorAll(q);
				} else {
					var d = document,
						a = d.styleSheets[0] || d.createStyleSheet();
					a.addRule(q, 'f:b');
					for (var l = d.all, b = 0, c = [], f = l.length; b < f; b++)
						l[b].currentStyle.f && c.push(l[b]);

					a.removeRule(0);
					res = c;
				}
				return res;
			},
			addEventListener = function(evt, fn) {
				window.addEventListener ? this.addEventListener(evt, fn, false) : (window.attachEvent) ? this.attachEvent('on' + evt, fn) : this['on' + evt] = fn;
			},
			_has = function(obj, key) {
				return Object.prototype.hasOwnProperty.call(obj, key);
			};

		function loadImage(el, fn) {
			var img = new Image(),
				src = el.getAttribute('data-src');
			img.onload = function() {
				$(el).removeClass('lazy error loading').addClass('native-call');
				if (!!el.parent) {
					el.parent.replaceChild(img, el)
				} else {
					el.src = src;
					$(el).removeClass('lazy');
				}

				fn && fn();
			};
			img.onerror = function(){
				var e = $(el);
				e.addClass('error lazy')
					.removeClass('native-call loading')
					.off('tap').tap(function(){
						/* 点击图片重新加载 */
						e.addClass('loading');
						loadImage(el, fn);
					});
			};
			img.src = src;
		}

		function elementInViewport(el) {
			var rect = el.getBoundingClientRect()

			return (
				rect.top >= 0 && rect.left >= 0 && rect.top <= (window.innerHeight || document.documentElement.clientHeight)
			)
		}

		function loadImageInScreen() {
			var images = Array.prototype.slice.call($q('img.lazy'), 0);
			for (var i = 0; i < images.length; i++) {
				if (elementInViewport(images[i])) {
					loadImage(images[i], function() {
						images.splice(i, i);
					});
				}
			};
		}
		addEventListener('scroll', loadImageInScreen);
		window.lazyLoadImage = loadImageInScreen;
	}(this);
```
在首屏显示时需要调用一下lazyLoadImage
