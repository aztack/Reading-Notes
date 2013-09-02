Useful resources from StackOverflow:
======
android:
- [background image not repeating in android layout](http://stackoverflow.com/questions/4077487/background-image-not-repeating-in-android-layout)
- [How to align Button by center and make offset](http://stackoverflow.com/questions/13501891/how-to-align-button-by-center-and-make-offset)
- [Layout params of loaded view are ignored](http://stackoverflow.com/questions/5288435/layout-params-of-loaded-view-are-ignored)
- [Android: Vertical alignment for multi line EditText (Text area)](http://stackoverflow.com/questions/2446544/android-vertical-alignment-for-multi-line-edittext-text-area)
- [★Custom XML Attributes For Your Custom Android Widgets](http://kevindion.com/2011/01/custom-xml-attributes-for-android-widgets/)
- [FrameLayout margin not working](http://stackoverflow.com/questions/5401952/framelayout-margin-not-working)
- [Background ListView becomes black when scrolling](http://stackoverflow.com/questions/2833057/background-listview-becomes-black-when-scrolling)
- [How can I put a ListView into a ScrollView without it collapsing?](http://stackoverflow.com/questions/3495890/how-can-i-put-a-listview-into-a-scrollview-without-it-collapsing)


Build Path
==========
After add jar to build path, you should also check corresponding item in `Order and Export` tab, otherwise you will get an `NoClassDefFoundError` at runtime

Custom ListView
===============
when custom ListView contains some focusable child, `onItemClick` would not be called.
set `android:descendantFocusability="blocksDescendants"` to root view of ListView item will fix it.
or `listView.setDescendantFocusability(ViewGroup.FOCUS_BLOCK_DESCENDANTS);`

[see also](http://www.cnblogs.com/ycmoon/archive/2011/04/25/2027728.html)

自定义ListView的Item之间有黑线
==============================
将divider的颜色设置为和背景一样(设置dividerHeight为0，貌似不管用)

```xml
    <com.comapny.project.ListViewExt
        android:id="@+id/question_detail_list"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_below="@id/nav_bar"
        android:layout_gravity="top"
        android:layout_marginLeft="10dp"
        android:layout_marginRight="10dp"
        android:cacheColorHint="@null"
        android:fadingEdge="none"
        android:dividerHeight="0dp"
        android:divider="#ffffff"
        android:listSelector="@android:color/transparent" >
    </com.comapny.project.ListViewExt>
```


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


模拟JavaScript的setTimeout
==========================

```java
	
	public interface Callback0{
		public void invoke();
	}
	
	public static void setTimeout(final CallbackUtils.Callback0 callback, int delayMillis){
		Handler handler = new Handler();
		handler.postDelayed(new Runnable() {
			@Override
			public void run() {
				try {
					callback.invoke();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}, delayMillis);
	}
```
