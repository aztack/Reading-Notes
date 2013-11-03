HTTP协议的状态消息都有哪些?
===========================

`"ruby\lib\ruby\2.0\webrick\httpstatus.rb"`

```ruby
      when 100...200; parent = Info
      when 200...300; parent = Success
      when 300...400; parent = Redirect
      when 400...500; parent = ClientError
      when 500...600; parent = ServerError
```

助记：
```
12345
ISRCS

IS red cold sausage (是红冷肠儿，哈尔滨红肠)

200-> 1-2->I(nfo)
304-> 3-4->R(edirect)
```

常用的
- 200 OK
- 304 未修改
- 404 请求的资源不存在   
- 503 服务器暂时不可用   
- 500 服务器内部错误  

简述下cookie的操作，还有cookie的属性都知道哪些
==============================================

网站优化
========

- 减少HTTP请求次数：CSS Spirit，Data URI
- JavaScript,CSS,HTML压缩

