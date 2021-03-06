CSS优先级
=========

CSS样式定义优先级顺序是

`浏览器缺省 < 外部样式表 < 内部样式表 < 内联样式`

确定度
```
选择符的确定度由4位逗号相隔的数字组成， 形式为0,0,0,0 . 分别用abcd表示， a,b,c,d
1. 若样式由元素的style属性确定而不通过选择符， 将a置为1，否则为0
2. 计算id选择符的个数， 赋值为b
3. 计算属性选择符或伪元素个数， 赋值为c
4. 计算类型选择符或伪元素个数， 赋值为d
比较abcd大小， 数值大的确定度高
```

画出盒式模型
============
[http://www.w3.org/TR/CSS2/box.html](http://www.w3.org/TR/CSS2/box.html)

![Box Model](http://www.w3.org/TR/CSS2/images/boxdim.png)

W3C和IE对盒模型不同的解释
----
![The difference in how width is interpreted between the W3C and Internet Explorer box models](http://upload.wikimedia.org/wikipedia/commons/6/64/W3C_and_Internet_Explorer_box_models.svg)

★[来源]([http://en.wikipedia.org/wiki/Internet_Explorer_box_model_bug)

助记:

![助记图](box-model.png)

- IE5.5以及以前的版本的IE使用IE盒模型。IE6在standards compliant mode会使用W3C的盒模型
- css3引入了控制盒模型的属性：`box-sizing = [border-box|content-box|__padding-box__|inherit]`
- `padding-box`目前只有Firefox支持

display有哪些属性
=================

```css
display: [
  inline
  | block
  | none
  | inline-block
  
  | table
  | inline-table
  | table-caption
  | table-header-group
  | table-footer-group
  | table-row
  | table-row-group
  | table-column
  | table-column-group
  | table-cell
  
  | run-in
  | list-item
  | inherit
  
  | flex
  | inline-flex
]
```

助记: ![display取值](display-values.png)

另外：为什么display有这么多table-开头的值呢？
★★★[css spec table](http://www.w3.org/TR/CSS21/tables.html#table-display)

> The CSS table model is based on the HTML4 table model, in which the structure of a table closely parallels the visual layout of the table. In this model, a table consists of an optional caption and any number of rows of cells. The table model is said to be "row primary" since authors specify rows, not columns, explicitly in the document language. Columns are derived once all the rows have been specified -- the first cell of each row belongs to the first column, the second to the second column, etc.). Rows and columns may be grouped structurally and this grouping reflected in presentation (e.g., a border may be drawn around a group of rows).
Thus, the table model consists of **tables, captions, rows, row groups (including header groups and footer groups), columns, column groups, and cells**.
**The CSS model does not require that the document language include elements that correspond to each of these components. For document languages (such as XML applications) that do not have pre-defined table elements, authors must map document language elements to table elements; this is done with the 'display' property**. 

助记2：
```
caption  { display: table-caption }
table    { display: table|inline-table }

thead    { display: table-header-group }
tfoot    { display: table-footer-group }

tr       { display: table-row }
tbody    { display: table-row-group }

col      { display: table-column }
colgroup { display: table-column-group }

td, th   { display: table-cell }

```


写一个三栏式布局
================

★★★★★先介绍css3 Flexbox
[A Complete Guide to Flexbox](http://css-tricks.com/snippets/css/a-guide-to-flexbox/)

使用Flexbox可以轻松做出三栏布局
传统的三栏布局用margin来调整div的位置就可以了


position有哪些可选值
==================

`position : [static|absolute|relative|fixed|inherit]`

注意：float不是position的可取值，而是一个css属性

float有哪些可选值
=================

`float : [left|right|none|inherit]`

有哪些css选择符
===============
```
Universal selector
Type selectors
Descendant selectors  - `a b` - 后代节点选择符
Child selectors - `a > b` -直接子节点选择符，助记`a>b>c 目录层级`
Ajacent sibling selectors - `a + b` -兄弟节点选择符，助记`parent > a + b + c`
Attribute selectors - `a[attr]`
ID selectors
Pseudo-elements/classes
```

助记:`Put Cai AD` `放菜广告`
注意：有两个A，Ajacent和Attribute；将AD及一位Ajacent和Descendant，都是表示关系的。
```
Selector PUT CAI AD `选择符放菜广告`

Pseudo Element and Class 伪元素、伪类
Universal Selector 通用选择符
Type Selector 类型选择符
Child selector 子节点选择符
Attributes selector 属性选择符 `菜的id和属性`
Id selector ID选择符
Ajacent Sibling selector 兄弟节点选择符
Descedant selector 后代选择符
```

关于Attribute selector：
```
a[attr]      有属性
a[attr*=val] 包含
a[attr=val] 等于
a[attr~=val] 空白符等于

a[attr|=val] 等于或等于val-
```
助记：有属性 和 包含 很好记忆。`|=`又很少用到。所以只需记忆`~=`,把波浪号想象成空白符。
因为空白符等于总不能携程 `a[attr =val]`，因为无法和`a[attr=val]`区分开来。所以用波浪线代表空白符。

如何将一个DIV垂直方向充满整个窗口
=================================

首先设置body,html的高度为100%，之后设置该DIV的高度为100%
```css
body,html {
  height:100%;
  margin:0px;
}
```

比较新的方法是使用css3中的[视口百分比](http://www.w3.org/TR/css3-values/#viewport-relative-lengths)宽度/高度：

```css
body { margin:0; /* This is used to reset any browser-default margins */ }

div {
    height:100vh; //视口的100%高度
    background:#f00;
    color:#fff;
}
```

参考:[Make div 100% height of browser window](http://stackoverflow.com/questions/1575141/make-div-100-height-of-browser-window)


如何给inline元素设置宽高？
=========================
span这类内联元素时无法设置宽高的。需要将其display设置为inline-block的。
但是IE6/7不支持inline-block。你需要设置`zoom:1`来trigger其hashLayout
```css
.inline-block {
    display: inline-block;
    zoom: 1;
    *display: inline;
}
```

CSS IE hacks
=============
_width=1px	// 6
*width=1px	// 67
+width=1px	// 7
width:1px\0	// 8
width:1px\9	/// 6789...

书写顺序：
- 其他浏览器
- IE7
- IE6

css样式层叠顺序,优先级由低到高
===============
- user agent
- external style sheet
- internal style sheet
- inline style sheet

列举一些css兼容性问题
=====================
- div的垂直居中问题
- margin加倍的问题
- 浮动ie产生的双倍距离
- IE与宽度和高度的问题
- DIV浮动IE文本产生3象素的bug
- IE6下为什么图片下有空隙产生

css3新增了那些内容
==================
- text-shadown
- box-shadown
- linear-gradient
- radial-gradient
- RGBA(alpha)
- border-radius
- transform
- transition(一定时间平滑过渡)
- animation(动画)


CSS selector 确定度算法
======================
