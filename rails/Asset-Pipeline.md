原文：[Ruby on Rails Guides: Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)

资源流水线
=========

本章覆盖了Rails 3.1 的资源流水线。通过阅读本章你可以：

- 了解资源流水线是什么，以及它可以做什么
- 正确的组织你的应用中的资源
- 在流水线中增加一个预处理器
- 将资源打包到一个gem中

1.资源流水线是什么?
===================

资源流水线提供了一个用来连接、混淆压缩JavaScript和CSS资源的框架。它还让你可以用诸如CoffeeScript，Sass和ERB的其他语言来编写这些资源文件。

在Rails 3.1之前，这些特性都是通过如Jammit和Sprockets这样的第三方库增加的。而Rails 3.1通过Action Pack，默认集成了Sprockets。

资源流水线变成Rails的核心特性后，所有Rails开发者都会从中受益：通过一个核心库来预处理、混淆压缩代码资源。这一点正好符合DHH在RailsConf 2011中提到的“默认最快”的Rails核心原则。

在 Rails 3.1 中，默认启用资源流水线。在config/application.rb中增加下面代码可以关闭资源流水线。

```
config.assets.enabled = false
```

除非你需要刻意避免使用使用资源流水线，否者还是建议你使用默认设置。

1.1 主要特性
-----------

资源流水线的首要特性就是“合并代码资源”。在生产环境中这是非常重要的，因为通过合并资源可以减少浏览器渲染页面时的请求次数。浏览器并行请求资源的数量是有限的，所以更少的请求意味着更快的页面加载速度。

Rails 2.x 为javascript\_include\_tag和stylesheet\_link_tag方法增加了合并JavaScript和CSS的功能：通过传入参数 :cache => true来实现。但是这样做有一些局限性。比如，它不能实现生成缓存，而且也不能透明地包含第三方库。

从 Rails 3.1 开始，所有JavaScript文件默认地被合并成一个.js文件。对CSS来说也是一样的。在后面，我会告诉你如何按你的意图自由组合、合并文件。&?在生产环境中，Rails 给合并后的文件名插入一段“MD5指纹”，使得文件被浏览器缓存住。每次你修改代码这个指纹都会自动更新，此时原来的缓存就失效了，新的代码就会被下载并重新缓存。

资源流水线的第二个特性是“代码压缩”。对于CSS文件来说就是删除多余的空白字符和注释。对于JavaScript来说这个过程可能更复杂一些。你可以从一组构建选项中选择，也可以指定你自己的构建方法。

资源流水线的第三个特性是“允许你是用高阶语言进行编码”。然后通过预编译转换成最终的资源代码。支持的高阶语言包括编译成CSS的Sass和编译成JavaScript的CoffeeScript，以及可以在CSS和JavaScript中使用的ERB模板语言。

1.2 什么是“指纹”，为什么需要关心“指纹”？

“指纹”是一种让文件名跟随文件内容变化而变化的技术。对于静态或不经常变化的文件内容，这种技术提供了一种辨别两个文件是否完全一致的方法。并且与所在服务器和部署日期无关。

当文件名是独一无二的，并且随文件内容而变时，HTTP头部就可以设置为在任何可能的地方尽可能缓存文件（比如在CDN，ISP，网络设备，或者是浏览器）。每当文件内容有更新，文件指纹也发生变化。这就导致客户端请求新的文件内容。这就是所谓的Cache Busting。

Rails将文件内容的哈希插入到文件名的后面。比如，global.css来说，它被重命名为：

```
global-908e25f4bf641868d8683022a5b62f54.css
```

这就是资源流水线采用的策略。

Rails’ old strategy was to append a date-based query string to every asset linked with a built-in helper. In the source the generated code looked like this:

```
/stylesheets/global.css?1309495796
```

The query string strategy has several disadvantages:

- Not all caches will reliably cache content where the filename only differs by query parameters.
Steve Souders recommends, “…avoiding a querystring for cacheable resources”. He found that in this case 5-20% of requests will not be cached. Query strings in particular do not work at all with some CDNs for cache invalidation.
- The file name can change between nodes in multi-server environments.
The default query string in Rails 2.x is based on the modification time of the files. When assets are deployed to a cluster, there is no guarantee that the timestamps will be the same, resulting in different values being used depending on which server handles the request.
- Too much cache invalidation
When static assets are deployed with each new release of code, the mtime of all these files changes, forcing all remote clients to fetch them again, even when the content of those assets has not changed.
Fingerprinting fixes these problems by avoiding query strings, and by ensuring that filenames are consistent based on their content.

Fingerprinting fixes these problems by avoiding query strings, and by ensuring that filenames are consistent based on their content.

Fingerprinting is enabled by default for production and disabled for all other environments. You can enable or disable it in your configuration through the config.assets.digest option.

“指纹”技术在生产环境默认开启。在其他环境中默认关闭。你可以通过config.assets.digest控制是否开启。
