Remove entire xcode
===================
`sudo /Developer/Library/uninstall-devtools --mode=all`

Manually download Xcode
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

