unit wSyck.Basics;

interface

  uses
    Winapi.Windows,
    wSyck.Addrs, wSyck.Defines, wSyck.Functions;

  function _ClientID  : DWORD;
  function _PosX      : DWORD;
  function _PosY      : DWORD;
  function _MoveSpeed : DWORD;
  function _GoldChar  : DWORD;
  function _GoldCargo : DWORD;
  function _Equip     : TEquip;
  function _Inventory : TInventory;
  function _Cargo     : TCargoItems;
  function _HP        : DWORD;
  function _Live      : BOOL;
  procedure _SendPacket(Packet : ARRAY OF BYTE; Size : DWORD);
  procedure _MoveChar(OpCode : DWORD; Packet : ARRAY OF BYTE);
  procedure _OpenCargo;
  procedure _AddItem(Packet : ARRAY OF BYTE);
  procedure _CliMsg(Delay : INTEGER; Msg : STRING);
  procedure _ShowMsg(Msg : STRING);
  function PlayerID : DWORD;

  const
    EQUIP     = 0;
    INVENTORY = 1;
    CARGO     = 2;

    BOLSA     = 0;

implementation

function _ClientID : DWORD;
asm
  MOV ECX, DWORD PTR DS:[CONS_ACC]
  ADD ECX, $DFC
  XOR EAX, EAX
  MOV AX,  WORD PTR DS:[ECX]
end;

function _PosX : DWORD;
asm
  MOV EAX, [CONS_PTRDAT]
  MOV EAX, [EAX+27614H]
end;

function _PosY : DWORD;
asm
  MOV EAX, [CONS_PTRDAT]
  MOV EAX, [EAX+27618H]
end;

function _MoveSpeed : DWORD;
begin
  Result := PDWORD(CONS_MOVESPEED)^;
end;

function _GoldChar : DWORD;
begin
  Result := PDWORD(PDWORD(CONS_MOBINFO)^+$18)^;
end;

function _GoldCargo : DWORD;
begin
  Result := PDWORD(PDWORD(CONS_MOBINFO)^+$6A8)^;
end;

function _Equip : TEquip;
var
  PtrEquip : ^TEquip;
begin
  PtrEquip := @PDWORD(PDWORD(CONS_MOBINFO)^+$8C)^;
  Result := PtrEquip^;
end;

function _Inventory : TInventory;
var
  PtrInventory : ^TInventory;
begin
  PtrInventory := @PDWORD(PDWORD(CONS_MOBINFO)^+$10C)^;
  Result := PtrInventory^;
end;

function _Cargo : TCargoItems;
var
  PtrCargo : ^TCargoItems;
begin
  PtrCargo := @PWORD(PDWORD(CONS_CARGO)^+$350)^;
  Result := PtrCargo^;
end;

function _HP : DWORD;
begin
  Result := PDWORD(PDWORD(CONS_MOBINFO)^+$74)^;
end;

function _Live : BOOL;
begin
  Result := _HP > 0;
end;

procedure _SendPacket(Packet : ARRAY OF BYTE; Size : DWORD);
asm
  PUSH SIZE
  PUSH PACKET
  CALL ADDR_SENDPACKET
  ADD  ESP, 08H
end;

procedure _MoveChar(OpCode : DWORD; Packet : ARRAY OF BYTE);
asm
  PUSH PACKET
  PUSH OPCODE
  CALL ADDR_MOVECHAR
  ADD  ESP, 08H
end;

procedure _OpenCargo;
asm
  MOV EAX, CONS_PTRDAT
  MOV EDX, DWORD PTR DS:[EAX]
  PUSH 1
  MOV ECX, EDX
  MOV EAX, ADDR_CARGO
  CALL EAX
end;

procedure _AddItem(Packet : ARRAY OF BYTE);
asm
  PUSH PACKET
  CALL ADDR_ADDITEM
  ADD  ESP, 08H
end;

procedure _CliMsg(Delay : INTEGER; Msg : STRING);
var
  Str : PANSICHAR;
begin
  Str := PAnsiChar(AnsiString(Msg));
  asm
    PUSH DELAY
    PUSH STR
    MOV  ECX, DWORD PTR SS:[CONS_PTRDAT]
    MOV  ECX, DWORD PTR DS:[ECX+$C4]
    CALL ADDR_CLIENTMSG
    PUSH 0
    PUSH 1
    MOV  EDX, DWORD PTR SS:[CONS_PTRDAT]
    MOV  ECX, DWORD PTR DS:[EDX+$C4]
    MOV  EAX, DWORD PTR SS:[CONS_PTRDAT]
    MOV  EDX, DWORD PTR DS:[EAX+$C4]
    MOV  EAX, DWORD PTR DS:[EDX]
    CALL DWORD PTR DS:[EAX+$88]
    MOV  EAX, 1
  end;
end;

procedure _ShowGameMsg(Msg : PANSICHAR);
asm
  LEA EDX, [MSG]
  MOV EAX, CONS_PTRDAT
  MOV ECX, DWORD PTR DS:[EAX]
  PUSH EDX
  MOV ECX, ECX
  CALL ADDR_SHOWMSG
  RETN
end;

procedure _ShowMsg(Msg : STRING);
var
  RET : CARDINAL;
begin
    VirtualProtect(PTR(ADDR_COLOR), 4, PAGE_EXECUTE_WRITECOPY, RET);
    PDWORD(ADDR_COLOR)^ := $FF99FF22;
    _ShowGameMsg(PAnsiChar(AnsiString(Msg)));
    PDWORD(ADDR_COLOR)^ := $FFFFAAAA;
end;

function PlayerID : DWORD;
begin
  Result := PDWORD(PDWORD(CONS_PTRDAT)^+$26EFC)^;
end;

end.
