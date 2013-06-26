Build Path
==========
After add jar to build path, you should also check corresponding item in `Order and Export` tab, otherwise you will get an `NoClassDefFoundError` at runtime

Custom ListView
===============
when custom ListView contains some focusable child, `onItemClick` would not be called.
set `android:descendantFocusability="blocksDescendants"` to root view of ListView item will fix it.
or `listView.setDescendantFocusability(ViewGroup.FOCUS_BLOCK_DESCENDANTS);`

[see also](http://www.cnblogs.com/ycmoon/archive/2011/04/25/2027728.html)
