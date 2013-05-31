常用命令
========
* rails new APPLICATION_NAME 创建应用
* rails server 启动HTTP服务器
* rails console 启动命令行
* rake db:create:all 创建数据库
* rake generate scaffold TABLE_NAME Field0:Type Field1:Type ...创建一个数据Migration
* rake db:migrate 将Migrations应用到数据库上，创建表
* rake routes 显示所有route
* rails destroy controller NAME
* rails destroy model NAME
* rails destroy scaffold NAME
* rails server --debug 调试，需要`gem install ruby-debug`

调试
====

[Debugging Rails Application](http://guides.rubyonrails.org/debugging_rails_applications.html)

`rails server --debug` 调试，需要`gem install ruby-debug`

.rdebugrc
```
  set reload
  set autolist
  set autoeval
  set history save
```

疑惑
====

1.What is edit\_post\_path from a Ruby standpoint
--------------------------------------------------

原问题：http://stackoverflow.com/questions/7536873
[2.3 Paths and URLs](http://guides.rubyonrails.org/routing.html)

- photos_path returns /photos
- new_photo_path returns /photos/new
- edit_photo_path(:id) returns /photos/:id/edit (for instance, edit_photo_path(10) returns /photos/10/edit)
- photo_path(:id) returns /photos/:id (for instance, photo_path(10) returns /photos/10)

2.如何布局?
------------

[Layout and Rendering](http://guides.rubyonrails.org/layouts_and_rendering.html)

3.数据库表如何增加列?
--------------------

4.主机与手机在同一个LAN，但是手机无法访问Rails服务器
----------------------------------------------------
在RubyMine中：
Run/Debug Configurations -> Configration -> IP address change to LAN IP, e.g: 192.168.1.100



猜测或结论
=========
1.ActionView Helpers中的函数在View中都可以用

参考
====
- [Ruby on Rails Guides (v3.2.13)](http://guides.rubyonrails.org/)
- [ActionView Helpers](file:///D:/prog/rb/railsinstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/actionpack-3.2.11/lib/action_view/helpers)

