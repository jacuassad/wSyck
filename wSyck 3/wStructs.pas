unit wStructs;

interface

uses
  Winapi.Windows;

type ITEM = Record
  Index     : WORD;
  EF1, EFV1 : BYTE;
  EF2, EFV2 : BYTE;
  EF3, EFV3 : BYTE;
end;

type POINT = Record
  X, Y : WORD;
end;

type EQUIP = Record
  Items : ARRAY[0..15] OF ITEM;
end;

type INVENTORY = Record
  Items : ARRAY[0..59] OF ITEM;
end;

type CARGO = Record
  Items : ARRAY[0..119] OF ITEM;
end;

implementation

end.
