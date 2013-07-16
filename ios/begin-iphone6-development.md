What's the difference about coding for iOS?
===========================================

- Only one active application
	
	> when your application not active or running in background, it does not receive any attention from CPU

- Only one window
	
	> the window size is fixed at the size of window

- Limited access
	
	> your application can only read or write file in your application's sandbox

- Limited response time

	> when user pressed home key, your application have to save and give up control in 5 seconds, if not, your application will be killed

- Limited screen size

	> iPhone,`480x960`;iPad,`1024x768`;iMac,`1920x1080`;27inchLED,`2560x1440`

- Limited system resources

	> iPhone4/4s,`512MB`;iPhone5,`1G`. **NO SWAP file**.
	iOS has mechanism to let your application know the memory is low, and your application must to free up some unneeded memory.

- NO Garbage Collection!!!

- New stuffs

	- Geolocation
	- Camera & Gallery
	- Accelerometer

- Diffrence approach

	> No keyboard and mouse

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
	- `project name-Prefix.pch`: pre-compile headers, list of header files from external frameworks
	- `main.m`: main() function
	- `project name-Info.plist`: contains application information
	- `ViewController.xib`: used by Interface Builder
- `framework`: any framework or library added to this folder will be linked into your application.
- `product`: project produced application, e.g: `Hello World.app`

The Interface Builder
=====================

- Interface Builder has a long history. It has been around since 1998!
- There are 2 types of IB files(we call them nib files):
	- *.nib __older format__
	- *.xib __newer format__
- In nib file design window: every icon represents a single objective-c class instance that will be *created automatically when nib file is loaded*, except `First responder` and `File's owner`. The nib files is loaded when your application launched.
- Every nib file starts off with the same two icons (can not be delete): 
	- `File's owner`: is the object that owns the nib file.
	- `First responder`: is the object that user currently interacting. The `First responder` changes as the user interacts with the interface.
- The `View` icon represents a instance of `UIView` class.
- Items on `Library Palette` is primaryly from the `iOS UIKit` framework, and used to create UI. `UIKit` fullfills the same role in Cocoa Touch as `AppKit` does in Cocoa.
- `Foundation framework` shared between `Cocoa` and `Cocoa Touch`
- Interface Builder does not generate code that has to be maintained, instead, it creates Objective-C objects and serializes them into nib files so that they can be loaded direct into memory.
- Do not try to match the style of iPhone icons, iPhone will automatically round the edges, give it a nice glassy appearance. Just create a normal flat, `57x57` PNG image.
- You should use `PNG format` for all image you add to your iOS projects. PNG image will be optimized by Xcode during build time.
- You can specify applicatio icon in `project name-Info.plist`-> `Icon file.` Xcode will automatically use `icon.png` as the icon file if you do not specify.
- If you want to run your application on an actual iOS device, you need to properly set `Bundle identifier` in `project name-Info.plist` file.

Handle basic interaction
========================

`UIKit` framework follow the principles of `MVC`
- `V`: you create Views with Interface Builder
- `M`: `objective-c classes` or `Core Data`
- `C`: `objective-c classed` or `subclasses of UIViewController`

Creating View Controller
========================

Outlets & Actions
-----------------

- Controller class can reference object in nib file by using a special instance variable called **`outlet`**. Youn can think outlet as a `pointer` pointing to object instances in nib file that is loaded into memory when application launched.
	> Model -> `Controller` -> `IBOutlet` -> `nib object instance(Views)`

	> using `Assistant Editor` in Xcode, ctrl+drag UI control to *.h can create outlets.

- Interface objects can be set up to trigger special method, called **`action`** in controller class.

Objective-C Properties
----------------------

* `getter` -> `accessor`
* `setter` -> `mutator`
* In Objective-C 2.0, you can use `Dot Notation` with properties.

```objective-c
	myVar = [someObject foo]
	myVar = someObject.foo

	[someObject setFoo:myVar]
	someObject.foo = myVar
```

General memory rule
-------------------
> if you didn’t allocate it or retain it, don't release it,”

Using the Application Delegate
------------------------------

- The application delegate let us do things at predefined time on behalf of the `UIApplication` class
- Every iPhone application has one and only one instance of `UIApplication` which responsible for the application run loop and application-level functionality.

