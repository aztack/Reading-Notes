What's the difference about coding for iOS?
===========================================

- Only one active application

  when your application not active or running in background, it does not receive any attention from CPU

- Only one window

	and the size is fixed at the size of window

- Limited access
	
	your application can only read/write file in your application's sandbox

- Limited response time

	when user pressed home key, your application have to save and give up control in 5 seconds, if not, your application will be killed

- Limited screen size

	iPhone,640x960;iPad,1024x768;iMac,1920x1080;27inchLED,2560x1440

- Limited system resources

	iPhone4/4s,512MB;iPhone5,1G. NO SWAP file.
	iOS has mechanism to let your application know the memeory is low, and your application must to free up some unneeded memory.

- NO Garbage Collection!!!

- New stuffs

	Geolocation;Camera & Gallery;Accelerometer

- Diffrence approach

	No keyboard and mouse

Setting up your project
=======================

- Xcode is located in `/Developer/Applications`
- [Apple's Developer Portal](http://developer.apple.com)
- `single view-based application` template is the simplest one.
- select `iPhone` in `device family` when creating application
- uncheck `storyboard` then you will see xib files

The Xcode project window
========================

- `project name` folder: place your code here
- 'project name/supporting files': 
	- `project name-Prefix.pch`: precompile headers, list of header files from external frameworks
	- `main.m`: main() function
	- `project name-Info.plist`: contains application information
	- `ViewController.xib`: used by Interface Builder
- `framework`: any framework or library added to this folder will be linked into your application.
- `product`: project produced application, e.g: `Hello World.app`
