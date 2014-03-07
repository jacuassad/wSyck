unit wSyck.ClientView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.TabNotBk, Vcl.ExtCtrls,
  {wSyck}
  wSyck.Defines,
  wSyck.Client,
  wSyck.Game,
  wSyck.ShowItem;

type
  TClientView = class(TForm)
    gInventory: TGroupBox;
    gEquip: TGroupBox;
    gCargo: TGroupBox;
    eCharGold: TLabeledEdit;
    eCargoGold: TLabeledEdit;
    eID: TLabeledEdit;
    ePos: TLabeledEdit;
    eSpeed: TLabeledEdit;
    eHP: TLabeledEdit;
    eBolsas: TLabeledEdit;
    MainLoop: TTimer;
    procedure MainLoopTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EquipClick(Sender: TObject);
    procedure InventoryClick(Sender: TObject);
    procedure CargoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClientView: TClientView;

implementation

{$R *.dfm}

procedure SetItem(Item : TItem);
begin
  ShowItem.SetItem(Item);
  ShowItem.Show;
end;

procedure TClientView.EquipClick(Sender: TObject);
begin
  if Sender is TButton then
    SetItem(Client.Char.Equip[TButton(Sender).Tag]);
end;

procedure TClientView.InventoryClick(Sender: TObject);
begin
  if Sender is TButton then
    SetItem(Client.Char.Items[((TButton(Sender).Tag-1) div 15)+1][((TButton(Sender).Tag-1) mod 15)+1]);
end;

procedure TClientView.CargoClick(Sender: TObject);
begin
  if Sender is TButton then
    SetItem(Client.Cargo.Items[((TButton(Sender).Tag-1) div 40)+1][((TButton(Sender).Tag-1) mod 40)+1]);    
end;

procedure TClientView.FormCreate(Sender: TObject);
var
  Button : TButton;
  I, J, vTop, vLeft : INTEGER;
begin
  {Create Buttons Equip}
  vTop  := 0;
  vLeft := 0;

  for I := 1 to 8  do
  begin
    for J := 2 downto 1 do
    begin
      Button := TButton.Create(Self);
      TWinControl(gEquip).InsertControl(Button);

      with Button do
      begin
        Tag := (I*2)-J;
        Caption := Format('%d', [Tag]);
        Top  := 15+vTop;
        Left := 10+vLeft;
        Width := 25;
        Height := 25;
        Cursor := crHandPoint;
        OnClick := EquipClick;
      end;

      Inc(vLeft, 32);
    end;
    vLeft := 0;
    Inc(vTop, 32);
  end;

  {Create Buttons Inventory}
  vTop  := 0;
  vLeft := 0;

  for I := 0 to 7  do
  begin
    for J := 1 to 8 do
    begin
      Button := TButton.Create(Self);
      TWinControl(gInventory).InsertControl(Button);

      with Button do
      begin
        Tag := (I*8)+J;
        Caption := Format('%d', [Tag]);
        Top  := 15+vTop;
        Left := 10+vLeft;
        Width := 25;
        Height := 25;
        Cursor := crHandPoint;
        OnClick := InventoryClick;

        if (I = 7) and (J > 4) then
        begin
            Caption := '';
          Enabled := False;
        end;
      end;

      Inc(vLeft, 32);
    end;
    vLeft := 0;
    Inc(vTop, 32);
  end;

  {Create Buttons Cargo}
  vTop  := 0;
  vLeft := 0;

  for I := 0 to 7  do
  begin
    for J := 1 to 15 do
    begin
      Button := TButton.Create(Self);
      TWinControl(gCargo).InsertControl(Button);

      with Button do
      begin
        Tag := (I*15)+J;
        Caption := Format('%d', [Tag]);
        Top  := 15+vTop;
        Left := 10+vLeft;
        Width := 25;
        Height := 25;
        Cursor := crHandPoint;
        OnClick := CargoClick;
      end;

      Inc(vLeft, 32);
    end;
    vLeft := 0;
    Inc(vTop, 32);
  end;

end;

procedure TClientView.MainLoopTimer(Sender: TObject);
begin
  if PID > 0 then
  begin
    if Game.Online then
    begin
      eID.Text        := Format('%d', [Client.ID]);
      ePos.Text       := Format('%d %d', [Client.Pos.X, Client.Pos.Y]);
      eSpeed.Text     := Format('%d', [Client.Speed]);
      eHP.Text        := Format('%d', [Client.HP]);
      eCharGold.Text  := FormatFloat('###,###,##0', Client.Char.Gold);
      eBolsas.Text    := Format('%d', [Client.Bolsas]);
      eCargoGold.Text := FormatFloat('###,###,##0', Client.Cargo.Gold);
    end;
  end;
end;

end.
