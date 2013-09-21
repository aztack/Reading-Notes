New features of Ruby 2.0.0
==========================

String & Symbol
---------------
- Symbol array literal
- String#b 
- String#lines, #chars, etc return an Array


Array&Hash
-----------
- Hash#default_proc= now accepts nil
- #to_h
- #bsearch
- Array#values_at returns nil for each value that is out-of-range
- Array#shuffle! and #sample

Class & Module & Method & Proc
------------
- Keyword arguments


- Module#refine & Kernel#using

> You can think `Refinements` as limited monkey-patching.

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

using `using` in lambda or Proc

```ruby
->{
  using StringRefinement
  "hello".say
}.call
#=> hello!
```

- Module#prepend

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

- Unbound methods ?
- Enumerable#lazy
- Lazy Enumerator#size and Range#size
- const_get understands namespaces
- Protected methods treated like private for #respond_to?
- #inspect no longer calls #to_s
- Top level define_method
- Proc#== and #eql? removed


Miscellaneous
------------
- Default UTF-8 encoding
- Time#to_s change encoding to US-ASCII
- warn supports multiple parameters
- LoadError#path
- OpenStruct can act like a hash

Removed
=======
- CSV::dump and ::load removed
- Iconv removed
- Syck removed

