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
