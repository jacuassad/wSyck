library wSyck;

 { CRÉDITOS:

 Aguinaldo - Pedraosilv@CB
 SKYPE : aguinaldo.123

 Syck
 SKYPE : syck.br }

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Forms,
  wHome in 'wHome.pas' {Syck},
  wFunctions in 'wFunctions.pas',
  wStructs in 'wStructs.pas',
  wAddrs in 'wAddrs.pas',
  wHacks in 'wHacks.pas';

{$R *.res}

procedure OpenForm;
begin
  Application.ShowMainForm := True;
  with TSyck.Create(Application) do
    ShowModal;
end;

procedure DllMain(Reason: DWORD);
var
  Show: DWORD;
begin
  if (Reason = DLL_PROCESS_ATTACH) then
    CreateThread(nil, 0, @OpenForm, nil, 0, Show);

  if (Reason = DLL_PROCESS_DETACH) then
    FreeLibraryAndExitThread(HInstance, 0);
end;

begin
  DllProc := @DllMain;
  DllMain(DLL_PROCESS_ATTACH);
end.
