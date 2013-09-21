String & Symbol
===============
> - Symbol array literal
- String#b 
- String#lines, #chars, etc return an Array


Array & Hash
============
> - Hash#default_proc= now accepts nil
- #to_h
- #bsearch
- Array#values_at returns nil for each value that is out-of-range
- Array#shuffle! and #sample

Class & Module & Method & Proc
=============================

> - Keyword arguments
- Module#refine & Kernel#using
- Unbound methods ?
- Enumerable#lazy
- Lazy Enumerator#size and Range#size
- const_get understands namespaces
- Protected methods treated like private for #respond_to?
- #inspect no longer calls #to_s
- Top level define_method
- Proc#== and #eql? removed

Keyword arguments
-----------------


Module#refine & Kernel#using
----------------------------

> You can think `Refinements` as limited, more safe monkey-patching.

```ruby
module StringRefinement
  refine String do
    def say; puts "#{self}!"; end
  end
  'hello'.say
end
#=> hello!

'world'.say
#=> NoMethodError: undefined method `say' for "world":String

```

Using `using` in module

```ruby
class StringSayHello
  using StringRefinement
  def hello
    'hello'.say
  end
end

StringSayHello.new.hello
#=> hello!
```

Using `using` in lambda or Proc

```ruby
->{
  using StringRefinement
  "hello".say
}.call
#=> hello!
```

Module#prepend
--------------

```ruby
module M
	def fn
		puts "M#fn"
		super
	end
end

class A
	def fn
		puts "A#fn"
	end
end

class B

	def fn
		puts "B#fn"
	end
end

class AChild < A
	include M
	def fn
		puts "AChild#fn"
		super
	end
end

class BChild < B
	prepend M
	def fn
		puts "BChild#fn"
		super
	end
end

AChild.new.fn
puts AChild.ancestors.join(">")

BChild.new.fn
puts BChild.ancestors.join(">")

#=>	AChild#fn
#	M#fn
#	A#fn
#	AChild>M>A>Object>Kernel>BasicObject

#=>	M#fn
#	BChild#fn
#	B#fn
#	M>BChild>B>Object>Kernel>BasicObject
```

`Module#prepend` works just like `Module#include`, but it inserts the module in to the inheritance chain as if it were a subclass rather than a superclass.
So method `M#fn` is called before `BChild#fn`.

bind UnboundedMethod to object
------------------------------

```ruby
module Foo
  def bar
    "bar"
  end
end

bar_method = Foo.instance_method(:bar)
#=> #<UnboundMethod: Bar#bar>
bar_method.bind(Object.new).call
#=> "bar"
```

```ruby
class Foo
  def initialize(name)
    @name = name
  end
	
  def fn
    puts "hello #{@name}!"
  end
end

fn = Foo.instance_method(:fn)
fn.bind(Object.new).call
#=> bind argument must be an instance of Foo

fn.bind(Foo.new("world")).call
#=> hello world!
```

Enumerable#lazy
-----------------

`Enumerable#lazy` will return a lazy enumerator, which doesn’t perform any calculations untill it is forced to.

Without calling `#lazy`, `e*10` is evaluated on every element of `(1..10000000)` thus takes more time:

```ruby
puts (1..10000000).map{|e|e*10}.take(10).to_a.join(",")
```

> <pre>10,20,30,40,50,60,70,80,90,100
real	0m1.417s
user	0m1.372s
sys	0m0.036s</pre>

With `#lazy` called on `(1..10000000)`, only first 10 element are calculated:

```ruby
puts (1..10000000).lazy.map{|e|e*10}.take(10).to_a.join(",")
```

> <pre>10,20,30,40,50,60,70,80,90,100
real	0m0.033s
user	0m0.027s
sys	0m0.005s</pre>

- Lazy Enumerator#size and Range#size
- const_get understands namespaces
- Protected methods treated like private for #respond_to?
- #inspect no longer calls #to_s
- Top level define_method
- Proc#== and #eql? removed


Miscellaneous
=============

>- Default UTF-8 encoding
- Time#to_s change encoding to US-ASCII
- warn supports multiple parameters
- LoadError#path
- OpenStruct can act like a hash

Removed
=======
>- CSV::dump and ::load removed
- Iconv removed
- Syck removed

