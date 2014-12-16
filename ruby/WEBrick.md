#HTTP File Server

```ruby
require 'webrick'
include WEBrick
server = HTTPServer.new(:Port=> ARGV.first.to_i,:DocumentRoot=> Dir::pwd)
server.mount("/", HTTPServlet::FileHandler, Dir.pwd,true)
server.start
```

```ruby
  require 'webrick'
  include WEBrick
	class MyServlet < WEBrick::HTTPServlet::FileHandler
		
		def initialize(*args)
			super(*args)
		end
		
		def do_GET(req, resp)
		  resp['cache-control'] = 'no-cache'
			resp['charset'] = 'utf-8'
			query = req.request_line.split(" ")[1]
			
			resp['content-type'] = 'application/json'
			resp.body << '{err:"succ"}'
		end
		
		def do_POST(req,resp)
			query = req.request_line.split(" ")[1]
			case query
			when /pattern1/ then
		    ...
			when /pattern2/
				...	
			else super(req,resp)
			end
		end
	end
	
	server = WEBrick::HTTPServer.new(:Port=> port+=1,:DocumentRoot=> $WORK)
	server.mount("/", MyServlet, $WORK,true)
```
