[CSS Flexible Box Layout Module](http://www.w3.org/TR/css3-flexbox/)
====

> CSS 2.1 defined four layout modes — algorithms which determine the size and position of boxes based on their relationships with their sibling and ancestor boxes:
block layout, designed for laying out documents
inline layout, designed for laying out text
table layout, designed for laying out 2D data in a tabular format
positioned layout, designed for very explicit positioning without much regard for other elements in the document

CSS 2.1 定义了四种布局模型 - 四种基于`盒`与兄弟节点、祖先节点的关系，用于确定`盒`尺寸、位置的算法:

- 块布局，用于布局文档
- 行内布局，用于布局文本
- 表格布局，用于在表格中布局二维数据
- 定位布局，用于非常明确的定位，与文档中的其他元素几乎无关

Note：
- An absolutely-positioned flex item does not participate in flex layout（since it has been taken out of the normal flow)

====================

[A gentle introduction to CSS3 Flexible Box Module](http://www.the-haystack.com/2010/01/23/css3-flexbox-part-1/)
====

> flexbox: arranging elements horizontally or vertically on the screen

It implies two important things:

- No more abusing floats, and no more getting abused by floats
- We can create true flexible layouts, and the browser will do the calculations for us

Flexbox gives us a new value for the display property (the box value), and eight new properties:

> display: box;

- box-orient
- `box-flex`
- box-align
- box-direction
- box-flex-group
- box-lines
- box-ordinal-group
- box-pack


```html

<div id="products">
    <p id="phones">First child</p>
    <p id="computers">Second child</p>
    <p id="last"></p>
</div>

```

```css
#products { 
  display:-webkit-box; /* 子元素使用box模型布局 */
	box-orient: horizontal; /* box模型水平布局 */
}
p{
	border:1px solid red; 
}
#computers{
	-webkit-box-flex:4; /* 之中p#computer将被水平撑开，占据inline不居中没有被占据的空间的五分之四 */
}
#last{
  -webkit-box-flex:1; /* p#last占据五分之一 */
}
```
