split csv
----

```delphi
sl := TStringList.Create;
sl.CommaText := 'jack,21,male';
name := sl[0]
age  := sl[1]
sex  := sl[2]
```
