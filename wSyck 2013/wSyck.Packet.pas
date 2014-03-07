unit wSyck.Packet;

interface

uses
  Winapi.Windows, 
  wSyck.Basics, wSyck.Functions, wSyck.Client;

type
  TPacket = class
  private
    OpCode   : WORD;
    Size     : WORD;
    ClientID : WORD;
    Status   : BOOL;
    Buffer   : ARRAY OF BYTE;

    procedure SetBuffer(OffSet : BYTE);
    procedure CreatePacket;
  public
    Write : ARRAY OF INTEGER;

    constructor Create(OpCode, Size : WORD; ClientID : WORD = 0);

    procedure Send; overload;
    procedure Send(Qtd : BYTE); overload;
    procedure ClientMove;
    procedure ClientAddItem;
  end;

implementation

constructor TPacket.Create(OpCode, Size : WORD; ClientID : WORD = 0);
begin
  self.OpCode := OpCode;
  self.Size   := Size;

  if ClientID <> 0 then
    self.ClientID := ClientID
  else
    self.ClientID := Client.ID;

  SetLength(Write, Size * sizeof(INTEGER));

  Write[00] := self.Size;
  Write[04] := self.OpCode;
  Write[06] := self.ClientID;

  Status := False;
  SetLength(Buffer, Size);
end;

procedure TPacket.Send;
begin
  CreatePacket;
  _SendPacket(Buffer, Size);
end;

procedure TPacket.Send(Qtd : BYTE);
begin
  while Qtd > 0 do
  begin
    Send;
    Dec(Qtd);
  end;
end;

procedure TPacket.ClientMove;
begin
  CreatePacket;
  _MoveChar(OpCode, Buffer);
end;

procedure TPacket.ClientAddItem;
begin
  CreatePacket;
  _AddItem(Buffer);
end;

procedure TPacket.SetBuffer(OffSet : BYTE);
begin
  case GetSize(Write[OffSet]) of
    1 : PBYTE (INTEGER(Buffer)+OffSet)^ := Write[OffSet];
    2 : PWORD (INTEGER(Buffer)+OffSet)^ := Write[OffSet];
    4 : PDWORD(INTEGER(Buffer)+OffSet)^ := Write[OffSet];
  end;
end;

procedure TPacket.CreatePacket;
var
  I : INTEGER;
begin
  if not Status then
  begin
    Status := True;
    for I := 0 to Size-1 do
      if Write[I] <> 0 then
        SetBuffer(I);
  end;
end;

end.
