[.xib and .storyboard Files](http://wiki.oxygenelanguage.com/en/.xib_and_.storyboard_Files)
====

.xib and .storyboard files are types of resource files used on the Cocoa platforms, mostly to represent the graphical user-interface of OSX and iOS applications (although they can contain non-visual elements and information, as well). They are commonly designed with the Interface Builder tool that is part of Xcode, and get embedded into the project and the final application, where they are then used at runtime.

.xib vs .storyboard Files
----
Both .xib and .storyboard files are conceptually very similar, although they use a slightly different file format (the .storyboard format is newer and thus more modern and maintainable), and have slightly different capabilities.
.xib files are supported on both Mac OS X and iOS, and while they can (and often do) contain a variety of different elements, it is common and considered good design practice for .xib files to contain only a single window or view.
.storyboards are a newer file format, and currently supported only on iOS. They expand the concept of .xib files by being designed to contain several views (in some cases even all views used by a single application), as well as information on how the application will segue between these different views.
When doing iOS development, one big advantage of .storyboard files is that their file format is much "saner" than that of .xib files, which will make diff'ing and version control easier when working with multiple developers on the same file. (Although during regular development tasks, i.e. when designing your UI, you will not come in contact with the internal file format much.)
From the point of view of working with and editing them, both .xib and .storyboard files behave mostly identical, so for the larger part of this topic, we will refer to .xib files, but the same concepts will apply to .storyboard files, as well.

What are .xib Files, exactly
----
Simply put, a .xib file is the serialization of an object graph. This means it contains the description of a number of object instances, their attributes (i.e. property values), as well as connections between the objects (e.g. a property on one object referring to a different object instance in the graph).
A .xib might have info that expresses "ok, i got an UIView. on it there's two UIButtons, their Caption is this, and their position is as such".
It is important to understand that a .xib files does not define new classes or types, but only instances of known classes. This is very much in contrast to many other UI frameworks, such as .NET's WinForms or WPF, or Delphi's VCL or FireMonkey, where the file that describes the UI (e.g. a .xaml or .dfm file) generally also declares a subclass of, say, the Window class.
A .xib file only refers to known classes — which can be classes defined by the base Cocoa frameworks, or classes you defined in your project yourself, and defines what classes should be instantiated when the .xib is loaded, and how they should be set up and connected.
When a .xib file is loaded into your application (more on that below), the runtime will create instances of all the classes it refers to, and set up the full object graph in memory for your application to use.



Styling iOS Native App with CSS
======================================
- [Pixate](http://www.pixate.com/)
- [Styling Your App Using Pixate](http://www.appdesignvault.com/styling-your-app-using-pixate/)
- [NUI](https://github.com/tombenner/nui)


UI Layouting
============

- [Auto Layout & Interface Builder Tutorial: Solving some common problems](http://ideveloper.co/auto-layout-interface-builder-tutorial/)
- [10 Things You Need To Know About Cocoa Autolayout](http://oleb.net/blog/2013/03/things-you-need-to-know-about-cocoa-autolayout/)

[How to Customize Navigation Bar and Back Button](http://www.appcoda.com/customize-navigation-bar-back-butto/)
======

```
[[UINavigationBar appearance] setBackgroundColor: [UIColor colorRed]];
[[UIBarButtonItem appearance] setTineColor:[UIColor colorRed]];
```

![Screen & Control size of iPhone4/5](http://www.idev101.com/code/User_Interface/img/bothPhones.jpg)

- http://www.idev101.com/code/User_Interface/sizes.html
- http://www.idev101.com/code/User_Interface/launchImages.html

