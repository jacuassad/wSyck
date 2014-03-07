unit wSyck.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.TabNotBk, Vcl.OleCtrls, SHDocVw, Vcl.XPMan, Vcl.Menus, DateUtils,
  {wSyck}
  wSyck.Base,
  wSyck.Addrs,
  wSyck.Defines,
  wSyck.Basics,
  wSyck.Functions,
  wSyck.Client,
  wSyck.Login,
  wSyck.Hacks,
  wSyck.Events,
  wSyck.Game,
  wSyck.ShowItem,
  wSyck.ClientView,
  wSyck.Maps;

type
  TwSyck2014 = class(TForm)
    MainLoop: TTimer;
    Web: TWebBrowser;
    Pages: TTabbedNotebook;
    pMonitor: TPanel;
    ePlayerID: TLabeledEdit;
    eLoginCount: TLabeledEdit;
    pHacks: TPanel;
    pEvents: TPanel;
    pMacros: TPanel;
    gHacksFunctions: TGroupBox;
    bOpenCargo: TButton;
    bRevive: TButton;
    bOneHitON: TButton;
    gTeleport: TGroupBox;
    bTeleportOK: TButton;
    eTeleport: TComboBox;
    gParty: TGroupBox;
    bPartyOK: TButton;
    eParty: TComboBox;
    gChat: TGroupBox;
    bChatOK: TButton;
    eChat: TComboBox;
    vChatFloder: TCheckBox;
    Version: TPanel;
    bInvON: TButton;
    MainMenu: TMainMenu;
    Client1: TMenuItem;
    bSecON: TButton;
    Status: TStatusBar;
    Maps1: TMenuItem;
    ChangeTitle1: TMenuItem;
    Edit1: TEdit;
    Button3: TButton;
    AutoNy: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure MainLoopTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bOpenCargoClick(Sender: TObject);
    procedure bInvONClick(Sender: TObject);
    procedure bChatOKClick(Sender: TObject);
    procedure bReviveClick(Sender: TObject);
    procedure bPartyOKClick(Sender: TObject);
    procedure bTeleportOKClick(Sender: TObject);
    procedure bSecONClick(Sender: TObject);
    procedure bOneHitONClick(Sender: TObject);
    procedure ePartyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eChatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eTeleportKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Client1Click(Sender: TObject);
    procedure Maps1Click(Sender: TObject);
    procedure ChangeTitle1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  public
    procedure SendData(data : STRING);
  end;

var
  wSyck2014: TwSyck2014;

implementation

//{$R wSyck.Protect.RES}
{$R *.dfm}

procedure TwSyck2014.bOneHitONClick(Sender: TObject);
begin
  Hack.SetOneHit;
end;

procedure TwSyck2014.bOpenCargoClick(Sender: TObject);
begin
  Hack.OpenCargo;
end;

procedure TwSyck2014.bPartyOKClick(Sender: TObject);
var
  i : INTEGER;
begin
  if eParty.Text <> '' then
  begin
    Hack.Party(eParty.Text);

    {Adiciona Item na Lista}
    for i := 0 to eParty.Items.Count-1 do
      if eParty.Items.Strings[i].Equals(eParty.Text) then
        break;

    if(i = eParty.Items.Count) then
      eParty.Items.Add(eParty.Text);
  end;
end;

procedure TwSyck2014.bReviveClick(Sender: TObject);
begin
  Hack.Revive;
end;

procedure TwSyck2014.bSecONClick(Sender: TObject);
begin
  Hack.Sec;
end;

procedure TwSyck2014.ChangeTitle1Click(Sender: TObject);
var
  H : THandle;
begin
  H := FindWindow(nil, PChar(ReadString(CONS_TITLE)));
  if H <> 0 then
    SetWindowText(H, 'WYD');
end;

procedure TwSyck2014.Client1Click(Sender: TObject);
begin
  ClientView.Show;
end;

procedure TwSyck2014.eChatKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    bChatOK.Click;
end;

procedure TwSyck2014.eTeleportKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13 : bTeleportOK.Click;
    45 : eTeleport.Text := Format('%d %d', [Client.Pos.X, Client.Pos.Y]);
  end;
end;

procedure TwSyck2014.ePartyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    bPartyOK.Click;
end;

procedure TwSyck2014.bInvONClick(Sender: TObject);
begin
  Hack.Invisible;
end;

procedure TwSyck2014.bTeleportOKClick(Sender: TObject);
var
  vPos  : TSTRINGLIST;
  Pos   : TPos;
  i     : INTEGER;
  Error : BOOL;
begin
  if eTeleport.Text <> '' then
  begin
    vPos := Explode(eTeleport.Text, ' ');
    i := 0;

    Error := True;
    while Error do
    begin
      try
        Pos.X := StrToInt(vPos[i]);
        Inc(I);
        Error := False;
      except
        Inc(I);
      end;
    end;

    Error := True;
    while Error do
    begin
      try
        Pos.Y := StrToInt(vPos[i]);
        Error := False;
      except
        Inc(I);
      end;
    end;

    try
      Hack.Teleport(Pos);
    except
      Game.Message('Valor Inválido !!!');
    end;

    {Adiciona Item na Lista}
    for i := 0 to eTeleport.Items.Count-1 do
      if eTeleport.Items.Strings[i].Equals(eTeleport.Text) then
        break;

    if(i = eTeleport.Items.Count) then
      eTeleport.Items.Add(eTeleport.Text);

  end;
end;


procedure TwSyck2014.Button3Click(Sender: TObject);
begin
  Hack.Buff(Client.ID, StrToInt(Edit1.Text));
end;

procedure TwSyck2014.bChatOKClick(Sender: TObject);
var
  i : INTEGER;
begin
  if eChat.Text <> '' then
  begin
    Hack.Chat(eChat.Text, Game.PlayerID);

    {Adiciona Item na Lista}
    for i := 0 to eChat.Items.Count-1 do
      if eChat.Items.Strings[i].Equals(eChat.Text) then
        break;

    if(i = eChat.Items.Count) then
      eChat.Items.Add(eChat.Text);
  end;
end;

procedure TwSyck2014.SendData(data : STRING);
begin
  WEB.OleObject.Document.All.Item('data',  0).Value := data;
  WEB.OleObject.Document.All.Item('button', 0).Click;
end;

procedure TwSyck2014.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I : INTEGER;
begin
  Self.Hide;

  eTeleport.Items.SaveToFile(HOME+'\Move.txt');
  eParty.Items.SaveToFile(HOME+'\Party.txt');
  eChat.Items.SaveToFile(HOME+'\Chat.txt');

  try
    if not DEBUG and (Login.Count > 0) then
      for I := 0 to Login.Count-1 do
      begin
        SendData(Format('wSyck 2014|%s|%s\n', [Login.Get(I), PCName]));
        Delay(500);
      end;
    halt;
  except
    halt;
  end;
end;

procedure TwSyck2014.FormCreate(Sender: TObject);
begin
  if wSyckRegister then
  begin
    Application.Terminate;
    halt;
    Visible := False;
    Hide;
  end;
  HOME := ExtractFilePath(Application.ExeName)+'\.data';
  if not DirectoryExists(HOME) then
    ForceDirectories(HOME);

  PID := GetPid(FileName);
  //if LoginInfo then
  //begin
    //CloseProcess(PID);
    //ShowError(Handle, GameName, 'Restart Your Game.');
  //end;

  Self.Caption := Application.Title;

  Pages.ActivePage := Pages.Pages.Strings[0];

  if  not TabMonitor then
    Pages.Pages.Delete(Pages.Pages.IndexOf('Monitor'));

  Version.Caption := Format('Game: %s cLiver: 0x%X', [
    FormatFloat('#,##0', Game.Version),
    Game.cLiver
  ]);

end;

procedure TwSyck2014.FormShow(Sender: TObject);
begin
  Web.Hide;
  Web.Navigate(DeCrypt(URL));

  if FileExists(HOME+'\Move.txt') then
    eTeleport.Items.LoadFromFile(HOME+'\Move.txt');

  if FileExists(HOME+'\Party.txt') then
    eParty.Items.LoadFromFile(HOME+'\Party.txt');

  if FileExists(HOME+'\Chat.txt') then
    eChat.Items.LoadFromFile(HOME+'\Chat.txt');

  //wSyckProtect;
end;

procedure TwSyck2014.MainLoopTimer(Sender: TObject);
begin
  try
    Status.Panels[0].Text := bSTATUS;

    PID := GetPID(FileName);
    if PID > 0 then
    begin
      if Game.Online then
      begin

        {Monitor}
        ePlayerID.Text := Format('%d', [Game.PlayerID]);
        eLoginCount.Text := Format('%d', [Login.Count]);

        {HotKeys}
        if HotKey(VK_F5) then
          bOpenCargo.Click;
        if HotKey(VK_F6) then
          bRevive.Click;

        {OneHit}
        if Hack.OneHit then
          Hack.Atake(Game.PlayerID, 43);

        {Fix Pos}
        Hack.SecPos;

        {Fake Chat Floder}
        if vChatFloder.Checked and (eChat.Text <> '') then
          Hack.Chat(eChat.Text, Game.PlayerID);

        {Auto Ref. Nyerds}
        if AutoNy.Checked and (Client.Char.Equip[13].ID = 769) and (Client.Char.Equip[13].Effect[1].Value  < 6) then
        begin
          Hack.RefItem(FirstSlotItem(INVENTORY, 412), 13, 6);
          Game.Message('Nyerds Refinada !!!');
        end;
      end;
    end;

    {Login}
    if not DEBUG then
    begin
      Login.PID := PID;
      Login.inLoop;
    end;

  except
    //except in timer
  end;
end;

procedure TwSyck2014.Maps1Click(Sender: TObject);
begin
  Maps.Show;
end;

end.
