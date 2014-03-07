unit wSyck.Game;

interface

uses
  Winapi.Windows, System.SysUtils,
  wSyck.Addrs, wSyck.Basics, wSyck.Functions, wSyck.Client;

type
  TGame = class
  public
    function Version : DWORD;
    function cLiver  : DWORD;

    function Online : BOOL;
    procedure Message(Msg : STRING; Args : ARRAY OF CONST; Delay : DWORD = 3000); overload;
    procedure Message(Msg : STRING; Delay : DWORD = 3000); overload;
    procedure ShowMsg(Msg : STRING; Args : ARRAY OF CONST); overload;
    procedure ShowMsg(Msg : STRING); overload;
  end;

  var
    Game : TGame;

implementation

function TGame.Version : DWORD;
begin
  Result := DEFN_CLIENT;
end;

function TGame.cLiver : DWORD;
begin
  Result := CONS_CLIVER;
end;

function TGame.Online : BOOL;
begin
  Result := False;
  if wSyckREG then
  begin
    try
      Result := inValue(Client.ID, 1, 999) and inValue(Client.Pos.X, 1, 4096) and inValue(Client.Pos.Y, 1, 4096);
    except

    end;
  end;
end;

procedure TGame.Message(Msg : STRING; Args : ARRAY OF CONST; Delay : DWORD = 3000);
begin
  _CliMsg(Delay, Format(Msg, Args));
end;

procedure TGame.Message(Msg : STRING; Delay : DWORD = 3000);
begin
  Message(Msg, [], Delay);
end;

procedure TGame.ShowMsg(Msg : STRING; Args : ARRAY OF CONST);
begin
  if Online then
    _ShowMsg(Format(Msg, Args));
end;

procedure TGame.ShowMsg(Msg : STRING);
begin
  ShowMsg(Msg, []);
end;

end.
