9.1 Introduction to the visual formatting model
-----------------------------------------------

This chapter and the next describe the visual formatting model: how user agents
process the document tree [p. 45] for visual media [p. 107] .

In the visual formatting model, each element in the document tree generates zero
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

9.1.1 The Viewport
------------------

User agents for continuous media [p. 110] generally offer users a viewport (a window
or other viewing area on the screen) through which users consult a document. User
agents may change the document’s layout when the viewport is resized (see the
initial containing block [p. 171] ).
When the viewport is smaller than the area of the canvas on which the document
is rendered, the user agent should offer a scrolling mechanism. There is at most one
viewport per canvas [p. 40] , but user agents may render to more than one canvas
(i.e., provide different views of the same document).

9.1.1 视口
----------

连续媒介的用户代理通常会为用户提供一个叫做视口的区域（一个窗口或者屏幕的一块区域），用户用来查看文档。
当视口的尺寸发生变化的时候用户代理（可能）会改变文档的布局。
当视口的尺寸比渲染文档的画布尺寸小的时候，用户代理应该提供滚动机制（让用户可以查看到整个文档）。
每个画布最多只能对应一个视口，但是，用户代理可以为同一个文档渲染出多个画布（比如同个文档的不同视图）。

9.1.2 Containing blocks
-----------------------

In CSS 2.1, many box positions and sizes are calculated with respect to the edges of
a rectangular box called a containing block. In general, generated boxes act as
containing blocks for descendant boxes; we say that a box "establishes" the containing
block for its descendants. The phrase "a box’s containing block" means "the
containing block in which the box lives," not the one it generates.
Each box is given a position with respect to its containing block, but it is not
confined by this containing block; it may overflow [p. 195] .
The details [p. 171] of how a containing block’s dimensions are calculated are
described in the next chapter [p. 171] .

9.1.2 包含块
------------
在CSS2.1中，许多Box的定位，尺寸的计算都是与一个正方形的叫做包含块的边沿有关的。
通常，Box的父Box就是它的包含块；换句话说就是，父Box为其后代Box“创建”了包含块。
如果提到一个“Box”的包含块，指的就是其父Box为其“创建”的那个包含块，而不是指它为它的后代创建的包含块。
每个Box都被定位在它的包含块中，但并不是说它被限制在包含框内,它有可能从包含块中“溢出”。

9.2 Controlling box generation
------------------------------

The following sections describe the types of boxes that may be generated in
CSS 2.1. A box’s type affects, in part, its behavior in the visual formatting model. The
’display’ property, described below, specifies a box’s type.

9.2 控制Box的生成
----------------
下面几节描述了CSS2.1中可能的几种Box类型。Box的类型会一定程度上影响它在可视格式化中的行为。
你可以通过display属性设置一个Box的类型。

9.2.1 Block-level elements and block boxes
------------------------------------------

Block-level elements are those elements of the source document that are formatted
visually as blocks (e.g., paragraphs). The following values of the ’display’ property
make an element block-level: ’block’, ’list-item’, and ’table’.

Block-level boxes are boxes that participate in a block formatting context. [p. 138]
Each block-level element generates a principal block-level box that contains descendant
boxes and generated content and is also the box involved in any positioning
scheme.Some block-level elements may generate additional boxes in addition to the
principal box: ’list-item’ elements. These additional boxes are placed with respect to
the principal box. Except for table boxes, which are described in a later chapter, and replaced
elements, a block-level box is also a block container box.

A block container box either contains only block-level boxes or establishes an inline formatting context and
thus contains only inline-level boxes. 

Not all block container boxes are block-level
boxes: non-replaced inline blocks and non-replaced table cells are block containers
but not block-level boxes. Block-level boxes that are also block containers are called block boxes. 

The three terms "block-level box," "block container box," and "block box" are
sometimes abbreviated as "block" where unambiguous. 

9.2.1 块级元素和块Box
“块级元素”是指源文档中被格式化为“可见块”的元素（比如,段落&lt;p&gt;)。元素的display被设置为
'block','list-item','table'时，该元素就成为了块级元素。

“块级Box”参与“块级格式化(环境)”的Box。
每个块级元素都会生成一个“主块级Box”，其中包含这个元素的后代的Box和这个元素生成的内容。同时，
这个“主块级Box”也参与元素的定位。一些块级元素在生成“主Box”的基础上，还会生成“额外的Box”：
比如'list-item'元素。这些额外的Box会根据“主Box”进行定位。除了table生成的Box和replaced elements &?
,“块级Box”同时也是一个“块包含Box”。“块包含Box”要么只包含“块级Box”，要么建立一个“行内格式化环境”并
只包含“行内Box”。并不是所有的“块包含Box”都是“块级Box”：non-replaced inline blocks和non-replaced
table cells都是“块包含Box”，但不是“块级Box”。如果“块级Box”同时也是“块包含Box”，称作“块Box”&?
目前有三个Box属于需要区分：“块级Box”，“块包含Box”和“块Box”。如果没有歧义，都简称为“块”。

块级元素 --生成--> 主块级Box [+ 额外Box] --同时也是--> 块包含Box
                  块级Box              <--不一定是-- 块包含Box
                  块级Box <----> 包含块 => 叫做"块Box"