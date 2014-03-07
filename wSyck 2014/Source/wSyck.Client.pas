unit wSyck.Client;

interface

uses
   Winapi.Windows,
   {wSyck}
   wSyck.Base,
   wSyck.Addrs,
   wSyck.Defines,
   wSyck.Basics;

type
  TClient = class
  public
    function ID     : WORD;
    function Pos    : TPos;
    function Speed  : DWORD;
    function HP     : DWORD;
    function Live   : BOOL;
    function Char   : TChar;
    function Cargo  : TCargo;
    function Bolsas : BYTE;
  end;

var
  Client : TClient;

  function FirstSlotItem(Local, ItemID : WORD) : INTEGER;

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

function FirstSlotItem(Local, ItemID : WORD) : INTEGER;
var
  I, X : INTEGER;
begin
  Result := -1;

  case Local of
    EQUIP :
      begin
        for I := 0 to 15 do
          if Client.Char.Equip[I].ID = ItemID then
          begin
            Result := I;
            break;
          end;
      end;
    INVENTORY :
      begin
        for X := 1 to Client.Bolsas do
          for I := 1 to 15 do
            if Client.Char.Items[X][I].ID = ItemID then
            begin
              Result := ((X-1)*15)+I-1;
              break;
            end;
      end;
    CARGO :
      begin
        for X := 1 to 3 do
          for I := 1 to 40 do
            if Client.Cargo.Items[X][I].ID = ItemID then
            begin
              Result := ((X-1)*40)+I-1;
              break;
            end;
      end;
  end;
end;

function TClient.Bolsas : BYTE;
var
	H      : THandle;
  NBR    : SIZE_T;
  Unc, p : DWORD;
  Item   : TItem;
const
  BOLSA_ANDARILHO = 3467;
begin
    Result := 2;
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_ACC), @p, 4, NBR);
    Inc(p, $85C);
    Inc(p, SizeOf(TInventory));
    ReadProcessMemory(H, PTR(p), @Item, Sizeof(Item), NBR);
    if Item.ID = BOLSA_ANDARILHO then
      Inc(Result);

    Inc(p, SizeOf(TItem));
    ReadProcessMemory(H, PTR(p), @Item, Sizeof(Item), NBR);
    if Item.ID = BOLSA_ANDARILHO then
      Inc(Result);
end;

end.
