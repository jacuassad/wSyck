unit wSyck.Base;

interface

uses
  Winapi.Windows;

  function RtlAdjustPrivilege(
    dwPrivilegeId : DWORD;
    bSet          : BOOL;
    AdjType       : INTEGER;
    Unc           : PDWORD
  ) : WORD; stdcall; external 'ntdll.dll';

implementation

end.
