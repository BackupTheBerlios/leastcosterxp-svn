program LeastCoster;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  windows,
  StrUtils,
  SysUtils,
  Unit1 in 'Unit1.pas' {Hauptfenster},
  Unit2 in 'Unit2.pas' {LCXPSettings},
  FILES in 'FILES.PAS',
  addons in 'addons.pas',
  auswertung in 'auswertung.pas',
  html in 'html.pas' {htmlwindow},
  Unit4 in 'Unit4.pas' {shutter},
  WebServ1 in 'WebServ1.pas' {WebServForm},
  screen in 'screen.pas' {screenshot},
  inifiles,
  Unit3 in 'Unit3.pas' {auswert},
  Tarifmanager in 'Tarifmanager.pas' {TaVerwaltung},
  Unit6 in 'Unit6.pas' {wndlist},
  tarifverw in 'tarifverw.pas',
  Unit7 in 'Unit7.pas' {PriceWarning},
  Unit8 in 'Unit8.pas' {Ctrlnfo},
  StringRoutine in 'StringRoutine.pas',
  leerlauf in 'leerlauf.pas' {disconnect_leerlauf},
  shutdown in 'shutdown.pas',
  Unit9 in 'Unit9.pas' {Info},
  gridEvents in 'gridEvents.pas',
  clipboard in 'clipboard.pas',
  modes in 'modes.pas',
  floating in 'floating.pas' {floatingW},
  menues in 'menues.pas',
  RSSReader in 'RSSReader.pas',
  Protokolle in 'Protokolle.pas';

{$R *.res}

begin

  Application.Initialize;

  Application.Title := 'LeastCosterXP';

  Application.HelpFile := '';
  Application.CreateForm(THauptfenster, Hauptfenster);
  Application.CreateForm(TWebServForm, WebServForm);
  Application.Run;

end.
