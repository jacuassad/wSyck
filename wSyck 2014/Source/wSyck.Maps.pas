unit wSyck.Maps;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.TabNotBk, IniFiles,
  {wSyck}
  wSyck.Defines,
  wSyck.Hacks;

type
  dMaps = record
    Name, Image : STRING;
    Pos : TPos;
  end;

  TMaps = class(TForm)
    Pages: TTabbedNotebook;
    procedure FormCreate(Sender: TObject);
    procedure ImageClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Maps : TMaps;
  Base : ARRAY[1..30] OF TPos;
  n    : INTEGER;

implementation

{$R *.dfm}

function ReadMap(Title : STRING) : dMaps;
var
  IniFile: TIniFile;
begin
  Result.Name  := '';
  Result.Image := '';
  Result.Pos.X := 0;
  Result.Pos.Y := 0;

  IniFile := TIniFile.Create(HOME+'\maps\maps.ini');
  try
    Result.Name  := IniFile.ReadString(Title, 'Name', Result.Name);
    Result.Image := IniFile.ReadString(Title, 'Image', Result.Image);
    Result.Pos.X := IniFile.ReadInteger(Title, 'X', Result.Pos.X);
    Result.Pos.Y := IniFile.ReadInteger(Title, 'Y', Result.Pos.Y);
  finally
    IniFile.Free;
  end;
end;

function ReadInt(Section, Key : STRING) : INTEGER;
var
  IniFile: TIniFile;
begin
  Result := -1;
  IniFile := TIniFile.Create(HOME+'\maps\maps.ini');
  try
    Result := IniFile.ReadInteger(Section, Key, Result);
  finally
    IniFile.Free;
  end;
end;

procedure WriteInt(Section, Key : STRING; Value : INTEGER);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(HOME+'\maps\maps.ini');
  try
    IniFile.WriteInteger(Section, Key, Value);
  finally
    IniFile.Free;
  end;
end;

procedure TMaps.ImageClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TImage then
    Hack.Teleport(Base[TImage(Sender).Tag].X+X, Base[TImage(Sender).Tag].Y+Y);
end;

procedure TMaps.ImageMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Sender is TImage then
    Self.Caption := Format('Maps - X/Y : %d %d', [Base[TImage(Sender).Tag].X+X, Base[TImage(Sender).Tag].Y+Y]);;
end;

procedure TMaps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (ReadInt('Map.Pos', 'Top') <>-7) and (ReadInt('Map.Pos', 'Left') <> -7) then
  begin
    WriteInt('Map.Pos', 'Top', Self.Top);
    WriteInt('Map.Pos', 'Left', Self.Left);
  end;

  WriteInt('Map.Size', 'Width', Self.Width);
  WriteInt('Map.Size', 'Height', Self.Height);
end;

procedure TMaps.FormCreate(Sender: TObject);
var
  I : INTEGER;
  Map : dMaps;
  Title : STRING;
  NewPage : TTabPage;
  wNumber : WORD;
  Panel : TPanel;
  Image : TImage;
begin
  if not DirectoryExists(HOME+'\maps') then
    ForceDirectories(HOME+'\maps');

  Pages.Pages.Clear;

  n := 0;

  for I := 1 to 30 do
  begin
    Title := Format('Map.%d', [I]);
    Map  := ReadMap(Title);
    if (Map.Name <> '') and (Map.Image <> '') and FileExists(HOME+'\maps\'+Map.Image) then
    begin
      Inc(n);

      NewPage := TTabPage.Create(Application);
      Pages.InsertControl(NewPage);
      wNumber := Pages.Pages.Add(Map.Name);

      Panel := TPanel.Create(Self);
      TWinControl(Pages.Pages.Objects[wNumber]).InsertControl(Panel);

      with Panel do
      begin
        Align := alClient;
        ParentBackground := False;
        Color := clBlack;
      end;

      Image := TImage.Create(Self);
      TWinControl(Panel).InsertControl(Image);

      with Image do
      begin
        Picture.LoadFromFile(HOME+'\maps\'+Map.Image);
        AutoSize := True;
        Cursor := crHandPoint;
        Tag := I;
        onMouseDown := ImageClick;
        onMouseMove := ImageMove;
        Hint := 'Click to Teleport';
        ShowHint := True;
      end;

      Base[I] := Map.Pos;

    end;
  end;
  if n > 0 then
    Pages.ActivePage := Pages.Pages.Strings[0];
end;

procedure TMaps.FormShow(Sender: TObject);
begin
  if n > 0 then
  begin
    if (ReadInt('Map.Pos', 'Top') <> -1) and (ReadInt('Map.Pos', 'Left') <> -1) then
    begin
      if (ReadInt('Map.Pos', 'Top') = -7) and (ReadInt('Map.Pos', 'Left') = -7) then
        Self.Position := poScreenCenter
      else
      begin
        Self.Top  := ReadInt('Map.Pos', 'Top');
        Self.Left := ReadInt('Map.Pos', 'Left');
      end;
    end
    else
      Self.Position := poScreenCenter;

    if (ReadInt('Map.Size', 'Width') <> -1) and (ReadInt('Map.Size', 'Height') <> -1) then
    begin
      Self.Width  := ReadInt('Map.Size', 'Width');
      Self.Height := ReadInt('Map.Size', 'Height');
    end;
  end
end;

end.
