```ruby
begin
	require 'nokogiri'
rescue LoadError
	#fallback to iconv+hpricot if nokogiri is unavailabe
	old_verbose = $VERBOSE
	$VERBOSE = nil
	require 'iconv'
	require 'hpricot'
	$Iconv =  Iconv.new("UTF-8//IGNORE","gb2312")
	$VERBOS = old_verbose
end
```
