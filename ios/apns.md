![Overview](http://cdn1.raywenderlich.com/wp-content/uploads/2011/05/Push-Overview-467x500.jpg)

1. app调用响应的API开启推送。用户点击同意接受。iOS向APNs请求一个device token
2. app收到device token
3. app将收到的device token发给你的服务器
4. 当需要的时候，你的服务器想APNS服务器发送push消息
5. APNS向你的应用推送消息

1-3是注册阶段，4-5是推送阶段

Push消息需要：
1. iPhone或者iPad：模拟器无法使用消息推送
2. iOs开发者：app需要provision文件，服务器需要SSL证书。在iOS Provisioning Portal中下载。每个应用都要由自己的证书文件，不能使用其他应用的
3. 接入互联网的服务器：Push消息是由你的服务器发出的。开发时你可以用Mac笔记本作为Server。发布后，至少得有一个VPS。你至少能在服务器上跑一个服务，安装SSL证书，在某个端口建立连接。

