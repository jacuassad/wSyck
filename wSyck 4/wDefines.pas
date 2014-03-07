unit wDefines;

interface

uses
  Winapi.Windows;

type TITEM = Record
  ID        : WORD;
  EF1, EFV1 : BYTE;
  EF2, EFV2 : BYTE;
  EF3, EFV3 : BYTE;
end;

type TPOINT = Record
  X, Y : WORD;
end;

type TEQUIP     = ARRAY[0..015] OF TITEM;

type TINVENTORY = ARRAY[0..059] OF TITEM;

type TCARGO     = ARRAY[0..119] OF TITEM;

type TMax = Record
  Equip     : BYTE;
  Inventory : BYTE;
  Cargo     : BYTE;
end;

type TNUMERIC = Record
  Active         : BOOLEAN;
  Min, Max, Size : Integer;
  Inc            : BOOLEAN;
  Pos, New       : Integer;
end;

type TCONTADOR = Record
  RefSlot : INTEGER;
  RefNum  : INTEGER;
  Alert   : INTEGER;
end;

type TRANGE = Record
  Actived : BOOLEAN;
  Value   : ARRAY[0..101] OF DWORD;
end;



{ADDRS, VERSÃO DO CLIVER : $1DA6, CLIENTE 7590}

const
  PTRDAT                  = $006EBB60;
  ADDR_ACC                = $01F856D4;
  ADDR_CARGO              = $0044C029;
  ADDR_MOVESPEED          = $006156E0;
  ADDR_SK_BS              = $00ED58E8;

var
  ADDR_SENDPACKET : DWORD = $0054D78B;
  ADDR_MOVECHAR   : DWORD = $004B80EB;
  ADDR_ADDITEM    : DWORD = $0051055B;
  ADDR_SHOWMSG    : DWORD = $00496F87;
  ADDR_CLIENTMSG  : DWORD = $0040409E;

  Sec     : TPOINT;
  Numeric : TNumeric;
  Max     : TMax;
  Count   : TCONTADOR;
  OneHit  : BOOLEAN;
  vRange  : TRANGE;

  {BOLSA DO ANDARILHO? 0, 1 OU 2}
  Bolsa : BYTE = 0;

implementation

begin
  Sec.X           := 0;
  Sec.Y           := 0;
  Count.RefSlot   := 0;
  Count.RefNum    := 0;
  Count.Alert     := 0;
  OneHit          := False;
  vRange.Actived  := False;

  Numeric.Active := False;
  Numeric.Min    := 0000;
  Numeric.Max    := 9999;
  Numeric.Size   := 0004;
  Numeric.Inc    := True;
  Numeric.Pos    := 0000;
  Numeric.New    := 1234;

  {NÚMERO MÁXIMO DE ITENS EQUIP, INVENTORY E CARGO}
  Max.Equip     := -1 + 016;
  Max.Inventory := -1 + 030 + (Bolsa * 15);
  Max.Cargo     := -1 + 120;
end.

