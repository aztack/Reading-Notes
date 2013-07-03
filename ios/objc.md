> 只有那写C语言没有的部分才有那些怪异的语法。而这种怪异语法的标志就是“@，[],:”。
因为这几个符号在C语言中没有被用到或者容易被赋予更多的含义。
你可以抛弃Objc为C语言增加的语法，而只使用C语言语法。这时你可以认为当前环境只是为C语言增加了一对NS开头的数据结构。

> 下面的目标是，正确理解Objc新增的语法，并能实现类似Ruby的元编程。
我暂且认为“能熟练使用元编程”是“掌握这门语言的标志”。下面从Ruby入手，列举一些元编程实例，然后寻找Objc的实现方法、对应实现。

从动态创建类开始
================

ruby:
```ruby
  eval("String").new("hello") == "hello"
  #another way
  Object.const_get("String").new("hello") == "hello"
  
  String.class != "hello".class
  String == "hello".class
```

objc:
```Objective-C
  id yumi = [[Person alloc] initWithName:@"yumi" age:28];
  [yumi greeting:@"aztack" at:@"morning"];
  
  id me = [[NSClassFromString(@"Person") alloc] initWithName:@"aztack" age:30];
  [me greeting:@"yumi" at:@"night"];
  
  if([yumi class] == [me class]){
    printf("Of the same type!");
  }
  
  if([Person class] == [me class]){
    printf("YES!");
  }
}
```

类作为变量
==========

ruby:
```ruby
  StringAlias = String
  StringAlias.new("hello") == "hello"
```

objc:
```objective-c
  Class StringAlias = [String class];
  id hello = [[StringAlias alloc] initWithString:@"hello"];
  NSLog(@"%b",[hello isEqual:@"hello"]); // output 1
```

> ruby中，类是一个常量，这个常量代表类本身。变量的class属性代表变量所属的类，就是对应的那个常量。
而在objc中，类的class属性代表它自己。实例的class属性代表它所属的类。这个class同时也是Class的实例。
可以通过变量传递。可以调用其alloc函数（对应ruby中的new）来创建对应的实例。



