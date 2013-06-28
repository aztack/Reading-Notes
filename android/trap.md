Build Path
==========
After add jar to build path, you should also check corresponding item in `Order and Export` tab, otherwise you will get an `NoClassDefFoundError` at runtime

Custom ListView
===============
when custom ListView contains some focusable child, `onItemClick` would not be called.
set `android:descendantFocusability="blocksDescendants"` to root view of ListView item will fix it.
or `listView.setDescendantFocusability(ViewGroup.FOCUS_BLOCK_DESCENDANTS);`

[see also](http://www.cnblogs.com/ycmoon/archive/2011/04/25/2027728.html)


android.os.NetworkOnMainThreadException
=======================================
[在4.0之后在主线程里面执行Http请求都会报这个错](http://www.android100.org/html/201302/15/1500.html)

在发起Http请求的Activity里面的onCreate函数里面添加如下代码

```java
StrictMode.setThreadPolicy(
  new StrictMode.ThreadPolicy.Builder()
    .detectDiskReads()
    .detectDiskWrites()
    .detectNetwork()
    .penaltyLog()
    .build());

StrictMode.setVmPolicy(
  new StrictMode.VmPolicy.Builder()
    .detectLeakedSqlLiteObjects()
    .detectLeakedClosableObjects()
    .penaltyLog()
    .penaltyDeath()
    .build());
```
