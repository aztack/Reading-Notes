#Simple Usage#
```csharp
// Open a Website in IE
string url = "http://www.baidu.com";
Process.Start("IExplore.exe", url);

// Open wiht StartInfo
ProcessStartInfo startInfo = new ProcessStartInfo("IExplore.exe");
startInfo.WindowStyle = ProcessWindowStyle.Minimized;
Process.Start(startInfo);
startInfo.Arguments = url;

Process.Start(startInfo);
```

[How to use System.Diagnostics.Process correctly](http://csharptest.net/321/how-to-use-systemdiagnosticsprocess-correctly/)
I’ve seen many a question on stackoverflow and other places about running a process and capturing it’s output. Using the System.Diagnostics.Process correctly is not easy and most often it’s done wrong.

Some common mistakes with System.Diagnostics.Process:

- Not capturing both output streams (error & output)
- Not redirecting input can cause applications to hang
- Not closing redirected input can cause applications to hang
- Not calling BeginOutputReadLine/BeginErrorReadLine when using events
- Using OutputDataReceived/ErrorDataReceived without waiting for null
- Not checking for null in OutputDataReceived/ErrorDataReceived handlers
- Forgetting to set EnableRaisingEvents = true; when using the Exited event
- Forgetting ErrorDialog, CreateNoWindow, or UseShellExecute settings
- Incorrect handling of StandardOutput or StandardError stream readers
 

So with this said, here are some basic guidelines:

Use the OutputDataReceived/ErrorDataRecieved events NOT the StandardOutput or StandardError. This will save you a lot of headache and needless thread management.
Always capture all output AND input, if you don’t plan to provide input, close the stream immediately.
Your process isn’t done until it exited AND you have read all the data. OutputDataReceived CAN AND WILL be fired after a call to WaitForExit() returns. You will need wait handles for each output stream and set the wait handle once your receive (null) data.
