```ruby
require 'execjs'
ctx = ExecJS.compile(File.read("lib.js",:encoding => 'utf-8'))
result = ctx.eval("some code")

js = File.read("sample.js",:encoding => 'utf-8'))
ExecJS.exec(js)
```

Notice: 
- You must return some value in js code, so that ExecJS can capture it and return it's value to ruby
- compile, eval used in pair, exec used alone
