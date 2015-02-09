PM> Install-Package CsQuery

```csharp
using System;
using System.Net;
using System.Text;

namespace ConsoleApplication1
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            string url = "http://www.baidu.com";
            WebClient wc = new WebClient();
            string html = wc.DownloadString(url);
            Console.WriteLine(html);

            var dom = CsQuery.CQ.Create(html);
            var anchors = dom.Select("a");
            foreach (var a in anchors)
            {
                string innerhtml = System.Net.WebUtility.HtmlDecode(a.InnerHTML);
                Console.WriteLine(">>" + utf82gb2312(innerhtml) + "<<");
            }
        }

        static string utf82gb2312(string str)
        {
            var utf8 = Encoding.GetEncoding("UTF-8");
            var gb2312 = Encoding.GetEncoding("GB2312");
            return utf8.GetString(gb2312.GetBytes(str));
        }
    }
}

```
