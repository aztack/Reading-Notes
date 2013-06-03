[Introduction to Range](http://www.quirksmode.org/dom/range_intro.html)
[Interface Range (introduced in DOM Level 2)](http://www.w3.org/TR/DOM-Level-2-Traversal-Range/ranges.html#Level-2-Range-idl)

Introduction to Range
=====================

show page contents
See also the Range Compatibility Table.
This page gives an introduction to the Range objects. Using these, you can select any part of an HTML document and do something with this information. The most common Range is a user selection.
This page concentrates on getting the user selection and converting this selection to a W3C Range or Microsoft Text Range object, although we'll treat the programmatic creation of Range objects, too.

What is a Range?
----------------
A Range is an arbitrary part of the content of an HTML document. A Range can start and end at any point, and the start and end point may even be the same (in which case you have an empty Range). The most common Range is a user text selection. As soon as the user has selected (part of) the text on an HTML page, you can convert this selection to a Range. However, you can also define Ranges programmatically.
Let's take this bit of HTML from my linklog as an example. Suppose the user selects a bit of text:

什么是Range?
------------
Range是HTML文档内容的任意一部分。Range可以在任何点开始，在任何点结束。起始点和结束点可以是相同的（此时得到一个空Range）。最常见的Range是`用户的选区`。当用户选择了HTML页面中的文字，你可以将这个选区转换成一个Range。当然，你也可以通过代码来定义一个Range。
