unit wSyck.Client;

interface

  uses
    Winapi.Windows,
    wSyck.Defines, wSyck.Basics;

type
  TClient = class
  public
    function ID    : WORD;
    function Pos   : TPos;
    function Speed : DWORD;
    function HP    : DWORD;
    function Live  : BOOL;
    function Char  : TChar;
    function Cargo : TCargo;
  end;

  function FirstSlotItem(Local, ItemID : WORD) : WORD;

  var
    Client : TClient;

implementation

function TClient.ID : WORD;
begin
  Result := _ClientID;
end;

function TClient.Pos : TPos;
begin
  Result.X := _PosX;
  Result.Y := _PosY;
end;

function TClient.Speed : DWORD;
begin
  Result := _MoveSpeed;
end;

function TClient.HP : DWORD;
begin
  Result := _HP;
end;

function TClient.Live : BOOL;
begin
  Result := _Live;
end;

function TClient.Char : TChar;
begin
  Result.Gold  := _GoldChar;
  Result.Equip := _Equip;
  Result.Items := _Inventory;
end;

function TClient.Cargo : TCargo;
begin
  Result.Gold  := _GoldCargo;
  Result.Items := _Cargo;
end;

function FirstSlotItem(Local, ItemID : WORD) : WORD;
var
  I, X, P : INTEGER;
begin
  P := 0;

  case Local of
    EQUIP : begin
      for I := 0 to 15 do
        if Client.Char.Equip[I].ID = ItemID then
        begin
          P := I;
          break;
        end;
    end;
    INVENTORY : begin
      for X := 1 to (2+BOLSA) do
        for I := 1 to 15 do
          if Client.Char.Items[X][I].ID = ItemID then
          begin
            P := I + ((X-1)*15);
            break;
          end;
    end;
    CARGO : begin
      for X := 1 to 3 do
        for I := 1 to 40 do
          if Client.Cargo.Items[X][I].ID = ItemID then
          begin
            P := I + ((X-1)*40);
            break;
          end;
    end;
  end;
  Result := P -1;
end;

end.
