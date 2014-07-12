忽略空白符
=============
必须用Nokogiri::XML加noblanks选项。Nokogiri::HTML不行
```ruby
Nokogiri:XML(html,&:noblanks)
```

搜索文本节点
===
```ruby
doc.xpath("//text()").each{|textNode|}
```

