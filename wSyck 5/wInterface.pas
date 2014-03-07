unit wInterface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.TabNotBk, Vcl.ExtCtrls,
  Vcl.StdCtrls, wDefines;

type
  TSyck = class(TForm)
    Timer: TTimer;
    Pages: TTabbedNotebook;
    PHacks: TPanel;
    HBox1: TGroupBox;
    bOpenCargo: TButton;
    bRevive: TButton;
    bSEC_ON: TButton;
    bSEC_OFF: TButton;
    bINV_ON: TButton;
    bINV_OFF: TButton;
    bONEHIT_OFF: TButton;
    bONEHIT_ON: TButton;
    HBox2: TGroupBox;
    vMove: TComboBox;
    bMove: TButton;
    HBox3: TGroupBox;
    vParty: TComboBox;
    bParty: TButton;
    HBox4: TGroupBox;
    vChat: TComboBox;
    bChat: TButton;
    vChatFix: TCheckBox;
    HBox5: TGroupBox;
    vPrompt: TComboBox;
    bPrompt: TButton;
    PMacros: TPanel;
    MBox1: TGroupBox;
    MNyerds: TCheckBox;
    MItem: TCheckBox;
    MRefItems: TLabeledEdit;
    MBox2: TGroupBox;
    Timer200M: TTimer;
    Time1S: TTimer;
    Life: TTimer;
    iDrop: TTimer;
    iEvent: TTimer;
    procedure FormShow(Sender: TObject);
    procedure bMoveClick(Sender: TObject);
    procedure vMoveKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bOpenCargoClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure bINV_ONClick(Sender: TObject);
    procedure bINV_OFFClick(Sender: TObject);
    procedure bSEC_ONClick(Sender: TObject);
    procedure bSEC_OFFClick(Sender: TObject);
    procedure bONEHIT_ONClick(Sender: TObject);
    procedure bONEHIT_OFFClick(Sender: TObject);
    procedure vPartyKeyPress(Sender: TObject; var Key: Char);
    procedure vChatKeyPress(Sender: TObject; var Key: Char);
    procedure bPartyClick(Sender: TObject);
    procedure bChatClick(Sender: TObject);
    procedure bPromptClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MNyerdsClick(Sender: TObject);
    procedure vMoveKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vPromptKeyPress(Sender: TObject; var Key: Char);
    procedure MItemClick(Sender: TObject);
    procedure Timer200MTimer(Sender: TObject);
    procedure Time1STimer(Sender: TObject);
    procedure bReviveClick(Sender: TObject);
    procedure LifeTimer(Sender: TObject);
    procedure iDropTimer(Sender: TObject);
    procedure iEventTimer(Sender: TObject);
  end;

var
  Syck: TSyck;

implementation

{$R *.dfm}

uses wFunctions, wHacks;

procedure TSyck.bChatClick(Sender: TObject);
var
  i : INTEGER;
  Insert : BOOLEAN;
begin
  Command('chat '+vChat.Text);
  Insert := True;
  for i := 0 to vChat.Items.Count-1 do
    if vChat.Items[i] = vChat.Text then Insert := False;
  if Insert then vChat.Items.Add(vChat.Text);
end;

procedure TSyck.bPromptClick(Sender: TObject);
var
  i : INTEGER;
  Insert : BOOLEAN;
  RET : CARDINAL;
begin
  Command(vPrompt.Text);
  Insert := True;
  for i := 0 to vPrompt.Items.Count-1 do
    if vPrompt.Items[i] = vPrompt.Text then Insert := False;
  if Insert then vPrompt.Items.Add(vPrompt.Text);
end;

procedure TSyck.bReviveClick(Sender: TObject);
begin
  Command('revive');
end;

procedure TSyck.bINV_OFFClick(Sender: TObject);
begin
  Command('inv off');
end;

procedure TSyck.bINV_ONClick(Sender: TObject);
begin
  Command('inv on');
end;

procedure TSyck.bMoveClick(Sender: TObject);
var
  i : INTEGER;
  Insert : BOOLEAN;
begin
  Command('move '+vMove.Text);
  Insert := True;
  for i := 0 to vMove.Items.Count-1 do
    if vMove.Items[i] = vMove.Text then
      Insert := False;
  if Insert then
  vMove.Items.Add(vMove.Text);
end;

procedure TSyck.bONEHIT_OFFClick(Sender: TObject);
begin
  Command('onehit off');
end;

procedure TSyck.bONEHIT_ONClick(Sender: TObject);
begin
  Command('onehit on');
end;

procedure TSyck.bOpenCargoClick(Sender: TObject);
begin
  Command('opencargo');
end;

procedure TSyck.bPartyClick(Sender: TObject);
var
  i : INTEGER;
  Insert : BOOLEAN;
begin
  Command('party '+vParty.Text);
  Insert := True;
  for i := 0 to vParty.Items.Count-1 do
    if vParty.Items[i] = vParty.Text then Insert := False;
  if Insert then vParty.Items.Add(vParty.Text);
end;

procedure TSyck.bSEC_OFFClick(Sender: TObject);
begin
  Command('sec off');
end;

procedure TSyck.bSEC_ONClick(Sender: TObject);
begin
  Command('sec on');
end;

procedure TSyck.iEventTimer(Sender: TObject);
begin
  try
    if (CheckGameState) and (Event.Active) then
    begin
      iEvent.Enabled := False;
      Sell_Items('412 413');
      iEvent.Enabled := True;
    end;
  except
    CliMsg(3000, 'Error : Except Timer');
  end;
end;

procedure TSyck.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TSyck.FormCreate(Sender: TObject);
var
  i : INTEGER;
begin
  Pages.ActivePage := Pages.Pages.Strings[0];
  {!XTRAP for i := 0 to 4 do wBYTE(CLIERROR[i], $EB);}
end;

procedure TSyck.FormShow(Sender: TObject);
var
  RFile : TSTRINGLIST;
  i : INTEGER;
begin
  RFile := LoadFile('Move.txt');
  for i := 0 to RFile.Count-1 do
    vMove.Items.Add(RFile[i]);

  RFile := LoadFile('Commands.txt');
  for i := 0 to RFile.Count-1 do
    vPrompt.Items.Add(RFile[i]);
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TSyck.iDropTimer(Sender: TObject);
begin
  try
    if (CheckGameState) and (Drop.Active) then CheckDrop;
  except
    CliMsg(3000, 'Error : Except Timer');
  end;
end;

procedure TSyck.LifeTimer(Sender: TObject);
var
  Pos : TPOINT;
begin
  try
    if (CheckGameState) and (cRevive) and (PDWORD(PDWORD(ADDR_MOBINFO)^+$74)^ = 0) then
    begin
      Life.Enabled := False;
      Pos.X := PosX;
      Pos.Y := PosY;
      Delay(100);
      Revive;
      Delay(100);
      Move(Pos.X, Pos.Y);
      Life.Enabled := True;
    end;
  except
    CliMsg(3000, 'Error : Except Timer');
  end;
end;

procedure TSyck.MItemClick(Sender: TObject);
begin
  if MItem.State = cbChecked then
  begin
   CliMsg(3000, 'Ref.Item [ON]');
   Count.RefSlot := 0;
   Count.RefNum  := 0;
  end
    else CliMsg(3000, 'Ref.Item [OFF]');
end;

procedure TSyck.MNyerdsClick(Sender: TObject);
begin
  if MNyerds.State = cbChecked then CliMsg(3000, 'Ref.Nyerds [ON]')
    else CliMsg(3000, 'Ref.Nyerds [OFF]');
end;

procedure TSyck.Time1STimer(Sender: TObject);
var
  Temp : TSTRINGLIST;
  SlotInv : INTEGER;
begin
  try
    if CheckGameState then
    begin
      if Count.Alert <= 10 then Inc(Count.Alert);

      if MNyerds.State = cbChecked then
      begin
        SlotInv := SlotItem(1, 412);
        if (SlotInv >= 0) and (SlotInv <= Max.Inventory) and (Equip[13].ID = 769) and (Equip[13].EFV1 <> 6) then
        begin
          RefItem(SlotInv, 13, 6);
          CliMsg(1000, 'Nyerds Refinada !!!')
        end;
      end;

      if MItem.State = cbChecked then
      begin
        Temp := Explode(MRefItems.Text);
        RefItem(Count.RefSlot, StrToInt(Temp[1]), ItemRefToEffect(4, StrToInt(Temp[2])));
        CliMsg(1000, 'Refinando Item +'+IntToStr(ItemEffectToRef(4, Equip[StrToInt(Temp[1])].EFV1))+', Aguarde ...');
        Inc(Count.RefSlot);
        Inc(Count.RefNum);
        if Count.RefSlot >= StrToInt(Temp[0]) then Count.RefSlot := 0;
        if Count.RefNum >= (StrToInt(Temp[0]) * 120) then
        begin
          MItem.State := cbUnChecked;
          CliMsg(800, 'Ref.Item Pausado ...');
        end;
        ShowMsg('PLS: '+IntToStr(Count.RefNum));
      end;

      {if Count.Alert = 5 then
        CliMsg(3000, 'Créditos: Syck e PedraoSilv');
      if Count.Alert = 10 then
        CliMsg(3000, 'www.cheatsbrasil.org');}
    end;
  except
    CliMsg(3000, 'Error : Except Timer');
  end;
end;


procedure TSyck.Timer200MTimer(Sender: TObject);
begin
  try
    if CheckGameState then
    begin
      if (vChatFix.State  = cbChecked) and (vChat.Text <> '') then Chat(VChat.Text);
    end;
    if Numeric.Active then
    begin
      ChangeNumeric(LeftValue(Numeric.Pos, Numeric.Size), IntToStr(Numeric.New));
       if Numeric.Inc then
      begin
        Inc(Numeric.Pos);
        CliMsg(3000, 'Testando Senha '+LeftValue(Numeric.Pos, Numeric.Size)+'/'+LeftValue(Numeric.Max, Numeric.Size)+', Aguarde ...');
        if Numeric.Pos >= Numeric.Max then
          Numeric.Active := False;
      end else
      begin
        Dec(Numeric.Pos);
        CliMsg(3000, 'Testando Senha '+LeftValue(Numeric.Pos, Numeric.Size)+'/'+LeftValue(Numeric.Min, Numeric.Size)+', Aguarde ...');
        if Numeric.Pos <= Numeric.Min then
          Numeric.Active := False;
      end;
    end;
  except
    CliMsg(3000, 'Error : Except Timer');
  end;
end;

procedure TSyck.TimerTimer(Sender: TObject);
begin
  try
    if CheckGameState then
    begin
      if HotKey(VK_F5) then Command('opencargo');
      if HotKey(VK_F6) then Command('revive');
      {ONEHIT ATK [SPACE]}
      if (HotKey(32)) and (OneHit) then Atake(PlayerID, 43, True, OneHit);
      //if HotKey(VK_INSERT) then CliMsg(1000, 'www.cheatsbrasil.org');
      SecCheck(Sec);
    end;
  except
    CliMsg(3000, 'Error : Except Timer');
  end;
end;

procedure TSyck.vChatKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then bChat.Click;
end;

procedure TSyck.vMoveKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_INSERT then VMove.Text := IntToStr(PosX)+' '+IntToStr(PosY);
end;

procedure TSyck.vMoveKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then bMove.Click;
end;

procedure TSyck.vPartyKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then bParty.Click;
end;

procedure TSyck.vPromptKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then bPrompt.Click;
end;

end.
