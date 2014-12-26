Upload File with TIdHTTP
------------------------

```delphi
procedure TTuMainForm.Upload(Sender: TObject);
var
  TestStream: TIdMultipartFormDataStream;
  sstream: TStringStream;
  stringList: TStringList;
  url: string;
  size: string;
begin
  try
    TestStream := TIdMultipartFormDataStream.Create;
    sstream := TStringStream.Create;

    HTTP := TIdHTTP.Create();
    IOHandler := TIdIOHandlerStream.Create();
    TestStream.AddFormField('Filename','a.png');
    TestStream.AddFile('Filedata','a.png','application/octet-stream');
    TestStream.AddFormField('Upload','Submit Query');

    HTTP.Request.Accept         := 'multipart/form-data';
    HTTP.Request.ContentType := TestStream.RequestContentType;
    StatusBar.Panels[0].Text := '上传中,请稍后...';
    HTTP.Post('http://a.com/upload/upload',TestStream,sstream);

    stringList := TStringList.Create;
    stringList.CommaText := sstream.DataString;
    url  := stringList[1];
    size := stringList[2];
    ImageUrl := Format('%s?%s',[url,size]);
    StatusBar.Panels[0].Text := ImageUrl;
  finally
      FreeAndNil(TestStream);
      FreeAndNil(HTTP);
      FreeAndNil(IOHandler);
      FreeAndNil(sstream);
      DeleteFile('a.png');
  end;
end;
```

[HTTP Util](http://www.experts-exchange.com/Programming/Languages/Pascal/Delphi/Q_23826343.html)
---------

```delphi
unit httpUtil;
 
interface
 
uses Classes, SysUtils, IdHTTP;
 
type
  THTTP_STATUS = Cardinal;
 
function DownloadToStream(AURL: String; AStream: TStream): THTTP_STATUS;
function HTTPGet(AURL: String): string; overload;
function HTTPGet(AURL: String; const Encoding: TEncoding): string; overload;
 
implementation
 
function HTTPGet(AURL: String): string; overload;
begin
  Result := HTTPGet(AURL, TEncoding.Default);
end;
 
function HTTPGet(AURL: String; const Encoding: TEncoding): string; overload;
var
  text: TMemoryStream;
  strings: TStrings;
begin
  with TIdHTTP.Create(nil) do
  begin
    try
      text := TMemoryStream.Create;
      try
        try
          Get(AURL, text);
        except
 
        end;
        if ResponseCode=200 then
        begin
          strings := TStringList.Create;
          text.Seek(0, 0);
          strings.LoadFromStream(text, Encoding);
          Result := strings.Text;
          strings.Free;
        end
        else
          Result := '';
      finally
        text.Free;
      end;
    finally
      Free;
    end;
  end;
end;
 
function DownloadToStream(AURL: String; AStream: TStream): THTTP_STATUS;
begin
  with TIdHTTP.Create(nil) do
  begin
    try
      Get(AURL, AStream);
      Result := ResponseCode;
    finally
      Free;
    end;
  end;
end;
 
end.
```
