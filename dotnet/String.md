```csharp
using System.Text;
class StringHelper {
  static string utf82gb2312(string str)
  {
      var utf8 = Encoding.GetEncoding("UTF-8");
      var gb2312 = Encoding.GetEncoding("GB2312");
      return utf8.GetString(gb2312.GetBytes(str));
  }
}
```
