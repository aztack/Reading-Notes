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
