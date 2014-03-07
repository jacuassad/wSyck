unit wHacks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, wFunctions, wAddrs, wStructs;
  {HACKS}
  procedure OpenCargo;
  procedure Moved(Move: BOOLEAN; Position : POINT);
  procedure Revive;
  procedure SecCheck(Position : POINT);
  procedure Inv(Active : BOOLEAN);
  procedure ChangeNumeric(Numeric, NewNumeric : STRING);
  procedure Atake(Skill : WORD; Onehit : BOOLEAN);
  procedure PartyHack(Nick : STRING);
  procedure Chat(Index : WORD; Msg : STRING);
  {EVENTO}
  procedure Erase(Slot : DWORD; Items : STRING);
  procedure Buy(NPC : WORD; nSlot, iSlot : BYTE);
  procedure ClickNPC(NPC : WORD);
  procedure Sell(NPC : WORD; Slot : DWORD);
  procedure MoveItem(srcSlot, srcType, dstSlot, dstType : BYTE; Items : STRING);
  procedure Amount(Items : STRING);
  procedure ReAmount(Items : STRING);
  procedure RefItem(iSlot, eSlot, MaxRef : DWORD);
  function SearchItem(ItemID : WORD) : WORD;

implementation


procedure OpenCargo;
  asm
    MOV  EAX, PTRDAT
    MOV  EDX, DWORD PTR DS : [EAX]
    PUSH 1
    MOV  ECX, EDX
    MOV  EAX, ADDR_CARGO
    CALL EAX
  end;

procedure Moved(Move: BOOLEAN; Position : POINT);
var
  Buffer : ARRAY OF BYTE;
begin
  if (Position.X >= 0) or (Position.X <= 4096) or (Position.Y >= 0) or (Position.Y <= 4096) then
  begin
    SetLength(Buffer, $34);
    PWORD(INTEGER(Buffer)+00)^ := $34;
    PWORD(INTEGER(Buffer)+04)^ := $36C;
    PWORD(INTEGER(Buffer)+06)^ := GetClientID;
    PWORD(INTEGER(Buffer)+12)^ := GetPosX;
    PWORD(INTEGER(Buffer)+14)^ := GetPosY;
    PWORD(INTEGER(Buffer)+16)^ := $01;
    PWORD(INTEGER(Buffer)+20)^ := PDWORD(ADDR_MOVESPEED)^;
    PWORD(INTEGER(Buffer)+48)^ := Position.X;
    PWORD(INTEGER(Buffer)+50)^ := Position.Y;
    SendPacket(Buffer, $34);
    asm
      MOV EAX, PTRDAT
      MOV EDX, DWORD PTR DS:[EAX]
      ADD EDX, $4C
      MOV ECX, DWORD PTR DS:[EDX]
    end;
    if Move = True then
    begin
      MoveChar($36C, Buffer);
      MoveChar($36C, Buffer);
    end;
  end;
end;

procedure Erase(Slot : DWORD; Items : STRING);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
  Item : TStringList;
begin
  Item := Explode(Items);
  if ((Slot >= 0) and (Slot <= 59) and (Item.Count >= 1)) then
  begin
    for i := 0 to Item.Count-1 do
    begin
      if (StrToInt(Item[i]) = GetInventory.Items[Slot].Index)then
      begin
        SetLength(Buffer, $14);
        PWORD(INTEGER(Buffer)+00)^ := $14;
        PWORD(INTEGER(Buffer)+04)^ := $2E4;
        PWORD(INTEGER(Buffer)+06)^ := GetClientID;
        PWORD(INTEGER(Buffer)+12)^ := Slot;
        PWORD(INTEGER(Buffer)+16)^ := StrToInt(Item[i]);
        SendPacket(Buffer, $14);
        SendPacket(Buffer, $14);
        Delay(200);
      end;
    end;
  end;
end;

procedure MoveItem(srcSlot, srcType, dstSlot, dstType : BYTE; Items : STRING);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
  Item : TSTRINGLIST;
begin
  Item := Explode(Items);
  if ((srcSlot >= 0) and (srcType >= 0) and (dstSlot >= 0) and (dstType >= 0) and (Item.Count >= 1)) then
  begin
    for i := 0 to Item.Count-1 do
    begin
      if StrToInt(Item[i]) = GetInventory.Items[srcSlot].Index then
      begin
        SetLength(Buffer, $14);
        PWORD(INTEGER(Buffer)+00)^ := $14;
        PWORD(INTEGER(Buffer)+04)^ := $376;
        PWORD(INTEGER(Buffer)+06)^ := GetClientID;
        PWORD(INTEGER(Buffer)+12)^ := dstType;
        PWORD(INTEGER(Buffer)+13)^ := dstSlot;
        PWORD(INTEGER(Buffer)+14)^ := srcType;
        PWORD(INTEGER(Buffer)+15)^ := srcSlot;
        SendPacket(Buffer, $14);
        Delay(100);
      end;
    end;
  end;
end;

procedure Buy(NPC : WORD; nSlot, iSlot : BYTE);
var
  Buffer : ARRAY OF BYTE;
begin
  if ((NPC >= 0) and (nSlot >= 0) and (iSlot >= 0)) then
  begin
    SetLength(Buffer, $18);
    PWORD(INTEGER(Buffer)+00)^ := $18;
    PWORD(INTEGER(Buffer)+04)^ := $379;
    PWORD(INTEGER(Buffer)+06)^ := GetClientID;
    PWORD(INTEGER(Buffer)+12)^ := NPC;
    PWORD(INTEGER(Buffer)+14)^ := nSlot;
    PWORD(INTEGER(Buffer)+16)^ := iSlot;
    SendPacket(Buffer, $18);
    Delay(100);
  end;
end;

procedure ClickNPC(NPC : WORD);
var
  Buffer : ARRAY OF BYTE;
begin
  if (NPC >= 0) then
  begin
    SetLength(Buffer, $14);
    PWORD(INTEGER(Buffer)+00)^ := $14;
    PWORD(INTEGER(Buffer)+04)^ := $28B;
    PWORD(INTEGER(Buffer)+06)^ := GetClientID;
    PWORD(INTEGER(Buffer)+12)^ := NPC;
    SendPacket(Buffer, $14);
    Delay(100);
  end;
end;

procedure Sell(NPC : WORD; Slot : DWORD);
var
  Buffer : ARRAY OF BYTE;
begin
  if ((NPC >= 0) and (Slot >= 0)) then
  begin
    SetLength(Buffer, $14);
    PWORD(INTEGER(Buffer)+00)^ := $14;
    PWORD(INTEGER(Buffer)+04)^ := $37A;
    PWORD(INTEGER(Buffer)+06)^ := GetClientID;
    PWORD(INTEGER(Buffer)+12)^ := NPC;
    PWORD(INTEGER(Buffer)+14)^ := $01;
    PWORD(INTEGER(Buffer)+16)^ := Slot;
    SendPacket(Buffer, $14);
    Delay(100);
  end;
end;

procedure Revive;
var
  Buffer : ARRAY OF BYTE;
  Position : POINT;
begin
  Position.X := GetPosX;
  Position.Y := GetPosY;
  SetLength(Buffer, $E);
  PWORD(INTEGER(Buffer)+00)^ := $E;
  PWORD(INTEGER(Buffer)+04)^ := $289;
  PWORD(INTEGER(Buffer)+06)^ := GetClientID;
  SendPacket(Buffer, $E);
  Moved(True, Position);
end;

procedure SecCheck(Position : POINT);
begin
    if((Position.X <> 0) and (Position.Y <> 0)) then
      if((Position.X <> GetPosX) or (Position.Y <> GetPosY)) then
          Moved(True, Position);
end;

procedure Inv(Active : BOOLEAN);
var
  Buffer : ARRAY OF BYTE;
  Position : POINT;
begin
  if Active then
  begin
    SetLength(Buffer, $14);
    PWORD(INTEGER(Buffer)+00)^ := 0;
    PWORD(INTEGER(Buffer)+02)^ := 0;
    PWORD(INTEGER(Buffer)+04)^ := $AD9;
    PWORD(INTEGER(Buffer)+06)^ := GetClientID;
    PWORD(INTEGER(Buffer)+08)^ := 0;
    PWORD(INTEGER(Buffer)+12)^ := 2;
    PWORD(INTEGER(Buffer)+16)^ := 1;
    SendPacket(Buffer, $14);
  end
  else
  begin
    Position.X := GetPosX;
    Position.Y := GetPosY;
    SetLength(Buffer, $14);
    PWORD(INTEGER(Buffer)+00)^ := 0;
    PWORD(INTEGER(Buffer)+02)^ := 0;
    PWORD(INTEGER(Buffer)+04)^ := $AD9;
    PWORD(INTEGER(Buffer)+06)^ := GetClientID;
    PWORD(INTEGER(Buffer)+08)^ := 0;
    PWORD(INTEGER(Buffer)+12)^ := 2;
    PWORD(INTEGER(Buffer)+16)^ := 2;
    SendPacket(Buffer, $14);
    Moved(True, Position);
  end;
end;

procedure ChangeNumeric(Numeric, NewNumeric : STRING);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
begin
  {TEST NUMERIC}
  SetLength(Buffer, $20);
  PWORD(INTEGER(Buffer)+00)^ := $20;
  PWORD(INTEGER(Buffer)+04)^ := $FDE;
  PWORD(INTEGER(Buffer)+06)^ := GetClientID;
  for i := 1 to Length(Numeric) do
    PCHAR(INTEGER(Buffer)+11+i)^ := Numeric[i];
  SendPacket(Buffer, $20);
  {CHANGE NUMERIC}
  SetLength(Buffer, $20);
  PWORD(INTEGER(Buffer)+00)^ := $20;
  PWORD(INTEGER(Buffer)+04)^ := $FDE;
  PWORD(INTEGER(Buffer)+06)^ := GetClientID;
  for i := 1 to Length(NewNumeric) do
    PCHAR(INTEGER(Buffer)+11+i)^ := NewNumeric[i];
  PWORD(INTEGER(Buffer)+28)^ := $01;
  SendPacket(Buffer, $20);
  Delay(100);
end;

procedure Amount(Items : STRING);
var
  vItem : ITEM;
  i, p, vAmount, fItem, faItem : INTEGER;
  sItem : TSTRINGLIST;
begin
  sItem := Explode(Items);
  for p := 0 to sItem.Count-1 do
  begin
    faItem := 0;
    fItem := -1;
    for i := 0 to 59 do
    begin
      vItem := GetInventory.Items[i];
      if vItem.Index = StrToInt(sItem[p]) then
      begin
        vAmount := 0;
        if vItem.EF1 = 61 then vAmount := vItem.EFV1 else
        if vItem.EF2 = 61 then vAmount := vItem.EFV2 else
        if vItem.EF3 = 61 then vAmount := vItem.EFV3;
        if vAmount >= 120 then continue;
        if faItem >= 120 then fItem := -1;
        if fItem = -1 then
        begin
          fItem := i;
          faItem := vAmount;
          continue;
        end;
        faItem := + vAmount;
        MoveItem(i, 1, fItem, 1, sItem[p]);
      end;
    end;
  end;
end;

procedure ReAmount(Items : STRING);
var
  Buffer : ARRAY OF BYTE;
  vItem : ITEM;
  i, j, p, vAmount : INTEGER;
  sItem : TSTRINGLIST;
begin
  sItem := Explode(Items);
  for p := 0 to sItem.Count-1 do
  begin
    for i := 0 to 59 do
    begin
      vItem := GetInventory.Items[i];
      if vItem.Index = StrToInt(sItem[p]) then
      begin
        vAmount := 1;
        if vItem.EF1 = 61 then vAmount := vItem.EFV1 else
        if vItem.EF2 = 61 then vAmount := vItem.EFV2 else
        if vItem.EF3 = 61 then vAmount := vItem.EFV3;
        Dec(vAmount);
        for j := 0 to vAmount-1  do
        begin
          SetLength(Buffer, $18);
          PWORD(INTEGER(Buffer)+00)^ := 0;
          PWORD(INTEGER(Buffer)+02)^ := 0;
          PWORD(INTEGER(Buffer)+04)^ := $2E5;
          PWORD(INTEGER(Buffer)+06)^ := GetClientID;
          PWORD(INTEGER(Buffer)+08)^ := 0;
          PWORD(INTEGER(Buffer)+12)^ := i;
          PWORD(INTEGER(Buffer)+16)^ := StrToInt(sItem[p]);
          PWORD(INTEGER(Buffer)+20)^ := 1;
          SendPacket(Buffer, $18);
          Delay(100);
        end;
      end;
    end;
  end;
end;

procedure RefItem(iSlot, eSlot, MaxRef : DWORD);
var
  Buffer : ARRAY OF BYTE;
begin
   while (GetEquip.Items[eSlot].EFV1 < MaxRef) and (GetInventory.Items[iSlot].Index <> 0){True} do
    begin
      {if (GetEquip.Items[eSlot].EFV1 < MaxRef) and (GetInventory.Items[iSlot].Index <> 0) then
      begin}
        SetLength(Buffer, $24);
        PWORD(INTEGER(Buffer)+00)^ := $24;
        PWORD(INTEGER(Buffer)+04)^ := $373;
        PWORD(INTEGER(Buffer)+06)^ := GetClientID;
        PWORD(INTEGER(Buffer)+12)^ := $01;
        PWORD(INTEGER(Buffer)+16)^ := iSlot;
        PWORD(INTEGER(Buffer)+24)^ := eSlot;
        SendPacket(Buffer, $24);
        Delay(500);
      {end
      else break;}
  end;
end;

function SearchItem(ItemID : WORD) : WORD;
var
  i, p : INTEGER;
begin
  p := -1;
  for i := 0 to 59 do
  begin
    if GetInventory.Items[i].Index = ItemID then
    begin
      p := i;
      break;
    end;
  end;
  Result := p;
end;

procedure PartyHack(Nick : STRING);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
begin
  SetLength(Buffer, $20);
  PWORD(INTEGER(Buffer)+00)^ := $20;
  PWORD(INTEGER(Buffer)+04)^ := $3AB;
  PWORD(INTEGER(Buffer)+06)^ := GetClientID;
  PWORD(INTEGER(Buffer)+08)^ := $00;
  PWORD(INTEGER(Buffer)+12)^ := GetPlayerID;
  for i := 1 to Length(Nick) do
    PCHAR(INTEGER(Buffer)+13+i)^ := Nick[i];
  SendPacket(Buffer, $20);
  Delay(100);
end;

procedure Atake(Skill : WORD; Onehit : BOOLEAN);
var
  Buffer : ARRAY OF BYTE;
begin
  SetLength(Buffer, $5E);
  PWORD(INTEGER(Buffer)+00)^ := $5E;
  PWORD(INTEGER(Buffer)+04)^ := $39D;
  PWORD(INTEGER(Buffer)+06)^ := GetClientID;
  PWORD(INTEGER(Buffer)+34)^ := GetPosX;
  PWORD(INTEGER(Buffer)+36)^ := GetPosY;
  PWORD(INTEGER(Buffer)+38)^ := GetPosX;
  PWORD(INTEGER(Buffer)+40)^ := GetPosY;
  PWORD(INTEGER(Buffer)+42)^ := GetClientID+2;
  PWORD(INTEGER(Buffer)+46)^ := $FF;
  PWORD(INTEGER(Buffer)+52)^ := $FF;
  PWORD(INTEGER(Buffer)+53)^ := $FF;
  PWORD(INTEGER(Buffer)+54)^ := $FF;
  PWORD(INTEGER(Buffer)+55)^ := $FF;
  PWORD(INTEGER(Buffer)+56)^ := Skill;
  PWORD(INTEGER(Buffer)+60)^ := GetPlayerID;
  PWORD(INTEGER(Buffer)+64)^ := $FF;
  PWORD(INTEGER(Buffer)+65)^ := $FF;
  PWORD(INTEGER(Buffer)+66)^ := $FF;
  PWORD(INTEGER(Buffer)+67)^ := $FF;
  if OneHit then
  begin
    PWORD(INTEGER(Buffer)+48)^ := $07;
    PWORD(INTEGER(Buffer)+73)^ := $BBB;
  end;
  SendPacket(Buffer, $5E);
end;

procedure Chat(Index : WORD; Msg : STRING);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
begin
  SetLength(Buffer, $6C);
  PWORD(INTEGER(Buffer)+00)^ := $6C;
  PWORD(INTEGER(Buffer)+04)^ := $333;
  PWORD(INTEGER(Buffer)+06)^ := Index;
  for i := 1 to Length(Msg) do
    PCHAR(INTEGER(Buffer)+11+i)^ := Msg[i];
  SendPacket(Buffer, $6C);
  Delay(100);
end;

end.
