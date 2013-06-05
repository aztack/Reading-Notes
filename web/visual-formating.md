参考资料：
- [Visual formatting model(W3C)](http://www.w3.org/TR/CSS21/visuren.html)
- [Visual formatting model(MDN)](https://developer.mozilla.org/en-US/docs/Web/CSS/Visual_formatting_model)
- [DOCUMENTATION AND TUTORIALS ABOUT CSS](https://developer.mozilla.org/en-US/docs/Web/CSS)
- [Formatting Concepts](http://reference.sitepoint.com/css/formattingcontext)
- [Understanding Floats](http://phrogz.net/css/understandingfloats.html)
- ["HasLayout" Overview](http://msdn.microsoft.com/en-us/library/bb250481%28VS.85%29.aspx)

首先需要明确的知识点：

各种盒子
--------

- 文档元素会生成`盒`，即Box。`盒`是css布局的对象（target）和基本单位。
- `盒`分为`块级盒` (block level)和`行内盒`或称`行级盒` (inline)。(Run-in box?)
- HTML元素有默认的display属性，决定了其默认的是块级元素还是行内元素。可以通过修改display属性来改变。`display`为`none`的元素不产生`盒`
- `盒`产生的`格式化上下文`会受到display、float、position的影响：比如，position为absolute、设置了float的属性的元素都会创建新的`块级格式化上下文`
- 请区分`块级元素`和`块级盒`。因为`块级元素`被设置为`display:inline`后，也可以产生`行内盒`

块级元素和行级元素
------------------
- [块级元素](https://developer.mozilla.org/en-US/docs/HTML/Block-level_elements)
  * `<address>` `<article>` `<aside>` `<audio>` 
  * `<blockquote>`
  * `<canvas>` 
  * `<dd>``<div>``<dl>`
  * `<fieldset>``<figcaption>` `<figure>` `<footer>` `<form>`
  * `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>`
  * `<header>` `<hgroup>` `<hr>`
  * `<noscript>`
  * `<ol>``<output>` 
  * `<p>``<pre>`
  * `<section>` 
  * `<table>``<tfoot>`
  * `<ul>`
  * `<video>` 

- [行级元素](https://developer.mozilla.org/en-US/docs/HTML/Inline_elements)
  * b, big, i, small, tt
  * abbr, acronym, cite, code, dfn, em, kbd, strong, samp, var
  * a, bdo, br, img, map, object, q, script, span, sub, sup
  * button, input, label, select, textarea

格式化上下文
------------

- 以前的理解：

 <del>`盒`内部会生成一个看不见的`格式化上下文`。这个`格式化上下文`会控制`盒`内部如何布局。</del>
 `格式化上下文`不限于`块级格式化上下文`简称*BFC*和`行内格式化上下文`简称*IFC*两种，还有
  + <del>`table格式化上下文`</del> [How many CSS formatting contexts are there?](http://stackoverflow.com/questions/16908438/how-many-css-formatting-contexts-are-there/16910066#16910066)
  + `grid格式化上下文`
  + `flex格式化上下文`
 但是，`盒`<del>只有</del>*主要有*block和inline两种。[还有...](https://developer.mozilla.org/en-US/docs/Web/CSS/Visual_formatting_model)
 - <del>`盒`+`格式化上下文`，作用于其包含的`盒`，实现布局。</del>
 

参考：
[Block formating contexts, ‘hasLayout’ – IE Window vs CSS2.1 browsers: simulations.](http://dev.l-c-n.com/IEW/simulations.php)

- 整理更新：

> "In general, a "formatting context" is simply an area in which descendant boxes of a certain kind (e.g. block, inline, flex-item) are laid out (or formatted) in normal flow."

> "A block formatting context is a part of a visual CSS rendering of a Web page. It is the region in which the layout of block boxes occurs and in which floats interact with each other."

格式化上下文是页面中一块渲染区域，产生格式化上下文的盒子的子代盒子在其中进行布局。

CSS2.1中只有 BFC和IFC，CSS3中还增加了GFC和FFC。

`非替换元素`和`替换了的元素`?
-------------------------------

- Non-replaced elements: 大多数HTML元素都是非替换的，包括起始标签和结束标签，中间的内容就是最终显示的内容。没有被外部其他内容`替换`
- Replaced elements: 典型的`替换了的`的元素有`<img>`,`<input>`，`<object>`,`<button>`,`<select>`，他们没有结束标签。它们显示的内容是从外部加载的。

哪些情况下会产生哪些`格式化上下文`?
-----------------------------------
[Block formatting context](https://developer.mozilla.org/en-US/docs/Web/CSS/Block_formatting_context?redirectlocale=en-US&redirectslug=CSS%2FBlock_formatting_context)

A block formatting context is created by one of the following:

- the root element or something that contains it
- floats (elements where float is not none)
- absolutely positioned elements (elements where position is absolute or fixed)
- inline-blocks (elements with display: inline-block)
- table cells (elements with display: table-cell, which is the default for HTML table cells)
- table captions (elements with display: table-caption, which is the default for HTML table captions)
- elements where overflow has a value other than visible
- flex boxes (elements with display: flex or inline-flex)

[Only the following properties change the standard element's flow](http://stackoverflow.com/posts/11917186/edit):

 - `float: right|left`
 - `position: absolute|fixed`

Just for completeness: 

 - `position: relative` does not change the flow order of the element, but changes the element position relative to the normal flow position.
 - `display: none` removes the element of the flow (strictly speaking it does no change the element flow order because the element will not have a flow order at all)
 - `visibility: hidden` will maintain the element on the flow but will not display it.

定位
----

正常流中的盒一个挨一个的排开。在BFC中盒子纵向依次排开，在IFC中盒子横向排开。当`position`设置为`static`或者`relative`，并且`float`设置为`none`时，正常流被激活。

```
  static positioning \
                      +--> normal flow <--- *Float Positioning Scheme* only apply to
relative positioning /
```
-`正常流`包含两种sub-cases：
 - `static定位`，盒被绘制在正常流定义的位置
	- `相对定位`，盒在正常流定位的基础上，根据top,bottom,left,right进行偏移
- `浮动定位`的盒被放置在当前行的开始或结尾处。正常流中的盒子围绕其左/右边缘排列，除非设置了`clear`属性。当`float`属性被设置为非`none`(`left`或`right`)，且`position`设置为`static`或`relative`的时候启用`float`定位。

```
absolut positioning \
                     +--> *Absolute Positioning Scheme*
  fixed positioning /
```

- `绝对定位`的盒子被从流中移除，并相对它的`包含块`(containing block)依据top,bottom,left,right来进行偏移。
如果没有指定偏移，那么它保持正常流中的位置，不进行偏移。如果指定了偏移，那么相对最近的`positioned`的父节点产生的盒子定位。如果找不到这么一个父节点，那么就相对根节点`html`偏移。
- `固定定位`的是一种绝对定位，只不`包含块`是`视口`。


记住
----

- 块级元素内的文本会生成匿名`行盒`！所以，文字按`行级`，外层元素按`块级`考虑布局
- `float`不适用于`position:absolute`的元素和根元素 [p.146]
- ["浮动是个行级的行为，当遇到浮动元素的时候，会首先"假装"它是个行内元素进行排版，排好后就往浮动的方向挤到挤不过去为止（遇到边界或者其它浮动元素）"](http://www.cnblogs.com/winter-cn/archive/2013/05/11/3072929.html)
- "margin of a float never collapse" [p.144]
- `width`和`height`不适用于`非替换的行级元素` [p.174 10.2] [p.182]
- In an inline formatting context, boxes are laid out horizontally, starting at the top of the containing block. Horizontal margins, padding, and borders can exist between the boxes, but *vertical margins are ignored* for inline boxes. *Dimensions (width and height) can’t be specified for inline boxes*(见上一条). [ref](http://reference.sitepoint.com/css/inlineformatting)

> 9.1 Introduction to the visual formatting model
> -----------------------------------------------

> This chapter and the next describe the visual formatting model: how user agents
process the document tree [p. 45] for visual media [p. 107] .

> In the visual formatting model, each element in the document tree generates zero
or more boxes according to the box model [p. 111] . The layout of these boxes is
governed by:
box dimensions [p. 111] and type [p. 129] .
positioning scheme [p. 134] (normal flow, float, and absolute positioning).
relationships between elements in the document tree. [p. 45]
external information (e.g., viewport size, intrinsic [p. 45] dimensions of images, 
etc.).

9.1 可视格式化模型
------------------

在可视格式化模型中，每个文档树中的元素都会生成的零个或多个盒式模型中提到的Box。这些Box的布局由以下几个方面确定：

- Box的尺寸和类型
- Box的定位方式。（标准流，浮动定位，以及绝对定位）
- 元素在文档树中与其他元素的关系
- 其他外部信息（比如，视口的尺寸、图片固有的尺寸，等等）

> 9.1.1 The Viewport
> ------------------

> User agents for continuous media [p. 110] generally offer users a viewport (a window or other viewing area on the screen) through which users consult a document. User agents may change the document’s layout when the viewport is resized (see the initial containing block [p. 171] ). When the viewport is smaller than the area of the canvas on which the document is rendered, the user agent should offer a scrolling mechanism. There is at most one viewport per canvas [p. 40] , but user agents may render to more than one canvas (i.e., provide different views of the same document).

9.1.1 视口
----------

连续媒介的用户代理通常会为用户提供一个叫做视口的区域（一个窗口或者屏幕的一块区域），用户用来查看文档。
当视口的尺寸发生变化的时候用户代理（可能）会改变文档的布局。
当视口的尺寸比渲染文档的画布尺寸小的时候，用户代理应该提供滚动机制（让用户可以查看到整个文档）。
每个画布最多只能对应一个视口，但是，用户代理可以为同一个文档渲染出多个画布（比如同个文档的不同视图）。

> 9.1.2 Containing blocks
> -----------------------

> In CSS 2.1, many box positions and sizes are calculated with respect to the edges of a rectangular box called a containing block. In general, generated boxes act as containing blocks for descendant boxes; we say that a box "establishes" the containing block for its descendants. The phrase "a box’s containing block" means "the
containing block in which the box lives," not the one it generates. *Each box is given a position with respect to its containing block, but it is not confined by this containing block; it may overflow* [p. 195] . The details [p. 171] of how a containing block’s dimensions are calculated are described in the next chapter [p. 171] .

9.1.2 包含块
------------
在CSS2.1中，Box的定位、尺寸的计算都是与一个正方形的叫做包含块的四边有关的。
通常，元素的`父节点生成的Box`就是该元素的Box的`包含块`；换句话说就是，父Box为其后代Box“创建”了`包含块`。
如果提到一个“Box”的`包含块`，指的就是其父Box为其“创建”的那个`包含块`，而不是指它为它的后代创建的`包含块`。
每个Box都被定位在它的`包含块`中，但并不是说它被限制在包含框内,它有可能从包含块中“溢出”。

> 9.2 Controlling box generation
> ------------------------------

> The following sections describe the types of boxes that may be generated in CSS 2.1. A box’s type affects, in part, its behavior in the visual formatting model. The ’display’ property, described below, specifies a box’s type.

9.2 控制`盒`的生成
----------------
下面几节描述了CSS2.1中可能的几种盒类型。盒的类型会一定程度上影响它在可视格式化中的行为。
你可以通过display属性设置盒的类型。

> 9.2.1 Block-level elements and block boxes
> ------------------------------------------

> Block-level elements are those elements of the source document that are formatted visually as blocks (e.g., paragraphs). The following values of the ’display’ property make an element block-level: ’block’, ’list-item’, and ’table’.

> *Block-level boxes are boxes that participate in a block formatting context*. [p. 138] Each block-level element generates a principal block-level box that contains descendant boxes and generated content and is also the box involved in any positioning scheme.Some block-level elements may generate additional boxes in addition to the
principal box: ’list-item’ elements. These additional boxes are placed with respect to the principal box. Except for table boxes, which are described in a later chapter, and replaced elements, a block-level box is also a block container box. 

> A block container box either contains only block-level boxes or establishes an inline formatting context and thus contains only inline-level boxes. 

> *Not all block container boxes are block-level boxes*: non-replaced inline blocks and non-replaced table cells are block containers but not block-level boxes. Block-level boxes that are also block containers are called block boxes. 

> The three terms "block-level box," "block container box," and "block box" are sometimes abbreviated as "block" where unambiguous. 

9.2.1 块级元素和`块级盒`
-----------------------

“块级元素”是指源文档中被"绘制”成“块”的元素（比如,段落`<p>`;)。元素的display被设置为
'block','list-item','table'时，该元素就成为了`块级元素`。

> 下面这段翻译中的box相关名词相当‘混乱’，得结合英文读好几遍才好理解...

“块级盒”参与“块级格式化(环境)”。
每个块级元素都会生成一个“主块级盒”，其中包含这个元素的后代产生的盒，以及这个元素生成的内容。同时，
这个“主盒”也参与元素的定位。一些块级元素在生成“主盒”的基础上，还会生成“额外的盒”：
比如'list-item'元素。这些额外的盒会根据“主盒”进行定位。除了table生成的盒和`替换了的元素`
,“块级盒”同时也**可能**是一个“块容器盒”。“块容器盒”要么只包含“块级盒”，要么建立一个“行内格式化环境”并
只包含“行内盒”。并不是所有的“块容器盒”都是“块级盒”：non-replaced inline blocks和non-replaced
table cells都是“块容器盒”，但不是“块级盒”。如果“块级盒”同时也是“块容器盒”，称作“块盒”&?
目前有三个与‘盒’相关的名词需要区分：“块级盒”，“块容器盒”和“块盒”。如果没有歧义，都简称为“块”。

![`块级盒`,`容器盒`，`块盒`的关系](https://developer.mozilla.org/@api/deki/files/5995/=venn_blocks.png)

> 注意：`块级盒`和`行级盒`都是盒子的固有'属性'，由display决定。而`块容器盒`、`块盒`都是盒子的“职能”。类比一下：盒的“级”(level)类似于国籍（可以更改），后面几个可以理解为“职位”。 这里的`快容器盒`的名字有些误导。它**不是**块级盒的元素：它要么只包含块级元素，要么只包含行级元素。所以不如管他叫“容器盒”。


>  9.2.1.1 Anonymouse block boxes
>  ------------------------------
> in a document like this:

> ```html
>   <div>
>     Some text
>     <p>More text</p>
>   </div>
> ```

> (and assuming the `<div>` and the `<p>` have `display:block`), the `<div>` appears to have both inline content and block content. To make it easier to define the formatting, we assume that there is an anonymouse block box around "Some text".

> [Figure in page 130 top]

> Diagram showing the three boxes of which one is anonymouse, for the example above.

>   In other words: if a block container box (such as that generated for the `<div>` above) has a block-level box inside it (such as the `<p>` above), then we force it to have only block-level boxes inside it.
  
>   When an inline box contains an in-flow block-level box, the inline box (and its inline ancestors within the same line box) are broken around the block-level box (and any block-level siblings that are consecutive or sparated only by collapsible whitespace and/or out-of-flow elements), splitting the inline box into two boxes (even if either side is empty), one on each side of the block-level box(es). The line boxes before the break and after the break are enclosed in anonymouse block, and the block-level blox becomes a sibling of those anonymouse boxes. When such an inline box is affected by relative positioning, any resulting translation also affects the block-level box contained in the inline box.
  
>   Example(s):
>   This model would apply in the following example if the following rules:
> ```css
>   p{display:inline;}
>   span{display:block;}
> ```
>   were used with this HTML document:
  
> ```html
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
  <title>Anonymouse text interrupted by a block</title>
</head>
<body>
  <p>
    This is anonymosue text before the SPAN.
    <span>This is the content of SPAN</span>
    This is anonymouse text after the SPAN
  </p>
</body>
```

> The `<p>` element contains a chunk(C1) of anonymouse text followed by a block-level element followed by another chunk(C2) of anonymouse text. The resulting boxes would be a block box representing the `<body>`, containing an anonymouse block box around C1, the `<span>` block box, and another anonymouse block box around C2.

>   The properties of anonymouse boxes are inherited from the enclosing non-anonymosue box (e.g., in the example just below the subsection heading "Anonymosue block boxes", the one for `<div>`). Non-inherited properties have their initial value. For example, the font of the anonymouse box is inherited from the `<div>`, but the margins will be 0.
  
>   Properties set on elements that cause anonymosue block boxes to be generated still apply to the boxes and content of that elemnt. For example, if a border had been set on the `<p>` element in the above example, the border would be drawn around C1(open at the end of the line and C2(open at the start of the line).
  
>   Some user agents have implemented borders on inlines containing blocks in other ways, e.g., by wrapping such nested blocks inside "anonymouse line boxes" and thus drawing inline borders around such boxes. As CSS1 and CSS2 did not define this behavior, CSS1-only and CSS2-only user agents may implement this alternative model andstill claim conformance to this part of CSS 2.1. This does not apply to UAs developed after this specification was released.
  
>   *Anonymouse block boxes are ignored when resolving percentage values that would refer to it*: the closest non-anonymouse ancestor abox is used instead. For example if the child of the anonymouse block box inside the `<div>` above needs to know the height of its containing block to resolve a percentage height, then it will use the height of the containing block formed by the `<div>`, not of the anonymouse block box.

9.2.1.1 匿名块级盒
------------------
略

9.2.2 Inline-level elments and inline boxes
-------------------------------------------
  Inline-level elements are those elements of the source document that do not form new block of content; the content is distributed in lines (e.g., emphasized pieces of text within a paragraph, inline images, etc.). The following values of the `display` property make an element inline-level:
  - `inline`
  - `inline-table`
  - `inline-block`
Inline-level elements generate _inline-level boxes_, which are boxes that participate in an inline formatting context.

  An _inline box_ is one that is both inline-level and whose contents participate in its containing inline formatting context. A non-replaced element with a `display` value of `inline` generates an inline box. Inline-level boxes that are not inline boxes(such as replaced inline-level elements, inline-block elements, and inline-table elements) are called _atomic inline-level boxes_ because they participate in their inline formating context as a single opaque box.
  
![`行级盒`,`参与行内格式化的盒子`和`行盒`的关系](https://developer.mozilla.org/@api/deki/files/6008/=venn_inlines.png)

9.2.2 行内元素和行内盒
--------------------

（暂时略过）

9.4 Normal flow
---------------

  Boxes in the normal flow belong to a formatting context, which may be block or inline, but not both simultaneously.`Block-level`[p. 129] boxes participate in a `block foramtting`[p. 138] context. `Inline-level boxes`[p. 131] participate in an `inline formatting` [p. 138] context.

9.4.1 Block formatting contexts
-------------------------------

 *`Floats`, `absolutely positioned elements`,`block containers`* (such as inline-blocks, table-cells, and table-captions) that are not block boxes, and block boxes with 'overflow' other than 'visible' (except when that value has been propagated to the viewprot) *establish new block formatting contexts for their contents*.
 
 In a block formatting context,boxes are laid out one after the other, vertically, beginning at the top of a containing block. The vertical distance between two sibling boxes is determined byh the `margin` properties. *Vertical margins between adjacent block-level boxes in a block formatting context collapse*[p. 117].
 
 In a block formatting context, each box's left outer edge touches the left edge of the containing block (for right-to-left formatting, right edges touch). This is true even in the presence of floats (alghough a box's _line boxes_ may shrink due to the floats), unless the box establishes a new block formatting context (in which case the box itself `may become narrower`[p.142] due to the floats).
 
 For information about page breaks in paged media, please consult the section on `allowed page break`[p. 229].
 
9.4.1 块级格式化上下文--BFC
---------------------------
暂略

9.4.2 Inline formatting contexts
--------------------------------
In an inline formatting context, boxes are laid out horizontally, one after the other, beginning at the top of a containing block. Horizontal margins, borders, and padding are respected between these boxes. The boxes may be aligned vertically in different ways: their bottoms or tops may be aligned, or the baselines of text within them may be aligned. The rectangular area that contains the boxes that form a line is called a _line box_.

  The width of a line box is determined by a `containing block`[p.128] and the presence of floats. The height of a line box is determined by the rules given in the section on `line height calculations`[p.189].
  
  A line box is always tall enough for all of the boxes it contains. However, it may be taller than the tallest box it contains (if ,for example, boxes are aligned so that baseline line up). When the height of a box B is less than the height of the line box containing it, the vertical alignment of B within the line box is determined by the `vertical-align` property. When several inline-level boxes cannot fit horizontally within a single line box, they are distributed among two or more vertically-stacked line boxes. Thus, a paragraph is a vertical stack of line boxes. Line boxes are stacked with no vertical separation (except as specified elsewhere) and they never overlap.
  
  In general, the left edge of a line box touches the left edge of its containing block and the right edge touches the right edge of its containing block. However, floating boxes may come between the containing block edge and the line box edge. Thus although line boxes in the same inline formatting context generally have the same width (taht of the containing block), they may vary in width if available horizontal space is reduced due to `floats`[p.142]. Line boxes in the same inline formatting context generally vary in height (e.g., one line might contain a tall image while the other contain only text).
  
  When the total width of the inline-level boxes on a line is less than the width of the line box containing them, their horizontal distribution within the line box is determined by the `text-align` property. If that property has the value `justify`, the user agent may stretch spaces and words in inline boxes (but not inline-table and inline-block boxes) as well.
  
  When an inline box exceeds the width of a line box, it is split into several boxes and these boxes are distributed across several line boxes. If an inline box cannot be split (e.g., if the inline box contains a single character, or language specific word breaking rules disallow a break within the inline box, or if the inline box is affected by a white-space value of nowrap or pre), then the inline box `overflows` the inline box.
  
  When an inline box is split, margins, borders, and padding have no visual effect where the split occurs (or at any split, when there are several). (断行处被生生截断）
  
  Inline boxes may also be split into several boxes _within the same line box_ due to `bidirectional text processing`[p.165].
  
  Line boxes are created as needed to hold inline-level content within an inline formatting context. *Line boxes that contains* no text, no `preserved white space`[p.134], no inline elements with non-zero margins, padding, or borders, and no other `in-flow`[p.134] content (such as images, inline blocks or inline tables), and do not end with a preserved newline *must be treated as zero-height line boxes* for the purposes of determining the positions of any elements inside of them, and must be treated as not existing for any other purpose.
  
  Here is an example of inline box construction. The following paragraph (created by the HTML block-level element `<p>`) contains anonymouse text interspersed with the elements `<em>` and `<strong>`:
  
```html
<p>Several <em>emphasized words</em> apperas 
<strong>in this</strong> sentence, dear.</p>
```

  The `<p>` element generates a block box that contains five inline boxes, three of which are anonymouse:
  
  - Anonymouse: "Several"
  - `<em>`: "emphasized words"
  - Anonymouse: "appear"
  - `<strong>`: "in this"
  - Anonymouse: "sentence, dear."

  To format the paragraph, the user agent flows the five boxes into line boxes. In this example, the box generated for the `<p>` element establishes the containing blocks for the line boxes. If the containing block is sufficiently wide, all the inline boxes will fit into a single line box:
  
> Several _emphasized words_ appear **in this** sentence, dear.
  
  If not, the inline boxes will be split up and distributed across several line boxes. The previous paragraph might be split as follows:
  
> Several _emphasized words_ appears <br/>
> **in this** sentence, dear.
 
 Or like this:
 
> Several _emphasized_ <br/>
> _words_ appear **in this** <br/>
> sentence, dear.

  In the previouse example, the `<em>` box was split into two `<em>` boxes (call them "split1" and "split2"). Margins, boarders,padding, or text decorations have no visible effect after split1 or before split2.
  
  Consider the following example:
  
```html
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1//EN">
<html>
  <head>
    <title>Example of inline flow on several lines</title>
    <style type="text/css">
      em{
        padding:2px;
        margin: 1em;
        border-width:medium;
        border-style:dashed;
        line-height:2.4em;
      }
    </style>
  </head>
  <body>
    <p>Several <em>emphasized words</em> appear here.</p>
  </body>
</html>
```

9.4.3 Relative positioning
--------------------------

  Once a box has been laid out according to the `normal flow`[p.137] or floated, it may be shifted relative to this position. This is called _relative positioning_. Offsetting a box(B1) in this way has no effect on the box(B2) that follows: B2 is given a position as if B1 were not offset and B2 is not re-positioned after B1's offset is applied. This implies that relative positioning may causeboxes to overlap. However, if relative positioning cause an `overflow:auto` or `overflow:scroll` box to have overflow, the UA must allow the user to access this content (at its offset position), which, through the creation of scrollbars, may affect layout.
  
  A relatively positioned box keeps its normal flow size, including line breaks and the space originally reserved for it. The section on `containing blocks`[p.128] explains when a relatively positioned box establishes a new containing block.
  
  For relatively positioned elements, `left` and `right` move the box(es) horizontally, without changing their size. `left` moves the boxes to the right, and `right` moves them to the left. Since boxes are not split or stretched as a result of `left` or `right`, the used values are always: left = -right;
  
  If both 'left' and 'right' are `auto` (their initial values), the used values are `0`(i.e., the boxes stay in their original position).
  
  If 'left' is 'auto', its used value is minus the value of 'right'(i.e., the boxes move to the left by the value of 'right').
  
  If 'right' is specified as 'auto', its used value is minus the value of 'left'.
  
  If neither 'left' nor 'right' is 'auto', the position is over-constrained, and one of them has to be ignored. If the `direction` property of the containing block is `ltr`, the value of 'left' wins and 'right' becomes -'left'. if `direction` of the containing block is `rtl`, 'right' wins and 'left' is ignored.

  Depending on the width of the `<p>`, the boxes may be distributed as follows:
  
  [Figure at p.140]
  
- The margin is inserted before "emphasized" and after "words".
- The padding is inserted before, above, and below "emphasized" and after,above,and below "words". A dashed border is rendered on threee sides in each case.

  Example(s):
  
  The following three rules are equivalent:
  
```css
div.a8 { position: relative; direction: ltr; left: -1em; right: auto }
div.a8 { position: relative; direction: ltr; left: auto; right: 1em }
div.a8 { position: relative; direction: ltr; left: -1em; right: 5em }
```

The ’top’ and ’bottom’ properties move relatively positioned element(s) up or down without changing their size. ’Top’ moves the boxes down, and ’bottom’ moves them up. Since boxes are not split or stretched as a result of ’top’ or ’bottom’, the used values are always: top = -bottom. If both are ’auto’, their used values are both ’0’. If one of them is ’auto’, it becomes the negative of the other. If neither is ’auto’, ’bottom’ is ignored (i.e., the used value of ’bottom’ will be minus the value of ’top’). Note. Dynamic movement of relatively positioned boxes can produce animation effects in scripting environments (see also the ’visibility’ property). Although relative positioning may be used as a form of superscripting and subscripting, the line height is not automatically adjusted to take the positioning into consideration. See the description of line height calculations [p. 189] for more information.

Examples of relative positioning are provided in the section comparing normal flow, floats, and absolute positioning [p. 154] .

9.5 Floats
----------

A float is a box that is shifted to the left or right on the current line, The most interesting characteristic of a float (or "floated" or "floating" box) is that content may flow along its side (or be prohibited from doing so by the `clear` property). Content flows down the right side of a left-floated box and down the left side of a right-floated box. The following is an introduction to float positioning and content flow; the exact rules[p.147] governing float behavior are given in the description of the `float` property.

  A floated box is shifted to the left or right untils its outer edge touches the containg block edge or the outer edge of another float. If there is a line box, the outer top of the floated box is aligned with the top of the current line box.
  
  If there is not enough horizontal room for the float, it is shifted downward until either it fits or there are no more floats presents.

  Since a float is not in the flow, non-positioned block boxes created before and after the float box flow vertically as if the float did not exist. However, the current and subsequent line boxes created next to the float are *shortened* as necessary to make room for the margin box of the float.
  
  A line box is next to a float when there exists a vertical position that satisfies all of theses four conditions:
  - at or below the top of the line box
  - at or above the bottom of the line box
  - below the top margin edge of the float, and
  - above the bottom margin edge of the float

  Note: this means that *floats with zero outer height or negative outer height do not shorten line boxes*.
  
  If a shortened line box is too small to contain any content, then the line box is shifted downward (and its width recomputed) until either some content fits or there are no more floats presents. Any content in the current line before a float box is `reflowed` in the same line on the other side of the float. In other words, if inline-level boxes are placed on the line before a left float is encountered that fits in the remaining line box space, the left float is placed on that line, aligned with the top of the line, and then the inline-level boxes already on the line are moved accordingly to the right of the float (the right being the other side of the left float) and vice versa for rtl and right float.
  
  The border box of a table, a block-level replaced element, or an element in the normal flow that establishes a new `block formatting context`[p.138] (such as an element with 'overflow' other than 'visible') must not overlap the margin box of any floats in the same block formatting context as the element itself. If necessary, implementations should clear the said element by placing it below any preceding floats, but may place it adjacent to such floats if there is sufficient space. They may even make the border box of said element narrower than defined by `section 10.3.3`[p.176]. CSS2 does not define when a UA may put said element next to the float or by how much said element `may become narrower`.
  Example(s):
  **Example**. In the following document fragment, the containing block is too narrow to contain the content next to the float, so the content gets moved to below the floats where it is aligned in the line box according to the text-align property.
  
```css
p {width: 10em; border: solid aqua;}
span {float:left;width:5em;height:5em;border:solid blue;}
```
```html
<p>
  <span></span>
  Supercalifragilisticexpialidocious
</p>
```

[Figure at page 143]

Several floats may be adjacent, and this model also applies to adjacent floats in the same line.

  Example(s):
  The following rule floats all `<img>` boxes with class="icon" to the left( and sets the left margin to '0'):
  
