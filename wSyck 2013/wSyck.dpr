library wSyck;

  { wSyck 1.0, bY: SYCK <SYCK.BR>, Créditos: PedraoSilv }

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Forms,
  wSyck.View in 'wSyck.View.pas' {Syck},
  wSyck.Addrs in 'wSyck.Addrs.pas',
  wSyck.Packet in 'wSyck.Packet.pas',
  wSyck.Client in 'wSyck.Client.pas',
  wSyck.Defines in 'wSyck.Defines.pas',
  wSyck.Functions in 'wSyck.Functions.pas',
  wSyck.Hacks in 'wSyck.Hacks.pas',
  wSyck.Basics in 'wSyck.Basics.pas',
  wSyck.Game in 'wSyck.Game.pas',
  wSyck.Event in 'wSyck.Event.pas';

{$R *.res}

procedure OpenSyck;
begin
  Application.ShowMainForm := False;
  TSyck.Create(Application).ShowModal;
end;

procedure DllMain(Reason : DWORD);
var
  Show : DWORD;
begin
  case Reason of
    DLL_PROCESS_ATTACH : begin
    CreateThread(nil, 0, @OpenSyck, nil, 0, Show);
    end;
    DLL_PROCESS_DETACH : FreeLibraryAndExitThread(HINSTANCE, 0);
  end;
end;

begin
  DllProc := @DllMain;
  DllMain(DLL_PROCESS_ATTACH);
end.

