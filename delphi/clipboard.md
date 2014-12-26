[Moniter Clipboard Changes](http://www.calmyoudown.com/?p=1066)
----

```delphi
TForm1 = class(TForm)
  private
    NextInChain: THandle;
    procedure WMDrawClipboard(var Msg: TMessage) ; message WM_DRAWCLIPBOARD;
    procedure WMChangeCBChain(var Msg: TMessage) ; message WM_CHANGECBCHAIN;

end;
  
procedure TTuMainForm.WMDrawClipboard(var Msg:TMessage) ;
 begin
  if Clipboard.HasFormat(CF_BITMAP) then begin
    //TODO
  end;

  if NextInChain <> 0 then
   SendMessage(NextInChain, WM_DrawClipboard, 0, 0)
 end;
 
  procedure TTuMainForm.WMChangeCBChain(var Msg: TMessage) ;
 var
   Remove, Next: THandle;
 begin
   Remove := Msg.WParam;
   Next := Msg.LParam;
  with Msg do
   if NextInChain = Remove then
    NextInChain := Next
   else if NextInChain <> 0 then
    SendMessage(NextInChain, WM_ChangeCBChain, Remove, Next)
 end;
 
```

Copy bitmap on clipboard to TImage
----
```delphi
image.Picture.Assign(Clipboard);
```

Set text to clipboard
----

```delphi
Clipboard.AsText := TextToBeCopy;
```
