library wSyck;

  { Créditos: Syck e PedraoSilv }

uses
  System.SysUtils, System.Classes,  Winapi.Windows, Vcl.Forms,
  wInterface in 'wInterface.pas' {Syck},
  wHacks in 'wHacks.pas',
  wFunctions in 'wFunctions.pas',
  wDefines in 'wDefines.pas';


{$R *.res}

procedure OpenForm;
begin
  Application.ShowMainForm := True;
  TSyck.Create(Application).ShowModal;
end;

procedure DllMain(Reason: DWORD);
var
  Show: DWORD;
begin
  case Reason of
    DLL_PROCESS_ATTACH : CreateThread(nil, 0, @OpenForm, nil, 0, Show);
    DLL_PROCESS_DETACH : FreeLibraryAndExitThread(HInstance, 0);
  end;
end;

begin
  DllProc := @DllMain;
  DllMain(DLL_PROCESS_ATTACH);
end.
