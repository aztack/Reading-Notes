```ruby
require 'open3'

def run(param, target, &block)
    EXEPATH = "..."
    paths = if target.is_a? String and File.directory?(target)
        Dir.glob(target).map{|e|%Q["#{File.expand_path(e)}"]} 
    else
        [target]
    end
    command = %Q["#{EXEPATH}" #{param} #{paths.map{|e|e.quote}.join(' ')}]

    #use US english locale
    ENV["LANG"] = "en_US.utf-8"
    Open3.popen3(ENV,command) do |input,output,error,thread|
        text = output.read
        block_given? ? block(text) : text
    end
end
```
