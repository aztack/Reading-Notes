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

删除空白文本节点
===

```ruby
doc.xpath("//text()").each{|e| e.remove if e.content =~ /^\s+$/}
```

格式化HTML
===

```ruby
doc = Nokogiri::HTML(html, &:noblanks)
xml = doc.to_xml(:indent => 4)

node.inner_html = xml #xml format will be messed up, use .content instead
node.content = xml
```

