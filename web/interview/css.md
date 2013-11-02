画出盒式模型
============
[http://www.w3.org/TR/CSS2/box.html](http://www.w3.org/TR/CSS2/box.html)

![Box Model](http://www.w3.org/TR/CSS2/images/boxdim.png)

W3C和IE对盒模型不同的解释
----
![The difference in how width is interpreted between the W3C and Internet Explorer box models](http://upload.wikimedia.org/wikipedia/commons/6/64/W3C_and_Internet_Explorer_box_models.svg)

[来源]([http://en.wikipedia.org/wiki/Internet_Explorer_box_model_bug)

助记:

![助记图](box-model.png)

- IE5.5以及以前的版本的IE使用IE盒模型。IE6在standards compliant mode会使用W3C的盒模型
- css3引入了控制盒模型的属性：`box-sizing = [border-box|content-box|padding-box|inherit]`


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

[](http://www.w3.org/TR/CSS21/tables.html#table-display)


position有哪些可选值
==================

`position : [static|absolute|relative|fixed|inherit]`

注意：float不是position的可取值，而是一个css属性

float有哪些可选值
=================

`float : [left|right]`
