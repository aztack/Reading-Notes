copy from : https://github.com/yanxyz/code-guide/blob/zh/README.md

# HTML and CSS code guide 

HTML与CSS代码规范

Standards for developing flexible, durable, and sustainable HTML and CSS.

为了开发灵活、持久及可持续的HTML与CSS而制定这些规则。



----------



## Table of contents 目录

* [Golden rule 黄金规则](#golden-rule)
* [HTML](#html)
  * [Syntax 语法](#html-syntax)
  * [HTML5 doctype](#html5-doctype)
  * [Pragmatism over semantics 实用优于语义](#pragmatism-over-semantics)
  * [Attribute order 属性顺序](#attribute-order)
  * [JavaScript generated markup 由js生成的标记](#javascript-generated markup)
* [CSS](#css)
  * [CSS syntax 语法](#css-syntax)
  * [Declaration order 声明顺序](#declaration-order)
  * [Formatting exceptions 例外格式](#formatting-exceptions)
    * [Prefixed properties 有前缀的属性](#prefixed-properties)
    * [Rules with single declarations 单个声明的规则](#rules-with-single-declarations)
  * [Human readable 便于人类阅读](#human-readable)
    * [Comments 注释](#comments)
    * [Classes 类](#classes)
    * [Selectors 选择器](#selectors)
  * [Organization 组织](#organization)
* [Writing copy 书写](#copy)
  * [Sentence case 句子大小写](#sentence-case)



----------



## Golden rule 

黄金规则

> All code in any code base should look like a single person typed it, no matter how many people contributed.

> 不管是多少人协同开发，代码都应该看起来像是一个人写的

This means strictly enforcing these agreed upon guidelines at all times. For additions or contributions, please [file an issue on GitHub](https://github.com/mdo/code-guide).

这意味着时刻要严格实行这些规则。

----------



## HTML


### HTML syntax 

HTML语法

* Use soft-tabs with two spaces 制表符tab占有两个空格
* Nested elements should be indented once (2 spaces) 嵌套元素缩进一次（2个空格）
* Always use double quotes, never single quotes 始终用双引号，永远不要用单引号
* Don't include a trailing slash in self-closing elements 自关闭元素不要斜杠

**Incorrect example 错误示例:**

````html
<!DOCTYPE html>
<html>
<head>
<title>Page title</title>
</head>
<body>
<img src='images/company-logo.png' alt='Company' />
<h1 class='hello-world'>Hello, world!</h1>
</body>
</html>
````

**Correct example 正确示例:**

````html
<!DOCTYPE html>
<html>
  <head>
    <title>Page title</title>
  </head>
  <body>
    <img src="images/company-logo.png" alt="Company">
    <h1 class="hello-world">Hello, world!</h1>
  </body>
</html>
````


### HTML5 doctype

Enforce standards mode in every browser possible with this simple doctype at the beginning of every HTML page.

每个HTML页面都使用这个简单的doctype，以强制所有的浏览器使用标准模式。

````html
<!DOCTYPE html>
````


### Pragmatism over semantics 

实用优于语义

Strive to maintain HTML standards and semantics, but don't sacrifice pragmatism. Use the least amount of markup with the fewest intricacies whenever possible.

努力维持HTML标准与语义，但是不要牺牲实用性。尽可能地用最少的标记，同时复杂程度最低。


### Attribute order 

属性顺序

HTML attributes should come in this particular order for easier reading of code.

为了方便地阅读代码，HTML属性应该按照这个顺序：

* class
* id
* data-*
* for|type|href

Such that your markup looks like 例如:



````html
<a class="" id="" data-modal="" href="">Example link</a>
````

### JavaScript generated markup 由js生成的标记

Writing markup in a javascript file makes the content harder to find, harder to edit, and less performant. Don't do it.

在js中书写标记，会让内容难以查找，编辑，且降低性能。不要这样。

----------



## CSS

### CSS syntax 

CSS语法

* Use soft-tabs with two spaces 制表符tab占用两个空格
* When grouping selectors, keep individual selectors to a single line 组选择器，每个选择器要单行
* Include one space before the opening brace of declaration blocks 声明块开始大括号前要有个空格
* Place closing braces of declaration blocks on a new line 声明块关闭大括号要单行
* Include one space after <code>:</code> in each property 属性之间要有个空格
* Each declaration should appear on its own line 声明不要分行
* End all declarations with a semi-colon 声明要用分号结束
* Comma-separated values should include a space after each comma 以逗号隔开的属性值，逗号后要有个空格
* Don't include spaces after commas in RGB or RGBa colors, and don't preface values with a leading zero  RGB 或 RGBa 颜色值逗号后面不要有空格，不要前导0
* Lowercase all hex values, e.g., <code>#fff</code> instead of <code>#FFF</code> hex值要全部小写
* Use shorthand hex values where available, e.g., <code>#fff</code> instead of <code>#ffffff</code> hex值可以简写时要简写
* Quote attribute values in selectors, e.g., <code>input[type="text"]</code> 选择器里的属性要用引号括起来
* Avoid specifying units for zero values, e.g., <code>margin: 0;</code> instead of <code>margin: 0px;</code> 属性值为0时不要带单位

**Incorrect example 错误示例:**

````css
.selector, .selector-secondary, .selector[type=text] {
  padding:15px;
  margin:0px 0px 15px;
  background-color:rgba(0, 0, 0, 0.5);
  box-shadow:0 1px 2px #CCC,inset 0 1px 0 #FFFFFF
}
````

**Correct example 正确示例:**

````css
.selector,
.selector-secondary,
.selector[type="text"] {
  padding: 15px;
  margin: 0 0 15px;
  background-color: rgba(0,0,0,.5);
  box-shadow: 0 1px 2px #ccc, inset 0 1px 0 #fff;
}
````

Questions on the terms used here? See the [syntax section of the Cascading Style Sheets article](http://en.wikipedia.org/wiki/Cascading_Style_Sheets#Syntax) on Wikipedia.


### Declaration order 

声明顺序

Related declarations should be grouped together, placing positioning and box-model properties closest to the top, followed by typographic and visual properties.

相关的声明应当放在一块，定位与盒模型属性放在最上面，然后是排版与视觉属性。

````css
.declaration-order {
  /* Positioning 定位*/
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 100;

  /* Box-model 盒模型*/
  display: block;
  float: right;
  width: 100px;
  height: 100px;

  /* Typography 排版*/
  font: normal 13px "Helvetica Neue", sans-serif;
  line-height: 1.5
  color: #333;
  text-align: center;

  /* Visual 视觉*/
  background-color: #f5f5f5;
  border: 1px solid #e5e5e5;
  border-radius: 3px;

  /* Misc 其它*/
  opacity: 1;
}
````

For a complete list of properties and their order, please see [Recess](http://twitter.github.com/recess).

完整的属性列表及其顺序，查看[Recess](http://twitter.github.com/recess)。

### Formatting exceptions 

例外格式

In some cases, it makes sense to deviate slightly from the default [syntax](#css-syntax).

有些情况下，可稍背离默认[语法](#css-syntax)。

#### Prefixed properties 

有前缀的属性

When using vendor prefixed properties, indent each property such that the value lines up vertically for easy multi-line editing.

当使用浏览器前缀时，为方便多行编辑像这样缩进：

````css
.selector {
  -webkit-border-radius: 3px;
     -moz-border-radius: 3px;
          border-radius: 3px;
}
````

In Textmate, use **Text &rarr; Edit Each Line in Selection** (&#8963;&#8984;A). In Sublime Text 2, use **Selection &rarr; Add Previous Line** (&#8963;&#8679;&uarr;) and **Selection &rarr;  Add Next Line** (&#8963;&#8679;&darr;).

Textmate及Sublime Text 2技巧

#### Rules with single declarations 

单个声明的规则

In instances where several rules are present with only one declaration each, consider removing new line breaks for readability and faster editing.

在每个规则只有一条声明的情况下，可考虑不空行，以方便阅读与快速编辑。


````css
.span1 { width: 60px; }
.span2 { width: 140px; }
.span3 { width: 220px; }

.sprite {
  display: inline-block;
  width: 16px;
  height: 15px;
  background-image: url(../img/sprite.png);
}
.icon           { background-position: 0 0; }
.icon-home      { background-position: 0 -20px; }
.icon-account   { background-position: 0 -40px; }
````


### Human readable 

便于人类阅读

Code is written and maintained by people. Ensure your code is descriptive, well commented, and approachable by others.

代码由人书写与维护，确保你的代码能自我说明，注释优良，容易让别人明白。

#### Comments 

注释

Great code comments convey context or purpose and should not just reiterate a component or class name.

好的注释说明上下文或目的，不应只是复述组件或类的名字。

**Bad example 坏的示例:**

````css
/* Modal header */
.modal-header {
  ...
}
````

**Good example 好的示例:**

````css
/* Wrapping element for .modal-title and .modal-close */
.modal-header {
  ...
}
````

#### Class names 

类名

* Keep classes lowercase and use dashes (not underscores or camelCase) 小写；使用短杠，不要用下划线或驼峰
* Avoid arbitrary shorthand notation 不要随意简写
* Keep classes as short and succinct as possible 尽量简短明了
* Use meaningful names; use structural or purposeful names over presentational 名字有意义，优先考虑结构或目的而不是视觉表现
* Prefix classes based on the closest parent component's base class 前缀式类名基于最近的父级元素的基础类名

**Bad example 坏的示例:**

````css
.t { ... }
.red { ... }
.header { ... }
````

**Good example 好的示例:**

````css
.tweet { ... }
.important { ... }
.tweet-header { ... }
````

#### Selectors 

选择器

* Use classes over generic element tags 优先使用类而不是元素标签
* Keep them short and limit the number of elements in each selector to three 尽量短，并且限制选择器中的元素最多为三个
* Scope classes to the closest parent when necessary (e.g., when not using prefixed classes) 类应限定在最近父级之下

**Bad example 坏的示例:**

````css
span { ... }
.page-container #stream .stream-item .tweet .tweet-header .username { ... }
.avatar { ... }
````

**Good example 好的示例:**

````css
.avatar { ... }
.tweet-header .username { ... }
.tweet .avatar { ... }
````

### Organization 

组织

* Organize sections of code by component 按组件组织代码
* Develop a consistent commenting hierarchy  一致的注释结构
* If using multiple CSS files, break them down by component 如果使用多个css文件，则按组件分开



----------



## Copy 

书写

### Sentence case 

句子大小写

Always write copy, including headings and code comments, in [sentence case](http://en.wikipedia.org/wiki/Letter_case#Usage). In other words, aside from titles and proper nouns, only the first word should be capitalized.

除了标题与专有名词外，只有第一个单词可以用大写。


----------



### Thanks 

致谢

Heavily inspired by [Idiomatic CSS](https://github.com/necolas/idiomatic-css) and the [GitHub Styleguide](http://github.com/styleguide). Made with all the love in the world by [@mdo](http://twitter.com/mdo).

[Idiomatic CSS](https://github.com/necolas/idiomatic-css) 和 [GitHub Styleguide](http://github.com/styleguide) 给了巨大启发。[@mdo](http://twitter.com/mdo)倾情制作。
