Concetps & Questions & Answers
==

很多iOS开发中遇到的问题都和工程设置有关。最好先看一下官方关于工程设置的文档：[Configure Your Project](http://developer.apple.com/library/ios/#documentation/ToolsLanguages/Conceptual/Xcode_User_Guide/025-Configure_Your_Project/configure_project.html)

How to Remove entire xcode?
===================
`sudo /Developer/Library/uninstall-devtools --mode=all`

How to manually download Xcode?
=======================
[https://developer.apple.com/downloads/index.action](https://developer.apple.com/downloads/index.action)

[Manually download Simulators](http://stackoverflow.com/questions/13410133/upgraded-xcode-to-4-5-2-from-4-3-2-and-install-simulator-5-0-or-5-1)
============================
copy
`/Users/<user>/Library/Caches/com.apple.dt.Xcode/Downloads/*.dvtdownloadableindex`
to
`~/any.plist`

open this plist file, find `downloadables.item N`. Url of download address of simulators are there

update: delete `*.dvtdownloadableindex` file, restart Xcode, install simulator.

Stroybord
=========
[A Storyboard is:](http://stackoverflow.com/questions/9083759/what-are-the-benefits-of-using-storyboards-instead-of-xib-files-in-ios-programmi)

- A `container` for all your Scenes (`View Controller`s, `Nav Controllers`, `TabBar Controllers`, etc)
- A `manager` of `connections and transitions` between these scenes (these are called `Segues`)
- A nice way to manage how different controllers talk to each other
- Storyboards give you a complete look at the flow of your application that you can never get from individual nib files floating around.
- A reducer of all the "clutter" that happens when you have several controllers each with it's own nib file.

Tutorial:
Beginning Storyboards in iOS 5
- [Part1](http://www.raywenderlich.com/5138/beginning-storyboards-in-ios-5-part-1)
- [Part2](http://www.raywenderlich.com/5138/beginning-storyboards-in-ios-5-part-2)

Bundle identifier grayed out and can not be changed
====

这是因为在project.plist文件中加入了工程名变量。类似com.company.${PRODUCT_NAME:rfc1034identifier} 。
所以不管你怎么改变bundle id，xcode都会在后面加上工程名。

解决：直接修改plist文件中的bundle id

Could not change executable permissions on the application
====

这是因为在你的设备上有同一个bundle id的应用，并且不同于当前工程。

解决：删除设备上的同id的引用

Could not read CBundleIdentifier from info.plist
====

这个问题一般是因为plist文件中（或者在工程设置，Targets，Info中）的`Bundle Identifier`被误删除导致的

解决： 在Target->Info中增加 Bundle Identifier，并设置正确的id。
