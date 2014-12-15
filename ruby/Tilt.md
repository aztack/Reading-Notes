#Add Custom Template
```ruby
module Tilt
    class EJSTemplate < Template
        self.default_mime_type = 'text/html'
        def prepare
          options = @options.merge(:filename => eval_file, :line => line)
          @engine = ::EJS
        end
        def evaluate(scope, locals, &block)
            scope.instance_variables.each do |v|
                var = scope.instance_variable_get(v)
                locals[v.to_s.sub(/^@/,'').to_sym] = var rescue ''
            end
            EJS.evaluate(data, locals)
        end
    end
    register EJSTemplate, 'ejs'
end
```
#Add ejs helper to Sinatra
```ruby
helpers do
    def ejs(*args)
        render(:ejs, *args)
    end
end
```
