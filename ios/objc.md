Objective-C 为 ANSI C 添加了下述语法和功能
==========================================
- 定义新的类
- 类和实例方法
- 方法调用（称为发消息）
- 属性声明（以及通过它们自动合成存取方法）
- 静态和动态类型化
- 块 (block)，已封装的、可在任何时候执行的多段代码
- 基本语言的扩展，例如协议和类别

- 在定义实例方法时，类型都用括号括起来
- “@”开头的，比如@interface，被称为指令

- [Objective-C Runtime Reference](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/ObjCRuntimeRef/Reference/reference.html#//apple_ref/c/func/class_copyMethodList)

只有那些C语言没有的部分才有那些怪异的语法。而这种怪异语法的标志就是“@，[],:”。
因为这几个符号在C语言中没有被用到或者容易被赋予更多的含义。

下面的目标是，正确理解Objc新增的语法，并能实现类似Ruby的元编程。
我暂且认为“能熟练使用元编程”是“掌握这门语言的标志”。下面从Ruby入手，列举一些元编程实例，然后寻找Objc的实现方法、对应实现。

在你的代码前面需要加上：

```objective-c
#import <objc/runtime.h>
#import <objc/message.h>
```

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

得到方法对象并调用
==================

ruby：obj.method(:name)
```ruby
  h = "hello"
  m = h.method(:capitalize)
  m.call == "Hello"
  h == "hello"
```

objc: [obj methodForSelector:sel]
```objective-c
  NSString* h = @"hello";
  SEL sel = @selector(capitalizedString);
  IMP m = [h methodForSelector:sel];
  NSLog(@"%@,%@",m(h,sel),h);//Hello,hello
```

ruby的obj.method(:name)发放返回:name对应的Method对象，调用其call相当于在obj上调用该方法。
objc的`methodForSelector`返回一个函数指针，所以可以用函数调用的语法直接调用：第一个参数是对象指针，第二个参数是selector。之后的参数是该函数对应的参数。

获取实例的方法列表
==================
ruby:
```ruby
  "hello".class.instance_methods
```
objc:
```objective-c
  int unsigned numMethods;
  Method *methods = class_copyMethodList([@"hello" class], &numMethods);
  for (int i = 0; i < numMethods; i++) {
      NSLog(@"%@", NSStringFromSelector(method_getName(methods[i])));
  }
```

为已有类增加方法
================

[Customizing Existing Classes](http://developer.apple.com/library/ios/#documentation/cocoa/conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html) 

ruby:
```ruby
class String
  def cap
    self.capitalize
  end
end
```

objc:
```objective-c
@interface NSString (Capitalization)
-(NSString*) cap;
@end

@implementation NSString(Capitalization)
-(NSString*) cap{
    return @"hacked";
}
@end

NSLog(@"%@",[@"hello" cap]); //output "hacked"
```

替换已有实例方法
================
ruby: method alias
```ruby
class String
  alias bakcup_cap caplitalize
  def capitalize
    "hacked"
  end
end
```

objc:
[Method Swizzle](http://stackoverflow.com/questions/1637604/method-swizzle-on-iphone-device/1638940#1638940)

```objective-c
void Swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
      class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
      method_exchangeImplementations(origMethod, newMethod);
    }
}

Swizzle([NSString class], @selector(capitalizedString), @selector(_cap));

NSLog(@"%@",[@"hello" capitalizedString]); //output "hacked"
NSLog(@"%@",[@"hello" cap]); //output "Hello"
```