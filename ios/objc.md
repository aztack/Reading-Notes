只有那些C语言没有的部分才有那些怪异的语法。而这种怪异语法的标志就是“@，[],:”。
因为这几个符号在C语言中没有被用到或者容易被赋予更多的含义。

下面的目标是，正确理解Objc新增的语法，并能实现类似Ruby的元编程。
我暂且认为“能熟练使用元编程”是“掌握这门语言的标志”。下面从Ruby入手，列举一些元编程实例，然后寻找Objc的实现方法、对应实现。

从动态创建类实例开始
====================

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

根据参数的类型执行不同的代码
============================

ruby: 用`kind_of?`方法
```ruby
  def f(arg)
    if arg.kind_of? String
      puts "#{arg} is a String"
    elsif arg.kind_of? Integer
      puts "#{arg} plus one is #{arg + 1}"
    else
      puts "#{arg.to_s} is a object"
    end
  end
  
  f("hello")
  f(42)
  f([])
```

objc:用`isKindOfClass`方法
```objective-c
  void f(id arg){
    if([arg isKindOfClass:[NSString class]]){
      NSLog(@"%@ is a NSString",arg);
    } else if([arg isKindOfCLass:[NSNumber class]){
      NSLog(@"%@ plus one is %@",arg,[arg integerValue] +1);
    } else {
      NSLog(@"%@ is an object");
    }
  }
  f(@"hello");
  f([[NSNumber alloc] initWithInt:42]);
  f([[NSArray alloc] init]);
```

通过方法名调用对应的方法
========================

ruby: send(:method)
```ruby
  h = "hello"
  sel = :capitalize
  h.send(sel) if h.response_to? sel
```

objc: performSelector
```objective-c
  NSString *h = @"hello";
  SEL sel = NSSelectorFromString(@"capitalizedString");
  if([h respondsToSelector:sel]){
    NSLog(@"%@",[@"hello" performSelector: sel]);  
  }
```

ruby中发送消息，消息用symbol表示。objc中的消息叫做`selector`。`selector`对应的数据类型是`SEL`。
`SEL`可以通过`NSSelectorFromString`构造。构造出来的东西和任何实例方法都没有关系。可以类比ruby的symbole来理解。


