```delphi
program WinLay;

uses
  Vcl.Forms,
  Winapi.Windows,
  Winapi.ShellAPI,
  Unit1 in 'Unit1.pas' {MainForm},
  AutoHotkey_TLB in '..\..\12.0\Imports\AutoHotkey_TLB.pas';
type
  TDllRegSvr = function:HRESULT;stdcall;

  function ExecAndWait(const ExecuteFile, ParamString : string): boolean;
  var
    SEInfo: TShellExecuteInfo;
    ExitCode: DWORD;
  begin
    FillChar(SEInfo, SizeOf(SEInfo), 0);
    SEInfo.cbSize := SizeOf(TShellExecuteInfo);
    with SEInfo do begin
      fMask := SEE_MASK_NOCLOSEPROCESS;
      Wnd := Application.Handle;
      lpFile := PChar(ExecuteFile);
      lpParameters := PChar(ParamString);
      nShow := SW_HIDE;
    end;
    if ShellExecuteEx(@SEInfo) then
    begin
      repeat
        Application.ProcessMessages;
        GetExitCodeProcess(SEInfo.hProcess, ExitCode);
      until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
      Result:=True;
    end
    else Result:=False;
  end;
{$R *.res}
var
  DllRegisterServer: TDllRegSvr;
begin
  Application.Initialize;
  try
    AutoHotkeyModule := LoadLibrary('AutoHotkey.dll');
    if AutoHotkeyModule <> 0 then
    begin
      DllRegisterServer := TDllRegSvr(GetProcAddress(AutoHotkeyModule,'DllRegisterServer'));
       if Assigned(DllRegisterServer) then
       begin
        DllRegisterServer();
        FreeLibrary(AutoHotkeyModule);
       end else begin
        ExecAndWait('regsvr32','/s AutoHotkey.dll');
       end;
    end;
  except
    Application.MessageBox('Can not Register AutoHotkey!', 'Error', MB_OK + MB_ICONSTOP);
    Application.Terminate;
  end;

  AHK := TAutoHotkey.Create(nil);
  AHK.ahkdll('a.ahk');
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TMainForm, MainForm);
  MainForm.AHK := AHK;
  Application.Run;
end.

```
