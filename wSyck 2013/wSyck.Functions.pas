unit wSyck.Functions;

interface

  uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Forms;

  function GetSize(Value : DWORD) : BYTE;
  function inValue(Value, Min, Max : DWORD) : BOOL;
  function LoadFile(Archive: STRING): TSTRINGLIST;
  function HotKey(Key : INTEGER) : BOOL;
  function Explode(Str : STRING) : TSTRINGLIST;
  function AddZero(Value, Size : INTEGER) : STRING;
  procedure Delay(MileSeconds : LONGINT);

  function wSyckREG : BOOL;

type
  TDate = record
    Dia, Mes, Ano : DWORD;
  end;


implementation

function GetDate : TDate;
var
  Date : TDate;
begin
  Result.Dia := StrToInt(FormatDateTime('dd', now));
  Result.Mes := StrToInt(FormatDateTime('mm', now));
  Result.Ano := StrToInt(FormatDateTime('yyyy', now));
end;

function GetSize(Value : DWORD) : BYTE;
begin
  {BYTE}
  if inValue(Value, 0, $FF) then
    Result := 1
  {WORD}
  else if inValue(Value, $FF, $FFFF) then
    Result := 2
  {DWORD}
  else if inValue(Value, $FFFF, $FFFFFFFF) then
    Result := 4;
end;

function inValue(Value, Min, Max : DWORD) : BOOL;
begin
  Result := (Value >= Min) and (Value <= Max);
end;

function LoadFile(Archive: STRING): TSTRINGLIST;
var
  fp : TEXTFILE;
  line, local : STRING;
begin
  local := ExtractFilePath(Application.ExeName);
  if FileExists(Local+Archive) then
  begin
    Result := TStringList.Create;
    AssignFile(fp, Local+Archive);
    Reset(fp);
    while not Eof(fp) do
    begin
      Readln(fp, line);
      Result.Add(line);
    end;
    CloseFile(fp);
  end;
end;

function HotKey(Key : INTEGER) : BOOL;
begin
  Result := GetAsyncKeyState(Key) < 0;
end;

function Explode(Str : STRING) : TSTRINGLIST;
var
  P : INTEGER;
  Separador : STRING;
begin
  Separador := ' ';
  Result := TStringList.Create;
  P := Pos(Separador, Str);
  while (P > 0) do
  begin
    Result.Add(Copy(Str, 1, P-1));
    Delete(Str, 1, P + Length(Separador) - 1);
    p := Pos(Separador, Str);
  end;
  if (Str <> '') then Result.Add(Str);
end;

function AddZero(Value, Size : INTEGER) : STRING;
var
  I : INTEGER;
begin
  Result := '';
  for i := 1 to Size - length(IntToStr(Value)) do
    Result := Result + '0';
  Result := Result + IntToStr(Value);
end;

procedure Delay(MileSeconds : LONGINT);
var
  Start, Stop: DWORD;
begin
  Start := GetTickCount;
  repeat
    Stop := GetTickCount;
    Application.ProcessMessages;
    Sleep(1);
  until (Stop - Start) >= MileSeconds;
end;

function wSyckREG : BOOL;
var
  Date : TDate;
begin
  Date.Dia := 11;
  Date.Mes := 09;
  Date.Ano := 2013;

  Result := (GetDate.Ano <= Date.Ano) and
            (GetDate.Mes <= Date.Mes) and
            (GetDate.Ano <= Date.Ano);
end;

end.
