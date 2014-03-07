unit wSyck.Defines;

interface

uses
  Winapi.Windows,
  {wSyck}
  wSyck.Addrs;

type
  TPos = record
    X, Y : DWORD;
  end;

type
  TEffect = record
    ID, Value : BYTE;
  end;

type
  TItem = record
    ID     : WORD;
    Effect : ARRAY[1..3] OF TEffect
end;

type TEquip      = ARRAY[0..15] OF TItem;

type TInventory  = ARRAY[1..4] OF ARRAY[1..15] OF TItem;

type TCargoItems = ARRAY[1..3] OF ARRAY[1..40] OF TItem;

type
  TChar = record
    Gold  : DWORD;
    Equip : TEquip;
    Items : TInventory;
  end;

type
  TCargo = record
    Gold  : DWORD;
    Items : TCargoItems;
  end;

type
  TSec = record
    Active : BOOL;
    Pos    : TPos;
  end;

var
  PID     : DWORD;
  SVNAME  : STRING;
  bSTATUS : STRING;
  HOME    : STRING;

const
  GameName   : STRING = 'With Your Destiny';
  FileName   : STRING = 'WYD.exe';
  URL        : STRING = 'www.google.com';
  DEBUG      : BOOL = True;
  TabMonitor : BOOL = False;

  EQUIP     = 0;
  INVENTORY = 1;
  CARGO     = 2;

  REG_DAY   = 07;
  REG_MONTH = 03;
  REG_YEAR  = 2015;

implementation

begin

end.
