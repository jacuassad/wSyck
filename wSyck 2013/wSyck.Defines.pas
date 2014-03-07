unit wSyck.Defines;

interface

  uses
    Winapi.Windows,
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

implementation

end.
