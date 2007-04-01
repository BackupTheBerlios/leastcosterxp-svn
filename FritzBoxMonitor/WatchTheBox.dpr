program WatchTheBox;

uses
  Forms,
  main in 'main.pas' {Form1},
  Unit2 in 'Unit2.pas' {CallIn},
  statistics in 'statistics.pas' {stats},
  tools in 'tools.pas',
  settings in 'settings.pas' {Form3},
  password in 'password.pas' {PWForm},
  CallManagement in 'CallManagement.pas';



{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WatchtheBox';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tstats, stats);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TPWForm, PWForm);
  Application.Run;
end.
