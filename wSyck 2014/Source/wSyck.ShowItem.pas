unit wSyck.ShowItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  {wSyck}
  wSyck.Defines,
  wSyck.Game;

type
  TShowItem = class(TForm)
    gItem: TGroupBox;
    eID: TLabeledEdit;
    eEF1: TLabeledEdit;
    eEFV1: TLabeledEdit;
    eEF2: TLabeledEdit;
    eEFV2: TLabeledEdit;
    eEF3: TLabeledEdit;
    eEFV3: TLabeledEdit;
  private
    { Private declarations }
  public
    procedure SetItem(Item : TItem);
  end;

var
  ShowItem: TShowItem;

implementation

{$R *.dfm}

procedure TShowItem.SetItem(Item : TItem);
begin
  eID.Text   := IntToStr(Item.ID);

  eEF1.Text  := IntToStr(Item.Effect[1].ID);
  eEFV1.Text := IntToStr(Item.Effect[1].Value);

  eEF2.Text  := IntToStr(Item.Effect[2].ID);
  eEFV2.Text := IntToStr(Item.Effect[2].Value);

  eEF3.Text  := IntToStr(Item.Effect[3].ID);
  eEFV3.Text := IntToStr(Item.Effect[3].Value);

  Self.Caption := Game.ItemName(Item.ID);
end;

end.
