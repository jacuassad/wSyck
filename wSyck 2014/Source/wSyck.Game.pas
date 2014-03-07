unit wSyck.Game;

interface

uses
  Winapi.Windows, System.SysUtils,
  {wSyck}
  wSyck.Addrs,
  wSyck.Basics,
  wSyck.Defines,
  wSyck.Functions,
  wSyck.Client;

type
  TGame = class
  public
    function Version : DWORD;
    function cLiver  : DWORD;

    function Online   : BOOL;
    function PlayerID : DWORD;

    function ItemName(ItemID : WORD) : STRING;

    procedure Message(Msg : STRING; Args : ARRAY OF CONST; Delay : DWORD = 3000); overload;
    procedure Message(Msg : STRING; Delay : DWORD = 3000); overload;
    procedure ShowMsg(Msg : STRING; Args : ARRAY OF CONST); overload;
    procedure ShowMsg(Msg : STRING); overload;
  end;

var
  Game : TGame;

implementation

function TGame.Version : DWORD;
begin
  Result := DEFN_CLIENT;
end;

function TGame.cLiver : DWORD;
begin
  Result := CONS_CLIVER;
end;

function TGame.Online : BOOL;
begin
  try
    Result := (not wSyckRegister) and inValue(Client.ID, 1, 999) and inValue(Client.Pos.X, 1, 4096) and inValue(Client.Pos.Y, 1, 4096);
  except
    Result := False;
    Message('Você não está Online !!!');
  end;
end;

function TGame.PlayerID : DWORD;
begin
  Result := _PlayerID;
end;


function TGame.ItemName(ItemID : WORD) : STRING;
const
  Size = 140; //Sizeof Struct ItemList
begin
  Result := StringReplace(ReadString(CONS_ITEMS + (ItemID * Size)), '_', ' ', [rfReplaceAll, rfIgnoreCase])
end;


procedure TGame.Message(Msg : STRING; Args : ARRAY OF CONST; Delay : DWORD = 3000);
begin
  //_CliMsg(Delay, Format(Msg, Args));
  bSTATUS := Format(Msg, Args);
end;

procedure TGame.Message(Msg : STRING; Delay : DWORD = 3000);
begin
  Message(Msg, [], Delay);
end;

procedure TGame.ShowMsg(Msg : STRING; Args : ARRAY OF CONST);
begin
  if Online then
    _ShowMsg(Format(Msg, Args));
end;

procedure TGame.ShowMsg(Msg : STRING);
begin
  ShowMsg(Msg, []);
end;

end.
