unit wSyck.Basics; // ATT GERAL

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  {wSyck}
  wSyck.Base,
  wSyck.Addrs,
  wSyck.Defines,
  wSyck.Functions;

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
  function _PlayerID  : DWORD;
  procedure _SendPacket(Packet : ARRAY OF BYTE; Size : DWORD);
  procedure _MoveChar(OpCode : DWORD; Packet : ARRAY OF BYTE; Size : DWORD);
  procedure _OpenCargo;
  procedure _AddItem(Packet : ARRAY OF BYTE; Size: DWORD); //-
  procedure _CliMsg(Delay : DWORD; Msg : STRING); //-
  procedure _ShowMsg(Msg : STRING);

implementation

function _ClientID : DWORD;
var
	H   : THandle;
  NBR : SIZE_T;
  Unc : DWORD;
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_ACC), @Result, 4, NBR);
    Inc(Result, $DFC);
    ReadProcessMemory(H, PTR(Result), @Result, 4, NBR);
  end;
end;

function _PosX : DWORD;
var
	H   : THandle;
  NBR : SIZE_T;
  Unc : DWORD;
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_PTRDAT), @Result, 4, NBR);
    Inc(Result, $27614);
    ReadProcessMemory(H, PTR(Result), @Result, 4, NBR);
  end;
end;

function _PosY : DWORD;
var
	H   : THandle;
  NBR : SIZE_T;
  Unc : DWORD;
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_PTRDAT), @Result, 4, NBR);
    Inc(Result, $27618);
    ReadProcessMemory(H, PTR(Result), @Result, 4, NBR);
  end;
end;

function _MoveSpeed : DWORD;
var
	H   : THandle;
  NBR : SIZE_T;
  Unc : DWORD;
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_MOVESPEED), @Result, 4, NBR);
  end;
end;

function _GoldChar : DWORD;
var
	H   : THandle;
  NBR : SIZE_T;
  Unc : DWORD;
begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_ACC), @Result, 4, NBR);
    Inc(Result, $768);
    ReadProcessMemory(H, PTR(Result), @Result, 4, NBR);
end;

function _GoldCargo : DWORD;
var
	H   : THandle;
  NBR : SIZE_T;
  Unc : DWORD;
begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_ACC), @Result, 4, NBR);
    Inc(Result, $DF8);
    ReadProcessMemory(H, PTR(Result), @Result, 4, NBR);
end;

function _Equip : TEquip;
var
	H      : THandle;
  NBR    : SIZE_T;
  Unc, p : DWORD;
begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_ACC), @p, 4, NBR);
    Inc(p, $7DC);
    ReadProcessMemory(H, PTR(p), @Result, Sizeof(Result), NBR);
end;

function _Inventory : TInventory;
var
	H      : THandle;
  NBR    : SIZE_T;
  Unc, p : DWORD;
begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_ACC), @p, 4, NBR);
    Inc(p, $85C);
    ReadProcessMemory(H, PTR(p), @Result, Sizeof(Result), NBR);
end;

function _Cargo : TCargoItems;
var
	H      : THandle;
  NBR    : SIZE_T;
  Unc, p : DWORD;
begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_CARGO), @p, 4, NBR);
    Inc(p, $350);
    ReadProcessMemory(H, PTR(p), @Result, Sizeof(Result), NBR);
end;

function _HP : DWORD;
var
	H   : THandle;
  NBR : SIZE_T;
  Unc : DWORD;
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_ACC), @Result, 4, NBR);
    Inc(Result, $7C4);
    ReadProcessMemory(H, PTR(Result), @Result, 4, NBR);
  end;
end;

function _Live : BOOL;
begin
  Result := _HP > 0;
end;

function _PlayerID : DWORD;
var
	H   : THandle;
  NBR : SIZE_T;
  Unc : DWORD;
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    ReadProcessMemory(H, PTR(CONS_PTRDAT), @Result, 4, NBR);
    Inc(Result, $26EFC);
    ReadProcessMemory(H, PTR(Result), @Result, 4, NBR);
  end;
end;

procedure _SendPacket(Packet : ARRAY OF BYTE; Size : DWORD);
var
	H : THandle;
  NBR : SIZE_T;
  RET : Cardinal;
  Unc : DWORD;
  CodeCave, Buffer : Pointer;
const
  SendPacketBytes : ARRAY[0..20] of BYTE = ($55, $8B, $EC, $6A, $00, $68, $00, $00, $00, $00, $B8, $00, $00, $00, $00, $FF, $D0, $8B, $E5, $5D, $C3);
  {
        PUSH EBP                 -> $55
        MOV EBP, ESP             -> $8B $EC
        PUSH SIZE                -> $6A __
        PUSH PACKET              -> $68 __ __ __ __
        MOV EAX, ADDR_SENDPACKET -> $B8 __ __ __ __
        CALL EAX                 -> $FF $D0
        MOV ESP, EBP             -> $8B $E5
        POP EBP                  -> $5D
        RETN                     -> $C3
  }
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    CodeCave := VirtualAllocEx(H, nil, SizeOf(SendPacketBytes), MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Buffer := VirtualAllocEx(H, nil, Size+1, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    WriteProcessMemory(H, CodeCave, @SendPacketBytes, SizeOf(SendPacketBytes), NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+4), @Size, 1, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+6), @Buffer, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+11), @ADDR_SENDPACKET, 4, NBR);
    WriteProcessMemory(H, Buffer, @Packet, Size, NBR);
    CreateRemoteThread(H, nil, 0, CodeCave, nil, 0, RET);
    VirtualFreeEx(H, CodeCave, SizeOf(SendPacketBytes), MEM_RELEASE);
    VirtualFreeEx(H, Buffer, Size+1, MEM_RELEASE);
    CloseHandle(H);
 end;
end;

procedure _MoveChar(OpCode : DWORD; Packet : ARRAY OF BYTE;Size : DWORD);
var
	H : THandle;
  NBR : SIZE_T;
  RET : Cardinal;
  Unc : DWORD;
  CodeCave, Buffer : Pointer;
const
  MoveCharBytes : ARRAY[0..23] of BYTE = ($55, $8B, $EC, $68, $00, $00, $00, $00, $68, $00, $00, $00, $00, $B8, $00, $00, $00, $00, $FF, $D0, $8B, $E5, $5D, $C3);
  {
        PUSH EBP                    -> $55
        MOV EBP, ESP                -> $8B $EC
        PUSH PACKET                 -> $68 __ __ __ __
        PUSH OPCODE                 -> $68 __ __ __ __
        MOV EAX, ADDR_MOVECHAR      -> $B8 __ __ __ __
        CALL EAX                    -> $FF $D0
        MOV ESP, EBP                -> $8B $E5
        POP EBP                     -> $5D
        RETN                        -> $C3
  }
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    CodeCave := VirtualAllocEx(H, nil, SizeOf(MoveCharBytes), MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Buffer := VirtualAllocEx(H, nil, Size+1, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    WriteProcessMemory(H, CodeCave, @MoveCharBytes, SizeOf(MoveCharBytes), NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+4), @Buffer, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+9), @OpCode, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+14), @ADDR_MOVECHAR, 4, NBR);
    WriteProcessMemory(H, Buffer, @Packet, Size, NBR);
    CreateRemoteThread(H, nil, 0, CodeCave, nil, 0, RET);
    VirtualFreeEx(H, CodeCave, SizeOf(MoveCharBytes), MEM_RELEASE);
    VirtualFreeEx(H, Buffer, Size+1, MEM_RELEASE);
    CloseHandle(H);
 end;
end;

procedure _OpenCargo;
var
	H : THandle;
  NBR : SIZE_T;
  RET : Cardinal;
  Unc : DWORD;
  CodeCave : Pointer;
const
  OpenCargoBytes : ARRAY[0..18] of BYTE = ($B8, $00, $00, $00, $00, $8B, $10, $6A, $01, $8B, $CA, $B8, $00, $00, $00, $00, $FF, $D0, $C3);
  {
        MOV EAX, CONS_PTRDAT          -> $B8 __ __ __ __
        MOV EDX, DWORD PTR DS:[EAX]   -> $8B $10
        PUSH 1                        -> $6A $01
        MOV ECX, EDX                  -> $8B $CA
        MOV EAX, ADDR_CARGO           -> $B8 __ __ __ __
        CALL EAX                      -> $FF $D0
        RETN                          -> $C3
  }
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    CodeCave := VirtualAllocEx(H, nil, SizeOf(OpenCargoBytes), MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    WriteProcessMemory(H, CodeCave, @OpenCargoBytes, SizeOf(OpenCargoBytes), NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+1), @CONS_PTRDAT, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+12), @ADDR_CARGO, 4, NBR);
    CreateRemoteThread(H, nil, 0, CodeCave, nil, 0, RET);
    VirtualFreeEx(H, CodeCave, SizeOf(OpenCargoBytes), MEM_RELEASE);
    CloseHandle(H);
 end;
end;

procedure _AddItem(Packet : ARRAY OF BYTE; Size: DWORD);
var
	H : THandle;
  NBR : SIZE_T;
  RET : Cardinal;
  Unc : DWORD;
  CodeCave, Buffer : Pointer;
const
  AddItemBytes : ARRAY[0..15] of BYTE = ($FF, $35, $00, $00, $00, $00, $FF, $15, $00, $00, $00, $00, $83, $C4, $08, $C3);
begin
  if (PID > 0) then
  begin
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    CodeCave := VirtualAllocEx(H, nil, SizeOf(AddItemBytes), MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Buffer := VirtualAllocEx(H, nil, Size+1, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    WriteProcessMemory(H, CodeCave, @AddItemBytes, SizeOf(AddItemBytes), NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+2), Buffer, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+8), @ADDR_ADDITEM, 4, NBR);
    WriteProcessMemory(H, Buffer, @Packet, Size, NBR);
    CreateRemoteThread(H, nil, 0, CodeCave, nil, 0, RET);
    CloseHandle(H);
 end;
end;

procedure _CliMsg(Delay : DWORD; Msg : STRING);
var
  Str : PANSICHAR;
  Size, Unc : DWORD;
	H : THandle;
  NBR : SIZE_T;
  RET : Cardinal;
  CodeCave, Buffer, B2 : Pointer;
const
  CliMsgBytes : ARRAY[0..77] of BYTE = ($68, $00, $00, $00, $00, $68, $00, $00, $00, $00, $36, $8B, $0D, $20, $EB, $6E, $00, $3E, $8B, $89, $C4, $00, $00, $00, $FF, $15, $00, $00, $00, $00, $6A, $00, $6A, $01, $36, $8B, $15, $20, $EB, $6E, $00, $3E, $8B, $8A, $C4, $00, $00, $00, $36, $8B, $05, $20, $EB, $6E, $00, $3E, $8B, $90, $C4, $00, $00, $00, $3E, $8B, $02, $3E, $FF, $90, $88, $00, $00, $00, $B8, $01, $00, $00, $00, $C3);
begin
  if (PID > 0) then
  begin
    Str := PansiChar(AnsiString(Msg));
    Size := Length(Str)+1;
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    CodeCave := VirtualAllocEx(H, nil, SizeOf(CliMsgBytes), MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Buffer := VirtualAllocEx(H, nil, Size, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    B2 := VirtualAllocEx(H, nil, 4, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    WriteProcessMemory(H, CodeCave, @CliMsgBytes, SizeOf(CliMsgBytes), NBR);
     WriteProcessMemory(H, PTR(INTEGER(CodeCave)+1), @B2, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+6), @Buffer, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+25), @ADDR_CLIMSG, 4, NBR);
     WriteProcessMemory(H, B2, @Delay, 4, NBR);
    WriteProcessMemory(H, Buffer, Str, Size, NBR);
    CreateRemoteThread(H, nil, 0, CodeCave, nil, 0, RET);
    CloseHandle(H);
  end;
end;

procedure _ShowMsg(Msg : STRING);
var
  Str : PANSICHAR;
  Size, Unc, Color : DWORD;
	H : THandle;
  NBR : SIZE_T;
  RET, old : Cardinal;
  CodeCave, Buffer : Pointer;
const
  ShowMsgBytes : ARRAY[0..27] of BYTE = ( $55, $8B, $EC, $B8, $00, $00, $00, $00, $8B, $10, $68, $00, $00, $00, $00, $8B, $CA, $B8, $00, $00, $00, $00, $FF, $D0, $8B, $E5, $5D, $C3);
  {
        PUSH EBP                    -> $55
        MOV EBP, ESP                -> $8B $EC
        MOV EAX, CONS_PTRDAT        -> $B8 __ __ __ __
        MOV EDX, DWORD PTR DS:[EAX] -> $8B $10
        PUSH MSG                    -> $68 __ __ __ __
        MOV ECX, EDX                -> $8B $CA
        MOV EAX, ADDR_SHOWMSG       -> $B8 __ __ __ __
        CALL EAX                    -> $FF $D0
        MOV ESP, EBP                -> $8B $E5
        POP EBP                     -> $5D
        RETN                        -> $C3
  }
begin
  if (PID > 0) then
  begin
    Str := PansiChar(AnsiString(Msg));
    Size := Length(Str)+1;
    RtlAdjustPrivilege(20, True, 0, @Unc);
    H := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    CodeCave := VirtualAllocEx(H, nil, SizeOf(ShowMsgBytes), MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Buffer := VirtualAllocEx(H, nil, Size, MEM_COMMIT, PAGE_EXECUTE_READWRITE);

    VirtualProtect(PTR(ADDR_COLOR), 4, PAGE_EXECUTE_WRITECOPY, old);
    Color := $FF99FF22;
    WriteProcessMemory(H, PTR(ADDR_COLOR), @Color, 4, NBR);

    WriteProcessMemory(H, CodeCave, @ShowMsgBytes, SizeOf(ShowMsgBytes), NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+4), @CONS_PTRDAT, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+11), @Buffer, 4, NBR);
    WriteProcessMemory(H, PTR(INTEGER(CodeCave)+18), @ADDR_SHOWMSG, 4, NBR);
    WriteProcessMemory(H, Buffer, Str, Size, NBR);
    CreateRemoteThread(H, nil, 0, CodeCave, nil, 0, RET);
    VirtualFreeEx(H, CodeCave, SizeOf(ShowMsgBytes), MEM_RELEASE);
    VirtualFreeEx(H, Buffer, Size, MEM_RELEASE);

    Delay(300);
    Color := $FFFFAAAA;
    WriteProcessMemory(H, PTR(ADDR_COLOR), @Color, 4, NBR);
    VirtualProtect(PTR(ADDR_COLOR), 4, old, old);

    CloseHandle(H);
  end;
end;

end.
