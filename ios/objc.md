[Clang Language Extensions](http://clang.llvm.org/docs/LanguageExtensions.html)

Objective-C 为 ANSI C 添加了下述语法和功能
==========================================
- 定义新的类
- 类和实例方法
- 方法调用（称为发消息）
- 属性声明（以及通过它们自动合成存取方法）
- 静态和动态类型化
- 块 (block)，已封装的、可在任何时候执行的多段代码
- 基本语言的扩展，例如协议和类别

> - 在定义实例方法时，类型都用括号括起来
- “@”开头的，比如@interface，被称为指令

[How are categories implemented in Objective C?](http://stackoverflow.com/questions/7026259/how-are-categories-implemented-in-objective-c)
=====================
可以想象，Category的实现肯定是在方法列表结构(类似vtable)上做文章。
下面是SO上的一个回答：

> Each class has a list of methods, when doing a method lookup the method list is scanned from beginning to end. If no method is found the superclass' list is scanned, etc. until reaching the root class. Found methods are cached for faster lookup next time.
When loading a category onto a class the `categories method list is prepended to the existing list`, and caches are flushed. Since the list is searched sequentially this means that the categories method will be found before the original method on next search.
This setup of categories is done lazily, from static data, when the class is first accessed. And can be re-done if loading a bundle with executable code.
In short it is a bit more low level than `class_replaceMethod()`.


从上面回复中可以印证，Category就是将其中的函数增加到vtable的前部。本质和Ruby、JavaScript中的method lookup是一样的。


[Difference between Category and Class Extension?](http://stackoverflow.com/questions/3499704/difference-between-category-and-class-extension)
===

> A category is a way to add methods to existing classes. They usually reside in files called "Class+CategoryName.h", like "NSView+CustomAdditions.h" (and .m, of course).
A class extension is a category, except for 2 main differences:

- 1. The category has no name.
- 2. The implementation of the extension must be in the main @implementation block of the file.

It's quite common to see a class extension at the top of a .m file declaring more methods on the class, that are then implemented below in the main @implementation section of the class. This is a way to declare "pseudo-private" methods (pseudo-private in that they're not really private, just not externally exposed).

[Objective-C Runtime Reference](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/ObjCRuntimeRef/Reference/reference.html#//apple_ref/c/func/class_copyMethodList)
===

只有那些C语言没有的部分才有那些怪异的语法。而这种怪异语法的标志就是“@，[],:”。
因为这几个符号在C语言中没有被用到或者容易被赋予更多的含义。

下面的目标是，正确理解Objc新增的语法，并能实现类似Ruby的元编程。
我暂且认为“能熟练使用元编程、函数式编程（如果可以的话）”是“掌握这门语言的标志”。下面从Ruby入手，列举一些元编程实例，然后寻找Objc的实现方法、对应实现。

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


不定参数
========

ruby:
```ruby
def f(*args)
  args.each{|e|puts e}
end
```

objc:
```objective-c
//args is array of ids
void log_each(NSArray* args){
  for(int i = 0; i < [args count]; ++i){
    id item = [args objectAtIndex:i];
    NSLog(@"%@",item);
  }
}

log_each([NSArray arrayWithObjects:@"hello",@"world", [NSNumber numberWithInt:42], nil]);

void log_each2(id first, ...){
    va_list arguments;
    id item;
    if (first != nil) {
        NSLog(@"%@",first);//handle first argument
        va_start(arguments, first);
        while ((item = va_arg(arguments, id))) {
            NSLog(@"%@",item);
        }
        va_end(arguments);
    }
}

log_each2(@"hello", @"world", [NSNumber numberWithInt:42], nil);
```

[Objective-C中的字面量](http://clang.llvm.org/docs/ObjectiveCLiterals.html)
-----------------------

Number:
```objective-c
// character literals.
  NSNumber *theLetterZ = @'Z';          // equivalent to [NSNumber numberWithChar:'Z']

  // integral literals.
  NSNumber *fortyTwo = @42;             // equivalent to [NSNumber numberWithInt:42]
  NSNumber *fortyTwoUnsigned = @42U;    // equivalent to [NSNumber numberWithUnsignedInt:42U]
  NSNumber *fortyTwoLong = @42L;        // equivalent to [NSNumber numberWithLong:42L]
  NSNumber *fortyTwoLongLong = @42LL;   // equivalent to [NSNumber numberWithLongLong:42LL]

  // floating point literals.
  NSNumber *piFloat = @3.141592654F;    // equivalent to [NSNumber numberWithFloat:3.141592654F]
  NSNumber *piDouble = @3.1415926535;   // equivalent to [NSNumber numberWithDouble:3.1415926535]

  // BOOL literals.
  NSNumber *yesNumber = @YES;           // equivalent to [NSNumber numberWithBool:YES]
  NSNumber *noNumber = @NO;             // equivalent to [NSNumber numberWithBool:NO]

#ifdef __cplusplus
  NSNumber *trueNumber = @true;         // equivalent to [NSNumber numberWithBool:(BOOL)true]
  NSNumber *falseNumber = @false;       // equivalent to [NSNumber numberWithBool:(BOOL)false]
#endif
```

String:
```objective-c
NSString* s = @"hello";
```

Dictionary:
```objective-c
NSDictionary *dictionary = @{
    @"name" : NSUserName(),
    @"date" : [NSDate date],
    @"processInfo" : [NSProcessInfo processInfo]
};
```

Array:
```objective-c
NSArray *array = @[ @"Hello", NSApp, @42];
```
