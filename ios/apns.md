[Apple Push Notification Services in iOS 6 Tutorial: Part 1/2](http://www.raywenderlich.com/32960/apple-push-notification-services-in-ios-6-tutorial-part-1)

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

Provisioning Profiles and Certificates
====

APNS 需要一个证书！`Apple Development IOS Push Services: com.company.appname`

你的应用需要用一个配置了Push服务的Provisioning profile签名；你的服务器需要一个SSL证书和APNS通信。
这个Provisioning profile 和SSL certificate是和你的App ID(com.company.appname)是绑定在一起的。
着这样才能保证只有你的服务器才可以向你的应用推送消息。

我们已经知道，app使用development和distribution两种Provisioning profile。
推送服务器证书也有两种：

- Development：如果你的app运行在Debug模式，被Development Provisioning profile签名（iPhone Developer），那么你的服务器也必须使用Development证书
- Production：当你的app发布后，被发布证书签名（iPhone Distribution），你的服务器也必须使用发布证书。

生成证书签名那个请求（CSR）
====
数字证书是基于公私秘钥(public-private key cryptography)加密技术的。你要明白的是，证书的工作总是伴随着一个私钥。

certificate是公私秘钥对儿中的“公”部分。你可以随意分发。这正是通过SSL通信时所发生的。私钥必须妥善保管。没有私钥，证书是没有用的。

当你需要一个电子证书的时候。你需要发起发起一个证书签名请求(Certificate Signing Request)。当你创建了一个CSR后，操作系统会给你创建一个全新的私钥，并加入到keychain中。系统会要求你，给你的私钥提供一个passphrase来保护它。之后你将这个CSR（一个*.certSigningRequest文件）发给证书颁发机构（这里就是苹果的开发者中心），它会基于你的CSR给你生成一个SSL证书。


