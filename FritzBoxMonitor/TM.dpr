program TM;

uses
  Forms,
  main in 'main.pas' {Form1},
  Unit2 in 'Unit2.pas' {CallIn},
  statistics in 'statistics.pas' {stats};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TCallIn, CallIn);
  Application.CreateForm(Tstats, stats);
  Application.Run;
end.
