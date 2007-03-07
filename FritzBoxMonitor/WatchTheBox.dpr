program WatchTheBox;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  main in 'main.pas' {Form1},
  Unit2 in 'Unit2.pas' {CallIn},
  statistics in 'statistics.pas' {stats},
  tools in 'tools.pas',
  settings in 'settings.pas' {Form3};

{$E exe}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Watch the Box';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TCallIn, CallIn);
  Application.CreateForm(Tstats, stats);
  Application.CreateForm(TForm3, Form3);

  Application.Run;
end.
