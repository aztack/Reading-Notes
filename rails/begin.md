搭建ubuntu虚拟机开发环境
========================
- 下载Vagrant：`https://dl.bintray.com/mitchellh/vagrant/Vagrant_1.4.3.msi`
- 下载Rails开发虚拟机：`https://github.com/rails/rails-dev-box`
- 开启虚拟机：进入虚拟机git目录，`vagrant up`启动虚拟机， `vagrant ssh`ssh连接到虚拟机

-----------------------------------------------------------------------------------------

- 修改ubuntu软件源：`vim /etc/apt/sources.list` 将“us”改为“cn”(sohu的源)
- 修改gem的源：参考`http://ruby.taobao.org/`（淘宝的源）
- 下载rvm： `curl -L get.rvm.io | bash -s stable`
- 安装ruby的依赖：`rvm requirements`
- 安装ruby：`rvm install 2.1` `rvm --default use 2.1`
- 安装rails：`gem install rails`
- 安装mysql开发包: `sudo apt-get install libmysqlclient-dev`
- 安装mysql2：`gem install mysql2`

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

5.accepts_nested_attributes_for in Post model?
----------------------------------------------

6.如何增加一个静态页面
------------------

增加route:
get "/about" => "home#about"
将/about映射到HomeController#about方法
在about方法中不用写任何代码
然后再/views/home/创建一个模板about.html.erb
这样，在访问/about的时候，会调用about方法，并渲染about.html.erb模板
还有一种选择：
在about方法中读取数据库，获得相关数据。然后再模板中展现
相关插件
- [FriendlyId](https://github.com/FriendlyId/friendly_id)
- [Hight Voltage](https://github.com/thoughtbot/high_voltage)
7.如何在View中生成连接
--------------------
猜测或结论
=========
- ActionView Helpers中的函数在View中都可以用
- Controller中的create,destroy方法都要自己写（废话..)，但有些是生成的，哪些来着?
- /views/CONTROLLER/METHOD.html.erb 会在 CONTROLLER#METHOD中自动调用

代码片段
=======
```
    def show
        @page = Page.find(params[:id])
        render 'shared/404', :status => 404 if @page.nil?
    end
```
参考
====
- [Ruby on Rails Guides (v3.2.13)](http://guides.rubyonrails.org/)
- [Rails API](http://apidock.com/rails)
- [ActionView Helpers](file:///D:/prog/rb/railsinstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/actionpack-3.2.11/lib/action_view/helpers)

