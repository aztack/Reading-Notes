String & Symbol
===============
> - Symbol array literal
- String#b & Range#b
- String#lines, #chars, etc return an Array

Symbol array literal
--------------------

```ruby
%i{hello world !}   #=> [:an, :array, :of, :symbols]
#=> [:hello, :world, :!]

questionmark = "?"
%I<hello world#{questionmark}>
#=> [:hello, :world?]
```

String#b & Range#b
------------------

You can use this method in two use cases: a find-minimum mode and a find-any mode. In either case, the elements of the array must be monotone (or sorted) with respect to the block.

In find-minimum mode (this is a good choice for typical use case), the block must return true or false, and there must be an index i (0 <= i <= ary.size) so that:

the block returns false for any element whose index is less than i, and

the block returns true for any element whose index is greater than or equal to i.

This method returns the i-th element. If i is equal to ary.size, it returns nil.

```ruby
ary = [0, 4, 7, 10, 12]
ary.bsearch {|x| x >=   4 } #=> 4
ary.bsearch {|x| x >=   6 } #=> 7
ary.bsearch {|x| x >=  -1 } #=> 0
ary.bsearch {|x| x >= 100 } #=> nil
```

In find-any mode (this behaves like libc’s bsearch(3)), the block must return a number, and there must be two indices i and j (0 <= i <= j <= ary.size) so that:

the block returns a positive number for ary if 0 <= k < i,

the block returns zero for ary if i <= k < j, and

the block returns a negative number for ary if j <= k < ary.size.

Under this condition, this method returns any element whose index is within i…j. If i is equal to j (i.e., there is no element that satisfies the block), this method returns nil.

```ruby
ary = [0, 4, 7, 10, 12]
# try to find v such that 4 <= v < 8
ary.bsearch {|x| 1 - x / 4 } #=> 4 or 7
# try to find v such that 8 <= v < 10
ary.bsearch {|x| 4 - x / 2 } #=> nil
```

You must not mix the two modes at a time; the block must always return either true/false, or always return a number. It is undefined which value is actually picked up at each iteration.

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

