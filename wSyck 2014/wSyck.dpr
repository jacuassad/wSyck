program wSyck;
{
  wSyck 2014, bY: SYCK <SYCK.BR>,

  Créditos: PedraoSilv, TheBaD, typedef_, xbennY, Cheats Brasil (www.cheatsbrasil.org)

}


uses
  Vcl.Forms,
  wSyck.Main in 'Source\wSyck.Main.pas' {wSyck2014},
  wSyck.Functions in 'Source\wSyck.Functions.pas',
  wSyck.Login in 'Source\wSyck.Login.pas',
  wSyck.Base in 'Source\wSyck.Base.pas',
  wSyck.Addrs in 'Source\wSyck.Addrs.pas',
  wSyck.Defines in 'Source\wSyck.Defines.pas',
  wSyck.Threads in 'Source\wSyck.Threads.pas',
  wSyck.Client in 'Source\wSyck.Client.pas',
  wSyck.Basics in 'Source\wSyck.Basics.pas',
  wSyck.Packet in 'Source\wSyck.Packet.pas',
  wSyck.Game in 'Source\wSyck.Game.pas',
  wSyck.Hacks in 'Source\wSyck.Hacks.pas',
  wSyck.Events in 'Source\wSyck.Events.pas',
  wSyck.ShowItem in 'Source\wSyck.ShowItem.pas' {ShowItem},
  wSyck.ClientView in 'Source\wSyck.ClientView.pas' {ClientView},
  wSyck.Maps in 'Source\wSyck.Maps.pas' {Maps};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'wSyck 2014';
  Application.CreateForm(TwSyck2014, wSyck2014);
  Application.CreateForm(TShowItem, ShowItem);
  Application.CreateForm(TClientView, ClientView);
  Application.CreateForm(TMaps, Maps);
  Application.Run;
end.
