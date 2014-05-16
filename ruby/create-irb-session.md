```ruby
require 'irb'
require 'irb/completion'

def hello
	$stdout.puts "hello~"
end

IRB.setup nil
IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context
IRB.conf[:PROMPT_MODE] = :SIMPLE
require 'irb/ext/multi-irb'
IRB.irb nil, self
#ruby this script and type hello
```
