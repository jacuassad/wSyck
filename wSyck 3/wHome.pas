unit wHome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls , wFunctions, wAddrs, wStructs, wHacks,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.TabNotBk;

type
  TSyck = class(TForm)
    Pages: TTabbedNotebook;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    GroupBox3: TGroupBox;
    PX: TLabeledEdit;
    PY: TLabeledEdit;
    Button2: TButton;
    GroupBox4: TGroupBox;
    Button3: TButton;
    LinkMap: TComboBoxEx;
    Panel2: TPanel;
    HotKeys: TTimer;
    Hacks: TTimer;
    Button5: TButton;
    Button6: TButton;
    Event: TTimer;
    Status: TStatusBar;
    PStart: TButton;
    PStop: TButton;
    Button4: TButton;
    Button7: TButton;
    Button9: TButton;
    NPC1ID: TLabeledEdit;
    NPC1X: TLabeledEdit;
    NPC1Y: TLabeledEdit;
    NPC2ID: TLabeledEdit;
    NPC2X: TLabeledEdit;
    NPC2Y: TLabeledEdit;
    Guardar: TLabeledEdit;
    Agrupar: TLabeledEdit;
    Apagar: TLabeledEdit;
    Panel3: TPanel;
    PNum1: TLabeledEdit;
    PNum2: TLabeledEdit;
    PNumNew: TLabeledEdit;
    PNumSize: TLabeledEdit;
    Button8: TButton;
    Button10: TButton;
    PNumVisor: TLabeledEdit;
    Numeric: TTimer;
    InputA: TLabeledEdit;
    InputB: TLabeledEdit;
    b1: TButton;
    b3: TButton;
    b2: TButton;
    b4: TButton;
    b5: TButton;
    b6: TButton;
    b7: TButton;
    b8: TButton;
    Button11: TButton;
    Button13: TButton;
    Button14: TButton;
    GroupBox2: TGroupBox;
    Button15: TButton;
    PNick: TLabeledEdit;
    Button16: TButton;
    Button17: TButton;
    Button12: TButton;
    Button18: TButton;
    Button19: TButton;
    MoveChar: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure HotKeysTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HacksTimer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure EventTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PStartClick(Sender: TObject);
    procedure PStopClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure NumericTimer(Sender: TObject);
    procedure b1Click(Sender: TObject);
    procedure b2Click(Sender: TObject);
    procedure b5Click(Sender: TObject);
    procedure b4Click(Sender: TObject);
    procedure b6Click(Sender: TObject);
    procedure b3Click(Sender: TObject);
    procedure b8Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
  end;

var
  Syck : TSyck;
  Sec : POINT;
  PsCargo, aNumeric, bNumeric : INTEGER;
  cEvent, cRevive, cNumeric, cOneHit : BOOLEAN;

implementation

{$R *.dfm}

procedure TSyck.b1Click(Sender: TObject);
begin
  Amount(InputA.Text);
end;

procedure TSyck.b2Click(Sender: TObject);
begin
  ReAmount(InputA.Text);
end;

procedure TSyck.b3Click(Sender: TObject);
var
  i : INTEGER;
begin
  for i := 0 to 29 do Sell(StrToInt(InputA.Text), i);
end;

procedure TSyck.b4Click(Sender: TObject);
var
  i : INTEGER;
begin
  i := SearchItem(0);
  if i <> -1 then Buy(StrToInt(InputA.Text),  StrToInt(InputB.Text), i);
end;

procedure TSyck.b5Click(Sender: TObject);
var
  i : INTEGER;
begin
  for i := 0 to 29 do Erase(i, InputA.Text);
end;

procedure TSyck.b6Click(Sender: TObject);
begin
  ClickNPC(StrToInt(InputA.Text));
end;

procedure TSyck.b8Click(Sender: TObject);
begin
  ShowMessage('INDEX : '+IntToStr(GetInventory.Items[0].Index)+#13+
  'EF1 : '+IntToStr(GetInventory.Items[0].EF1)+', '+'EFV1 : '+IntToStr(GetInventory.Items[0].EFV1)+#13+
  'EF2 : '+IntToStr(GetInventory.Items[0].EF2)+', '+'EFV2 : '+IntToStr(GetInventory.Items[0].EFV2)+#13+
  'EF3 : '+IntToStr(GetInventory.Items[0].EF3)+', '+'EFV3 : '+IntToStr(GetInventory.Items[0].EFV3)+#13);
end;

procedure TSyck.Button10Click(Sender: TObject);
begin
  {cNumeric := False;
  Numeric.Enabled := False;}
end;

procedure TSyck.Button11Click(Sender: TObject);
var
  i, ID : INTEGER;
  Buffer : ARRAY OF BYTE;
begin
  for i := 0 to 29 do
  begin
    ID := GetInventory.Items[i].Index;
    if ID <> 0 then
    begin
      SetLength(Buffer, $14);
      PWORD(INTEGER(Buffer)+00)^ := $14;
      PWORD(INTEGER(Buffer)+04)^ := $2E4;
      PWORD(INTEGER(Buffer)+06)^ := GetClientID;
      PWORD(INTEGER(Buffer)+12)^ := i;
      PWORD(INTEGER(Buffer)+16)^ := ID;
      SendPacket(Buffer, $14);
      SendPacket(Buffer, $14);
      Delay(200);
    end;
  end;
end;

procedure TSyck.Button12Click(Sender: TObject);
begin
  InputA.Text := IntToStr(GetPlayerID);
end;

procedure TSyck.Button13Click(Sender: TObject);
begin
 cOneHit := True;
end;

procedure TSyck.Button14Click(Sender: TObject);
begin
 cOneHit := False;
end;

procedure TSyck.Button15Click(Sender: TObject);
begin
  PartyHack(PNick.Text);
end;

procedure TSyck.Button16Click(Sender: TObject);
begin
  Px.Text := IntToStr(GetPosX);
  Py.Text := IntToStr(GetPosY);
end;

procedure TSyck.Button17Click(Sender: TObject);
begin
  ShowMessage('Client ID: '+IntToStr(GetClientID)+#13+'Posição: X:'+IntToStr(GetPosX)+', Y:'+IntToStr(GetPosY));
end;

procedure TSyck.Button18Click(Sender: TObject);
begin
  Chat(GetPlayerID, InputA.Text);
end;

procedure TSyck.Button19Click(Sender: TObject);
var
  i : INTEGER;
begin
  for i := 1 to 999 do Chat(i, InputA.Text);
end;

procedure TSyck.Button1Click(Sender: TObject);
begin
  Status.Panels[0].Text := 'Open Cargo';
  OpenCargo;
end;

procedure TSyck.Button2Click(Sender: TObject);
var
  Position : POINT;
begin
  Status.Panels[0].Text := 'Moved X: '+Px.Text+' Y: '+Py.Text;
  Position.X := StrToInt(Px.Text);
  Position.Y := StrToInt(Py.Text);
  if MoveChar.State = cbChecked then Moved(True, Position)
  else Moved(False, Position);
end;

procedure TSyck.Button3Click(Sender: TObject);
var
  Temp : TStringList;
  Position : POINT;
begin
  if LinkMap.Text <> '' then
  begin
    Temp := Explode(LinkMap.Text);
    Status.Panels[0].Text := 'Moved X: '+Temp[1]+' Y: '+Temp[2];
    Position.X := StrToInt(Temp[1]);
    Position.Y := StrToInt(Temp[2]);
    if MoveChar.State = cbChecked then Moved(True, Position)
    else Moved(False, Position);
  end;
end;

procedure TSyck.Button4Click(Sender: TObject);
begin
  Inv(True);
end;

procedure TSyck.PStartClick(Sender: TObject);
begin
  {Status.Panels[0].Text := 'Iniciando Evento ...';
  Event.Enabled := True;
  cEvent := True;}
end;

procedure TSyck.Button5Click(Sender: TObject);
begin
  Status.Panels[0].Text := 'Sec ON';
  Sec.X := GetPosX;
  Sec.Y := GetPosY;
  {TEMPORARIO = SEM GAMECHECKSTATE}
  Hacks.Enabled := True;
end;

procedure TSyck.Button6Click(Sender: TObject);
begin
  Status.Panels[0].Text := 'Sec OFF';
  Sec.X := 0;
  Sec.Y := 0;
  {TEMPORARIO = SEM GAMECHECKSTATE}
  Hacks.Enabled := False;
end;

procedure TSyck.Button7Click(Sender: TObject);
begin
  Inv(False);
end;

procedure TSyck.Button8Click(Sender: TObject);
begin
  {aNumeric := StrToInt(Pnum1.Text);
  bNumeric := StrToInt(Pnum2.Text);
  cNumeric := True;
  Numeric.Enabled := True;}
end;

procedure TSyck.Button9Click(Sender: TObject);
begin
  Revive;
end;

procedure TSyck.PStopClick(Sender: TObject);
begin
  {Status.Panels[0].Text := 'Evento pausado';
  Event.Enabled := False;
  cEvent := False;}
end;

procedure TSyck.EventTimer(Sender: TObject);
var
  i, p : INTEGER;
  Delete : STRING;
  Position : POINT;
  Temp : TSTRINGLIST;
begin
  Event.Enabled := False;
  {INICIO EVENTO : EM BUSCA DE PODERES}
  Position.X := StrToInt(NPC1X.Text);
  Position.Y := StrToInt(NPC1Y.Text);
  Moved(False, Position);
  Delay(100);

  for i := 00 to 09 do Buy(StrToInt(NPC1ID.Text), 58, i);
  for i := 10 to 19 do Buy(StrToInt(NPC1ID.Text), 30, i);
  for i := 20 to 29 do Buy(StrToInt(NPC1ID.Text), 01, i);

  Position.X := StrToInt(NPC2X.Text);
  Position.Y := StrToInt(NPC2Y.Text);
  Moved(False, Position);
  Delay(100);

  for i := 0 to 9 do ClickNPC(StrToInt(NPC2ID.Text));
  {LISTA COM ITEMS QUE DEVEM SER APAGADOS}
  for i := 0 to 9 do Erase(i, Apagar.Text);

  Amount(Agrupar.Text);

  {LISTA COM ITEMS QUE DEVEM SER GUARDADOS}
  for i := 0 to 9 do
  begin
    Temp := Explode(Guardar.Text);
    for p := 0 to Temp.Count-1 do
    begin
      if GetInventory.Items[i].Index = StrToInt(Temp[p]) then
      begin
        {PsCargo = TEMPORARIO}
        MoveItem(i, 1, PsCargo, 2, Guardar.Text);
        Inc(PsCargo);
        if PsCargo >= 120 then PsCargo := 0;
      end;
    end;
  end;
  {FIM EVENTO}
  if cEvent = True then Event.Enabled := True;
end;

procedure TSyck.FormCreate(Sender: TObject);
begin
  Pages.ActivePage := Pages.Pages.Strings[0];
  {INICIALIZAÇÕES}
  Sec.X := 0;
  Sec.Y := 0;
  PsCargo := 0;

  {STRINGS TIPO 'PESA ARCANO' FAZ O XTRAP DETECTAR}
  {ARMIA}
  LinkMap.Items.Add('A, 2100, 2100');
  {PESA A}
  LinkMap.Items.Add('P A, 1209, 172');
  {LICH}
  LinkMap.Items.Add('P 1, 3448, 1629');
  {AMON}
  LinkMap.Items.Add('P 3, 3353, 1443');
  {BARLOG}
  LinkMap.Items.Add('B BL, 3396, 1214');
  {PORTAO INFERNAL}
  LinkMap.Items.Add('P I, 1843, 3652');
  {GUERRA DE CIDADES}
  LinkMap.Items.Add('WR, 189, 193');
  {CIDADE KEFRA}
  LinkMap.Items.Add('C K, 3250, 1703');
  {PILAR DESERTO}
  LinkMap.Items.Add('P D, 1186, 1706');
  {PVP ARMIA}
  LinkMap.Items.Add('PVP, 2144, 2144');

  //PBYTE($004B9165)^ := $EB; {Create Scene Fail}
  //PBYTE($004F7341)^ := $EB; {Crashed Character Unit Time}
  //PBYTE($00477FDA)^ := $EB; {Critical Data Error In Client}
  //PBYTE($00478023)^ := $EB; {Critical Data Error In Client}
  //PBYTE($004A8B39)^ := $EB; {Critical Data Error In Client}
end;

procedure TSyck.HacksTimer(Sender: TObject);
begin
  if {CheckGameState = }True then
  begin
    SecCheck(Sec);
  end;
end;

procedure TSyck.HotKeysTimer(Sender: TObject);
begin
  if(GetAsyncKeyState(VK_F5) < 0) then OpenCargo;
  if(GetAsyncKeyState(VK_F6) < 0) then Revive;
  if(GetAsyncKeyState(VK_HOME) < 0) then PStart.Click;
  if(GetAsyncKeyState(VK_END) < 0) then PStop.Click;
  {ONEHIT ATK [SPACE]}
  if(GetAsyncKeyState(32) < 0) and (cOneHit) then Atake(43, True);
end;

procedure TSyck.NumericTimer(Sender: TObject);
var
  i : STRING;
begin
  {NÃO FUNCIONAL !!!}
  Numeric.Enabled := False;
  {NUMERIC}
  if StrToInt(PNumSize.Text) = 4 then i := Format('%5.4d', [aNumeric]) else
  if StrToInt(PNumSize.Text) = 5 then i := Format('%5.5d', [aNumeric]) else
  if StrToInt(PNumSize.Text) = 6 then i := Format('%5.6d', [aNumeric]);
  ChangeNumeric(i, PNumNew.Text);
  PNumVisor.Text := i;
  Inc(aNumeric);
  if aNumeric > bNumeric then cNumeric := False;
  if cNumeric then Numeric.Enabled := True;
end;

end.
