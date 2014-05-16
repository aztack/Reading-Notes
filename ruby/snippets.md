OptionParser解析命令行参数
===========================
```ruby
require 'optparse'

opt_parser = OptionParser.new do |opts|
  #banner
	opts.banner = "builder.rb [options]"

  #一个参数
	opts.on('-g [png]','generate dependency graph') do |png|
    
	end
	
	#无参数
	opts.on('-d','print dependency hash') do

	end

  #多个参数
	opts.on('-u [namespace,spec,exclude]', Array, 'generate code under namespace with dependency') do |args|
		namespace,spec,exclude = *args
    #...
	end
	
	#帮助
	opts.on_tail("-h", "--help", "Show this message") do
		puts opts
		exit
	end

end

#使用
opt_parser.parse! ARGV
```
