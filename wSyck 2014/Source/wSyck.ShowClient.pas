unit wSyck.ShowClient;

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
  TShowItems = class(TForm)
    GroupBox2: TGroupBox;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    Button38: TButton;
    Button39: TButton;
    Button40: TButton;
    Button41: TButton;
    Button42: TButton;
    Button43: TButton;
    Button44: TButton;
    Button45: TButton;
    Button46: TButton;
    Button47: TButton;
    Button48: TButton;
    GroupBox3: TGroupBox;
    Button65: TButton;
    Button66: TButton;
    Button69: TButton;
    Button72: TButton;
    Button73: TButton;
    Button76: TButton;
    Button77: TButton;
    Button80: TButton;
    Button81: TButton;
    Button85: TButton;
    Button86: TButton;
    Button88: TButton;
    Button89: TButton;
    Button90: TButton;
    Button91: TButton;
    Button92: TButton;
    Button67: TButton;
    Button68: TButton;
    Button70: TButton;
    Button71: TButton;
    Button74: TButton;
    Button75: TButton;
    Button78: TButton;
    Button79: TButton;
    Button82: TButton;
    Button83: TButton;
    Button84: TButton;
    Button87: TButton;
    Button93: TButton;
    Button94: TButton;
    Button95: TButton;
    Button96: TButton;
    Button97: TButton;
    Button98: TButton;
    Button99: TButton;
    Button100: TButton;
    Button101: TButton;
    Button102: TButton;
    Button103: TButton;
    Button104: TButton;
    Button105: TButton;
    Button106: TButton;
    Button107: TButton;
    Button108: TButton;
    Button109: TButton;
    Button110: TButton;
    Button111: TButton;
    Button112: TButton;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button49: TButton;
    Button50: TButton;
    Button51: TButton;
    Button52: TButton;
    Button53: TButton;
    Button54: TButton;
    Button55: TButton;
    Button56: TButton;
    Button57: TButton;
    Button58: TButton;
    Button59: TButton;
    Button60: TButton;
    Button61: TButton;
    Button62: TButton;
    Button63: TButton;
    Button64: TButton;
    Button114: TButton;
    Button115: TButton;
    Button116: TButton;
    Button117: TButton;
    Button118: TButton;
    Button119: TButton;
    Button122: TButton;
    Button123: TButton;
    Button124: TButton;
    Button125: TButton;
    Button126: TButton;
    Button127: TButton;
    Button130: TButton;
    Button131: TButton;
    Button132: TButton;
    Button133: TButton;
    Button134: TButton;
    Button135: TButton;
    Button138: TButton;
    Button139: TButton;
    Button140: TButton;
    Button141: TButton;
    Button142: TButton;
    Button143: TButton;
    Button113: TButton;
    Button120: TButton;
    Button121: TButton;
    Button128: TButton;
    Button129: TButton;
    Button136: TButton;
    Button137: TButton;
    Button144: TButton;
    Button145: TButton;
    Button146: TButton;
    Button147: TButton;
    Button148: TButton;
    Button149: TButton;
    Button150: TButton;
    Button151: TButton;
    Button152: TButton;
    Button153: TButton;
    Button154: TButton;
    Button155: TButton;
    Button156: TButton;
    Button157: TButton;
    Button158: TButton;
    Button159: TButton;
    Button160: TButton;
    Button161: TButton;
    Button162: TButton;
    Button163: TButton;
    Button164: TButton;
    Button165: TButton;
    Button166: TButton;
    Button167: TButton;
    Button168: TButton;
    Button169: TButton;
    Button170: TButton;
    Button171: TButton;
    Button172: TButton;
    Button173: TButton;
    Button174: TButton;
    Button175: TButton;
    Button176: TButton;
    Button177: TButton;
    Button178: TButton;
    Button179: TButton;
    Button180: TButton;
    Button181: TButton;
    Button182: TButton;
    Button183: TButton;
    Button184: TButton;
    Button185: TButton;
    Button186: TButton;
    Button187: TButton;
    Button188: TButton;
    Button189: TButton;
    Button190: TButton;
    Button191: TButton;
    Button192: TButton;
    Button193: TButton;
    Button194: TButton;
    Button195: TButton;
    Button196: TButton;
    Button197: TButton;
    Button198: TButton;
    Button199: TButton;
    Button200: TButton;
    eCharGold: TLabeledEdit;
    eCargoGold: TLabeledEdit;
    MainLoop: TTimer;
    eID: TLabeledEdit;
    ePos: TLabeledEdit;
    eSpeed: TLabeledEdit;
    eHP: TLabeledEdit;
    procedure Button65Click(Sender: TObject);
    procedure Button66Click(Sender: TObject);
    procedure Button69Click(Sender: TObject);
    procedure Button72Click(Sender: TObject);
    procedure Button73Click(Sender: TObject);
    procedure Button76Click(Sender: TObject);
    procedure Button77Click(Sender: TObject);
    procedure Button80Click(Sender: TObject);
    procedure Button81Click(Sender: TObject);
    procedure Button85Click(Sender: TObject);
    procedure Button88Click(Sender: TObject);
    procedure Button86Click(Sender: TObject);
    procedure Button89Click(Sender: TObject);
    procedure Button90Click(Sender: TObject);
    procedure Button91Click(Sender: TObject);
    procedure Button92Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button109Click(Sender: TObject);
    procedure Button110Click(Sender: TObject);
    procedure Button111Click(Sender: TObject);
    procedure Button112Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button108Click(Sender: TObject);
    procedure Button107Click(Sender: TObject);
    procedure Button106Click(Sender: TObject);
    procedure Button105Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button101Click(Sender: TObject);
    procedure Button102Click(Sender: TObject);
    procedure Button103Click(Sender: TObject);
    procedure Button104Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button100Click(Sender: TObject);
    procedure Button99Click(Sender: TObject);
    procedure Button98Click(Sender: TObject);
    procedure Button97Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button93Click(Sender: TObject);
    procedure Button94Click(Sender: TObject);
    procedure Button95Click(Sender: TObject);
    procedure Button96Click(Sender: TObject);
    procedure Button40Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button87Click(Sender: TObject);
    procedure Button84Click(Sender: TObject);
    procedure Button83Click(Sender: TObject);
    procedure Button82Click(Sender: TObject);
    procedure Button41Click(Sender: TObject);
    procedure Button42Click(Sender: TObject);
    procedure Button45Click(Sender: TObject);
    procedure Button46Click(Sender: TObject);
    procedure Button74Click(Sender: TObject);
    procedure Button75Click(Sender: TObject);
    procedure Button78Click(Sender: TObject);
    procedure Button79Click(Sender: TObject);
    procedure Button43Click(Sender: TObject);
    procedure Button44Click(Sender: TObject);
    procedure Button48Click(Sender: TObject);
    procedure Button47Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button141Click(Sender: TObject);
    procedure Button142Click(Sender: TObject);
    procedure Button143Click(Sender: TObject);
    procedure Button113Click(Sender: TObject);
    procedure Button187Click(Sender: TObject);
    procedure Button188Click(Sender: TObject);
    procedure Button189Click(Sender: TObject);
    procedure Button190Click(Sender: TObject);
    procedure Button191Click(Sender: TObject);
    procedure Button192Click(Sender: TObject);
    procedure Button200Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button140Click(Sender: TObject);
    procedure Button139Click(Sender: TObject);
    procedure Button138Click(Sender: TObject);
    procedure Button120Click(Sender: TObject);
    procedure Button186Click(Sender: TObject);
    procedure Button185Click(Sender: TObject);
    procedure Button184Click(Sender: TObject);
    procedure Button183Click(Sender: TObject);
    procedure Button182Click(Sender: TObject);
    procedure Button181Click(Sender: TObject);
    procedure Button199Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button133Click(Sender: TObject);
    procedure Button134Click(Sender: TObject);
    procedure Button135Click(Sender: TObject);
    procedure Button121Click(Sender: TObject);
    procedure Button180Click(Sender: TObject);
    procedure Button179Click(Sender: TObject);
    procedure Button178Click(Sender: TObject);
    procedure Button177Click(Sender: TObject);
    procedure Button176Click(Sender: TObject);
    procedure Button175Click(Sender: TObject);
    procedure Button198Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button132Click(Sender: TObject);
    procedure Button131Click(Sender: TObject);
    procedure Button130Click(Sender: TObject);
    procedure Button128Click(Sender: TObject);
    procedure Button169Click(Sender: TObject);
    procedure Button170Click(Sender: TObject);
    procedure Button171Click(Sender: TObject);
    procedure Button172Click(Sender: TObject);
    procedure Button173Click(Sender: TObject);
    procedure Button174Click(Sender: TObject);
    procedure Button197Click(Sender: TObject);
    procedure Button49Click(Sender: TObject);
    procedure Button53Click(Sender: TObject);
    procedure Button52Click(Sender: TObject);
    procedure Button51Click(Sender: TObject);
    procedure Button125Click(Sender: TObject);
    procedure Button126Click(Sender: TObject);
    procedure Button127Click(Sender: TObject);
    procedure Button129Click(Sender: TObject);
    procedure Button168Click(Sender: TObject);
    procedure Button167Click(Sender: TObject);
    procedure Button166Click(Sender: TObject);
    procedure Button165Click(Sender: TObject);
    procedure Button164Click(Sender: TObject);
    procedure Button163Click(Sender: TObject);
    procedure Button196Click(Sender: TObject);
    procedure Button56Click(Sender: TObject);
    procedure Button54Click(Sender: TObject);
    procedure Button55Click(Sender: TObject);
    procedure Button50Click(Sender: TObject);
    procedure Button124Click(Sender: TObject);
    procedure Button123Click(Sender: TObject);
    procedure Button122Click(Sender: TObject);
    procedure Button136Click(Sender: TObject);
    procedure Button157Click(Sender: TObject);
    procedure Button158Click(Sender: TObject);
    procedure Button159Click(Sender: TObject);
    procedure Button160Click(Sender: TObject);
    procedure Button161Click(Sender: TObject);
    procedure Button162Click(Sender: TObject);
    procedure Button195Click(Sender: TObject);
    procedure Button57Click(Sender: TObject);
    procedure Button58Click(Sender: TObject);
    procedure Button61Click(Sender: TObject);
    procedure Button62Click(Sender: TObject);
    procedure Button117Click(Sender: TObject);
    procedure Button118Click(Sender: TObject);
    procedure Button119Click(Sender: TObject);
    procedure Button137Click(Sender: TObject);
    procedure Button156Click(Sender: TObject);
    procedure Button155Click(Sender: TObject);
    procedure Button154Click(Sender: TObject);
    procedure Button153Click(Sender: TObject);
    procedure Button152Click(Sender: TObject);
    procedure Button151Click(Sender: TObject);
    procedure Button194Click(Sender: TObject);
    procedure Button59Click(Sender: TObject);
    procedure Button60Click(Sender: TObject);
    procedure Button64Click(Sender: TObject);
    procedure Button63Click(Sender: TObject);
    procedure Button116Click(Sender: TObject);
    procedure Button115Click(Sender: TObject);
    procedure Button114Click(Sender: TObject);
    procedure Button144Click(Sender: TObject);
    procedure Button145Click(Sender: TObject);
    procedure Button147Click(Sender: TObject);
    procedure Button146Click(Sender: TObject);
    procedure Button148Click(Sender: TObject);
    procedure Button149Click(Sender: TObject);
    procedure Button150Click(Sender: TObject);
    procedure Button193Click(Sender: TObject);
    procedure MainLoopTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShowItems: TShowItems;

implementation

{$R *.dfm}

procedure SetItem(Item : TItem);
begin
  ShowItem.SetItem(Item);
  ShowItem.ShowModal;
end;

procedure TShowItems.Button100Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][14]);
end;

procedure TShowItems.Button101Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][6]);
end;

procedure TShowItems.Button102Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][7]);
end;

procedure TShowItems.Button103Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][8]);
end;

procedure TShowItems.Button104Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][9]);
end;

procedure TShowItems.Button105Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][1]);
end;

procedure TShowItems.Button106Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][15]);
end;

procedure TShowItems.Button107Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][14]);
end;

procedure TShowItems.Button108Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][13]);
end;

procedure TShowItems.Button109Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][5]);
end;

procedure TShowItems.Button10Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][34]);
end;

procedure TShowItems.Button110Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][6]);
end;

procedure TShowItems.Button111Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][7]);
end;

procedure TShowItems.Button112Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][8]);
end;

procedure TShowItems.Button113Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][8]);
end;

procedure TShowItems.Button114Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][32]);
end;

procedure TShowItems.Button115Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][31]);
end;

procedure TShowItems.Button116Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][30]);
end;

procedure TShowItems.Button117Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][15]);
end;

procedure TShowItems.Button118Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][16]);
end;

procedure TShowItems.Button119Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][17]);
end;

procedure TShowItems.Button11Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][33]);
end;

procedure TShowItems.Button120Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][23]);
end;

procedure TShowItems.Button121Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][38]);
end;

procedure TShowItems.Button122Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][2]);
end;

procedure TShowItems.Button123Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][1]);
end;

procedure TShowItems.Button124Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][40]);
end;

procedure TShowItems.Button125Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][25]);
end;

procedure TShowItems.Button126Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][26]);
end;

procedure TShowItems.Button127Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][27]);
end;

procedure TShowItems.Button128Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][13]);
end;

procedure TShowItems.Button129Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][28]);
end;

procedure TShowItems.Button12Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][32]);
end;

procedure TShowItems.Button130Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][12]);
end;

procedure TShowItems.Button131Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][11]);
end;

procedure TShowItems.Button132Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][10]);
end;

procedure TShowItems.Button133Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][35]);
end;

procedure TShowItems.Button134Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][36]);
end;

procedure TShowItems.Button135Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][37]);
end;

procedure TShowItems.Button136Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][3]);
end;

procedure TShowItems.Button137Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][18]);
end;

procedure TShowItems.Button138Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][22]);
end;

procedure TShowItems.Button139Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][21]);
end;

procedure TShowItems.Button13Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][6]);
end;

procedure TShowItems.Button140Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][20]);
end;

procedure TShowItems.Button141Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][5]);
end;

procedure TShowItems.Button142Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][6]);
end;

procedure TShowItems.Button143Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][7]);
end;

procedure TShowItems.Button144Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][33]);
end;

procedure TShowItems.Button145Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][34]);
end;

procedure TShowItems.Button146Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][36]);
end;

procedure TShowItems.Button147Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][35]);
end;

procedure TShowItems.Button148Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][37]);
end;

procedure TShowItems.Button149Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][38]);
end;

procedure TShowItems.Button14Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][9]);
end;

procedure TShowItems.Button150Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][39]);
end;

procedure TShowItems.Button151Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][24]);
end;

procedure TShowItems.Button152Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][23]);
end;

procedure TShowItems.Button153Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][22]);
end;

procedure TShowItems.Button154Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][21]);
end;

procedure TShowItems.Button155Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][20]);
end;

procedure TShowItems.Button156Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][19]);
end;

procedure TShowItems.Button157Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][4]);
end;

procedure TShowItems.Button158Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][5]);
end;

procedure TShowItems.Button159Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][6]);
end;

procedure TShowItems.Button15Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][8]);
end;

procedure TShowItems.Button160Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][7]);
end;

procedure TShowItems.Button161Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][8]);
end;

procedure TShowItems.Button162Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][9]);
end;

procedure TShowItems.Button163Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][34]);
end;

procedure TShowItems.Button164Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][33]);
end;

procedure TShowItems.Button165Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][32]);
end;

procedure TShowItems.Button166Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][31]);
end;

procedure TShowItems.Button167Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][30]);
end;

procedure TShowItems.Button168Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][29]);
end;

procedure TShowItems.Button169Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][14]);
end;

procedure TShowItems.Button16Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][7]);
end;

procedure TShowItems.Button170Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][15]);
end;

procedure TShowItems.Button171Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][16]);
end;

procedure TShowItems.Button172Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][17]);
end;

procedure TShowItems.Button173Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][18]);
end;

procedure TShowItems.Button174Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][19]);
end;

procedure TShowItems.Button175Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][4]);
end;

procedure TShowItems.Button176Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][3]);
end;

procedure TShowItems.Button177Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][2]);
end;

procedure TShowItems.Button178Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][1]);
end;

procedure TShowItems.Button179Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][40]);
end;

procedure TShowItems.Button17Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][1]);
end;

procedure TShowItems.Button180Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][39]);
end;

procedure TShowItems.Button181Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][29]);
end;

procedure TShowItems.Button182Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][28]);
end;

procedure TShowItems.Button183Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][27]);
end;

procedure TShowItems.Button184Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][26]);
end;

procedure TShowItems.Button185Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][25]);
end;

procedure TShowItems.Button186Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][24]);
end;

procedure TShowItems.Button187Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][9]);
end;

procedure TShowItems.Button188Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][10]);
end;

procedure TShowItems.Button189Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][11]);
end;

procedure TShowItems.Button18Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][2]);
end;

procedure TShowItems.Button190Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][12]);
end;

procedure TShowItems.Button191Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][13]);
end;

procedure TShowItems.Button192Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][14]);
end;

procedure TShowItems.Button193Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][40]);
end;

procedure TShowItems.Button194Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][25]);
end;

procedure TShowItems.Button195Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][10]);
end;

procedure TShowItems.Button196Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][35]);
end;

procedure TShowItems.Button197Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][20]);
end;

procedure TShowItems.Button198Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][5]);
end;

procedure TShowItems.Button199Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][30]);
end;

procedure TShowItems.Button19Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][3]);
end;

procedure TShowItems.Button1Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][1]);
end;

procedure TShowItems.Button200Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][15]);
end;

procedure TShowItems.Button20Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][4]);
end;

procedure TShowItems.Button21Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][9]);
end;

procedure TShowItems.Button22Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][12]);
end;

procedure TShowItems.Button23Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][11]);
end;

procedure TShowItems.Button24Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[1][10]);
end;

procedure TShowItems.Button25Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][2]);
end;

procedure TShowItems.Button26Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][5]);
end;

procedure TShowItems.Button27Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][4]);
end;

procedure TShowItems.Button28Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][3]);
end;

procedure TShowItems.Button29Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][10]);
end;

procedure TShowItems.Button2Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][2]);
end;

procedure TShowItems.Button30Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][13]);
end;

procedure TShowItems.Button31Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][12]);
end;

procedure TShowItems.Button32Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][11]);
end;

procedure TShowItems.Button33Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][3]);
end;

procedure TShowItems.Button34Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][14]);
end;

procedure TShowItems.Button35Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][6]);
end;

procedure TShowItems.Button36Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][5]);
end;

procedure TShowItems.Button37Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][4]);
end;

procedure TShowItems.Button38Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][12]);
end;

procedure TShowItems.Button39Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][13]);
end;

procedure TShowItems.Button3Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][3]);
end;

procedure TShowItems.Button40Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][11]);
end;

procedure TShowItems.Button41Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][4]);
end;

procedure TShowItems.Button42Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][5]);
end;

procedure TShowItems.Button43Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][12]);
end;

procedure TShowItems.Button44Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][13]);
end;

procedure TShowItems.Button45Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][6]);
end;

procedure TShowItems.Button46Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][7]);
end;

procedure TShowItems.Button47Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][15]);
end;

procedure TShowItems.Button48Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][14]);
end;

procedure TShowItems.Button49Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][21]);
end;

procedure TShowItems.Button4Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][4]);
end;

procedure TShowItems.Button50Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][39]);
end;

procedure TShowItems.Button51Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][24]);
end;

procedure TShowItems.Button52Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][23]);
end;

procedure TShowItems.Button53Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][22]);
end;

procedure TShowItems.Button54Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][37]);
end;

procedure TShowItems.Button55Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][38]);
end;

procedure TShowItems.Button56Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[2][36]);
end;

procedure TShowItems.Button57Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][11]);
end;

procedure TShowItems.Button58Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][12]);
end;

procedure TShowItems.Button59Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][26]);
end;

procedure TShowItems.Button5Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][16]);
end;

procedure TShowItems.Button60Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][27]);
end;

procedure TShowItems.Button61Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][13]);
end;

procedure TShowItems.Button62Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][14]);
end;

procedure TShowItems.Button63Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][29]);
end;

procedure TShowItems.Button64Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[3][28]);
end;

procedure TShowItems.Button65Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[0]);
end;

procedure TShowItems.Button66Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[1]);
end;

procedure TShowItems.Button69Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[2]);
end;

procedure TShowItems.Button6Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][19]);
end;

procedure TShowItems.Button72Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[3]);
end;

procedure TShowItems.Button73Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[4]);
end;

procedure TShowItems.Button74Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][8]);
end;

procedure TShowItems.Button75Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][9]);
end;

procedure TShowItems.Button76Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[5]);
end;

procedure TShowItems.Button77Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[6]);
end;

procedure TShowItems.Button78Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][10]);
end;

procedure TShowItems.Button79Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][11]);
end;

procedure TShowItems.Button7Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][18]);
end;

procedure TShowItems.Button80Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[7]);
end;

procedure TShowItems.Button81Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[8]);
end;

procedure TShowItems.Button82Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][3]);
end;

procedure TShowItems.Button83Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][2]);
end;

procedure TShowItems.Button84Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[4][1]);
end;

procedure TShowItems.Button85Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[9]);
end;

procedure TShowItems.Button86Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[11]);
end;

procedure TShowItems.Button87Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][15]);
end;

procedure TShowItems.Button88Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[10]);
end;

procedure TShowItems.Button89Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[12]);
end;

procedure TShowItems.Button8Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][17]);
end;

procedure TShowItems.Button90Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[13]);
end;

procedure TShowItems.Button91Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[14]);
end;

procedure TShowItems.Button92Click(Sender: TObject);
begin
  SetItem(Client.Char.Equip[15]);
end;

procedure TShowItems.Button93Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][7]);
end;

procedure TShowItems.Button94Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][8]);
end;

procedure TShowItems.Button95Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][9]);
end;

procedure TShowItems.Button96Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][10]);
end;

procedure TShowItems.Button97Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][2]);
end;

procedure TShowItems.Button98Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[3][1]);
end;

procedure TShowItems.Button99Click(Sender: TObject);
begin
  SetItem(Client.Char.Items[2][15]);
end;

procedure TShowItems.Button9Click(Sender: TObject);
begin
  SetItem(Client.Cargo.Items[1][31]);
end;

procedure TShowItems.MainLoopTimer(Sender: TObject);
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
      eCargoGold.Text := FormatFloat('###,###,##0', Client.Cargo.Gold);
    end;
  end;
end;

end.
