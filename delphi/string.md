split csv
----

```delphi
sl := TStringList.Create;
sl.CommaText := 'jack,21,male';
name := sl[0]
age  := sl[1]
sex  := sl[2]
```

[Md5](http://www.pockhero.com/short-hash-function-names/)
---

```delphi
unit hashutil;
 
interface
 
uses SysUtils, Classes, IdGlobal, IdHash, IdHashMessageDigest, IdHashSHA, IdHashCRC;
 
function MD5(S: String): String; overload;
function MD5(S: TStream): String; overload;
function MD5_Bytes(S: String): TIdBytes;
function MD5_File(AFilename: String): String;
 
implementation
 
 
function MD5_File(AFilename: String): String;
var
  fs: TFileStream;
begin
  with TIdHashMessageDigest5.Create do
  begin
    fs := TFileStream.Create(AFilename, fmOpenRead);
    try
      Result := HashStreamAsHex(fs);
    finally
      fs.Free;
    end;
    Free;
  end;
end;
 
function MD5_Bytes(S: String): TIdBytes;
begin
  with TIdHashMessageDigest5.Create do
  begin
    Result := HashString(S);
    Free;
  end;
end;
 
function MD5(S: String): String;
begin
  with TIdHashMessageDigest5.Create do
  begin
    Result := HashStringAsHex(S);
    Free;
  end;
end;
 
function MD5(S: TStream): String;
begin
  with TIdHashMessageDigest5.Create do
  begin
    Result := HashStreamAsHex(S);
    Free;
  end;
end;
 
end.
```
