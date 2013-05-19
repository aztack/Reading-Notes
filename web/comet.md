[Comet (programming)](http://en.wikipedia.org/wiki/Comet_(programming))

Comet是一种web应用模型，这种模型中，允许通过HTTP‘长连接’请求，让服务器可以向浏览器推送数据，不再需要浏览器主动请求。Comet是一组术语，包括多种技术。实现Comet的技术都是浏览器默认支持的，比如JavaScript。不需要额外的插件。原始的web模型一次请求一个完成的页面，而Comet并不是这样。


> Comet is a web application model in which a long-held HTTP request allows a web server to push data to a browser, without the browser explicitly requesting it.[1][2] Comet is an umbrella term, encompassing multiple techniques for achieving this interaction. All these methods rely on features included by default in browsers, such as JavaScript, rather than on non-default plugins. The Comet approach differs from the original model of the web, in which a browser requests a complete web page at a time.[3]


早在Comet这个web技术术语被造出来之前，Comet中包含的技术就已经被用于web开发中了。Comet包括Ajax Push，Reverse Ajax,Two-way-web,HTTP Streaming 以及 HTTP server push。

> The use of Comet techniques in web development predates the use of the word Comet as a neologism for the collective techniques. Comet is known by several other names, including Ajax Push,[4][5] Reverse Ajax,[6] Two-way-web,[7] HTTP Streaming,[7] and HTTP server push[8] among others.[9]


实现（Implementations）
=====================

Comet试图通过提供实时交互、使用HTTP长连接来消除page-by-page的web模型和传统轮询模型的限制。因为浏览器在设计之初没有考虑到服务器事件，所以为了达到这个效果就发展处了一些技术。每种技术都有各自的优缺点。最大的阻碍就是HTTP 1.1规范。它规定浏览器不应该与服务器在一个时间有多于两个以上的连接。所以，保持一个用于实时通讯的连接对浏览器的可用性有不好的影响：浏览器可能会因为要等待前一个连接返回结果而被阻塞。比如一组图片。可以通过为同一个物理主机的实时通讯部分建立一个独立的主机名来绕过这个限制。实现Comet的方法具体分为两大类：流（streaming）和 长轮询（long polling）。

> Comet applications attempt to eliminate the limitations of the page-by-page web model and traditional polling by offering real-time interaction, using a persistent or long-lasting HTTP connection between the server and the client. Since browsers and proxies are not designed with server events in mind, several techniques to achieve this have been developed, each with different benefits and drawbacks. The biggest hurdle is the HTTP 1.1 specification, which states that a browser should not have more than two simultaneous connections with a web server.[10] Therefore, holding one connection open for real-time events has a negative impact on browser usability: the browser may be blocked from sending a new request while waiting for the results of a previous request, e.g., a series of images. This can be worked around by creating a distinct hostname for real-time information, which is an alias for the same physical server.Specific methods of implementing Comet fall into two major categories: streaming and long polling.

流（Streaming）
--------------
使用‘流Comet’技术的应用为所有Comet事件建立一个浏览器到服务器的持久连接。在服务器每次发送新的事件时，客户端都会逐个处理发过来的事件。客户端和服务器都不断开连接。实现‘流Comet’的具体技术包括如下(hidden iframe和XMLHttpRequest)：

> An application using streaming Comet opens a single persistent connection from the client browser to the server for all Comet events. These events are incrementally handled and interpreted on the client side every time the server sends a new event, with neither side closing the connection.[3]
Specific techniques for accomplishing streaming Comet include the following:

隐藏的iframe（Hidden iframe）
----------------------------

> Hidden iframe
A basic technique for dynamic web application is to use a hidden iframe HTML element (an inline frame, which allows a website to embed one HTML document inside another). This invisible iframe is sent as a chunked block, which implicitly declares it as infinitely long (sometimes called "forever frame"). As events occur, the iframe is gradually filled with script tags, containing JavaScript to be executed in the browser. Because browsers render HTML pages incrementally, each script tag is executed as it is received. Some browsers require a specific minimum document size before parsing and execution is started, which can be obtained by initially sending 1-2 kB of padding spaces.[11]
> One benefit of the iframe method is that it works in every common browser. Two downsides of this technique are the lack of a reliable error handling method, and the impossibility of tracking the state of the request calling process.[11]

XMLHttpRequest
--------------

> XMLHttpRequest [edit]
The XMLHttpRequest (XHR) object, the main tool used by Ajax applications for browser–server communication, can also be pressed into service for server–browser Comet messaging, in a few different ways.

> In 1995, Netscape Navigator added a feature called “server push”, which allowed servers to send new versions of an image or HTML page to that browser, as part of a multipart HTTP response (see History section, below), using the content type multipart/x-mixed-replace. Since 2004, Gecko-based browsers such as Firefox accept multipart responses to XHR, which can therefore be used as a streaming Comet transport.[12] On the server side, each message is encoded as a separate portion of the multipart response, and on the client, the callback function provided to the XHR onreadystatechange function will be called as each message arrives. This functionality is included in Gecko-based browsers, there is discussion of adding it to WebKit.[13] Internet Explorer 10 also supports this functionality.[14]

> Instead of creating a multipart response, and depending on the browser to transparently parse each event, it is also possible to generate a custom data format for an XHR response, and parse out each event using browser-side JavaScript, relying only on the browser firing the onreadystatechange callback each time it receives new data.
