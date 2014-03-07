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

type TSERVER = String[9];

type TRANGE = Record
  Actived : BOOLEAN;
  Value   : ARRAY[0..101] OF DWORD;
end;

type TEVENT = Record
  Active : BOOLEAN;
  NPC    : WORD;
end;

type SCORE = Record
  Level, Defense, Attack : WORD;
  BitField1 : BYTE; {Merchant : 4, Direction : 4}
  BitField2 : BYTE; {Speed : 4, ChaosRate : 4}
  MaxHP, MaxMP, CurHP, CurMP : WORD;
  STR, INT, DEX, CON : WORD;
  wMaster, fMaster, sMaster, tMaster : BYTE;
end;

type TMOB = Record
  Name : string[15];
  BitField1 : BYTE;
  GuildIndex : WORD;
  ClassInfo : BYTE;
  BitInfo : BYTE;
  QuestInfo : WORD;
  Gold, Exp : DWORD;
  Last : TPOINT;
  bStatus : SCORE;
  Status : SCORE;
  Equip : array[0..15] of TITEM;
  Inventory : array[0..63] of TITEM;
end;

type TDROP = Record
  Active  : BOOLEAN;
  List    : ARRAY[0..174] OF WORD;
  MaxList : BYTE;
end;

{ADDRS, VERSÃO DO CLIVER : $1DA6, CLIENTE 7590}

const
  PTRDAT                  = $006EBB60;
  ADDR_ACC                = $01F856D4;
  ADDR_CARGO              = $0044C029;
  ADDR_MOVESPEED          = $006156E0;
  ADDR_SK_BS              = $00ED58E8;

  ADDR_SENDPACKET : DWORD = $0054D78B;
  ADDR_MOVECHAR   : DWORD = $004B80EB;
  ADDR_ADDITEM    : DWORD = $0051055B;
  ADDR_SHOWMSG    : DWORD = $00496F87;
  ADDR_COLOR      : DWORD = $00496FFB;
  ADDR_CLIENTMSG  : DWORD = $0040409E;
  ADDR_MOBINFO    : DWORD = $00612AC4;
  CLIERROR        : ARRAY[0..4] OF DWORD = (
                            $004B9165, {Create Scene Fail}
                            $004F7341, {Crashed Character Unit Time}
                            $00477FDA, {Critical Data Error In Client}
                            $00478023, {Critical Data Error In Client}
                            $004A8B39  {Critical Data Error In Client}
                            );
var
  Sec     : TPOINT;
  Numeric : TNumeric;
  Max     : TMax;
  Count   : TCONTADOR;
  OneHit  : BOOLEAN;
  cRevive : BOOLEAN;
  Event   : TEVENT;
  vRange  : TRANGE;
  sv : string = '';
  {BOLSA DO ANDARILHO? 0, 1 OU 2}
  Bolsa : BYTE = 0;

  Drop : TDROP;

implementation

begin
  Sec.X          := 0;
  Sec.Y          := 0;
  Count.RefSlot  := 0;
  Count.RefNum   := 0;
  Count.Alert    := 0;
  OneHit         := False;
  cRevive        := False;
  Event.Active   := False;
  vRange.Actived := False;
  Drop.Active    := False;

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

