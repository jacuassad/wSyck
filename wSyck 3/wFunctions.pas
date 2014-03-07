unit wFunctions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Forms, wAddrs, wStructs;

  function GetClientID : DWORD;
  function GetPosX : DWORD;
  function GetPosY : DWORD;
  function GetPlayerID : DWORD;
  function GetEquip : EQUIP;
  function GetInventory : INVENTORY;
  {function GetCargo : CARGO;}
  {function CheckGameState : BOOLEAN;}
  function Explode(Str : STRING) : TSTRINGLIST;

  procedure Delay(MSeconds : LONGINT);
  procedure SendPacket(Packet : ARRAY OF BYTE; Size : DWORD);
  procedure MoveChar(OpCode : DWORD; Packet : ARRAY OF BYTE);
  procedure sMessage(Str : PCHAR);
  procedure ShowMsg(Str : PCHAR; Color : DWORD);
implementation

function GetClientID : DWORD;
  asm
    MOV ECX, DWORD PTR DS:[ADDR_ACC]
    ADD ECX, $DFC
    XOR EAX, EAX
    MOV AX,  WORD PTR DS:[ECX]
  end;

function GetPosX : DWORD;
  asm
    MOV EAX, [PTRDAT]
    MOV EAX, [EAX+27614H]
  end;

function GetPosY : DWORD;
  asm
    MOV EAX, [PTRDAT]
    MOV EAX, [EAX+27618H]
  end;

function GetPlayerID : DWORD;
begin
  Result := PDWORD(PDWORD(PTRDAT)^+$26EFC)^;
end;

function GetEquip : EQUIP;
var
  PEquip : ^EQUIP;
begin
  PEquip := @PDWORD(PDWORD($00612AC4)^+$8C)^;
  Result := PEquip^;
end;

function GetInventory : INVENTORY;
var
  PInventory : ^INVENTORY;
begin
  PInventory := @PDWORD(PDWORD($00612AC4)^+$10C)^;
  Result := PInventory^;
end;

{function GetCargo : CARGO;}
{function CheckGameState : BOOLEAN;}

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

procedure sMessage(Str : PCHAR);
  asm
    LEA  EDX, [STR]
    MOV  EAX, PTRDAT
    MOV  ECX, DWORD PTR DS:[EAX]
    PUSH EDX
    MOV  ECX, ECX
    CALL ADDR_SHOWMESSAGE
    RETN
  end;

procedure ShowMsg(Str : PCHAR; Color : DWORD);
var
  RET : CARDINAL;
begin
  VirtualProtect(ptr($496FFB), 10, PAGE_EXECUTE_WRITECOPY, RET);
  {COLOR = $FF99FF22}
  PDWORD(PDWORD($00440C84)^+$7FB)^ := Color;
  sMessage(Str);
  PDWORD(PDWORD($00440C84)^+$7FB)^ := $FFFFAAAA;
end;

function Explode(Str : STRING) : TSTRINGLIST;
var
  P : INTEGER;
  Separador : STRING;
begin
  Separador := ', ';
  Result := TStringList.Create;

  P := Pos(Separador, Str);
  while (P > 0) do
  begin
    Result.Add(Copy(Str, 1, P-1));
    Delete(Str, 1, P + Length(Separador) - 1);
    p := Pos(Separador, Str);
  end;

  if (Str <> '') then
    Result.Add(Str);
end;

end.
