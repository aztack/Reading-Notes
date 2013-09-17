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


[Working with .xib Files](http://wiki.oxygenelanguage.com/en/Working_with_XIB_Files)
====

Background: What are XIB Files?
----

So what are XIB files? From the point of view of the UI designer, XIB files contain the views or windows that you design in Interface Builder — the controls, their layout and properties, and their connections to your code.
`It is important to understand that on a technical level, XIB files are stored object graphs`. That means that an XIB file, essentially, is a hierarchical set of objects descriptions. `When an XIB file gets loaded at runtime, all the objects defined in the XIB file get instantiated, configured, and connected as described in the XIB`.
These objects can be a combination of standard framework classes (such as NSView/UIView, NSButton/UIButton, etc), classes from third party libraries, or even classes defined in your own application code. When the Cocoa runtime loads an XIB, it goes thru the list one by one, looks for the classes with the appropriate names and news up the necessary objects.
Each XIB file also knows about a special object called the "File's Owner". This object will not be created when the XIB is loaded. Rather, the object that initiated the loading of the XIB file will take the place of the File's Owner within the XIB's object graph — including any connections and references to it. We will see how that is useful and important, soon.

Connections
----
Did i say connections? So how does this work?
Easy, really. XIB files know about two basic kinds of connections between objects: Outlets and Actions.

You can think of outlets as references to other objects. If your view controller class has a property of type UIButton, and your XIB file contains a UIButton, that's a match made in heaven. You can just Ctrl-drag the button onto the File's Owner (or vice versa) in the XIB to hook them up, and now you have access to the UIButton from your code, because as the XIB gets loaded and the UIButton gets created, it gets hooked up to your property automatically.

Actions, you may have guessed, can be thought of as events. If something happens with the objects in the XIB (such as a button being tapped), they send out events. Just as above, if your view controller exposes a method with the right signature (that is, any method with exactly one parameter of type "id" or a concrete class), you can Ctrl-drag it into your XIB file to hook them up — and when the event triggers, that method is called.

Of course outlets and actions can be hooked up between any two objects inside your XIB, not just with the view controller. For example, you can cause an action on one control to trigger a method on a different control.
Ok, so how does the XIB designer in Xcode know about the methods and properties on your view controller (or other classes)? Magic! As you write your classes, Oxygene(Xcode) will automatically update the XIB and Storyboard files, behind the scenes, with information about all the relevant classes and their properties and methods — that is any property marked "[IBOutlet]" and any method marked "[IBAction]". As you work on your XIB file in Xcode, it sees this information, and makes the connections available.
If you need to expose a new control to your code or want to hook up a new event, simply add a new property or method to your code, and that's it.


Terminology: XIB vs. NIB?
----
In the text above, i talk about XIB files, but the method names all mention NIBs. What's up with that?
XIBs are a newer, `XML based format` that is used for the UI at design time. When you compile your app, the `XIB files are converted to binary NIB files` for you, and those binary versions of the files are `embedded into your app`. All the APIs working with these files predate the new format (and, at runtime, only work with the older NIB format), that's why all the method names refer to NIB, not XIB. When you pass around names, you never need to (or should) specify the file extension anyway, so this is a distinction that you can largely ignore (unless you want to go spelunking into your .app bundle).
