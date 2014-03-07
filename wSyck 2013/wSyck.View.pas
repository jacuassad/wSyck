unit wSyck.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  wSyck.Addrs, wSyck.Defines, wSyck.Basics, wSyck.Functions, wSyck.Client, wSyck.Hacks, wSyck.Event, wSyck.Game,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.TabNotBk;

type
  TSyck = class(TForm)
    pHacks: TPanel;
    gPrincipal: TGroupBox;
    OpenCargo: TButton;
    Revive: TButton;
    Sec: TButton;
    OneHit: TButton;
    InvON: TButton;
    InvOFF: TButton;
    gParty: TGroupBox;
    GrupoOK: TButton;
    gTeleportar: TGroupBox;
    TeleportarOK: TButton;
    gPossuir: TGroupBox;
    PossuirOK: TButton;
    vFlood: TCheckBox;
    vTeleportar: TEdit;
    vGrupo: TEdit;
    vPossuir: TEdit;
    tSec: TTimer;
    tHit: TTimer;
    Timer: TTimer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure OpenCargoClick(Sender: TObject);
    procedure ReviveClick(Sender: TObject);
    procedure OneHitClick(Sender: TObject);
    procedure SecClick(Sender: TObject);
    procedure InvONClick(Sender: TObject);
    procedure InvOFFClick(Sender: TObject);
    procedure TeleportarOKClick(Sender: TObject);
    procedure GrupoOKClick(Sender: TObject);
    procedure PossuirOKClick(Sender: TObject);
    procedure vTeleportarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vPossuirKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tSecTimer(Sender: TObject);
    procedure tHitTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Syck : TSyck;

implementation

{$R *.dfm}

procedure TSyck.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TSyck.FormCreate(Sender: TObject);
begin
  //Pages.ActivePage := Pages.Pages.Strings[0];
end;

procedure TSyck.FormShow(Sender: TObject);
begin
  if not wSyckREG then
  begin
    halt;
    //Game.Message('wSyck não registrado !!!', [], 60000);
    //Delay(60000);
    //halt;
  end else
  begin
    //Game.Message('Bem vindo ao wSyck %s !!!', [FormatFloat('#,##0', Hack.Version)]);
  end;

  //Delay(10000);
  //Game.Message('Bem vindo ao wSyck %s', [FormatFloat('#,##0', Hack.Version)]);
  //Timer.Enabled := True;
end;

procedure TSyck.GrupoOKClick(Sender: TObject);
begin
  Hack.Party(vGrupo.Text);
end;

procedure TSyck.InvOFFClick(Sender: TObject);
begin
  Hack.Invisible(False);
end;

procedure TSyck.InvONClick(Sender: TObject);
begin
  Hack.Invisible(True);
end;

procedure TSyck.OneHitClick(Sender: TObject);
begin
  Hack.OneHit := not Hack.OneHit;
  if Hack.OneHit then
    Game.Message('OneHit Ativado !!!')
  else
    Game.Message('OneHit Desativado !!!');
end;

procedure TSyck.OpenCargoClick(Sender: TObject);
begin
  Hack.OpenCargo;
end;

procedure TSyck.PossuirOKClick(Sender: TObject);
begin
  Hack.Chat(vPossuir.Text);
end;

procedure TSyck.ReviveClick(Sender: TObject);
begin
  Hack.Revive;
end;

procedure TSyck.SecClick(Sender: TObject);
begin
  Hack.Sec;
end;

procedure TSyck.TeleportarOKClick(Sender: TObject);
var
  Pos : TSTRINGLIST;
begin
  try
    Pos := Explode(vTeleportar.Text);
    Hack.Teleport(Pos[0], Pos[1]);
  except
    Game.Message('Valor Inválido !!!');
  end;
end;

procedure TSyck.tSecTimer(Sender: TObject);
begin
  tSec.Enabled := False;
  Hack.SecPos;

      if HotKey(VK_F5) then OpenCargo.Click;
      if HotKey(VK_F6) then Revive.Click;

  tSec.Enabled := True;
end;

procedure TSyck.tHitTimer(Sender: TObject);
begin
  tHit.Enabled := False;
  if (HotKey(32)) and (Hack.OneHit) then
    Hack.Atake(PlayerID, 43);
  tHit.Enabled := True;
end;

procedure TSyck.TimerTimer(Sender: TObject);
begin

end;
  {Timer.Enabled := False;
  try
    if Game.Online then
    begin
      if HotKey(VK_F5) then OpenCargo.Click;
      if HotKey(VK_F6) then Revive.Click;

    end;
  except

  end;
  Timer.Enabled := True;}


procedure TSyck.vGrupoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
    GrupoOk.Click;
end;

procedure TSyck.vPossuirKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
    PossuirOK.Click;
end;

procedure TSyck.vTeleportarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  case Key of
    13 : TeleportarOk.Click;
    45 : vTeleportar.Text := Format('%d %d', [Client.Pos.X, Client.Pos.Y]);
  end;

end;

end.

  //Button6.Caption := Format('wSyck %s - WYD: %s cLiver: 0x%X', [
  //FormatFloat('#,##0', Hack.Version), FormatFloat('#,##0', Game.Version), Game.cLiver]);


