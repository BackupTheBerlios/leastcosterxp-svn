program WebServ;

uses
  Forms,
  WebServ1 in 'WebServ1.pas' {WebServForm},
  screen in 'screen.pas' {screenshot};

{$R *.RES}

begin
  Application.CreateForm(TWebServForm, WebServForm);
  Application.CreateForm(Tscreenshot, screenshot);
  Application.Run;
end.
