unit wHacks;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, wDefines;
  {HACKS}
  procedure OpenCargo;
  procedure Move(vPosX, vPosY : DWORD);
  procedure Revive;
  procedure Inv(Active : BOOLEAN);
  procedure SecCheck(Pos : TPOINT);
  procedure Atake(Index : DWORD; Skill : WORD; Mag, Onehit : BOOLEAN);
  procedure Party(Nick : STRING);
  procedure Chat(Msg : STRING);
  procedure FakeItem(Item : TITEM);
  procedure ChangeNumeric(Numeric, NewNumeric : STRING);
  procedure RefItem(SlotInv, SlotEquip, MaxRef : DWORD);
  procedure Range;
  {EVENT}
  procedure Erase(Items : STRING);
  procedure Buy(NPC : WORD; Slot : BYTE; Qtd : INTEGER);
  procedure ClickNPC(NPC : WORD; Qtd : INTEGER);
  procedure Sell(NPC : WORD; Items : STRING);
  procedure Amount(Items : STRING);
  procedure ReAmount(Items : STRING);
  procedure MoveItem(srcSlot, srcType, dstSlot, dstType : BYTE; Items : STRING);
  procedure CheckDrop;
  procedure InsertDrop(Items : STRING);
  procedure Sell_Items(Items : STRING);

implementation

uses wFunctions;

{HACKS}

procedure OpenCargo;
begin
  if CheckGameState then
  begin
    asm
      MOV EAX, PTRDAT
      MOV EDX, DWORD PTR DS:[EAX]
      PUSH 1
      MOV ECX, EDX
      MOV EAX, ADDR_CARGO
      CALL EAX
    end;
    CliMsg(3000, 'Bau Aberto');
  end;
end;

procedure Move(vPosX, vPosY : DWORD);
var
  Buffer : ARRAY OF BYTE;
begin
  if (CheckGameState) and (vPosX >= 0) and (vPosX <= 4096) and (vPosY >= 0) and (vPosY <= 4096) then
  begin
    SetLength(Buffer, $34);
    PWORD(INTEGER(Buffer)+00)^ := $34;
    PWORD(INTEGER(Buffer)+04)^ := $36C;
    PWORD(INTEGER(Buffer)+06)^ := ClientID;
    PWORD(INTEGER(Buffer)+12)^ := PosX;
    PWORD(INTEGER(Buffer)+14)^ := PosY;
    PDWORD(INTEGER(Buffer)+16)^ := $01;
    PDWORD(INTEGER(Buffer)+20)^ := MoveSpeed;
    PWORD(INTEGER(Buffer)+48)^ := vPosX;
    PWORD(INTEGER(Buffer)+50)^ := vPosY;
    SendPacket(Buffer, $34);
    asm
      MOV EAX, PTRDAT
      MOV EDX, DWORD PTR DS:[EAX]
      ADD EDX, $4C
      MOV ECX, DWORD PTR DS:[EDX]
    end;
    if (Abs(vPosX - PosX) < 200) or (Abs(vPosY - PosY) < 200) then
      MoveChar($36C, Buffer);
  end;
end;

procedure Revive;
var
  Buffer : ARRAY OF BYTE;
begin
  SetLength(Buffer, $E);
  PWORD(INTEGER(Buffer)+00)^ := $E;
  PWORD(INTEGER(Buffer)+04)^ := $289;
  PWORD(INTEGER(Buffer)+06)^ := ClientID;
  SendPacket(Buffer, $E);
end;

procedure Inv(Active : BOOLEAN);
var
  Buffer : ARRAY OF BYTE;
  Pos : TPOINT;
begin
  if Active then
  begin
    SetLength(Buffer, $14);
    PWORD(INTEGER(Buffer)+00)^ := $00;
    PWORD(INTEGER(Buffer)+02)^ := $00;
    PWORD(INTEGER(Buffer)+04)^ := $AD9;
    PWORD(INTEGER(Buffer)+06)^ := ClientID;
    PWORD(INTEGER(Buffer)+08)^ := $00;
    PWORD(INTEGER(Buffer)+12)^ := $02;
    PWORD(INTEGER(Buffer)+16)^ := $01;
    SendPacket(Buffer, $14);
    CliMsg(3000, 'Invibilidade [ON]');
  end
  else
  begin
    Pos.X := PosX;
    Pos.Y := PosY;
    SetLength(Buffer, $14);
    PWORD(INTEGER(Buffer)+00)^ := $00;
    PWORD(INTEGER(Buffer)+02)^ := $00;
    PWORD(INTEGER(Buffer)+04)^ := $AD9;
    PWORD(INTEGER(Buffer)+06)^ := ClientID;
    PWORD(INTEGER(Buffer)+08)^ := $00;
    PWORD(INTEGER(Buffer)+12)^ := $02;
    PWORD(INTEGER(Buffer)+16)^ := $02;
    SendPacket(Buffer, $14);
    Move(Pos.X, Pos.Y);
    CliMsg(3000, 'Invibilidade [OFF]');
  end;
end;

procedure SecCheck(Pos : TPOINT);
begin
  if(Pos.X <> 0) and (Pos.Y <> 0) and ((Pos.X <> PosX) or (Pos.Y <> PosY)) then
    Move(Pos.X, Pos.Y);
end;

procedure Atake(Index : DWORD; Skill : WORD; Mag, Onehit : BOOLEAN);
var
  Buffer : ARRAY OF BYTE;
begin
  if (CheckGameState) and (Index >= 1) and (Index <= 999) and (Skill >= 1) then
  begin
    if Mag then
    begin
      SetLength(Buffer, $5E);
      PWORD(INTEGER(Buffer)+00)^  := $5E;
      PWORD(INTEGER(Buffer)+04)^  := $39D;
      PWORD(INTEGER(Buffer)+06)^  := ClientID;
      PWORD(INTEGER(Buffer)+34)^  := PosX;
      PWORD(INTEGER(Buffer)+36)^  := PosY;
      PWORD(INTEGER(Buffer)+38)^  := PosX;
      PWORD(INTEGER(Buffer)+40)^  := PosY;
      PWORD(INTEGER(Buffer)+42)^  := ClientID+2;
      PWORD(INTEGER(Buffer)+46)^  := $FF;
      PDWORD(INTEGER(Buffer)+52)^ := $FFFFFFFF;
      PWORD(INTEGER(Buffer)+56)^  := Skill;
      PWORD(INTEGER(Buffer)+60)^  := Index;
      PDWORD(INTEGER(Buffer)+64)^ := $FFFFFFFF;
      if OneHit then
      begin
        PWORD(INTEGER(Buffer)+48)^ := $07;
        PWORD(INTEGER(Buffer)+73)^ := $BBB;
      end;
      SendPacket(Buffer, $5E);
    end
    else
    begin
      {DAMAGE ATAKE}
    end;
  end;
end;

procedure Party(Nick : STRING);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
begin
  if (CheckGameState) and (PlayerID >= 1) and (PlayerID <= 999) and (Nick <> '') then
  begin
    SetLength(Buffer, $20);
    PWORD(INTEGER(Buffer)+00)^ := $20;
    PWORD(INTEGER(Buffer)+04)^ := $3AB;
    PWORD(INTEGER(Buffer)+06)^ := ClientID;
    PWORD(INTEGER(Buffer)+08)^ := $00;
    PWORD(INTEGER(Buffer)+12)^ := PlayerID;
    for i := 1 to Length(Nick) do
      PCHAR(INTEGER(Buffer)+13+i)^ := Nick[i];
    SendPacket(Buffer, $20);
  end;
end;

procedure Chat(Msg : STRING);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
begin
  if (CheckGameState) and (PlayerID >= 1) and (PlayerID <= 999) and (Msg <> '') then
  begin
    SetLength(Buffer, $6C);
    PWORD(INTEGER(Buffer)+00)^ := $6C;
    PWORD(INTEGER(Buffer)+04)^ := $333;
    PWORD(INTEGER(Buffer)+06)^ := PlayerID;
    for i := 1 to Length(Msg) do
      PCHAR(INTEGER(Buffer)+11+i)^ := Msg[i];
    SendPacket(Buffer, $6C);
  end;
end;

procedure FakeItem(Item : TITEM);
var
  Buffer : ARRAY OF BYTE;
  Slot : INTEGER;
begin
  Slot := SlotItem(1, 0);
  if (CheckGameState) and (Slot <> -1) and (Item.ID <> 0) then
  begin
    SetLength(Buffer, $18);
    PWORD(INTEGER(Buffer)+00)^ := $18;
    PWORD(INTEGER(Buffer)+02)^ := $00;
    PWORD(INTEGER(Buffer)+04)^ := $182;
    PWORD(INTEGER(Buffer)+06)^ := ClientID;
    PWORD(INTEGER(Buffer)+08)^ := $00;
    PWORD(INTEGER(Buffer)+12)^ := $01;
    PWORD(INTEGER(Buffer)+14)^ := Slot;
    PWORD(INTEGER(Buffer)+16)^ := Item.ID;
    PWORD(INTEGER(Buffer)+18)^ := Item.EF1;
    PWORD(INTEGER(Buffer)+19)^ := Item.EFV1;
    PWORD(INTEGER(Buffer)+20)^ := Item.EF2;
    PWORD(INTEGER(Buffer)+21)^ := Item.EFV2;
    PWORD(INTEGER(Buffer)+22)^ := Item.EF3;
    PWORD(INTEGER(Buffer)+23)^ := Item.EFV3;
    asm
      MOV EAX, PTRDAT
      MOV EDX, DWORD PTR DS:[EAX]
      ADD EDX, $4C
      MOV ECX, DWORD PTR DS:[EDX]
    end;
    AddItem(Buffer);
    CliMsg(3000, 'FakeItem');
  end;
end;

procedure ChangeNumeric(Numeric, NewNumeric : STRING);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
begin
  SetLength(Buffer, $20);
  PWORD(INTEGER(Buffer)+00)^ := $20;
  PWORD(INTEGER(Buffer)+04)^ := $FDE;
  PWORD(INTEGER(Buffer)+06)^ := ClientID;
  for i := 1 to Length(Numeric) do
    PCHAR(INTEGER(Buffer)+11+i)^ := Numeric[i];
  SendPacket(Buffer, $20);

  SetLength(Buffer, $20);
  PWORD(INTEGER(Buffer)+00)^ := $20;
  PWORD(INTEGER(Buffer)+04)^ := $FDE;
  PWORD(INTEGER(Buffer)+06)^ := ClientID;
  for i := 1 to Length(NewNumeric) do
    PCHAR(INTEGER(Buffer)+11+i)^ := NewNumeric[i];
  PWORD(INTEGER(Buffer)+28)^ := $01;
  SendPacket(Buffer, $20);
end;

procedure RefItem(SlotInv, SlotEquip, MaxRef : DWORD);
var
  Buffer : ARRAY OF BYTE;
  P : INTEGER;
begin
  if (SlotInv <> 0) and (SlotEquip <> 0) and (Equip[SlotEquip].EFV1 <> MaxRef) then
    begin
      SetLength(Buffer, $24);
      PWORD(INTEGER(Buffer)+00)^ := $24;
      PWORD(INTEGER(Buffer)+04)^ := $373;
      PWORD(INTEGER(Buffer)+06)^ := ClientID;
      PWORD(INTEGER(Buffer)+12)^ := $01;
      PWORD(INTEGER(Buffer)+16)^ := SlotInv;
      PWORD(INTEGER(Buffer)+24)^ := SlotEquip;
      SendPacket(Buffer, $24);
    end;
end;

{RANGE BY BENNY}
procedure Range;
var
  i : INTEGER;
const
  Max_Range = $20;
begin
  if not vRange.Actived then
  begin
    for i := 0 to 101 do
    begin
      vRange.Value[i] := PDWORD(INTEGER(ADDR_SK_BS)+(i*96)+16)^;
      PDWORD(INTEGER(ADDR_SK_BS)+(i*96)+16)^ := $20;
    end;
    vRange.Actived := True;
    CliMsg(3000, 'Range [ON]');
  end else
  begin
    for i := 0 to 101 do
      PDWORD(INTEGER(ADDR_SK_BS)+(i*96)+16)^ := vRange.Value[i];
    vRange.Actived := False;
    CliMsg(3000, 'Range [OFF]');
  end;
end;

procedure Buff;
var
  i : INTEGER;
begin
    for i := 0 to 101 do
    begin
      PDWORD(INTEGER(ADDR_SK_BS)+(i*96)+4)^ := 2;
    end;
    CliMsg(3000, 'Buff [ON]');
end;

{EVENT}

procedure Erase(Items : STRING);
var
  Buffer : ARRAY OF BYTE;
  i, j : INTEGER;
  Item : TSTRINGLIST;
begin
  if Items = 'all' then
  begin
   for i := 0 to Max.Inventory do
     if Inventory[i].ID <> 0 then
     begin
       SetLength(Buffer, $14);
       PWORD(INTEGER(Buffer)+00)^ := $14;
       PWORD(INTEGER(Buffer)+04)^ := $2E4;
       PWORD(INTEGER(Buffer)+06)^ := ClientID;
       PWORD(INTEGER(Buffer)+12)^ := i;
       PWORD(INTEGER(Buffer)+16)^ := Inventory[i].ID;
       SendPacket(Buffer, $14);
       SendPacket(Buffer, $14);
       Delay(200);
     end;
  end
  else
  begin
    Item := Explode(Items);
    for i := 0 to Max.Inventory do
      for j := 0 to Item.Count-1 do
        if Inventory[i].ID = StrToInt(Item[j]) then
        begin
          SetLength(Buffer, $14);
          PWORD(INTEGER(Buffer)+00)^ := $14;
          PWORD(INTEGER(Buffer)+04)^ := $2E4;
          PWORD(INTEGER(Buffer)+06)^ := ClientID;
          PWORD(INTEGER(Buffer)+12)^ := i;
          PWORD(INTEGER(Buffer)+16)^ := Inventory[i].ID;
          SendPacket(Buffer, $14);
          SendPacket(Buffer, $14);
          Delay(200);
        end;
  end;
end;

procedure Buy(NPC : WORD; Slot : BYTE; Qtd : INTEGER);
var
  Buffer : ARRAY OF BYTE;
  i, j : INTEGER;
begin
  if (NPC >= 0) and (Slot >= 0) and (Qtd <= Max.Inventory+1) then
    for i := 0 to Qtd-1 do
    begin
      j := SlotItem(1, 0);
      if j <> -1 then
      begin
        SetLength(Buffer, $18);
        PWORD(INTEGER(Buffer)+00)^ := $18;
        PWORD(INTEGER(Buffer)+04)^ := $379;
        PWORD(INTEGER(Buffer)+06)^ := ClientID;
        PWORD(INTEGER(Buffer)+12)^ := NPC;
        PWORD(INTEGER(Buffer)+14)^ := Slot;
        PWORD(INTEGER(Buffer)+16)^ := j;
        SendPacket(Buffer, $18);
        Delay(100);
      end;
    end;
end;

procedure ClickNPC(NPC : WORD; Qtd : INTEGER);
var
  Buffer : ARRAY OF BYTE;
  i : INTEGER;
begin
  if NPC >= 0 then
    for i := 1 to Qtd do
    begin
      SetLength(Buffer, $14);
      PWORD(INTEGER(Buffer)+00)^ := $14;
      PWORD(INTEGER(Buffer)+04)^ := $28B;
      PWORD(INTEGER(Buffer)+06)^ := ClientID;
      PWORD(INTEGER(Buffer)+12)^ := NPC;
      SendPacket(Buffer, $14);
      Delay(100);
    end;
end;

procedure Sell(NPC : WORD; Items : STRING);
var
  Buffer : ARRAY OF BYTE;
  i, j : INTEGER;
  Item : TSTRINGLIST;
begin
  if Items = 'all' then
  begin
   for i := 0 to 59 do
     if Inventory[i].ID <> 0 then
     begin
       SetLength(Buffer, $14);
       PWORD(INTEGER(Buffer)+00)^ := $14;
       PWORD(INTEGER(Buffer)+04)^ := $37A;
       PWORD(INTEGER(Buffer)+06)^ := ClientID;
       PWORD(INTEGER(Buffer)+12)^ := NPC;
       PWORD(INTEGER(Buffer)+14)^ := $01;
       PWORD(INTEGER(Buffer)+16)^ := i;
       SendPacket(Buffer, $14);
       SendPacket(Buffer, $14);
       Delay(200);
     end;
  end
  else
  begin
    Item := Explode(Items);
    for i := 0 to 59 do
      for j := 0 to Item.Count-1 do
        if Inventory[i].ID = StrToInt(Item[j]) then
        begin
          if (Inventory[i].EF1 = 61) and (Inventory[i].EFV1 > 1) then Continue;
          SetLength(Buffer, $14);
          PWORD(INTEGER(Buffer)+00)^ := $14;
          PWORD(INTEGER(Buffer)+04)^ := $37A;
          PWORD(INTEGER(Buffer)+06)^ := ClientID;
          PWORD(INTEGER(Buffer)+12)^ := NPC;
          PWORD(INTEGER(Buffer)+14)^ := $01;
          PWORD(INTEGER(Buffer)+16)^ := i;
          SendPacket(Buffer, $14);
          SendPacket(Buffer, $14);
          Delay(200);
        end;
  end;
end;

procedure Amount(Items : STRING);
var
  vItem : TITEM;
  i, p, vAmount, fItem, faItem : INTEGER;
  Item : TSTRINGLIST;
begin
  Item := Explode(Items);
  for p := 0 to Item.Count-1 do
  begin
    faItem := 0;
    fItem := -1;
    for i := 0 to Max.Inventory do
    begin
      vItem := Inventory[i];
      if vItem.ID = StrToInt(Item[p]) then
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
        MoveItem(i, 1, fItem, 1, Item[p]);
      end;
    end;
  end;
end;

procedure ReAmount(Items : STRING);
var
  Buffer : ARRAY OF BYTE;
  vItem : TITEM;
  i, j, k, p, vAmount, mv : INTEGER;
  Item : TSTRINGLIST;
begin
  Item := Explode(Items);
  for p := 0 to Item.Count-1 do
  begin
    for i := 0 to Max.Inventory do
    begin
      vItem := Inventory[i];
      if vItem.ID = StrToInt(Item[p]) then
      begin
        vAmount := 1;
        if vItem.EF1 = 61 then vAmount := vItem.EFV1 else
        if vItem.EF2 = 61 then vAmount := vItem.EFV2 else
        if vItem.EF3 = 61 then vAmount := vItem.EFV3;
        Dec(vAmount);

        mv := 0;
        for k := 0 to 59 do
          if Inventory[k].ID = 0 then
            Inc(mv);

        if vAmount > mv then
          Dec(mv)
        else
          mv := vAmount-1;

        for j := 0 to mv  do
        begin
          SetLength(Buffer, $18);
          PWORD(INTEGER(Buffer)+00)^ := $00;
          PWORD(INTEGER(Buffer)+02)^ := $00;
          PWORD(INTEGER(Buffer)+04)^ := $2E5;
          PWORD(INTEGER(Buffer)+06)^ := ClientID;
          PWORD(INTEGER(Buffer)+08)^ := $00;
          PWORD(INTEGER(Buffer)+12)^ := i;
          PWORD(INTEGER(Buffer)+16)^ := StrToInt(Item[p]);
          PWORD(INTEGER(Buffer)+20)^ := $01;
          SendPacket(Buffer, $18);
          Delay(100);
        end;
      end;
    end;
  end;
end;

{Usado p vender lac/ori automaticamente no npc}
procedure Sell_Items(Items : STRING);
var
  Buffer : ARRAY OF BYTE;
  vItem : TITEM;
  i, j, k, p, vAmount, mv : INTEGER;
  Item : TSTRINGLIST;
begin
  Item := Explode(Items);
  for p := 0 to Item.Count-1 do
  begin
    for i := 0 to Max.Inventory do
    begin
      vItem := Inventory[i];
      if vItem.ID = StrToInt(Item[p]) then
      begin
        vAmount := 1;
        if vItem.EF1 = 61 then vAmount := vItem.EFV1 else
        if vItem.EF2 = 61 then vAmount := vItem.EFV2 else
        if vItem.EF3 = 61 then vAmount := vItem.EFV3;
        Dec(vAmount);

        mv := 0;
        for k := 0 to 59 do
          if Inventory[k].ID = 0 then
            Inc(mv);

        if vAmount > mv then
          Dec(mv)
        else
          mv := vAmount-1;

        for j := 0 to mv  do
        begin
          SetLength(Buffer, $18);
          PWORD(INTEGER(Buffer)+00)^ := $00;
          PWORD(INTEGER(Buffer)+02)^ := $00;
          PWORD(INTEGER(Buffer)+04)^ := $2E5;
          PWORD(INTEGER(Buffer)+06)^ := ClientID;
          PWORD(INTEGER(Buffer)+08)^ := $00;
          PWORD(INTEGER(Buffer)+12)^ := i;
          PWORD(INTEGER(Buffer)+16)^ := StrToInt(Item[p]);
          PWORD(INTEGER(Buffer)+20)^ := $01;
          SendPacket(Buffer, $18);
          Delay(100);
        end;

        Sell(Event.NPC, Items);

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
      if StrToInt(Item[i]) = Inventory[srcSlot].ID then
      begin
        SetLength(Buffer, $14);
        PWORD(INTEGER(Buffer)+00)^ := $14;
        PWORD(INTEGER(Buffer)+04)^ := $376;
        PWORD(INTEGER(Buffer)+06)^ := ClientID;
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

procedure CheckDrop;
var
  i, j : INTEGER;
  Apagar : BOOLEAN;
begin
  for i := 0 to Max.Inventory do
  begin
    Apagar := True;
    for j := 0 to Drop.MaxList do
      if Inventory[i].ID = Drop.List[j] then
        Apagar := False;
    if Apagar then
    begin
      Erase(IntToStr(Inventory[i].ID));
      CliMsg(3000, 'Drop: '+IntToStr(Inventory[i].ID)+' foi apagado.');
    end;
  end;
end;

procedure InsertDrop(Items : STRING);
var
  i, j : INTEGER;
  Item : TSTRINGLIST;
begin
  for i := 0 to 174 do
    Drop.List[i] := 0;

  j := 0;

  for i := 1 to Max.Equip do
    if Equip[i].ID <> 0 then
    begin
      Drop.List[j] := Equip[i].ID;
      Inc(j);
    end;

  for i := 0 to Max.Inventory do
    if Inventory[i].ID <> 0 then
    begin
      Drop.List[j] := Inventory[i].ID;
      Inc(j);
    end;

  Item := Explode(Items);

  for i := 0 to Item.Count-1 do
    if StrToInt(Item[i]) <> 0 then
    begin
      Drop.List[j] := StrToInt(Item[i]);
      Inc(j);
    end;

  Drop.MaxList := j-1;
end;

end.
