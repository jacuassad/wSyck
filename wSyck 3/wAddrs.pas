unit wAddrs;

interface

uses
  Winapi.Windows;

  {ADDRS VERSAO 7590 = $1DA6}

const
  PTRDAT          = $006EBB60;
  ADDR_ACC        = $01F856D4;
  ADDR_CARGO      = $0044C029;
  ADDR_MOVESPEED  = $006156E0;

var
  ADDR_SENDPACKET  : DWORD = $0054D78B;
  ADDR_MOVECHAR    : DWORD = $004B80EB;
  ADDR_SHOWMESSAGE : DWORD = $00496F87;

implementation

end.
