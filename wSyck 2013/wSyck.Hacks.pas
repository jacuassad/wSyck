unit wSyck.Hacks;

interface

uses
  Winapi.Windows, System.SysUtils,
  wSyck.Addrs, wSyck.Defines, wSyck.Basics, wSyck.Functions, wSyck.Client, wSyck.Packet, wSyck.Game;

type
  THack = class
  private
    hSec    : TSec;
  public
    OneHit : BOOL;

    constructor Create();

    function Version : DWORD;
    procedure OpenCargo;
    procedure Teleport(Pos : TPos); overload;
    procedure Teleport(PosX, PosY : DWORD); overload;
    procedure Teleport(PosX, PosY : STRING); overload;
    procedure Revive;
    procedure Invisible(Active : BOOL);
    procedure SecPos;
    procedure Sec;
    procedure Atake(Index : DWORD; Skill : WORD; Mag : BOOL = True);
    procedure Party(Nick : STRING);
    procedure Chat(Msg : STRING);
    procedure FakeItem(Item : TItem); overload;
    procedure FakeItem(ID : WORD; EF1, EFV1, EF2, EFV2, EF3, EFV3 : BYTE); overload;
    procedure ChangeNumeric(Numeric, NewNumeric : STRING);
    procedure RefItem(SlotInv, SlotEquip, MaxRef : DWORD);
  end;

  var
    Hack : THack;

implementation

constructor THack.Create;
begin
  hSec.Active := False;
  OneHit := False;
end;

function THack.Version : DWORD;
begin
  Result := wSyck_Version;
end;

procedure THack.OpenCargo;
begin
  if Game.Online then
  begin
    _OpenCargo;
    Game.Message('Baú Aberto !!!');
  end;
end;

procedure THack.Teleport(Pos : TPos);
var
  Packet : TPacket;
begin
  if Game.Online then
  begin
    Packet := TPacket.Create($36C, $34);
    Packet.Write[12] := Client.Pos.X;
    Packet.Write[14] := Client.Pos.Y;
    Packet.Write[16] := 1;
    Packet.Write[20] := Client.Speed;
    Packet.Write[48] := Pos.X;
    Packet.Write[50] := Pos.Y;
    Packet.Send;

    asm
      MOV EAX, CONS_PTRDAT
      MOV EDX, DWORD PTR DS:[EAX]
      ADD EDX, $4C
      MOV ECX, DWORD PTR DS:[EDX]
    end;

    if (Abs(Pos.x - Client.Pos.X) < 200) or (Abs(Pos.Y - Client.Pos.Y) < 200) then
      Packet.ClientMove;

    Game.Message('Teleportado para X: %d Y: %d !!!', [Pos.X, Pos.Y]);
  end;
end;

procedure THack.Teleport(PosX, PosY : DWORD);
var
  Pos : TPos;
begin
  Pos.X := PosX;
  Pos.Y := PosY;
  Teleport(Pos);
end;

procedure THack.Teleport(PosX, PosY : STRING);
begin
  Teleport(StrToInt(PosX), StrToInt(PosY));
end;

procedure THack.Revive;
var
  Packet : TPacket;
begin
  if Game.Online then
  begin
    if not Client.Live then
    begin
      Packet := TPacket.Create($289, $E);
      Packet.Send;
      Game.Message('Você foi Revivido !!!');
    end
    else
      Game.Message('Você não está morto !!!');
  end;
end;

procedure THack.Invisible(Active : BOOL);
var
  Packet : TPacket;
  Pos    : TPos;
begin
  if Game.Online then
  begin
    Packet := TPacket.Create($AD9, $14);
    Packet.Write[12] := 2;
    if Active then
    begin
      Packet.Write[16] := 1;
      Packet.Send;
      Game.Message('Você está Invísivel !!!');
    end
    else
    begin
      Pos := Client.Pos;
      Packet.Write[16] := 2;
      Packet.Send;
      Teleport(Pos);
      Game.Message('Você está Vísivel !!!');
    end;
  end;
end;

procedure THack.Sec;
begin
  hSec.Active := not hSec.Active;
  if hSec.Active then
  begin
    hSec.Pos := Client.Pos;
    Game.Message('Sua posição foi fixada em %d %d !!!', [hSec.Pos.X, hSec.Pos.Y]);
  end
  else
  begin
    Game.Message('Posição não fixada !!!');
  end;

end;

procedure THack.SecPos;
begin
  if hSec.Active then
    if (hSec.Pos.X <> Client.Pos.X) and (hSec.Pos.Y <> Client.Pos.Y) then
      Teleport(hSec.Pos);
end;

procedure THack.Atake(Index : DWORD; Skill : WORD; Mag : BOOL = True);
var
  Packet : TPacket;
begin
  if Game.Online and inValue(Index, 1, 999) then
  begin
    if Mag then
    begin
      Packet := TPacket.Create($39D, $5E);
      Packet.Write[34] := Client.Pos.X;
      Packet.Write[36] := Client.Pos.Y;
      Packet.Write[38] := Client.Pos.X;
      Packet.Write[40] := Client.Pos.Y;
      Packet.Write[42] := Client.ID +2;
      Packet.Write[46] := $FF;
      Packet.Write[52] := $FFFFFFFF;
      Packet.Write[56] := Skill;
      Packet.Write[60] := Index;
      Packet.Write[64] := $FFFFFFFF;
      if OneHit then
      begin
        Packet.Write[48] := $07;
        Packet.Write[73] := $BBB;
      end;
      Packet.Send;
    end
    else
    begin
      {DAMAGE ATAKE}
    end;
  end;
  Game.Message('Você atacou %d !!!', [Index]);
end;

procedure THack.Party(Nick : STRING);
var
  Packet : TPacket;
  I : INTEGER;
begin
  if Game.Online and inValue(PlayerID, 1, 999) then
  begin
    Packet := TPacket.Create($3AB, $20);
    Packet.Write[12] := PlayerID;
    for I := 1 to length(Nick) do
      Packet.Write[13+I] := ord(Nick[I]);
    Packet.Send;
    Game.Message('Voce entro no grupo de %s (%d) !!!', [Nick, PlayerID]);
  end;
end;

procedure THack.Chat(Msg : STRING);
var
  Packet : TPacket;
  I : INTEGER;
begin
  if Game.Online and inValue(PlayerID, 1, 999) then
  begin
    Packet := TPacket.Create($333, $6C, PlayerID);
    for I := 1 to length(Msg) do
      Packet.Write[11+I] := ord(Msg[I]);
    Packet.Send;
    Game.Message('Possuir: %d, diz: %s', [PlayerID, Msg]);
  end;
end;

procedure THack.FakeItem(Item : TItem);
var
  Packet : TPacket;
  Slot : INTEGER;
begin
  Slot := FirstSlotItem(INVENTORY, 0);
  if Game.Online and (Slot <> -1) then
  begin
    Packet := TPacket.Create($182, $18);
    Packet.Write[12] := INVENTORY;
    Packet.Write[14] := Slot;
    Packet.Write[16] := Item.ID;
    Packet.Write[18] := Item.Effect[1].ID;
    Packet.Write[19] := Item.Effect[1].Value;
    Packet.Write[20] := Item.Effect[2].ID;
    Packet.Write[21] := Item.Effect[2].Value;
    Packet.Write[22] := Item.Effect[3].ID;
    Packet.Write[23] := Item.Effect[3].Value;

    asm
      MOV EAX, CONS_PTRDAT
      MOV EDX, DWORD PTR DS:[EAX]
      ADD EDX, $4C
      MOV ECX, DWORD PTR DS:[EDX]
    end;

    Packet.ClientAddItem;
    Game.Message('FakeItem: %d %d %d %d %d %d %d', [
      Item.ID,
      Item.Effect[1].ID,
      Item.Effect[1].Value,
      Item.Effect[2].ID,
      Item.Effect[2].Value,
      Item.Effect[3].ID,
      Item.Effect[3].Value
    ]);
  end;
end;

procedure THack.FakeItem(ID : WORD; EF1, EFV1, EF2, EFV2, EF3, EFV3 : BYTE);
var
  Item : TItem;
begin
  Item.ID              := ID;
  Item.Effect[1].ID    := EF1;
  Item.Effect[1].Value := EFV1;
  Item.Effect[2].ID    := EF2;
  Item.Effect[2].Value := EFV2;
  Item.Effect[3].ID    := EF3;
  Item.Effect[3].Value := EFV3;
  FakeItem(Item);
end;

procedure THack.ChangeNumeric(Numeric, NewNumeric : STRING);
var
  Packet, PacketNew : TPacket;
  I : INTEGER;
begin
  Packet := TPacket.Create($FDE, $20);
  for I := 1 to length(Numeric) do
    Packet.Write[11+I] := ord(Numeric[I]);
  Packet.Send;

  PacketNew := TPacket.Create($FDE, $20);
  for I := 1 to length(NewNumeric) do
    PacketNew.Write[11+I] := ord(NewNumeric[I]);
  PacketNew.Write[28] := 1;
  PacketNew.Send;
end;

procedure THack.RefItem(SlotInv, SlotEquip, MaxRef : DWORD);
var
  Packet : TPacket;
begin
  if Game.Online and (Client.Char.Equip[SlotEquip].Effect[1].Value <> MaxRef) then
  begin
    Packet := TPacket.Create($373, $24);
    Packet.Write[12] := 1;
    Packet.Write[16] := SlotInv;
    Packet.Write[24] := SlotEquip;
    Packet.Send;
  end;
end;

begin
  Hack := THack.Create;
end.
