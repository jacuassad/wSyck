unit wFunctions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Forms , wDefines;
  {LEITURA WYD}
  function ClientID : DWORD;
  function PosX : DWORD;
  function PosY : DWORD;
  function MoveSpeed : DWORD;
  function GoldChar : DWORD;
  function GoldCargo : DWORD;
  function Equip : TEQUIP;
  function Inventory : TINVENTORY;
  function Cargo : TCARGO;
  function PlayerID : DWORD;
  function CheckGameState : BOOLEAN;
  function SlotItem(Local, ItemID : WORD) : WORD;
  function ItemRefToEffect(Gema, Ref : INTEGER) : INTEGER;
  function ItemEffectToRef(Gema, Effect : INTEGER) : INTEGER;
  function MOB : TMOB;
  function Servidor : TSERVER;
  {FUNÇÕES WYD}
  procedure SendPacket(Packet : ARRAY OF BYTE; Size : DWORD);
  procedure MoveChar(OpCode : DWORD; Packet : ARRAY OF BYTE);
  procedure AddItem(Packet : ARRAY OF BYTE);
  procedure ShowMsg(Msg : STRING);
  procedure CliMsg(Delay : INTEGER; Msg : STRING);
  {FUNÇÕES DE DADOS}
  function Explode(Str : STRING) : TSTRINGLIST;
  function LoadFile(Archive: STRING): TSTRINGLIST;
  function HotKey(Key : INTEGER) : BOOLEAN;
  function LeftValue(Value, Size : INTEGER) : STRING;
  procedure Delay(MSeconds : LONGINT);
  procedure wBYTE(Addr : DWORD; Value : Byte);
  {PACKET CONTROL}
  procedure PacketControl(Data, dLength : Pointer; dType : Integer);cdecl;
  {PROMPT}
  procedure Command(CMD : STRING);
implementation

uses wHacks, wInterface;

{LEITURA WYD}

function ClientID : DWORD;
asm
  MOV ECX, DWORD PTR DS:[ADDR_ACC]
  ADD ECX, $DFC
  XOR EAX, EAX
  MOV AX,  WORD PTR DS:[ECX]
end;

function PosX : DWORD;
asm
  MOV EAX, [PTRDAT]
  MOV EAX, [EAX+27614H]
end;

function PosY : DWORD;
asm
  MOV EAX, [PTRDAT]
  MOV EAX, [EAX+27618H]
end;

function MoveSpeed : DWORD;
begin
  Result := PDWORD(ADDR_MOVESPEED)^;
end;

function GoldChar : DWORD;
begin
  Result := PDWORD(PDWORD(ADDR_MOBINFO)^+$18)^;
end;

function GoldCargo : DWORD;
begin
  Result := PDWORD(PDWORD(ADDR_MOBINFO)^+$6A8)^;
end;

function MOB : TMOB;
var
  PtrMOB : ^TMOB;
begin
  PtrMOB := @PBYTE(PDWORD(ADDR_ACC)^+$750)^;
  Result := PtrMOB^;
end;

function Servidor : TSERVER;
var
  PtrSERVER : ^TSERVER;
begin
  PtrSERVER := @PCHAR($01F88D34)^;
  Result := PtrSERVER^;
end;

function Equip : TEQUIP;
var
  PtrEquip : ^TEQUIP;
begin
  PtrEquip := @PDWORD(PDWORD(ADDR_MOBINFO)^+$8C)^;
  Result := PtrEquip^;
end;

function Inventory : TINVENTORY;
var
  PtrInventory : ^TINVENTORY;
begin
  PtrInventory := @PDWORD(PDWORD(ADDR_MOBINFO)^+$10C)^;
  Result := PtrInventory^;
end;

function Cargo : TCARGO;
var
  PtrCargo : ^TCARGO;
begin
  PtrCargo := @PWORD(PDWORD($01F856D4)^+$350)^;
  Result := PtrCargo^;
end;

function PlayerID : DWORD;
begin
  Result := PDWORD(PDWORD(PTRDAT)^+$26EFC)^;
end;

function CheckGameState : BOOLEAN;
begin
  try
    if (ClientID >= 1) and (ClientID <= 999) and (PosX >= 1) and (PosX <= 4096) and (PosY >= 1) and (PosY <= 4096) then
      Result := True
    else
      Result := False;
  except
    Result := False;
  end;
end;

{LOCAL : 0 = EQUIP, 1 = INVENTORY E 2 = CARGO}
function SlotItem(Local, ItemID : WORD) : WORD;
var
  i, P : INTEGER;
begin
  P := -1;
  if Local = 0 then
  begin
    for i := 0 to Max.Equip do
      if Equip[i].ID = ItemID then
      begin
        P := i;
        break;
      end;
  end
  else if Local = 1 then
  begin
    for i := 0 to Max.Inventory do
      if Inventory[i].ID = ItemID then
      begin
        P := i;
        break;
      end;
  end
  else
  begin
    for i := 0 to Max.Cargo do
      if Cargo[i].ID = ItemID then
      begin
        P := i;
        break;
      end;
  end;
  Result := P;
end;

{Gema = 4 = ABSORÇÃO}
function ItemRefToEffect(Gema, Ref : INTEGER) : INTEGER;
begin
  if (Ref >= 10) and (Ref <= 15) then
  begin
    Result := 229 + Gema + (4 * (Ref mod 10));
  end
  else
    Result := Ref;
end;

function ItemEffectToRef(Gema, Effect : INTEGER) : INTEGER;
begin
  if (Effect >= 229) and (Effect <= 253) then
  begin
    Result := ((Effect - 229) div 4) + 9;
  end
  else
    Result := Effect;
end;

{FUNÇÕES  WYD}

procedure SendPacket(Packet : ARRAY OF BYTE; Size : DWORD);
asm
  PUSH SIZE
  PUSH PACKET
  CALL ADDR_SENDPACKET
  ADD  ESP, 08H
end;

procedure MoveChar(OpCode : DWORD; Packet : ARRAY OF BYTE);
asm
  PUSH PACKET
  PUSH OPCODE
  CALL ADDR_MOVECHAR
  ADD  ESP, 08H
end;

procedure AddItem(Packet : ARRAY OF BYTE);
asm
  PUSH PACKET
  CALL ADDR_ADDITEM
  ADD  ESP, 08H
end;

procedure ShowGameMsg(Msg : PANSICHAR);
asm
  LEA EDX, [MSG]
  MOV EAX, PTRDAT
  MOV ECX, DWORD PTR DS:[EAX]
  PUSH EDX
  MOV ECX, ECX
  CALL ADDR_SHOWMSG
  RETN
end;

procedure ShowMsg(Msg : STRING);
var
  RET : CARDINAL;
begin
  if CheckGameState then
  begin
    VirtualProtect(PTR(ADDR_COLOR), 4, PAGE_EXECUTE_WRITECOPY, RET);
    PDWORD(ADDR_COLOR)^ := $FF99FF22;
    ShowGameMsg(PAnsiChar(AnsiString(Msg)));
    PDWORD(ADDR_COLOR)^ := $FFFFAAAA;
  end;
end;

procedure CliMsg(Delay : INTEGER; Msg : STRING);
var
  Str : PANSICHAR;
begin
  Str := PAnsiChar(AnsiString(Msg));
  asm
    PUSH DELAY
    PUSH STR
    MOV  ECX, DWORD PTR SS:[PTRDAT]
    MOV  ECX, DWORD PTR DS:[ECX+$C4]
    CALL ADDR_CLIENTMSG
    PUSH 0
    PUSH 1
    MOV  EDX, DWORD PTR SS:[PTRDAT]
    MOV  ECX, DWORD PTR DS:[EDX+$C4]
    MOV  EAX, DWORD PTR SS:[PTRDAT]
    MOV  EDX, DWORD PTR DS:[EAX+$C4]
    MOV  EAX, DWORD PTR DS:[EDX]
    CALL DWORD PTR DS:[EAX+$88]
    MOV  EAX, 1
  end;
end;

{FUNÇÕES DE DADOS}

function LoadFile(Archive: STRING): TSTRINGLIST;
var
  fp : TEXTFILE;
  line, local : STRING;
begin
  local := ExtractFilePath(Application.ExeName);
  if FileExists(Local+Archive) then
  begin
    Result := TStringList.Create;
    AssignFile(fp, Local+Archive);
    Reset(fp);
    while not Eof(fp) do
    begin
      Readln(fp, line);
      Result.Add(line);
    end;
    CloseFile(fp);
  end;
end;

function Explode(Str : STRING) : TSTRINGLIST;
var
  P : INTEGER;
  Separador : STRING;
begin
  Separador := ' ';
  Result := TStringList.Create;
  P := Pos(Separador, Str);
  while (P > 0) do
  begin
    Result.Add(Copy(Str, 1, P-1));
    Delete(Str, 1, P + Length(Separador) - 1);
    p := Pos(Separador, Str);
  end;
  if (Str <> '') then Result.Add(Str);
end;

function HotKey(Key : INTEGER) : BOOLEAN;
begin
  if GetAsyncKeyState(Key) < 0 then Result := True
    else Result := False;
end;

procedure Delay(MSeconds : LONGINT);
var
  Start, Stop: DWORD;
begin
  Start := GetTickCount;
  repeat
    Stop := GetTickCount;
    Application.ProcessMessages;
    Sleep(1);
  until (Stop - Start) >= MSeconds;
end;

function LeftValue(Value, Size : INTEGER) : STRING;
var
  NewValue : STRING;
  i : INTEGER;
begin
  NewValue := '';
  for i := 1 to Size - Length(IntToStr(Value)) do
    NewValue := NewValue + '0';
  Result := NewValue + IntToStr(Value);
end;

procedure wBYTE(Addr : DWORD; Value : Byte);
var
  RET : CARDINAL;
begin
  VirtualProtect(PTR(Addr), SizeOf(Value), PAGE_EXECUTE_WRITECOPY, RET);
  PBYTE(Addr)^ := Value;
end;

{PACKET CONTROL}

procedure PacketControl(Data, dLength : Pointer; dType : Integer);cdecl;
var
  Size, OpCode, pClientID : WORD;
const
  Send  = 0;
  Recv  = 1;
begin
  Size      := PWORD(INTEGER(Data)+00)^;
  OpCode    := PWORD(INTEGER(Data)+04)^;
  pClientID := PWORD(INTEGER(Data)+06)^;

  {CHANGE NUMERIC PAUSE}
  if (dType = Recv) and (OpCode = $FDE) then
  begin
    Numeric.Active := False;
    CliMsg(300, 'Senha Encontrada !!!');
  end;

end;

{PROMPT}

procedure Command(CMD : STRING);
var
  KEY : TSTRINGLIST;
  Temp : STRING;
  Item : TITEM;
  Slot : BYTE;
begin
  KEY := Explode(CMD);
  try
    if KEY.Count >= 1 then
    begin

      if KEY[0] = 'opencargo' then
      begin
        OpenCargo;
      end else

      if KEY[0] = 'move' then
      begin
        Move(StrToInt(KEY[1]), StrToInt(KEY[2]));
        CliMsg(3000, 'Move X = '+KEY[1]+' Y = '+KEY[2]);
      end else

      if KEY[0] = 'erase' then
      begin
        Temp := Copy(CMD, Length(KEY[0])+2, Length(CMD)-1);
        Erase(Temp);
        CliMsg(3000, PAnsiChar(AnsiString('Items Apagados : '+Temp)));
      end else

      if KEY[0] = 'buy' then
      begin
        Buy(StrToInt(KEY[1]), StrToInt(KEY[2]), StrToInt(KEY[3]));
        CliMsg(3000, 'Buy : NPC = '+KEY[1]+' Slot = '+KEY[2]+' Qtd. = '+KEY[3]);
      end else

      if KEY[0] = 'clicknpc' then
      begin
        ClickNPC(StrToInt(KEY[1]), StrToInt(KEY[2]));
        CliMsg(3000, 'Click : NPC = '+KEY[1]+' Qtd. = '+KEY[2]);
      end else

      {if KEY[0] = 'sell' then
      begin
        Temp := Copy(CMD, Length(KEY[0]+' '+KEY[1])+2, Length(CMD)-1);
        Sell(StrToInt(KEY[1]), Temp);
        CliMsg(3000, 'Sell : NPC = '+KEY[1]+' Items = '+Temp);
      end else}

      if KEY[0] = 'amount' then
      begin
        Temp := Copy(CMD, Length(KEY[0])+2, Length(CMD)-1);
        Amount(Temp);
        CliMsg(3000, 'Agrupar Items : '+Temp);
      end else

      if KEY[0] = 'reamount' then
      begin
        Temp := Copy(CMD, Length(KEY[0])+2, Length(CMD)-1);
        ReAmount(Temp);
        CliMsg(3000, 'Desagrupar Items : '+Temp);
      end else

      if KEY[0] = 'revive' then
      begin
        if not cRevive then
        begin
          cRevive := True;
          CliMsg(3000, 'Revive [ON]');
        end else
        begin
          cRevive := False;
          CliMsg(3000, 'Revive [OFF]');
        end;
      end else

      if KEY[0] = 'party' then
      begin
        Party(KEY[1]);
        CliMsg(3000, 'Grupo Nick = '+KEY[1]+', Index = '+IntToStr(PlayerID));
      end else

      if KEY[0] = 'chat' then
      begin
        Temp := Copy(CMD, Length(KEY[0])+2, Length(CMD)-1);
        Chat(Temp);
        CliMsg(3000, 'Chat Index = '+IntToStr(PlayerID)+', diz : '+Temp);
      end else

      if KEY[0] = 'sec' then
      begin
        if KEY[1] = 'on' then
        begin
          Sec.X := PosX;
          Sec.Y := PosY;
          CliMsg(3000, 'Sec [ON] X = '+IntToStr(Sec.X)+' Y = '+IntToStr(Sec.Y));
        end else
        begin
          Sec.X := 0;
          Sec.Y := 0;
          CliMsg(3000, 'Sec [OFF]');
        end;
      end else

      if KEY[0] = 'onehit' then
      begin
        if KEY[1] = 'on' then
        begin
          OneHit := True;
          CliMsg(3000, 'One Hit [ON]');
          ShowMsg('[CTRL + M.RIGHT] + [SPACE]');
        end else
        begin
          OneHit := False;
          CliMsg(3000, 'One Hit [OFF]');
        end;
      end else

      if KEY[0] = 'inv' then
      begin
        if KEY[1] = 'on' then Inv(True)
          else Inv(False);
      end else

      if KEY[0] = 'vender' then
      begin
        if KEY[1] <> 'off' then
        begin
          Event.NPC := StrToInt(KEY[1]);
          Event.Active := True;
        end else Event.Active := False;
      end else

      if KEY[0] = 'range' then
      begin
        Range;
      end else

      if KEY[0] = 'soul' then
      begin
        Atake(ClientID, 102, True, False);
        CliMsg(3000, 'Soul Delay = 15min, 8 Skill Necessária');
      end else

      if KEY[0] = 'equip' then
      begin
        Slot := StrToInt(KEY[1]);
        ShowMsg('Equip Slot = '+KEY[1]);
        ShowMsg('ItemID = '+IntToStr(Equip[Slot].ID));
        ShowMsg('EF1 = '+IntToStr(Equip[Slot].EF1)+', '+'EFV1 = '+IntToStr(Equip[Slot].EFV1));
        ShowMsg('EF2 = '+IntToStr(Equip[Slot].EF2)+', '+'EFV2 = '+IntToStr(Equip[Slot].EFV2));
        ShowMsg('EF3 = '+IntToStr(Equip[Slot].EF3)+', '+'EFV3 = '+IntToStr(Equip[Slot].EFV3));
      end else

      if KEY[0] = 'inventory' then
      begin
        Slot := StrToInt(KEY[1]);
        ShowMsg('Inventory Slot = '+KEY[1]);
        ShowMsg('ItemID = '+IntToStr(Inventory[Slot].ID));
        ShowMsg('EF1 = '+IntToStr(Inventory[Slot].EF1)+', '+'EFV1 = '+IntToStr(Inventory[Slot].EFV1));
        ShowMsg('EF2 = '+IntToStr(Inventory[Slot].EF2)+', '+'EFV2 = '+IntToStr(Inventory[Slot].EFV2));
        ShowMsg('EF3 = '+IntToStr(Inventory[Slot].EF3)+', '+'EFV3 = '+IntToStr(Inventory[Slot].EFV3));
      end else

      if KEY[0] = 'cargo' then
      begin
        Slot := StrToInt(KEY[1]);
        ShowMsg('Cargo Slot = '+KEY[1]);
        ShowMsg('ItemID = '+IntToStr(Cargo[Slot].ID));
        ShowMsg('EF1 = '+IntToStr(Cargo[Slot].EF1)+', '+'EFV1 = '+IntToStr(Cargo[Slot].EFV1));
        ShowMsg('EF2 = '+IntToStr(Cargo[Slot].EF2)+', '+'EFV2 = '+IntToStr(Cargo[Slot].EFV2));
        ShowMsg('EF3 = '+IntToStr(Cargo[Slot].EF3)+', '+'EFV3 = '+IntToStr(Cargo[Slot].EFV3));
      end else

      if KEY[0] = 'fakeitem' then
      begin
        try
          Item.ID  := StrToInt(KEY[1]);
        except
          Item.ID  := 0;
        end;

        try
          Item.EF1  := StrToInt(KEY[2]);
          Item.EFV1 := StrToInt(KEY[3]);
        except
          Item.EF1  := 0;
          Item.EFV1 := 0;
        end;
        try
          Item.EF2  := StrToInt(KEY[4]);
          Item.EFV2 := StrToInt(KEY[5]);
        except
          Item.EF2  := 0;
          Item.EFV2 := 0;
        end;
        try
          Item.EF3  := StrToInt(KEY[6]);
          Item.EFV3 := StrToInt(KEY[7]);
        except
          Item.EF3  := 0;
          Item.EFV3 := 0;
        end;
        FakeItem(Item);
        CliMsg(3000, 'FakeItem : '+IntToStr(Item.ID)+' '+IntToStr(Item.EF1)+' '+ IntToStr(Item.EFV1)+' '+IntToStr(Item.EF2)+' '+ IntToStr(Item.EFV2)+' '+IntToStr(Item.EF3)+' '+ IntToStr(Item.EFV3));
        ShowMsg('FakeItem: '+IntToStr(Item.ID));
      end else

      if KEY[0] = 'numeric' then
      begin
        if KEY[1] = 'on' then
        begin
          Numeric.Min  := StrToInt(KEY[2]);
          Numeric.Max  := StrToInt(KEY[3]);
          Numeric.Size := StrToInt(KEY[4]);
          if KEY[5] = '+' then
          begin
            Numeric.Inc := True;
            Numeric.Pos := Numeric.Min;
          end else
          begin
            Numeric.Inc := False;
            Numeric.Pos := Numeric.Max;
          end;
          CliMsg(3000, 'Numeric [ON]');
          Numeric.Active := True;
        end else
        if KEY[1] = 'off' then
        begin
          CliMsg(3000, 'Numeric [OFF]');
          Numeric.Active := False;
        end else
        if KEY[1] = 'continue' then
        begin
          CliMsg(3000, 'Numeric [CONTINUE]');
          Numeric.Active := True;
        end;
      end
      else CliMsg(3000, 'Error : Invalid Command');
    end;
  except
    CliMsg(3000, 'Error : Except Command');
  end;
end;

end.
