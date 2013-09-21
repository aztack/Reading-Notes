
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
- Refinements
- Module#prepend
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
