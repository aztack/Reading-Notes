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

```html
<h4 id="entry1196"><a
  href="http://radar.oreilly.com/archives/2007/03/call_for_a_blog_1.html"
	class="external">Call for a Blogger's Code of Conduct</a></h4>

<p>Tim O'Reilly |<=calls for a Blogger Code of Cond<=|uct. His proposals are:</p>

<ol>
	<li>Take responsibility not just for your own words, but for the
		comments you allow on your blog.</li>
	<li>Label your tolerance level for abusive comments.</li>
	<li>Consider eliminating anonymous comments.</li>
</ol>
```

You can convert this user selection to a Range object (details below), which contains the bit of text the user has selected. Through the Range object you can find the start and end point of this Range, and if you so desire you can copy or delete it, or substitute it by another text, or even a bit of HTML.

This is about the simplest Range object you can get, because it only contains text. Let's move to a more complicated example, where the user-generated Range spans several HTML elements:

你可以将用户选择的部分转换成一个Range对象，其中包含了用户选择的文字。通过这个Range对象，你可以找到Range的起点和终点。你还可以拷贝、删除、用另一段文字甚至是HTML替换它。
这是你可以获得的最简单的Range，因为它只包含文字。下面我们看一些更复杂的例子。其中用户产生的Range设计多个HTML元素：

```html
<h4 id="entry1196"><a
  href="http://radar.oreilly.com/archives/2007/03/call_for_a_blog_1.html"
	class="external">Call for a Blogger's Code of Conduct</a></h4>

<p>Tim O'Reilly |<=calls for a Blogger Code of Conduct. His proposals are:</p>

<ol>
	<li>Take responsibility not just for your own words, but for the
		comments you allow on your blog.</li>
	<li>Label your toleran<=|ce level for abusive comments.</li>
	<li>Consider eliminating anonymous comments.</li>
</ol>
```

Again, a Range object is created, one that contains HTML. The problem is that the user selection (and thus the Range) crosses a few boundaries from one HTML element to the next. Without more action, it would look like this:

如上所示，用户选择又创建了一个包含HTML的Range对象。问题是用户选择的部分跨越了HTML元素的边界。选择的部分是：

```html
calls for a Blogger Code of Conduct. His proposals are:</p>

<ol>
  <li>Take responsibility not just for your own words, but for the
		comments you allow on your blog.</li>
	<li>Label your toleran
```

This is violently invalid HTML. Fortunately all browsers intervene: they adjust the HTML so that the snippet becomes valid:

这显然是一段不符合语法规则的HTML。幸运的是经过浏览器的干预，这段HTML被调整为：

```html
<p>calls for a Blogger Code of Conduct. His proposals are:</p>

<ol>
  <li>Take responsibility not just for your own words, but for the
		comments you allow on your blog.</li>
	<li>Label your toleran</li></ol>
```

As you see, the browsers add the minimum amount of HTML to make the Range valid. If you copy or move the Range, you copy or move this valid HTML snippet.

如你所见，浏览器增加了少量HTML标签后，使之前非法的代码合法化。如果你拷贝、移动这个Range，你实际拷贝、移动的是这个调整后的Range对象。
