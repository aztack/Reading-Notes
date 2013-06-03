参考资料：
- [Visual formatting model](http://www.w3.org/TR/CSS21/visuren.html)
- [Formatting Concepts](http://reference.sitepoint.com/css/formattingcontext)

首先需要明确的知识点：

- 文档元素生成的`盒`，即Box。`盒`是css布局的对象（target）和基本单位
- `盒`分为`块级` (block level)和`行内` (inline)2种。
- `盒`内部会生成一个看不见的`格式化上下文`。这个`格式化上下文`会控制`盒`内部如何布局。
`格式化上下文`不限于`块级格式化上下文`和`行内格式化上下文`两种，还有`table格式化上下文`，`grid格式化上下文`，`flex格式化上下文`。
以后随着标准的发展可能还会有新的格式化上下文出现。但是，`盒`只有block和inline两种。
- `盒`+`格式化上下文`，作用于其包含的`盒`，实现布局。
- HTML元素有默认的display属性，决定了其默认的是块级元素还是行内元素。可以通过修改display属性来改变。`display`为`none`的元素不产生`盒`
- `盒`产生的`格式化上下文`会受到display、float、position的影响：比如，position为absolute、设置了float的属性的元素都会创建新的`块级格式化上下文`

`非替换的元素`和`替换了的元素`
- Non-replaced elements: 大多数HTML元素都是非替换的，包括起始标签和结束标签，中间的内容就是最终显示的内容。没有被外部其他内容`替换`
- Replaced elements: 典型的`替换了的`的元素有`<img>`,`<input>`，`<object>`,`<button>`,`<select>`，他们没有结束标签。它们显示的内容是从外部加载的。

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

9.2 控制Box的生成
----------------
下面几节描述了CSS2.1中可能的几种Box类型。Box的类型会一定程度上影响它在可视格式化中的行为。
你可以通过display属性设置一个Box的类型。

> 9.2.1 Block-level elements and block boxes
> ------------------------------------------

> Block-level elements are those elements of the source document that are formatted visually as blocks (e.g., paragraphs). The following values of the ’display’ property make an element block-level: ’block’, ’list-item’, and ’table’.

> *Block-level boxes are boxes that participate in a block formatting context*. [p. 138] Each block-level element generates a principal block-level box that contains descendant boxes and generated content and is also the box involved in any positioning scheme.Some block-level elements may generate additional boxes in addition to the
principal box: ’list-item’ elements. These additional boxes are placed with respect to the principal box. Except for table boxes, which are described in a later chapter, and replaced elements, a block-level box is also a block container box. 

> A block container box either contains only block-level boxes or establishes an inline formatting context and thus contains only inline-level boxes. 

> *Not all block container boxes are block-level boxes*: non-replaced inline blocks and non-replaced table cells are block containers but not block-level boxes. Block-level boxes that are also block containers are called block boxes. 

> The three terms "block-level box," "block container box," and "block box" are sometimes abbreviated as "block" where unambiguous. 

9.2.1 块级元素和块Box
---------------------

“块级元素”是指源文档中被"绘制”成“块”的元素（比如,段落`<p>`;)。元素的display被设置为
'block','list-item','table'时，该元素就成为了块级元素。

> 下面这段翻译中的box相关名词相当‘混乱’，得结合英文读好几遍才好理解...

“块级Box”参与“块级格式化(环境)”。
每个块级元素都会生成一个“主块级Box”，其中包含这个元素的后代的Box和这个元素生成的内容。同时，
这个“主块级Box”也参与元素的定位。一些块级元素在生成“主Box”的基础上，还会生成“额外的Box”：
比如'list-item'元素。这些额外的Box会根据“主Box”进行定位。除了table生成的Box和replaced elements &?
,“块级Box”同时也是一个“块包含Box”。“块包含Box”要么只包含“块级Box”，要么建立一个“行内格式化环境”并
只包含“行内Box”。并不是所有的“块包含Box”都是“块级Box”：non-replaced inline blocks和non-replaced
table cells都是“块包含Box”，但不是“块级Box”。如果“块级Box”同时也是“块包含Box”，称作“块Box”&?
目前有三个Box属于需要区分：“块级Box”，“块包含Box”和“块Box”。如果没有歧义，都简称为“块”。

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

  An inline box is one that is both inline-level and whose contents participate in its containing inline formatting context. A non-replaced element with a `display` value of `inline` generates an inline box.

9.2.2 行级元素和行盒
--------------------

