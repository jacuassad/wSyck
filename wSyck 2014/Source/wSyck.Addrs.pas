unit wSyck.Addrs;

interface

uses
 Winapi.Windows;

{ *** Addrs, Cliente 7606 *** }
const
  wSyck_Version           = 000001000;
 {DEFN}
  DEFN_CLIENT             = $00001DB6;
 {CONS}
  CONS_CLIVER             = $000002F7;
  CONS_PTRDAT : DWORD     = $006EEB20;
  CONS_ACC                = $02288694;
  CONS_MOVESPEED          = $00618650;
  CONS_CARGO              = $02288694;
  CONS_SVNAME             = $0228BCF4;
  CONS_TITLE              = $00622D74;
  CONS_ITEMS              = $00FB7678; //ITEM LIST STRUCT ADDR
 {ADDR}
  ADDR_CARGO      : DWORD = $0044C113;
  ADDR_SENDPACKET : DWORD = $0054DCBB;
  ADDR_MOVECHAR   : DWORD = $004B85AB;
  ADDR_ADDITEM    : DWORD = $00510A01;
  ADDR_SHOWMSG    : DWORD = $497443+1;
  ADDR_COLOR      : DWORD = $4974B7+1;
  ADDR_CLIMSG     : DWORD = $0040409E;

implementation

end.
