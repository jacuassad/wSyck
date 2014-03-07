unit wSyck.Addrs;

interface

uses
 Winapi.Windows;

{ *** Addrs, Cliente 7605 *** }
const
  wSyck_Version           = 000001000;
 {DEFN}
  DEFN_CLIENT             = $00001DB5;
 {CONS}
  CONS_CLIVER             = $000002F7;
  CONS_PTRDAT             = $006EEB20;
  CONS_ACC                = $02288694;
  CONS_MOVESPEED          = $00618650;
  CONS_SK_BS              = $011D88A8;
  CONS_MOBINFO            = $00615A34;
  CONS_CARGO              = $02288694;
 {ADDR}
  ADDR_CARGO      : DWORD = $0044C0F3;
  ADDR_SENDPACKET : DWORD = $0054DC8B;
  ADDR_MOVECHAR   : DWORD = $004B857B;
  ADDR_ADDITEM    : DWORD = $005109D1; //ERROR
  ADDR_SHOWMSG    : DWORD = $49740A+1;
  ADDR_COLOR      : DWORD = $49747E+1;
  ADDR_CLIENTMSG  : DWORD = $0040409E;

implementation

end.
