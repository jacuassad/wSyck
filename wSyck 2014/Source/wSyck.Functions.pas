unit wSyck.Functions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Forms, Tlhelp32, IniFiles, ShellApi,
  {wSyck}
  wSyck.Base,
  wSyck.Defines;

  function GetPID(Process : STRING) : DWORD;
  function CloseProcess(ProcessID : DWORD) : INTEGER;
  procedure ShowError(Handle : THandle; Title, Text : STRING);
  function inValue(Value, Min, Max : DWORD) : BOOL;
  function LoadFile(Archive: STRING): TSTRINGLIST;
  function HotKey(Key : INTEGER) : BOOL;
  function Explode(Text, Separator : STRING) : TSTRINGLIST;
  function AddZero(Value, Size : INTEGER) : STRING;
  procedure Delay(MileSeconds : LONGINT);
  function GetSize(Value : DWORD) : BYTE;
  function ReadString(Address: INTEGER) : STRING;
  function DeCrypt(Src : STRING) : STRING;
  function GetActiveWindow : STRING;
  function PCName : STRING;
  function TempDir : STRING;
  procedure wSyckProtect;
  function wSyckRegister : BOOL;

implementation

function wSyckRegister : BOOL;
begin
  Result := StrToDate(IntToStr(REG_DAY) + '/' + IntToStr(REG_MONTH) + '/' + IntToStr(REG_YEAR)) <= Date;
end;

procedure wSyckProtect;
var
  Stream: TResourceStream;
begin
  if not DEBUG then
  begin
    if not FileExists(TempDir+'protect.exe') then
    begin
      Stream := TResourceStream.Create(hInstance, 'Protect', RT_RCDATA);
      try
        Stream.SaveToFile(TempDir+'protect.exe');
      finally
        Stream.Free;
      end;
    end;
    if FindWindow(PChar('TProtect'), nil) = 0 then
    begin
      ShellExecute(Application.Handle, 'open', PChar(TempDir+'protect.exe'), nil, nil, SW_SHOWNORMAL);
    end;
  end;
end;

function TempDir : STRING;
var
  Buffer : ARRAY[0..$90] OF CHAR;
begin
  GetTempPath($90, Buffer);
  Result := StrPas(Buffer);
end;

function PCName : STRING;
var
  Size : DWORD;
begin
  Size := $1F;
  SetLength(Result, Size);
  GetComputerName(Pchar(Result), Size);
end;

function GetPID(Process : STRING) : DWORD;
var
  NextProcess        : BOOL;
  FSnapshotHandle    : THandle;
  FProcessEntry      : TProcessEntry32;
  ProcessName        : STRING;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry.dwSize := sizeof(FProcessEntry);
  NextProcess := Process32First(FSnapshotHandle, FProcessEntry);
  while NextProcess do
  begin
    ProcessName := FProcessEntry.szExeFile;
    if ProcessName.Equals(Process) then
       Result := FProcessEntry.th32ProcessID;
    NextProcess := Process32Next(FSnapshotHandle, FProcessEntry);
  end;
  CloseHandle(FSnapshotHandle);
end;

function CloseProcess(ProcessID : DWORD) : INTEGER;
begin
  Result := Integer(TerminateProcess(OpenProcess(1, False, ProcessID), 0));
end;

procedure ShowError(Handle : THandle; Title, Text : STRING);
begin
  MessageBox(Handle, PChar(Text), PChar(Title), MB_ICONERROR + MB_OK);
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

function Explode(Text, Separator : STRING) : TSTRINGLIST;
var
  P : INTEGER;
begin
  Result := TStringList.Create;
  P := Pos(Separator, Text);
  while (P > 0) do
  begin
    Result.Add(Copy(Text, 1, P-1));
    Delete(Text, 1, P + Length(Separator) - 1);
    p := Pos(Separator, Text);
  end;
  if (Text <> '') then
    Result.Add(Text);
end;

function AddZero(Value, Size : INTEGER) : STRING;
var
  I : INTEGER;
begin
  Result := '';
  for i := 1 to Size - Length(IntToStr(Value)) do
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

function ReadString(Address: INTEGER) : STRING;
var
  NB        : NativeUInt;
  Temp      : ARRAY [1..255] OF BYTE;
  I         : BYTE;
  IDProcess : Cardinal;
  Unc       : PDWORD;
begin
  RtlAdjustPrivilege(20, True, 0, @Unc);
  IDProcess := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
  ReadProcessMemory(IDProcess, PTR(Address), @Temp[1], 255, NB);
  Result := '';
  I := 1;
  while ((Temp[I] <> 0) and (Temp[I] <> $0F)) do
  begin
    Result := Result + Chr(Temp[I]);
    Inc(I);
  end;
end;

function DeCrypt(Src : STRING) : STRING;
begin
  Result := Src;
end;

{ Pega o Titulo da janela ativa }
function GetActiveWindow : STRING;
begin
  SetLength(Result, GetWindowTextLength(GetForegroundWindow));
  GetWindowText(GetForegroundWindow, PChar(Result), GetWindowTextLength(GetForegroundWindow)+1);
end;

end.
