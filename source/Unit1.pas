unit Unit1;

interface

uses
  BomeOneInstance,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, Menus, ExtCtrls,  shellapi,
  XPMan, files, addons, CoolTrayIcon, auswertung, html,
  inifiles, ImgList,
  Grids, Mapi,
  SRLabel, SRGrad,
  magrascon, magrasper, magrasedt, magrasapi,magsubs1, AppEvnts, Registry,
  LibXmlParser, LibXmlComps, Spin,
  AMAdvLed,
  inilang, messagestrings,
  Tarifaktualisierung,
  Zeitupdate;

type

 TMyThread = class(TThread)
 protected
  // procedure Execute; override;
 end;

 TExecuteWaitEvent = procedure(const ProcessInfo: TProcessInformation;
                                    var ATerminate: Boolean) of object;

//Tarifliste
  TTarif = record
    Tarif: String[70];
    Tag: String[39];
    Nummer,User,Passwort, Editor: String[40];
    Webseite: String[150];
    Takt: String[5];
    Preis, Einwahl: real;
    Beginn, Ende: TTime;
    eingetragen,validfrom, expires:TDate;
    DeleteWhenExpires: boolean;
  end;

  TTarif02 = record
    Tarif: String[70];
    Tag: String[39];
    Nummer,User,Passwort, Editor: String[40];
    Webseite: String[150];
//    Takt: String[5];
    takt_a, takt_b: integer;
    Preis, Einwahl: real;
    Beginn, Ende: TTime;
    eingetragen,validfrom, expires:TDate;
    DeleteWhenExpires: boolean;
    Mindestumsatz: real;
  end;

  TTarifheader = record
    programm : String[40];
    Version  : integer;
    Datum    : TDateTime;
   end;

   Tholidays = record
    name      : string[40];
    date      : TDate;
   end; 

//Rss - Reader
  TInhalt = record
    title, link: String;
    checked: boolean;
  end;

  TAutoDial = record
    Tag: integer;
    von, bis: TTime;
  end;

  proggys = record
      section,path,param,style, mintime,timeout: string;
      days: integer;
      date: TDate;
      today: boolean;
     end;

    Automatics = record
      Enabled, Ask, UseDelay, WaitforUser: boolean;
      Delay: integer;
    end;

    OnlineStream = record
      recv, xmit: array [0..9] of real;
      recv_av, xmit_av: real;
      index: short;
    end;

    KontingentDatensatz = record
       Tarif: string;
       FreiSekunden: LongInt;   //reicht f�r ~214GB
       FreikB: Real;
       MB_both: boolean;
       ResetTag: integer;
       NextReset, LastReset: TDate;
    end;

    Onlinewerte = record
      Startzeit,Dauer,Tarif,Rufnummer, Webseite, tag: string;
      takt_a, takt_b: integer;
      mindestumsatz, kosten_mindest: real;
      Datum: TDateTime;
      vbegin,wechselend, vend, Endzeit: TTime;
      Einwahl2, Kosten,Preis,Einwahl: real;
      wechselpreis, wechseleinwahl: real;
      wechsel: TDatetime;
      upload, download: Cardinal;
      gesamtdauer: longint;
      dauer_takt: longint;
     end;

    TScores = record
       Name, Color: string;
       erfolgreich, gesamt,state: integer; //state: 0 - ok, 1-suspended, 2-abgelaufen
      end;

   programs = array of proggys;

   THauptfenster = class(TForm)
    Bevel1: TBevel;
    Menu: TMainMenu;
    MM3: TMenuItem;
    Timer_an: TTimer;
    Timer_aus: TTimer;
    firststartcheck: TTimer;
    Status: TStatusBar;
    MM2: TMenuItem;
    MM1_5_1: TMenuItem;
    Tray: TCoolTrayIcon;
    PopupMenu1: TPopupMenu;
    PM12: TMenuItem;
    hinttimer: TTimer;
    call: TTimer;
    calloff: TTimer;
    MM3_1: TMenuItem;
    closer: TTimer;
    hider: TTimer;
    MM7: TMenuItem;
    MM7_5: TMenuItem;
    MM7_6: TMenuItem;
    MM7_4: TMenuItem;
    PM13: TMenuItem;
    Icons: TImageList;
    TrayDisconnect: TMenuItem;
    MM2_2_2: TMenuItem;
    MM1_5: TMenuItem;
    sntptimer: TTimer;
    MM2_3_2: TMenuItem;
    MM2_3_4: TMenuItem;
    MM5: TMenuItem;
    MM2_1: TMenuItem;
    MM2_4: TMenuItem;
    Liste: TStringGrid;
    DialBtn: TBitBtn;
    Aktualisieren: TBitBtn;
    costs: TEdit;
    DialStatus: TEdit;
    surfdauer: TTrackBar;
    MM2_4_1: TMenuItem;
    MM2_4_2: TMenuItem;
    IsOntimer: TTimer;
    edTarif: TEdit;
    edtime: TEdit;
    EdNumber: TEdit;
    MM2_3: TMenuItem;
    MM1: TMenuItem;
    MM1_10: TMenuItem;
    MM1_3: TMenuItem;
    MM1_2: TMenuItem;
    MM1_1: TMenuItem;
    Aktualisieren_timer: TTimer;
    MM2_5: TMenuItem;
    MM1_8: TMenuItem;
    MM2_7: TMenuItem;
    MM2_7_1: TMenuItem;
    MM2_7_2: TMenuItem;
    MM1_7: TMenuItem;
    MM1_6: TMenuItem;
    Reload: TTimer;
    MM5_1: TMenuItem;
    MM5_2: TMenuItem;
    RSSMenu: TMenuItem;
    Rsstimer: TTimer;
    MM2_3_3: TMenuItem;
    LeastCosterXP1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    MM2_3_1: TMenuItem;
    MM2_2: TMenuItem;
    MM2_2_1: TMenuItem;
    LedRSS: TAMAdvLed;
    LEDTimer: TTimer;
    ctrltimer: TTimer;
    MagRasEdt: TMagRasEdt;
    MagRasPer: TMagRasPer;
    leerlauf: TTimer;
    MM7_1: TMenuItem;
    MM7_2: TMenuItem;
    MM7_3: TMenuItem;
    PM13_1: TMenuItem;
    PM13_2: TMenuItem;
    PM13_3: TMenuItem;
    PM13_4: TMenuItem;
    PM13_5: TMenuItem;
    warnung_unterdruecken: TTimer;
    Autodial: TTimer;
    ipemail: TTimer;
    clock: TStaticText;
    Time: TTimer;
    DateLabel: TStaticText;
    MagRasCon: TMagRasCon;
    LEDTime: TAMAdvLed;
    ConnectMenu: TPopupMenu;
    rennen1: TMenuItem;
    N10: TMenuItem;
    N2Kanal1: TMenuItem;
    N1Kanal1: TMenuItem;
    rennen2: TMenuItem;
    Verbinden2Methode1: TMenuItem;
    TarifStatus: TPopupMenu;
    TS1: TMenuItem;
    TS4: TMenuItem;
    TS2: TMenuItem;
    TS2_1: TMenuItem;
    TS2_2: TMenuItem;
    TS2_3: TMenuItem;
    TS2_4: TMenuItem;
    TS5: TMenuItem;
    WaitOnDisconnect: TTimer;
    ScoreTimer: TTimer;
    MM3_3: TMenuItem;
    MM3_2: TMenuItem;
    AutoTrennen: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    AutoDiscLED: TAMAdvLed;
    Label6: TLabel;
    trennticker: TDateTimePicker;
    TabSheet4: TTabSheet;
    AutoDialLED: TAMAdvLed;
    Autobasis: TLabel;
    AutoDialEinwahl: TCheckBox;
    AutoBase: TTrackBar;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    AutoLeerlaufLed: TAMAdvLed;
    Leertime: TSpinEdit;
    leerlaufboxask: TCheckBox;
    TabSheet3: TTabSheet;
    Autoaus: TComboBox;
    OneInstance: TBomeOneInstance;
    MM1_9: TMenuItem;
    TS2_5: TMenuItem;
    TS3: TMenuItem;
    TS3_1: TMenuItem;
    TS3_2: TMenuItem;
    ColorDialog: TColorDialog;
    TS6: TMenuItem;
    TS6_1: TMenuItem;
    TS6_2: TMenuItem;
    TS3_3: TMenuItem;
    TS3_3_1: TMenuItem;
    TS3_3_2: TMenuItem;
    TS3_3_3: TMenuItem;
    TS3_3_4: TMenuItem;
    TS3_3_5: TMenuItem;
    Label3: TLabel;
    OCostLabel: TLabel;
    ozeit: TLabel;
    StatLED1: TAMAdvLed;
    StatLED2: TAMAdvLed;
    online: TLabel;
    Donate: TMenuItem;
    beliebig_date: TDateTimePicker;
    beliebig_time: TDateTimePicker;
    Takt2: TProgressBar;
    Takt1: TProgressBar;
    beliebig_check: TCheckBox;
    trennask: TCheckBox;
    NoChangeWarning: TCheckBox;
    PanelBevel: TBevel;
    setmultilink: TCheckBox;
    TarifProgress: TProgressBar;
    Spalten1: TMenuItem;
    S_1: TMenuItem;
    S_2: TMenuItem;
    S_3: TMenuItem;
    S_4: TMenuItem;
    S_5: TMenuItem;
    S_6: TMenuItem;
    S_7: TMenuItem;
    S_8: TMenuItem;
    S_9: TMenuItem;
    S_10: TMenuItem;
    S_11: TMenuItem;
    S_15: TMenuItem;
    S_16: TMenuItem;
    S_12: TMenuItem;
    S_13: TMenuItem;
    S_14: TMenuItem;
    S_17: TMenuItem;
    ForceDial: TMenuItem;
    AutoDialStatus: TAMAdvLed;
    WebServ: TMenuItem;
    S_18: TMenuItem;
    MM2_3_5: TMenuItem;
    procedure MM2_3_5Click(Sender: TObject);
    procedure WebServClick(Sender: TObject);
    procedure AutoDialStatusLedStateChanged(Sender: TObject; LedOn: Boolean;
      NumSwitch: Integer);
    procedure AutoDialStatusClick(Sender: TObject);
    procedure ForceDialClick(Sender: TObject);
    procedure S_1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TrayMinimizeToTray(Sender: TObject);
    procedure DonateClick(Sender: TObject);
    procedure ListeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListeMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ListeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);

    procedure TrayMenueClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExecuteFile(const AFilename: String;
                 AParameter, ACurrentDir: String; AWait, Hidden: Boolean;
                 AOnWaitProc: TExecuteWaitEvent=nil);
    function StringVonMorgen(date: TDate): string;
    procedure save_cfg;
    procedure ClearRasEntry;
    procedure ListeClick(Sender: TObject);
    procedure ListeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure disconnect;
    procedure SetDialParams(user, password, number: string);
    procedure zeitumrechnen(zeit_in_sec: longint; var h,m,s: word);
    procedure Timer_anTimer(Sender: TObject);
    procedure Timer_ausTimer(Sender: TObject);
    procedure firststartcheckTimer(Sender: TObject);
    procedure PerformExit;
    procedure onlineMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PM14Click(Sender: TObject);
    procedure hinttimerTimer(Sender: TObject);
    procedure callTimer(Sender: TObject);
    procedure calloffTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure closerTimer(Sender: TObject);
    procedure hiderTimer(Sender: TObject);
    procedure trenntickerChange(Sender: TObject);
    procedure TrayDisconnectClick(Sender: TObject);
    procedure TrayClick(Sender: TObject);
    procedure sntptimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DialBtnClick(Sender: TObject);
    procedure surfdauerChange(Sender: TObject);
    procedure AktualisierenClick(Sender: TObject);
    procedure disconnectviatrennticker;
    procedure IsOntimerTimer(Sender: TObject);
    procedure OnConnect;
    procedure OnDisconnect;
    Procedure SendMail(Subject,Mailtext,FromName,FromAdress,ToName,ToAdress,AttachedFileName,DisplayFileName:string;ShowDialog:boolean);
    procedure Aktualisieren_timerTimer(Sender: TObject);
    procedure refreshall;
    procedure FormActivate(Sender: TObject);
    procedure beliebig_check1Click(Sender: TObject);
    procedure beliebig_timeChange(Sender: TObject);
    procedure OneInstanceInstanceStarted(Sender: TObject;params: TStringList);
    procedure ReloadTimer(Sender: TObject);

    procedure LangClick(Sender: TObject);
    procedure RsstimerTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ApplicationEvents1ShortCut(var Msg: TWMKey;
      var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure TrayBalloonHintTimeout(Sender: TObject);
    procedure TrayBalloonHintShow(Sender: TObject);
    procedure LEDTimerTimer(Sender: TObject);
    procedure ListeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure ctrltimerTimer(Sender: TObject);
    procedure LedRSSMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LedRSSMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure leerlaufTimer(Sender: TObject);
    procedure LeertimeChange(Sender: TObject);
    procedure WMQueryEndSession (var M: TWMQueryEndSession); message
      WM_QUERYENDSESSION;
    procedure warnung_unterdrueckenTimer(Sender: TObject);
    procedure AutoDialLEDMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AutoDialLEDLedStateChanged(Sender: TObject; LedOn: Boolean;
      NumSwitch: Integer);
    procedure AutodialTimer(Sender: TObject);
    procedure AutoDialer;
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure AutoBaseChange(Sender: TObject);
    procedure ipemailTimer(Sender: TObject);
    procedure CheckForUpdates;
    procedure ListeDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ListeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimeTimer(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure ListeDblClick(Sender: TObject);
    procedure MagRasConStateEvent(Sender: TObject;
      ConnState: TRasStateRec);
    procedure StatLED1Click(Sender: TObject);
    procedure rennen2Click(Sender: TObject);
    procedure rennen1Click(Sender: TObject);
    procedure Verbinden2Methode1Click(Sender: TObject);
    procedure OCostLabelMouseEnter(Sender: TObject);
    procedure TarifStatusPopup(Sender: TObject);
    procedure WaitOnDisconnectTimer(Sender: TObject);
    procedure ScoreTimerTimer(Sender: TObject);

    procedure MM3_2Click(Sender: TObject);
    procedure TarifStatusClick(Sender: TObject);
    procedure MainMenueClick(Sender: TObject);
    procedure loadprogs;
    procedure loadprogsoff;
    procedure FastDisconnectOnExit;

   private
    { Private declarations }

    title2: TSRLabel;
    grad2 : TSRGradient;

    Formhidden: boolean;

    mousedownrow: integer;

    timerstarted: boolean;
    disconnecting: boolean;
    oldtime: tDatetime;
    KontingenteWarned: boolean;
    SubHandle:TSubHandList;
    Kanalbuendelung: boolean;
    ConnHandle, DialHandle: HRasConn;
    firststart: boolean;
    ctrl_start, ctrl_last, ctrl_delay: cardinal;
    kill_list: TStringlist;

    OnlineSpeed: Onlinestream;
    LastXmit, LastRecv, LastTime: LongWord;

    dialing, sort_descending: boolean;
    liste_last_x: integer;

    public
    { Public declarations }
      Selected: array of boolean;

     //Rss im Men�
      RSSItems: array of array of tInhalt;
      Rss_max: word;
      rss_old: boolean;
      EdWebSite, WebIntLabel: TSRLabel;
      closeallowed: boolean;
      autoclose: boolean;
      ConnectionCostVisible: boolean;
      MinimizeonClose: boolean;
      IPAdress: string;

      disconnectseconds: integer;
      DisconnectStopped: boolean;
      ctrlcount: integer;

      modemname, modemtype, modemname2, modemtype2, modemstring: string;
      allow_multilink: boolean;
      timeofliste: TDatetime;
      path, prog : string;
      webzugriff: boolean; //kommt eine Anfrage vom WebInterface ?
      startwithimport:boolean;
      importfilename: string;
      rss_update: integer;
      tarife: array of TTarif02;
      lookforward: integer;
      selfdial: boolean;
      noFeeds: boolean;
      noBalloon: boolean;
      Autodisconnect, Leerlaufdisconnect: Automatics;
      leerlaufdisconnectzeit, AutoAusindex: integer;
      AutoSurfdauer : integer;
      DaysToSaveLogs, leerlaufschwelle: integer;
      warnung_gezeigt: boolean;
      UseColors: boolean;
      SetupModems: boolean;
      Scores : array of TScores;
      TarifeDisabled,neuladen: boolean;

      rssrunning: boolean; //l�uft RSS-Update ?
      AutoDialTimes: array of TAutoDial;
  end;

var
  Hauptfenster: THauptfenster;
  isonline: boolean; //OnlineStatus
  progcount, progcountoff: integer;
  zeit_min, zeit_std : string;
  maxkostenrot, maxkostengelb: real;
  oprog, oprogoff: programs;
  lastupdate: TDatetime;
  updateinterval: integer;
  onlinetime_start, onlinetime2_start,onlinetime_ende: integer;
  onlinetime_starttime: TDatetime;
  startcount: integer;
  verbindungsname: string;
  nooncheck: boolean;
  dauer, dauer2, taktlaenge: integer; //onlinedauer in s
  gesamtdauer: longint;
  rascheck: boolean;
  actnumber: string;
  actofftime: TTime;
  datensaetze: integer;
  writeme: boolean;
  atomcount: integer;
  parameters : TStringlist;

  timeupdaterunning : boolean = false;
  ActConnectState: string;

  settings            : TMemIniFile; //was die lcr.cfg enth�lt
  UserSettings        : TMemIniFile; //die user.pwd
  SettingsTraffic     : TMemIniFile; //traffic.ini
  SettingsScores      : TMemIniFile; //Scores.ini
  SettingsKontingente : TMemIniFile; //Kontingente.ini
  SettingsOnline      : TMemIniFile; //online.ini
  SettingsOffline     : TMemIniFile; //Offline.ini

  atomserver: TStringlist;
  holidaylist   : array of THolidays;
  onlineset: Onlinewerte;

  Kontingente: Array of Kontingentdatensatz;
  kontingentindex: integer;
  TarifdateiLaden: TTarifThread;
  UhrzeitEinstellen: TZeitThread;
implementation

uses Unit2, Unit4, WebServ1, shutdown, Unit3, tarifverw,
  Tarifmanager, Strutils,DateUtils, floating, unit8, Unit6, mmsystem,
  leerlauf, StringRoutine, Unit7, Unit9, GridEvents, modes, menues, RSSReader, Protokolle, httpprot,
  donation;

{$R *.dfm}


procedure ShowUsersWebStart;
var Http: THttpCli;
    Outfile: TStringStream;
begin
//jeden User nur einmal am Tag z�hlen
// if (dateof(now) <> settings.ReadDate('Dialer','stat', Dateof(yesterday))) then
// begin
  http:= ThttpCli.Create(nil);

   //Z�hler f�r die Einwahlen >>> Quelltext im Forum erfragen
   http.URL:=  'http://darkempire.funpic.de/php/count/count.php?user=LCXP';

   outfile:= TStringStream.Create('');
   http.RcvdStream := outfile;
   try
     http.Get;
   except

   end;
//   settings.WriteDate('Dialer','stat', Dateof(now));
   http.free;
   outfile.free;

// end;

 if settings.readbool('Dialer','OpenWeb',true) then
   Shellexecute(0, 'open', Pchar(onlineset.webseite), nil, nil, SW_SHOWmaximized);

end;

// Benden des Programms ##############################ANFANG####################
//Beenden von Windows abfangen
procedure THauptfenster.WMQueryEndSession (var M: TWMQueryEndSession);
begin
 M.Result:=1;
 MinimizeOnClose:= false; //minimieren bei Schlie�en abschalten
 fastDisconnectOnExit;
 hauptfenster.close;
end;

procedure THauptfenster.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var msg: string;
begin

if not MinimizeOnClose then closeallowed:= true;

canclose:= closeallowed;

if not closeallowed then
   begin
     //tray.hidemainform;
     hauptfenster.Visible:= false;
     formhidden:= true;
     if not noballoon then tray.ShowBalloonHint(misc(M01,'M01'), misc(M02,'M02'), bitInfo, 10);
   end
   else
   begin
    save_cfg;
    if ((not isonline) and (webservform.HttpServer1.tag = 0)) then CanClose:= True//PerformExit
    else
    begin
     if isonline then
      begin
        if selfdial then msg := misc(M03,'M03') else msg := misc(M04,'M04');
      end
     else
     if (webservform.HttpServer1.tag = 5) then msg := misc(M05,'M05');

     canClose:= true;
    end;
   end;

  if canclose and assigned(RssRead.MyThread) then //wenn RSS-Update noch l�uft
    begin
     canclose:= false; //beenden erstmal verbieten
     RSSRead.shutdown:= true; //herunterfahren im RSSReader erlauben
     RssRead.MyThread.thread.terminate; //bei der n�chsten gelegenheit RSS-Reader schlie�en
    end;

end;

procedure THauptfenster.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    save_cfg;
    Performexit;
end;

// Benden des Programms ############################## ENDE ####################
procedure THauptfenster.OneInstanceInstanceStarted(Sender: TObject;
  params: TStringList);
begin

tray.ShowMainForm;
SetForegroundWindow(handle);
SetActiveWindow(handle);

if params.count = 0 then exit; // verhindert index out of bounds(0)
if not startwithimport then
begin
  If (Params.Count>0) and (FileExists(Params.Strings[0]))
    then
    begin
      if ansicontainstext(params.strings[0],'.lcx') then
      begin
        importfilename:= params.strings[0];
        startwithimport:= true;
        hauptfenster.MainMenueClick(Hauptfenster.MM1_1);
      end
      else showmessage('Datei '+ params.strings[0] +' ist ung�ltig');
    end;
  end;
end;

procedure THauptfenster.ExecuteFile(const AFilename: String;
                 AParameter, ACurrentDir: String; AWait, Hidden: Boolean;
                 AOnWaitProc: TExecuteWaitEvent=nil);
var
  si: TStartupInfo;
  pi: TProcessInformation;
  bTerminate: Boolean;
begin
  bTerminate := False;

  if Length(ACurrentDir) = 0 then
    ACurrentDir := ExtractFilePath(AFilename);

  if AnsiLastChar(ACurrentDir) = '\' then
    Delete(ACurrentDir, Length(ACurrentDir), 1);

  FillChar(si, SizeOf(si), 0);
  with si do begin
    cb := SizeOf(si);
    dwFlags := STARTF_USESHOWWINDOW;
    if hidden then wShowWindow := SW_HIDE else wShowWindow := SW_NORMAL;
  end;

  FillChar(pi, SizeOf(pi), 0);
  AParameter := Format('"%s" %s', [AFilename, TrimRight(AParameter)]);

  if CreateProcess(Nil, PChar(AParameter), Nil, Nil, False,
                   CREATE_DEFAULT_ERROR_MODE or CREATE_NEW_CONSOLE or
                   NORMAL_PRIORITY_CLASS, Nil, PChar(ACurrentDir), si, pi) then
  try
    if AWait then
      while WaitForSingleObject(pi.hProcess, 50) <> Wait_Object_0 do
      begin
        if Assigned(AOnWaitProc) then
        begin
          AOnWaitProc(pi, bTerminate);
          if bTerminate then
            TerminateProcess(pi.hProcess, Cardinal(-1));
        end;

        Application.ProcessMessages;
      end;
  finally
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
  end;
end;


procedure THauptfenster.langClick(Sender: TObject);
var language: string;
    i: integer;
    checked: boolean;
begin

 checked:= (sender as TMenuItem).checked;

 for i:= 0 to MM3_3.Count-1 do MM3_3.items[i].Checked:= false;

 if not checked then
 begin
   language:= stripHotkey((sender as TMenuItem).caption);
   settings.WriteString('LeastCoster','language',language);
   (sender as TMenuItem).checked:= true;
 end
 else settings.WriteString('LeastCoster','language','');

  CL:=loadIni('lang\'+settings.readstring('LeastCoster','language',''));
  if CL<>nil then
    begin
      fillProps([Hauptfenster],CL);
      if isonline then DialBtn.Caption := misc(M82,'M82') else misc(M24,'M24');
      surfdauerchange(nil);
    end else status.simpletext:= misc(M272,'M272');
end;

procedure SetLEDs;
begin

with hauptfenster do
begin
case MagRasCon.StateSubEntry of
0: if MagRasCon.ConnectState <> RASCS_Connected then //wenn der 0. Eintrag gel�scht wird
   begin
      if statLED1.LedOn then //wenn erster Kanal belegt war, dann muss getrennt werden
            if isonline then
            begin
             StatLED1.Ledon:= false;
             StatLED2.Ledon:= false;
             OnDisconnect; 
            end;
   end
   else if not isonline then begin StatLED1.ledon:= true; {OnConnect;} end;

1:if MagRasCon.ConnectState = RASCS_Connected then
   begin
     //Fall 2 LED ist noch aus und muss geschaltet werden
     if not StatLED1.LedOn then
     begin
      StatLED1.LEDon:= true;
      aktualisieren.enabled:= true;
      surfdauer.enabled:= true;
     end;
   end
   else //wenn Kanal 1 nicht connected;
     if statLED1.LedOn then //wenn erster Kanal belegt war, dann muss getrennt werden
        begin
             StatLED1.Ledon:= false;
             if isonline then OnDisconnect;
        end;

2: if MagRasCon.ConnectState = RASCS_Connected then
      begin
         //Fall 2 LED ist noch aus und muss geschaltet werden
         if not StatLED2.LedOn then
         begin
          StatLED2.LEDon:= true; //schalten damit einwahl nicht doppelt gez�hlt wird

          //Einwahlgeb�hren f�r den zweiten Kanal addieren
          if selfdial then onlineset.kosten:= onlineset.kosten + onlineset.einwahl2/100;
          onlinetime2_start:= gettickcount;
          Kanalbuendelung:= true;
          takt2.Tag:= taktlaenge;
         end;
       end
   else // 2. Kanal nicht mehr connected
        if StatLED2.LedOn then //wenn an, dann umschalten
         begin
            StatLED2.Ledon:= false;
            dauer2:= 0;
            Kanalbuendelung:= false;
            takt2.tag:= 0;
         end;
end;
end;
end;

function CheckAutoConnect(var rest:integer): boolean;
var DialDay: shortint;
    DialStart, DialEnd: TDateTime;
    i, day: integer;
    n: TDateTime;

begin
 Result:= false;
 if settings.ReadBool('AutoConnect','atTime', false) then
 begin
  n:= now;
  day:= DayOfTheWeek(n);
  for i:= 0 to length(hauptfenster.AutoDialTimes) -1 do
  begin

    DialDay  := Hauptfenster.AutodialTimes[i].tag;
    DialStart:= Dateof(n) + Timeof(Hauptfenster.AutodialTimes[i].von);
    DialEnd  := Dateof(n) + Timeof(Hauptfenster.AutodialTimes[i].bis);

    If DialEnd <= DialStart then
    begin
      DialEnd:= incday(DialEnd, 1);
      if dateof(n) = dateof(DialEnd) then
      begin
      day:= day-1; if day < 0 then day:= 6;
      end;
    end;
    
    case DialDay of
    //   Mo-So
      0..6:  if ((day = DialDay+1)
                and ((n >= DialStart) and (n < DialEnd)) )
                  then Result:= true;
    //   daily
      7:  if ((n >= DialStart) and (n < DialEnd))
                then Result:= true;
    //   weekday
      8: if ( (Day < 6 )
                and ((n >= DialStart) and (n < DialEnd)) )
                  then Result:= true;
    //   weekend
      9: if ( (Day > 5)
                and ((n >= DialStart) and (n < DialEnd)) )
                  then Result:= true;
      end;
     if result then
      begin
        if (n < DialEnd) then rest:= secondsbetween(n, DialEnd) else rest:= 0;
        break;
      end;
   end;
 end;
end;

procedure TryAutoConnect;
var restzeit: integer;
    check: boolean;
    delay: integer;
begin
if Hauptfenster.AutoDialStatus.LEDOn then
begin
 delay:= 10;
 check:= CheckAutoConnect(restzeit);

//Automatische Einwahl
 if check and not isonline and (restzeit > 10 + delay) and (not Hauptfenster.dialing) then
    begin
       Hauptfenster.AutoDialEinwahl.checked:= settings.Readbool('AutoConnect','mitEinwahl',false);
       Hauptfenster.AutoDialLed.ledon:= true;
       if not Hauptfenster.AutoDial.enabled
        then Hauptfenster.AutoDial.enabled:= true;
    end
  else
  if check and (restzeit <= 10 + delay) then
  begin
   hauptfenster.autodial.enabled:= false; //falls der Timer noch l�uft abschalten
  //Automatisches Trennen
   if assigned(disconnect_leerlauf) and (disconnect_leerlauf.Tag= 2) then
     begin //wenn das Fenster noch am Einw�hlen ist
      disconnect_leerlauf.close;
     end
   else
   if not assigned(disconnect_leerlauf) and isonline then
      begin
           Application.CreateForm(Tdisconnect_leerlauf, disconnect_leerlauf);
           disconnect_leerlauf.tag:= 1;
           disconnect_leerlauf.usetimer:= true;
           disconnect_leerlauf.timer1.tag:= delay;
           disconnect_leerlauf.Label1.Caption:= misc(M06,'M06');
           disconnect_leerlauf.grad.endcolor:= $0081E6EB; {gelb}//$009191DB; {rot}//$006FEE7E;{gr�n}
           disconnect_leerlauf.Show;
      end;
  end;
end;
end;

procedure THauptfenster.IsOntimerTimer(Sender: TObject);
var h,m,s                     : word;
    delaytime, k, index       : integer;
    ConnCount                 : integer;
    curxmit, currecv, interval: LongWORD ;
    noerror                   : boolean;
    beginn, ende              : TDateTime;
begin
MagRasCon.GetConnections;
//suche aktive Verbindungen > Achtung Win9x meldet Verbindungen als aktiv, die mit dem W�hlen beginnen> Fehler werden nicht erkannt
ConnCount := MagRasCon.Connections.Count;

//wenn selbst gew�hlt und Win9x dann schauen ob wirklich connected
if (ConnHandle=0) and (ConnCount >0) and (MagRasOSVersion = OSW9x) then
  For index:= ConnCount-1 downto 0 do
    begin
      //Status bestimmen
      MagRasCon.GetConnectStatusEx(MagRasCon.Connections.RasConn(index),1);
      //ConnCount runterz�hlen, wenn die Verbindung noch nicht aktiv
      if MagRasCon.ConnectState < RASCS_Connected then
      begin
        dec(ConnCount);
        MagRasCon.Connections.Delete(index);  //Eintrag in der Liste l�schen
      end;
    end;

If ((ConnHandle=0) and( ConnCount > 0)) then //wenn keine Connection bekannt war
begin
     OnConnect;
     if selfdial then
      begin ConnHandle:= DialHandle; DialHandle:= 0; end
     else //wenn externe Verbindung
     For index:= 0 to ConnCount -1 do
         if ( (lowercase(MagRasCon.Connections.DeviceType(index)) = 'modem')
            or(lowercase(MagRasCon.Connections.DeviceType(index)) = 'isdn')) then
                begin
                         MagRasCon.EntryName:= MagRasCon.Connections.EntryName(index);
                         MagRasCon.GetEntryProps(true);
                         ConnHandle:= MagrasCon.CurRasConn;
                         break;
                end;
end;

MagRasCon.GetSubHandles(ConnHandle,2,SubHandle);

//wenn Connection besteht, dann nachschauen auf welchem Kanal
if (ConnHandle > 0) and (MagRasOSVersion = OSW9x) then
  begin
   MagRasCon.GetConnectStatusEx(ConnHandle,1);
   setLEDs;
  end
else
if (ConnHandle > 0) then
  begin
     MagRasCon.GetConnectStatusEx(Subhandle[1],1);
     setLEDs;
     MagRasCon.GetConnectStatusEx(Subhandle[2],2);
     setLEDs;
  end;


TryAutoConnect;

//wenn keine Verbindung mehr besteht, dann alles trennen
if ConnCount = 0 then
  begin
        if StatLED1.LEDon then StatLED1.LEDon:= false;
        if StatLED2.LEDon then StatLED2.LEDon:= false;
        if isonline then OnDisconnect; //wenn noch kein OnDisconnect kam, dann jetzt
       exit;
   end;

if isonline then
begin//Onlinezeitmessung
 onlinetime_ende:= gettickcount;
 //Onlinezeitanzeige
 dauer:=round((onlinetime_ende-onlinetime_start)/1000); //sekunden
 if taktlaenge > 0 then takt1.position:= dauer mod taktlaenge;

 if Kanalbuendelung then
 begin
     dauer2 := round((onlinetime_ende-onlinetime2_start)/1000);
     if taktlaenge > 0 then takt2.position:= dauer2 mod taktlaenge;
 end else dauer2:= 0; //sekunden

 gesamtdauer:= dauer +dauer2;
 Onlineset.gesamtdauer:= gesamtdauer;
 zeitumrechnen(gesamtdauer,h,m,s);

 if (dauer >= onlineset.takt_a) then begin taktlaenge:= onlineset.takt_b; takt1.Max:= taktlaenge; takt2.max:= taktlaenge; end;

 ozeit.caption:=timetostr(encodetime(h,m,s,0));
 ocostlabel.left:= ozeit.left + ozeit.width + 10; //position richtig setzen

 noerror:= true;

 if selfdial then
 begin
  noerror := computecosts(Kanalbuendelung);
  OCostLabel.Visible:= true
 end else oCostlabel.Visible:= false;

 onlineset.Dauer:= ozeit.caption;

 if selfdial then
 if noerror then
 begin
  OCostlabel.Font.Color:= clGreen;
  OCostLabel.Caption:= Format('%.4m',[onlineset.kosten]);
 end
 else
 begin
  OCostlabel.Font.Color:= clRed;
  OCostLabel.Caption:= Format('> %.4m',[onlineset.kosten]);
 end;

if Assigned(floatingW) then
 begin
   floatingW.ozeit.Caption:= ozeit.caption;
   floatingW.ozeit.Refresh;
   floatingW.ocostlabel.caption:= ocostlabel.caption;
   floatingW.ocostlabel.refresh;
 end;

 //ip ausgeben
 if isonline then
 if ( (IPAdress = '0.0.0.0') or (IpAdress= '')
    or not ansicontainstext(status.simpletext,'IP: ')
    or not ansicontainstext(status.simpletext,' | '+misc(M07,'M07')+': ')
    or not ansicontainstext(status.simpletext,' | '+misc(M08,'M08')+': ')
    ) then
 begin
   MagRasCon.GetProtocolEx(ConnHandle);
   IPAdress:=  MagRasCon.ClientIP;
   if selfdial then actnumber:= onlineset.Rufnummer
   else
     begin
       MagRasEdt.GetAllEntryProps(MagRasCon.CurConnName);
       actnumber:= MagRasEdt.LocalPhoneNumber;
      end;
   status.SimpleText:= 'IP: '+ IpAdress+' | '+ misc(M07,'M07')+': '+ actnumber+ ' | '+misc(M08,'M08')+ MagRasCon.CurConnName;
 end;

 if  ((IPAdress <> '0.0.0.0') and (IPAdress <> '' ) and not timerstarted) then
 begin //einwahl war erfolgreich
          timerstarted:= true;
          ForceDial.Checked:= false;

          if selfdial then
          begin
           ShowUsersWebStart;
           if settings.ReadBool('Tariflisten','aktiv',false) then
             MM2_3_5Click(self);   //Tarifdaten laden
          end; 

          //Atomzeit-Update
          sntptimer.interval:= 2000;
          sntptimer.enabled:= settings.ReadBool('Onlinecheck','Atomzeit', false);

          rsstimer.interval:= 5000; //5 sekunden abwarten
          rsstimer.enabled:= true;
 end;
 //wenn das Ende von Kontingenten gemeldet werden soll
 if selfdial and settings.Readbool('Autotrennen','Kontingente',true) then
 if not kontingenteWarned then
 if ((length(kontingente) > 0) and (kontingentindex > -1)) then
 begin
 //Warnung beim Ende von Zeitkontingenten
 if (((kontingente[kontingentindex].FreiSekunden >0)
        and (60 > kontingente[kontingentindex].FreiSekunden)
        and (not assigned(disconnect_leerlauf)) )
    or( (kontingente[kontingentindex].FreikB > 0)  //Volumenkontingente
        and ( kontingente[kontingentindex].FreikB < 512)
        and (not assigned(disconnect_leerlauf)))
   )
    then
       begin
            Application.CreateForm(Tdisconnect_leerlauf, disconnect_leerlauf);
            disconnect_leerlauf.usetimer:= true;
            disconnect_leerlauf.timer1.tag:= 30;
            disconnect_leerlauf.Label1.Caption:= misc(M09,'M09');
            disconnect_leerlauf.grad.endcolor:= $009191DB; {rot}
            disconnect_leerlauf.Show;
            kontingenteWarned:= true;
       end;
 end;

 if Autodiscled.ledon then
    begin //verbindung trennen
    //nur wenn 5 sec vor eingestelltem Zeitpunkt, dann trennen
     if (autodisconnect.useDelay and trennask.checked )then delaytime:= disconnectseconds+autodisconnect.delay
     else delaytime:= disconnectseconds;

     if ((secondsbetween(trennticker.DateTime,now) < (delaytime)) and (not DisconnectStopped) ) then
     begin
        if trennask.Checked then
          begin
           if not assigned(disconnect_leerlauf) then
                begin
                      Application.CreateForm(Tdisconnect_leerlauf, disconnect_leerlauf);
                      disconnect_leerlauf.tag:= 1;
                      if Autodisconnect.UseDelay then
                      begin
                        disconnect_leerlauf.usetimer:= true;
                        disconnect_leerlauf.timer1.tag:= Autodisconnect.Delay;
                      end;
                      disconnect_leerlauf.Label1.Caption:= misc(M06,'M06');
                      disconnect_leerlauf.grad.endcolor:= $009191DB; {rot}
                      disconnect_leerlauf.Show;
                end;
          end
        else disconnectviatrennticker;
      end;

     //wenn zeit zwischen Trennen und aktueller Zeit ausserhalb der Trennzeit dann Fenster aktivieren (Urzustand herstellen)
     if ((secondsbetween(trennticker.DateTime,now) > (delaytime)) and DisconnectStopped ) then DisconnectStopped:= false;
      end;
//~~~~~~~~~~~~~~~~~ SPEED ~~~~~~~~~~~~~~~~~~~~~~~~~~
// get performance info, element 0 is combined performance for all ports/conns
// the three different platforms handle multiple calls differently
if isonline and selfdial then
begin
      try
       if MagRasOSVersion >= OSW2K then
       begin
        MagRasPer.GetPerfStats;
       // Datenzaehler
       if MagRasPer.PerfRecvCur[0] > onlineset.download then
          onlineset.download:= MagRasPer.PerfRecvCur[0];
       if MagRasPer.PerfXmitCur[0] > onlineset.upload then
          onlineset.upload:= MagRasPer.PerfXmitCur[0];

        curxmit := onlineset.upload - LastXmit ;
        currecv := onlineset.download - LastRecv ;
       end
       else   //wenn windows Speed nciht unterst�tzt
       begin
        curxmit := 0;
        currecv := 0;
       end;

        interval := GetTickCount - LastTime ;    // milliseconds

        try
        curxmit := (curxmit * 1000) div interval ;
        currecv := (currecv * 1000) div interval ;
        except
        curxmit := (curxmit * 1000) div 1000 ;
        currecv := (currecv * 1000) div 1000 ;
        end;

        //mitteln �ber 10s
        with onlinespeed do
        begin
         recv[index]:= currecv;
         xmit[index]:= curxmit;
         inc(index);
         if index= 10 then index:= 0;
         recv_av:= 0; xmit_av:= 0;
         for k:= 0 to 9 do
         begin
              recv_av:= recv_av + recv[k];
              xmit_av:= xmit_av + xmit[k];
         end;
         recv_av:= recv_av/10;
         xmit_av:= xmit_av/10;
        end;

	// keep current stats
       if MagRasOSVersion >= OSW2K then
       begin
        LastXmit := MagRasPer.PerfXmitCur [0] ;
        LastRecv := MagRasPer.PerfRecvCur [0] ;
        LastTime := GetTickCount ;
       end
       else
        begin
        LastXmit := 0;
        LastRecv := 0;
        end;

        //Volumen Kontingent updaten
        if ((length(kontingente) > 0) and (kontingentindex > -1))then
        begin
         kontingente[kontingentindex].freikb := kontingente[kontingentindex].freikb - LastRecv/1024;
         if kontingente[kontingentindex].MB_both then //auch den Up-Stream abziehen ?
         kontingente[kontingentindex].freikb := kontingente[kontingentindex].freikb - LastXmit/1024;
        end;
      except

      end;
	// talk to user  - note that NT4 does not report a connection speed
  if assigned(floatingW) and isonline then
  with floatingW do
  begin
   if MagRasOSVersion >= OSW2K then
   begin
    LabelSpeedVal.Caption := Format('%2.1f kBit/s',[MagRasPer.PerfConnSpd [0]/1000]);
    LabelDataXmit.Caption := Format('%10.0n b',[(MagRasPer.PerfXmitCur[0]/1000)*1000]);
    LabelDataRecv.Caption := Format('%10.0n b',[(MagRasPer.PerfRecvCur[0]/1000)*1000]);
   end
   else
    begin
    LabelSpeedVal.Caption := Format('-- kBit/s',[MagRasPer.PerfConnSpd [0]/1000]);
    LabelDataXmit.Caption := Format('-- b',[(MagRasPer.PerfXmitCur[0]/1000)*1000]);
    LabelDataRecv.Caption := Format('-- b',[(MagRasPer.PerfRecvCur[0]/1000)*1000]);
    end;
    
    LabelSpeedXmit.caption:=   Format('%2.1f kb/s',[onlinespeed.xmit_av/1024]);
    LabelSpeedRecv.caption:=   Format('%2.1f kb/s',[onlinespeed.recv_av/1024]);

    if onlinespeed.recv_av > 500 then LEDREcv.LEdOn:= true else LEDREcv.LEdOn:= false;
    if onlinespeed.xmit_av > 500 then LEDxmit.LEdOn:= true else LEDxmit.LEdOn:= false;
  end;

  //leerlauf
  if ((onlinespeed.recv_av+onlinespeed.xmit_av) < leerlaufschwelle) then
  leerlauf.enabled:= true else leerlauf.enabled:= false;

end;
//~~~~~~~~SPEED~ENDE~~~~~~~~~

      if (selfdial and( minutesbetween(oldtime, now) > 2)) then
      begin

          beginn := Dateof(Now) + onlineset.vbegin;
          Ende   := Dateof(Now) + onlineset.vend;

          if Ende < beginn then Ende:= incday(ende,1);

        //WarnFenster freigeben, wenn es schon existiert
          If Assigned(PriceWarning) then Pricewarning.close.click;

           Application.CreateForm(TPriceWarning, PriceWarning);

           PriceWarning.info2.Caption:= Format(misc(M255,'M255'),[onlineset.Tarif ,onlineset.Preis ,onlineset.Einwahl]);
           PriceWarning.info3.Caption:= Format(misc(M256,'M256'),[timetoStr(onlineset.vbegin) ,timeToStr(onlineset.vend)]);
           PriceWarning.info4.Caption:= '';

           PriceWarning.neu1.Caption:= misc(M17,'M17')+' : ' +timetostr(now-oldtime);

           if ((now > beginn) and (now < ende)) then
           begin
             PriceWarning.neu2.Caption:= misc(M18,'M18');
             PriceWarning.neu3.Caption:= misc(M19,'M19');
             Pricewarning.trennen2.Caption:= Format(misc(M261,'M261'),[TimeToStr(onlineset.vend)]);
             Pricewarning.Timer1.enabled:= true;
           end;
           if ((now < beginn) or (now > ende)) then
           begin
              PriceWarning.neu2.Caption:= misc(M20,'M20');
              PriceWarning.neu3.Caption:= misc(M21,'M21');
              Pricewarning.trennen2.visible:= false;
              Pricewarning.Timer1.enabled:= true;
           end;
           Pricewarning.Show;
           pricewarning.BringToFront;
      end;

   if dauer > 0 then
   Tray.Hint:= 'LeastCosterXP' + #13#10+
                'IP: ' + IpAdress + #13#10+
                misc(M48,'M48')+': ' + ozeit.Caption  + #13#10+
                misc(M49,'M49')+': ' + timetostr(strtotime(ozeit.caption)+settings.ReadTime('Tageskosten','Zeit',Encodetime(0,0,0,0))) + #13#10+
                misc(M50,'M50')+': ' + format('%3m',[onlineset.kosten + settings.ReadFloat('Tageskosten','Kosten',0)]) + #13#10+
                misc(M28,'M28')+': ' + chr(9) + Inttostr(settings.ReadInteger('Tageskosten','Verbindungen',0)+1) + #13#10+
                misc(M12,'M12')+'/min: ' + format('%1.3f',[0.5* onlineset.kosten/(dauer/60) + 0.5 * settings.ReadFloat('Tageskosten','Mittelwert',0)*100]);

oldtime:= now;

//alle 5 min Verbindungsdaten auf die platte schreiben
if (dauer > 0) and (dauer mod 300 = 0) then WriteOnlinesetToHD;
end;
end;

procedure THauptfenster.MagRasConStateEvent(Sender: TObject;ConnState: TRasStateRec);
begin

if not (ConnState.ConnectState = ERROR_INVALID_PORT_HANDLE) then
  Dialstatus.text:= ConnState.statusstr +' ('  +inttostr(connstate.ConnectState) +')'; //Status ausgeben

//nur wenn eine fremde Verbindung aufgebaut wurde ist DialHandle 0
//oder
//nur beim ersten W�hlen (wenn dailing=true) hier beenden (wird ja im OnlineTimer abgehandelt)
if isonline and ((DialHandle = 0) or (dialing=false)) then exit;//beenden wenn schon online (damit frende Verbindungen nicht neu ausl�sen)

if ConnState.ConnectState = RASCS_Connected then
begin
     selfdial:= true;
     surfdauer.enabled:= true;
     aktualisieren.enabled:= true;
     //verstecken wenn online
     if settings.readbool('Dialer','Tray',false) then MainMenueClick(MM1_9);
     exit;
end;

if ConnState.ConnectError <> 0 then //wenn Fehler aufgetreten oder aufgelegt
begin
 RasHangUp(DialHandle);
 dialing:= false;
 selfdial:= false;
 ConnHandle:= 0; DialHandle:= 0;
 DialBtn.caption:= misc(M24,'M24');
 Aktualisieren.enabled:= true;
 aktualisieren.click;
 surfdauer.enabled:= true;
 reload.enabled:= true;
 ClearRasEntry;
 Hauptfenster.Cursor := crDefault;

 if (AutoDialLed.ledon) then
 begin
  Autodial.Enabled:= true;
  status.simpletext:= misc(M25,'M25')+' ('+Datetimetostr(now)+')';
 end
 else status.simpletext:= misc(M26,'M26')+' ('+Datetimetostr(now)+')';
 aktualisierenclick(self);

 if ForceDial.Checked then Dialbtn.Click;
end;

end;

procedure THauptfenster.StatLED1Click(Sender: TObject);
var i: integer;
begin
if ((sender = StatLED2)
   and (MagRasCon.EntryName = 'LeastCosterXP')
   and isonline and selfdial
   and (MagRasOSVersion >= OSW2k)
   and allow_multilink) then
begin
     ConnectMenu.Items.Items[4].Enabled:= not statLED2.LedOn;
     ConnectMenu.Items.Items[5].Enabled:= statLED2.LedOn;
     ConnectMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y-115);
     exit;
end;

 MagRasCon.GetConnections;
 if MagRasCon.Connections.count = 0 then exit;

 if not assigned(info) then
 begin
     Application.CreateForm(TInfo, Info);
     info.show;
     info.edit.clear;
     info.Edit.lines.add(misc(M27,'M27'));
     info.Edit.lines.add(misc(M28,'M28')+chr(9)+': ' + inttostr(MagRasCon.Connections.Count));
     info.Edit.lines.add('');

     For i:= 0 to MagRasCon.Connections.Count-1 do
     begin
      if MagRasCon.Connections.RasConn(i) = ConnHandle then
         info.Edit.lines.add(misc(M29,'M29'));
      info.Edit.lines.add(misc(M30,'M30')+chr(9)+': ' + inttostr(i));
      info.Edit.lines.add(misc(M31,'M31')+chr(9)+chr(9)+': ' + MagRasCon.Connections.EntryName(i));      info.Edit.lines.add(misc(M33,'M33')+chr(9)+': ' + MagRasCon.Connections.DeviceName(i));
      info.Edit.lines.add(misc(M32,'M32')+chr(9)+': ' + MagRasCon.Connections.DeviceType(i));
      if MagRasCon.Connections.RasConn(i) = ConnHandle then
      begin
             if (StatLED1.LedOn and statled2.ledon) then
              info.Edit.lines.add(misc(M34,'M34')+chr(9)+': 2')
             else
              info.Edit.lines.add(misc(M34,'M34')+chr(9)+': 1');

      info.Edit.lines.add(misc(M35,'M35')+chr(9)+': ' + inttostr(onlineset.download));
      info.Edit.lines.add(misc(M36,'M36')+chr(9)+': ' + inttostr(onlineset.upload));
      end;
     end;
     info.Edit.lines.add('________________________________________');
 end;

end;

procedure THauptfenster.FastDisconnectOnExit;
var buf: string;
begin
 if isonline then
  with hauptfenster do
    begin
     disconnect;
     onlineset.Endzeit:= timeof(now);
     closertimer(nil); //Verbindung aufschreiben

     ClearRasEntry;

     //Logfile schreiben
     Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+misc(M37,'M37')+#13#10;
     webserv1.status:= buf;
     webservform.logfile_add(buf);
    end;

end;

//~~~~~~~~~~~~~~~~~~~~~~~~~ RASMANAGER ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptfenster.disconnect;
begin
MagRasCon.DisconnectEx(ConnHandle,0,3000, true);
end;

procedure THauptfenster.SetDialParams(user, password, number: string);
var errcode: integer ;
begin

 //Informationen der RasVerbindung einlesen
 errcode := MagRasEdt.GetAllEntryProps('LeastCosterXP') ;
  if errcode = 0 then MagRasEdt.GetDialProps('LeastCosterXP')
   else Status.SimpleText := MagRasEdt.StatusStr ;

// set properties
// dial params - optional
   MagRasEdt.UserName := user;
   MagRasEdt.Password := password ;
   MagRasEdt.LocalPhoneNumber := Modemstring+number ;

   with MagRasEdt do
   begin
   if ((MagRasOSVersion = OSW9x) or (not allow_multilink))then dialmode:= dialSingle
   else
   dialmode:= dialAll; //immer auf DialAll setzen und dann einzeln aufrufen

   bSharedPhoneNumbers:= true;
   bRequireEncryptedPassword:= false;

// device stuff - required, must match precisely name and type from lists
  if SetUpModems then
  begin
    DeviceName := modemname;
    DeviceType := modemtype;

   if ((MagRasOSVersion >= OSW2K) and allow_multilink) then
   begin
    MagRasEDT.GetSubEntryProps('LeastCosterXP',1);

    SubDeviceName[1] := modemname;
    SubDeviceType[1] := modemtype;
    SubLocalPhoneNumber[1] := LocalPhoneNumber;

    SubDeviceName[2] := modemname2;
    SubDeviceType[2] := modemtype2;
    SubLocalPhoneNumber[2] := LocalPhoneNumber;
    subcurtotal:= 2;
   end;
  end ;
end;

    MagRasEdt.bCustom:= false;

    errcode := MagRasEdt.PutAllEntryProps ('LeastCosterXP') ;        //setzen
    if errcode = 0 then MagRasEdt.PutDialProps ('LeastCosterXP') ;   //setzen der DialProps
    if errcode <> 0 then
    begin
    Status.SimpleText := MagRasEdt.StatusStr ;
    beep;
    end;
end;

procedure CreateRAS;
var errcode: integer ;
    newname: string ;
begin
  newname := 'LeastCosterXP';
with Hauptfenster do
begin
  // default all properties for a PPP TCP/IP entry
 MagRasEdt.PPPDefault;

// set specific properties
	with MagRasEdt do
    begin
	// telephone numbers - required
    bUseCountryAndAreaCodes := false; //keine Area-Codes
    bModemLights            := true;  //zeige Status im Tray an
    bShowDialingProgress    := true;  //Status w�hrend des W�hlens anzeigen
    bPreviewPhoneNumber     := true;
    bSecureLocalFiles       := true;
    bPreviewUserPw          := true;
    LocalPhoneNumber := '0' ;

	// device stuff - required, must match precisely name and type from lists
    	DeviceName := modemname;
    	DeviceType := modemtype;
	end ;
    errcode := MagRasEdt.PutAllEntryProps (newname) ;
    if errcode = 0 then MagRasEdt.PutDialProps (newname) ;
    if errcode <> 0 then
    begin
    Status.SimpleText := MagRasEdt.StatusStr ;
        beep ;
    end
	else
    begin
//    Status.SimpleText := 'Created New Entry OK' ;
    beep ;
    end ;
end;
end;

function FindRasConnection: boolean;
var i: word;
begin
Result:= false;
with hauptfenster do
begin
MagRasCon.GetPhoneBookEntries;
if MagRasCon.PhoneBookEntries.Count>0 then
for i:= 0 to MagRasCon.PhoneBookEntries.Count-1 do
    if MagRasCon.PhoneBookEntries.Strings[i] = 'LeastCosterXP' then
    begin
     Result:= true;
     break;
    end else Result:= false;
end;
end;


//~~~~~~~~~~~~~~~~~~~~~~~~~ RASMANAGER ~ENDE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure THauptfenster.zeitumrechnen(zeit_in_sec: longint; var h,m,s: word);
begin
h:= zeit_in_sec div 3600;
m:= (zeit_in_sec mod 3600) div 60;
s:= zeit_in_sec mod 60;
end;

procedure THauptfenster.save_cfg;
var i: integer;
begin
settings.writebool('Basics','Profi', MM3_2.checked);
settings.writeinteger('lasttime','base',hauptfenster.surfdauer.Position);
settings.writeinteger('lastdate','count',datensaetze);
settings.writebool('Autotrennen','keineWechselWarnung',Hauptfenster.NoChangeWarning.checked);

SettingsScores.Clear;

if length(Scores)>0 then
begin
 with hauptfenster do
  for i:= 0 to length(Scores)-1 do
  begin
   SettingsScores.WriteInteger(Scores[i].Name,'DialedAll',Scores[i].gesamt);
   SettingsScores.WriteInteger(Scores[i].Name, 'Dialed',Scores[i].erfolgreich);
   SettingsScores.WriteInteger(Scores[i].Name, 'State',Scores[i].state);
   SettingsScores.WriteString(Scores[i].Name, 'Color',Scores[i].Color);
  end;
end;

end;

procedure THauptfenster.Timer_anTimer(Sender: TObject);
begin
 status.simpletext:= misc(M38,'M38');
 timer_aus.enabled:= true; timer_an.enabled:= false;
end;

procedure THauptfenster.Timer_ausTimer(Sender: TObject);
begin
 timer_an.enabled:= true;  timer_aus.enabled:= false;
end;

procedure callexeoff;
var time, code: integer;
begin
if length(oprogoff)>0 then
begin
     Val(oprogoff[0].timeout, time, Code);
     if code <> 0 then time:= 1000;
    if ((dateof(now) >= oprogoff[0].date) or (oprogoff[0].days = 0)) then
    begin
        oprogoff[0].today:=true;
        hauptfenster.calloff.interval:=time;
        hauptfenster.calloff.Enabled:= true;
    end
    else
    begin
        oprogoff[0].today:=false;
        hauptfenster.calloff.interval:=1;
        hauptfenster.calloff.Enabled:= true;
    end;

end;
end;

procedure callexe;
var time, code: integer;
begin
if length(oprog)>0 then
begin
  Val(oprog[0].timeout, time, Code);
  if code <> 0 then time:= 1000;

   if ((dateof(now) >= oprog[0].date) or(oprog[0].days = 0)) then
    begin
        oprog[0].today:=true;
        hauptfenster.call.interval:=time;
        hauptfenster.call.Enabled:= true;
    end
    else
    begin
        oprog[0].today:=false;
        hauptfenster.call.interval:=1;
        hauptfenster.call.Enabled:= true;
    end;

end;
end;

procedure THauptfenster.loadprogsoff;
var programs: TStringlist;
    i: integer;
begin
setlength(oprogoff,0);

programs:= TStringlist.Create;
SettingsOffline.ReadSections(programs);
setlength(oprogoff,programs.count);

if programs.count > 0 then
for i:= 0 to programs.Count-1 do
begin
 oprogoff[i].section := programs.Strings[i];
 oprogoff[i].path   := SettingsOffline.ReadString(programs.Strings[i],'Pfad','');
 oprogoff[i].param  := SettingsOffline.ReadString(programs.Strings[i],'Param','');
 oprogoff[i].style  := Uppercase(SettingsOffline.ReadString(programs.Strings[i],'Style',''));
 oprogoff[i].mintime:= SettingsOffline.ReadString(programs.Strings[i],'mintime','');
 oprogoff[i].timeout:= SettingsOffline.ReadString(programs.Strings[i],'timeout','');
 oprogoff[i].Days   := SettingsOffline.ReadInteger(programs.Strings[i],'Days',0);
 oprogoff[i].Date   := SettingsOffline.ReadDate(programs.Strings[i],'DaytoRun',Dateof(now));
end;

programs.free;

callexeoff; {Aufruf der Exeverarbeitung}
end;

procedure THauptfenster.loadprogs;
var programs: TStringlist;
    i: integer;
begin
setlength(oprog,0);

programs:= TStringlist.Create;
SettingsOnline.ReadSections(programs);
setlength(oprog,programs.count);

if programs.count > 0 then
for i:= 0 to programs.Count-1 do
begin
 oprog[i].section := programs.Strings[i];
 oprog[i].path   := SettingsOnline.ReadString(programs.Strings[i],'Pfad','');
 oprog[i].param  := SettingsOnline.ReadString(programs.Strings[i],'Param','');
 oprog[i].style  := Uppercase(SettingsOnline.ReadString(programs.Strings[i],'Style',''));
 oprog[i].mintime:= SettingsOnline.ReadString(programs.Strings[i],'mintime','');
 oprog[i].timeout:= SettingsOnline.ReadString(programs.Strings[i],'timeout','');
 oprog[i].Days   := SettingsOnline.ReadInteger(programs.Strings[i],'Days',0);
 oprog[i].Date   := SettingsOnline.ReadDate(programs.Strings[i],'DaytoRun',Dateof(now));
 if SettingsOnline.ReadBool(programs.Strings[i],'kill',false) then hauptfenster.kill_list.append(ExtractFileName(oprog[i].path));
end;

programs.free;
callexe; {Aufruf der Exeverarbeitung}
end;


procedure THauptfenster.firststartcheckTimer(Sender: TObject);
var reg: TRegistry;
begin
firststartcheck.enabled:= false;

Reg := TRegistry.Create;
Reg.RootKey := HKEY_CLASSES_ROOT;

//Dateiendung lcz und lcx installieren
 try
   if not reg.KeyExists('.lcx') then
     InstallExt('.lcx', 'LeastCosterXP Xport', 'LeastCosterXP Tarifdatei', ParamStr(0), '%1',0);
 finally  reg.free; end;
//einstellungsfenster �ffnen
MainMenueClick(MM3_1);
showmessage(misc(M39,'M39'));
end;


procedure THauptfenster.PerformExit;
var i: integer;
    buf: string;
begin
    UserSettings.erasesection('active');                                          //alle aktiven Benutzer aus dem WebInterface ausloggen
    settings.writeinteger('lasttime','base', hauptfenster.surfdauer.position);    //sichern der Einstellungen

    for i:= 1 to liste.colcount-1 do                                              //abspeichern der Tabellenbreiten
      settings.writeinteger('Tariflist','Col'+inttostr(i),hauptfenster.liste.ColWidths[i]);

    settings.writebool('Tariflist','Colors', usecolors);
    settings.writeBool('LeastCoster','ConnectionCost', ConnectionCostVisible );
    settings.WriteBool('Tariflist','Clock', clock.Visible);

    if DialHandle <> 0 then  //wenn gerade gew�hlt wird
      begin RasHangUp(DialHandle); ClearRasEntry;  dialing:= false; Hauptfenster.Cursor := crDefault; ForceDial.Checked:= false; end;

    if (isonline and selfdial) then //wenn noch online
    begin
     disconnect;
     onlineset.Endzeit:= timeof(now);
     closertimer(nil);

     //Logfile schreiben
     Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+misc(M40,'M40')+#13#10;
     webserv1.status:= buf;
     webservform.logfile_add(buf);

     //Sound
     if fileexists(settings.readstring('LeastCoster','SoundOFF',  '' )) then
        sndPlaySound(PChar(settings.readstring('LeastCoster','SoundOFF',  '' )),SND_ASYNC);
        
     ClearRasEntry;
     end;
    sndPlaySound(nil,0);  //stummschalten
end;

procedure THauptfenster.onlineMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
online.Hint:=getlocalips;
end;

procedure THauptfenster.PM14Click(Sender: TObject);
begin
hauptfenster.Visible:=true;
end;

procedure THauptfenster.hinttimerTimer(Sender: TObject);
begin
hinttimer.Enabled:=false;
tray.HideBalloonHint;
end;

procedure OProgSetDate(item, days: integer);
begin
SettingsOnline.WriteDate(oprog[item].section,'DaytoRun',Dateof(incday(now,days)));
end;

procedure OProgOffSetDate(item, days: integer);
begin
SettingsOffline.WriteDate(oprogoff[item].section,'DaytoRun',Dateof(incday(now,days)));
end;

procedure THauptfenster.callTimer(Sender: TObject);
var min,time, basis, styl: integer;
    code: integer;
begin
call.Enabled:= false;
styl:=10;
basis:= surfdauer.position;

Val(oprog[progcount].mintime, min, Code);
if code <> 0 then min:= 1;

if (min <= basis) then
begin
if oprog[progcount].today then
begin

if oprog[progcount].days > 0 then
   OProgSetDate(progcount,oprog[progcount].days);

 if fileexists(oprog[progcount].path) then
  begin

  if oprog[progcount].style = 'SHOWNORMAL' then styl:=1
  else if oprog[progcount].style = 'MINIMIZE' then styl:=2
    else if oprog[progcount].style = 'MAXIMIZE' then styl:=3
      else if oprog[progcount].style = 'HIDE' then styl:=4;

  if not isexerunning(Extractfilename(oprog[progcount].path)) then
  begin
      case styl of
        1: ShellExecute(handle,'open',Pchar(oprog[progcount].path),Pchar (oprog[progcount].param),nil,SW_SHOWNORMAL);
        2: ShellExecute(handle,'open',Pchar(oprog[progcount].path),Pchar (oprog[progcount].param),nil,SW_MINIMIZE);
        3: ShellExecute(handle,'open',Pchar(oprog[progcount].path),Pchar (oprog[progcount].param),nil,SW_MAXIMIZE);
        4: ShellExecute(handle,'open',Pchar(oprog[progcount].path),Pchar (oprog[progcount].param),nil,SW_HIDE);
        else ShellExecute(handle,'open',Pchar(oprog[progcount].path),Pchar (oprog[progcount].param),nil,SW_SHOWNORMAL);
      end;
   end
   else
       if not noballoon then tray.ShowBalloonHint(misc(M41,'M41'),Extractfilename(oprog[progcount].path)+ ' '+misc(M42,'M42'),bitInfo,10);
 end
 else
     if not noballoon then tray.ShowBalloonHint(misc(M41,'M41'),oprog[progcount].path +' ' +misc(M43,'M43')+ #13#10 +misc(M38,'M38'),bitInfo,10);
end;
end;
progcount:= progcount+1;
if (progcount < length(oprog)) then
  begin
    Val(oprog[progcount].timeout, time, Code);
    if code <> 0 then time:= 1000;

    if ((dateof(now) >= oprog[progcount].date) or (oprog[progcount].days = 0))  then
    begin
        oprog[progcount].today:=true;
        hauptfenster.call.interval:=time;
        call.Enabled:= true;
    end
    else
    begin
        oprog[progcount].today:=false;
        hauptfenster.call.interval:=1;
        call.Enabled:= true;
    end;
  end
  else hauptfenster.call.interval:=1000;
end;

procedure THauptfenster.calloffTimer(Sender: TObject);
var time, styl: integer;
    code: integer;
begin
calloff.Enabled:= false; styl:=10;
if oprogoff[progcountoff].today then
begin
if oprogoff[progcountoff].days > 0 then
   OProgOffSetDate(progcountoff,oprogoff[progcountoff].days);

{exe ausf�hren}
 if fileexists(oprogoff[progcountoff].path) then
 begin
  if oprogoff[progcountoff].style = 'SHOWNORMAL' then styl:=1;
    if oprogoff[progcountoff].style = 'MINIMIZE' then styl:=2;
      if oprogoff[progcountoff].style = 'MAXIMIZE' then styl:=3;
        if oprogoff[progcountoff].style = 'HIDE' then styl:=4;

   if not isexerunning(Extractfilename(oprogoff[progcountoff].path)) then
   begin
   case styl of
    1 :  ShellExecute(handle,'open',Pchar(oprogoff[progcountoff].path),Pchar(oprogoff[progcountoff].param) ,nil,SW_SHOWNORMAL);
    2 :  ShellExecute(handle,'open',Pchar(oprogoff[progcountoff].path),Pchar(oprogoff[progcountoff].param) ,nil,SW_MINIMIZE);
    3 :  ShellExecute(handle,'open',Pchar(oprogoff[progcountoff].path),Pchar(oprogoff[progcountoff].param) ,nil,SW_MAXIMIZE);
    4 :  ShellExecute(handle,'open',Pchar(oprogoff[progcountoff].path),Pchar(oprogoff[progcountoff].param) ,nil,SW_HIDE);
    else ShellExecute(handle,'open',Pchar(oprogoff[progcountoff].path),Pchar(oprogoff[progcountoff].param) ,nil,SW_SHOWNORMAL);
    end;
   end else if not noballoon then tray.ShowBalloonHint(misc(M41,'M41'),Extractfilename(oprogoff[progcountoff].path)+ ' '+misc(M42,'M42'),bitInfo,10);
  end
 else
 if not noballoon then tray.ShowBalloonHint(misc(M41,'M41'),oprogoff[progcountoff].path +' '+misc(M43,'M43')+ #13#10 +misc(M38,'M38'),bitInfo,10);
end;

progcountoff:= progcountoff+1;
if (progcountoff < length(oprogoff)) then
  begin
    Val(oprogoff[progcountoff].timeout, time, Code);
    if code <> 0 then time:= 1000;

    if ((dateof(now) >= oprogoff[progcountoff].date) or (oprogoff[progcountoff].days = 0)) then
    begin
        oprogoff[progcountoff].today:=true;
        hauptfenster.calloff.interval:=time;
        calloff.Enabled:= true;
    end
    else
    begin
        oprogoff[progcountoff].today:=false;
        hauptfenster.calloff.interval:=1;
        calloff.Enabled:= true;
    end;

  end
  else  hauptfenster.calloff.interval:=1000;
end;

procedure loadholidays;
var f: file of THolidays;
    hol: THolidays;
    c: integer;
begin

  c:= 0;
  setlength(holidaylist, c);
  if not fileExists(extractfilepath(paramstr(0))+'holidays.dat') then exit;
  
  assignfile(f, extractfilepath(paramstr(0))+'holidays.dat');
  reset(f);
  while not eof(f) do
   begin
    read(f, hol);
    inc(c);
    setlength(holidaylist, c);
    holidaylist[c-1]:= hol;
   end;
  closefile(f);
end;

procedure THauptfenster.FormCreate(Sender: TObject);
var i       : integer;
    sr      : TSearchRec;
    F       : string;
    reg     : TRegistry;
    langlist: TStringlist;
    lastConn: OnlineWerte;
begin
closeallowed := false;
autoclose    := false;
ConnHandle   := 0;
Disconnecting:= false;
neuladen     := false;
isonline     := false;

reg:= TRegistry.Create;
  //lcz-Dateien wieder unregistrieren -> nicht mehr n�tig
  if reg.keyexists('.lcz') then UnInstallExt('.lcz');
reg.Free;

//  if isDSLOnline then
//hauptfenster.MM2_3.Enabled:= true;
//(wieder auskommentieren)
Rssread:= TRss.Create;

//gradienten erzeugen
if MagRasOSVersion > OSW9x then
begin
  grad2           := TSRGradient.Create(self);
  grad2.parent    := hauptfenster;
  grad2.Align     := alClient;
  grad2.Direction := gdUpLeft;
  grad2.EndColor  := $00DBAF95;
  grad2.StartColor:= clBtnFace;
  grad2.Style     := gsPyramid;
  grad2.SendToBack;//nach hinten schieben
end;

 EdWebsite := TSRLabel.Create(self);
 EdWebsite.Parent := hauptfenster;
 with EdWebsite do
  begin
    Name                := 'EdWebsite';
    Left                := 27;
    Top                 := 374;
    Width               := 60;
    Height              := 13;
    Constraints.MaxWidth:= 360;
    Constraints.MinWidth:= 60;
    Font.Charset        := DEFAULT_CHARSET;
    Font.Color          := clBlue;
    Font.Height         := -11;
    Font.Name           := 'MS Sans Serif';
    Font.Style          := [fsBold];
    ParentFont          := False;
    Transparent         := true;
    HoverFontColor      :=clHotlight;
    Font.Color          := clBlue;
    LinkActive          := true;
    LinkType            := ltWWW;
    ShortenFilenames    := false;
    ShowHighlight       := false;
    ShowShadow          := false;
    Style               := lsCustom;
    UnderlineOnEnter    := false;
    Visible             := true;
  end;

  WebIntLabel := TSRLabel.Create(Self);
  WebIntLabel.Parent := hauptfenster;
  with WebIntLabel do
  begin
    Name             := 'WebIntLabel';
    Left            := 135;
    Top             := 483;
    Width           := 149;
    Height          := 16;
    Anchors         := [akLeft, akTop, akRight];
    Caption         := '>>> WebInterface <<<';
    Font.Color      := clBlue;
    Font.Height     := -13;
    Font.Name       := 'MS Sans Serif';
    Font.Style      := [fsBold];
    ParentFont      := False;
    Transparent     := True;
    HoverFontColor  :=clHotlight;
    Font.Color      := clBlue;
    LinkActive      := true;
    LinkType        := ltWWW;
    ShortenFilenames:= false;
    ShowHighlight   := false;
    ShowShadow      := false;
    Style           := lsCustom;
    UnderlineOnEnter:= false;
    Visible         := False;
  end;


  //Fenstertitle erzeugen
  Title2                 := TSRLabel.Create(self);
  title2.Parent          := Hauptfenster;
  title2.Alignment       := taCenter;
  title2.Anchors         := [akTop];
  title2.BevelStyle      := bvnone;
  title2.Caption         := 'LeastCosterXP';
  title2.Hint            := 'www.leastcosterxp.de';
  title2.HoverFontColor  :=$000000BF;
  title2.Left            := 120;
  title2.Height          := 29;
  title2.Font.Color      := $0000007B;
  title2.Font.Name       := 'Verdana';
  title2.font.Style      := [fsBold];
  title2.Font.Size       := 15;
  title2.Layout          := tlTop;
  title2.LinkActive      := true;
  title2.LinkedAdress    := 'http://www.leastcosterxp.de';
  title2.LinkType        := ltWWW;
  title2.ShadowColor     := $00D7E0E1;
  title2.ShadowOffset    := 3;
  title2.ShortenFilenames:= false;
  title2.ShowHighlight   := true;
  title2.ShowShadow      := true;
  title2.Style           := lsCustom;
  title2.Top             := 0;
  title2.Transparent     := true;
  title2.UnderlineOnEnter:= false;
  title2.Width           := 166;
  title2.Visible         := true;

  settings               := TMemIniFile.Create(extractfilepath(paramstr(0))+'lcr.cfg');
  UserSettings           := TMemIniFile.Create(extractfilepath(paramstr(0))+'user.pwd');
  SettingsTraffic        := TMemIniFile.Create(extractfilepath(paramstr(0))+'traffic.ini');
  SettingsKontingente    := TMemIniFile.Create(extractfilepath(paramstr(0))+'Kontingente.ini');
  SettingsScores         := TMemIniFile.Create(extractfilepath(paramstr(0))+'Scores.ini');
  SettingsOnline         := TMemInifile.Create(ExtractFilepath(Paramstr(0)) + 'online.ini');
  SettingsOffline        := TMemInifile.Create(ExtractFilepath(Paramstr(0)) + 'offline.ini');

//Tarifliste
  liste.colwidths[0]:= -1; //erste spalte : ScoreWerte (immer unsichtbar)
//Standardwerte
  liste.ColWidths[6]:= -1;
  for i:= 8 to liste.colcount-1 do liste.ColWidths[i]:= -1;

  liste.ColWidths[1]:= round (2.0* liste.width/7)-3;
  liste.ColWidths[2]:= round(liste.width/7)-3;
  liste.ColWidths[3]:= round(liste.width/7)-3;
  liste.ColWidths[4]:= round(liste.width/7)-3;
  liste.ColWidths[5]:= round(liste.width/7)-3;
  liste.ColWidths[7]:= round(liste.width/7)-3;

  for i:= 1 to liste.colcount-1 do
  begin
    liste.ColWidths[i]:= settings.ReadInteger('Tariflist','Col'+inttostr(i),liste.ColWidths[i]);
    TarifStatus.Items.Items[5].Items[2].items[i-1].checked:= not (liste.ColWidths[i] = -1);
  end;
  useColors := settings.ReadBool('Tariflist','Colors', false);
  TS6_2.checked:= not usecolors;

  TarifeDisabled        := false;
  KontingenteWarned     := false;
  parameters            := TStringList.Create;
  kill_list             := TStringList.Create;
  parameters.Duplicates := dupIgnore;
  atomcount             := 0;
  startwithimport       := false;
  importfilename        := '';
  selfdial              := false;
  webzugriff            := false;
  rascheck              := true;
  writeme               := false;
  startcount            :=0;
  firststart            := false;
  rssrunning            := false;
  warnung_gezeigt       := false;
  dialing               := false;
  beliebig_check.checked:= false;
  Hauptfenster.Caption  := 'LeastCosterXP '+GetFileVersion(application.exename);
  ozeit.caption         := '';
  usecolors             := true;
  TS6_2.checked         := false;
  disconnectseconds     := 5;
  minimizeonclose       := true;
  ConnectionCostvisible := true;
  TS6_1.Checked         := not ConnectionCostvisible;
  DaysToSaveLogs        := 60;

  F:= ExtractFilepath(Paramstr(0));

  if not directoryexists(F + 'log')      then mkdir(F + 'log');
  if not directoryexists(F + 'www')      then mkdir(F + 'www');
  if not directoryexists(F + 'www\log')  then mkdir(F + 'www\log');
  if not directoryexists(F + 'www\files')then mkdir(F + 'www\files');
  if not directoryexists(F + 'www\img')  then mkdir(F + 'www\img');
  if not directoryexists(F + 'RSS')      then mkdir(F + 'RSS');
  if not directoryexists(F + 'lang')     then mkdir(F + 'lang');

//einlesen aller Sprachdateien
langlist:= TStringlist.Create;
if FindFirst(ExtractFilePath(paramStr(0))+ 'lang\*.*', faAnyFile, SR) = 0 then
    repeat
        if ( (sr.name <> '.') and (sr.name<>'..') and (ExtractFileExt(sr.name)='.lng') ) then begin langlist.Append(sr.name); end;
    until FindNext(SR) <> 0;
findclose(sr);

//Einlesen der Language-Men�-Punkte
for i:= 0 to langlist.Count -1 do
 if fileexists(ExtractFilePath(paramStr(0))+ 'lang\' + langlist.Strings[i]) then
   mm3_3.Add(NewItem(ExtractFileName(langlist.strings[i]),TextToShortCut(''),False,True,langClick,0,'Item1'));
langlist.free;
//Sprache laden
CL:=loadIni('lang\'+settings.readstring('LeastCoster','language',''));
  if CL<>nil then
  begin
    fillProps([Hauptfenster],CL);
    if isonline then DialBtn.Caption := misc(M82,'M82') else misc(M24,'M24');
  end;

for i:= 0 to mm3_3.count -1 do
 if striphotkey(mm3_3.items[i].caption) = settings.readstring('LeastCoster','language','') then mm3_3.items[i].checked:= true;


//pr�fen ob RAS installiert
if not MagRasCon.TestRas then
begin
 Dialbtn.Enabled:= false;
 status.simpletext:= misc(M44,'M44');
end;

//Atomserver einlesen
atomserver:= TStringlist.Create;
if fileexists(extractfilepath(paramstr(0))+'Atomzeitserver.txt') then
 atomserver.LoadFromFile(extractfilepath(paramstr(0))+'Atomzeitserver.txt');

//Feiertage einlesen
loadholidays;

//Eintr�ge pr�fen und wenn leer setzen
if (atomserver.count = 0) then
begin
  atomserver.Append('ntps1-0.cs.tu-berlin.de');
  atomserver.savetoFile(extractfilepath(paramstr(0))+'Atomzeitserver.txt');
end
else
begin
  //leere eintr�ge entfernen
    for i:= atomserver.count-1 downto 0 do
     if atomserver.strings[i] = '' then atomserver.Delete(i);
  //wenn alle leer waren, dann jetzt einen anf�gen
  if (atomserver.count = 0) then
  begin
    atomserver.Append('ntps1-0.cs.tu-berlin.de');
    atomserver.savetoFile(extractfilepath(paramstr(0))+'Atomzeitserver.txt');
  end;
end;

setupmodems:= true;

MM3_2.Checked := settings.readbool('Basics','Profi', false);
MM3_2click(self);

if not fileexists(ExtractFilePath(Application.ExeName)+'lcr.cfg')  then
begin
 firststart:= true;
 tray.iconvisible:= true;
// exit;
end;

   //minimiert starten wenn gew�nscht
  application.showmainform:= not settings.ReadBool('LeastCoster','minimiert',false);

  //wenn datei �bergeben wurde mainform anzeigen
  If (ParamCount>0) and (FileExists(ParamStr(1))) then application.showmainform:= true;

  //letzten Basiszeitwert setzen
  surfdauer.Position:= settings.Readinteger('lasttime','base',15);

  //atomzeit
  if not settings.ReadBool('Onlinecheck','Atomzeit', false) then
  begin
   LEDTime.ColorOff:= clGray;
   LEDTime.Hint:= misc(M45,'M45');
  end;

  lookforward         := settings.Readinteger('Onlinecheck','Vorschub',5);

  //Modemeinstellungen
   modemname            := settings.Readstring('Dialer','Device','');
   modemtype            := settings.Readstring('Dialer','Devicetype','');
   modemname2           := settings.Readstring('Dialer','Device2','');
   modemtype2           := settings.Readstring('Dialer','Devicetype2','');
   allow_Multilink      := settings.ReadBool('Dialer','Multilinkallowed', false);
   setMultilink.checked := settings.ReadBool('Dialer','Multilink', false);

   if (allow_multilink and (modemname2<>'')) then
      SetMultilink.Visible:= true else SetMultilink.Visible:= false;

   SetUpModems := settings.ReadBool('Dialer','SetUpModem', true);
   modemstring := settings.Readstring('Dialer','Vorwahl','');

   noBalloon            := settings.readbool('LeastCoster','noBalloon',false);

   DaysToSaveLogs       := settings.Readinteger('LeastCoster','DaysToSaveLogs', 60);
   MinimizeOnClose      := settings.Readbool('LeastCoster','MinimizeOnClose', true);
   ConnectionCostvisible:= settings.Readbool('LeastCoster','ConnectionCost', true);
   TS6_1.Checked:= not ConnectionCostvisible;

  //Autotrennen
   Autodisconnect.Enabled    := settings.Readbool('Autotrennen','Enabled',true);
   AutoDisconnect.Ask        := settings.Readbool('Autotrennen','Ask',false);
   AutoDisconnect.UseDelay   := settings.Readbool('Autotrennen','UseDelay',false);
   Autodisconnect.Delay      := settings.Readinteger('Autotrennen','Delay',30);
   Autodisconnect.WaitforUser:= settings.Readbool('Autotrennen','WaitForUser',true);

   disconnectseconds         := settings.Readinteger('Autotrennen','DisconnectSeconds',5);
   NoChangeWarning.checked   := settings.Readbool('Autotrennen','keineWechselWarnung',false);

  //Leerlauf
   LeerlaufDisconnect.Enabled    := settings.readbool('Leerlauf','Enabled',true);
   leerlaufdisconnectzeit        := settings.Readinteger('Leerlauf','LeerlaufZeit',5);
   leerlaufdisconnect.Ask        := settings.Readbool('Leerlauf','Ask',true);
   Leerlaufdisconnect.UseDelay   := settings.Readbool('Leerlauf','UseDelay',true);
   leerlaufdisconnect.Delay      := settings.Readinteger('Leerlauf','Delay',30);
   leerlaufdisconnect.WaitforUser:= settings.Readbool('Leerlauf','WaitForUser',false);
   leerlaufschwelle              := settings.Readinteger('Leerlauf','Schwelle',500);

  //Ausschalten nach Auto-Trennen
   AutoAusIndex:= settings.Readinteger('Ausschalten','Value',0);

  //AutoVerbinden
   AutoSurfdauer      := settings.Readinteger('AutoConnect','Basiszeit',1);

   Autobasis.caption:= inttostr(AutosurfDauer div 60) + ' h '+ inttostr(AutosurfDauer mod 60) + ' min';
   AutoBase.Position:= Autosurfdauer;

   AutoDial.Tag:= 10; //10 Sekunden Countdown
   if settings.Readbool('AutoConnect','AutoStartConnect',false) then
   begin
       AutoDialEinwahl.checked:= settings.Readbool('AutoConnect','mitEinwahl',false);
       AutoDialLed.ledon:= settings.Readbool('AutoConnect','AutoStartConnect',false);
       AutoDial.enabled:= true;
   end
   else AutoDial.Interval:= 1;
   AutoDialStatus.Visible:= settings.ReadBool('AutoConnect','atTime', false);
   AutoDialStatus.LEDON:= settings.ReadBool('AutoConnect','atTime', false);

  //Rss-Update
   rss_update := settings.ReadInteger('RSS','Update',60);
   noFeeds    := settings.ReadBool('Rss', 'noFeeds', false);
   Rss_max    := settings.ReadInteger('RSS','maxItems', 40);
   rss_old    := settings.Readbool('RSS','oldFeeds', true);

   if noFeeds then
      begin
           ledRss.ColorOff:= clGray;
           ledrss.Hint:= misc(M46,'M46');
      end;

  clock.Visible:= settings.ReadBool('Tariflist','Clock', false);
  if not clock.Visible then Datelabel.Constraints.MaxWidth:= 402;

  //Tagesstatistik l�schen, wenn Tag gewechselt
  if settings.ReadDate('Tageskosten','Date',encodedate(1970,1,1)) <> dateof(now)
   then settings.EraseSection('Tageskosten');

  RSSRead.LoadRSSList;

  tarifverw.ladetarife;
  Kontingente_Laden;
  LoadAutoDialTimes;

  //LogFiles trimmen
  ShortenLogFiles(Extractfilepath(paramstr(0)) + 'www\log\log.txt',DaysToSaveLogs);
  ShortenLogFiles(Extractfilepath(paramstr(0)) + 'log\atomzeit.txt',DaysToSaveLogs);

  tray.iconvisible:= true;

  if not MagRasCon.TestRas then
   status.SimpleText:=misc(M44,'M44')
   else
   status.SimpleText:= misc(M47,'M47');

  if fileexists(ExtractFilepath(ParamStr(0)) + 'activeConnection.dat') then
  begin //alte Verbindung noch zum Protokoll hinzuf�gen
   ReadOnlineSetFromHD(lastconn);
   Protokolle.SaveConnection(lastConn);
   SaveTrafficData(lastConn);
   SettingsTraffic.UpdateFile;//auf die Platte schreiben
   deletefile(ExtractFilepath(ParamStr(0)) + 'activeConnection.dat');
  end;

  if fileexists(ExtractFilepath(ParamStr(0)) + 'UpdatedFiles.dat') then
      CheckForUpdates;


  Tray.Hint:= 'LeastCosterXP' + #13#10+
                misc(M49,'M49')+ ': ' + timetostr(settings.ReadTime('Tageskosten','Zeit',Encodetime(0,0,0,0))) + #13#10+
                misc(M50,'M50')+ ': ' + format('%3m',[settings.ReadFloat('Tageskosten','Kosten',0)]) + #13#10+
                misc(M28,'M28')+ ': ' + Inttostr(settings.ReadInteger('Tageskosten','Verbindungen',0)) + #13#10+
                misc(M12,'M12')+'/min :' + format('%1.3f',[settings.ReadFloat('Tageskosten','Mittelwert',0)*100]);

end;

//wird nach dem Trennen ausgef�hrt ... hier wird alles gespeichert
procedure THauptfenster.closerTimer(Sender: TObject);
var i: integer;
begin
closer.Enabled:= false;

if selfdial then
begin
   Protokolle.SaveConnection(onlineset);
   SaveTrafficData(onlineset);
   SettingsTraffic.UpdateFile;//auf die Platte schreiben
   if fileexists(ExtractFilepath(ParamStr(0)) + 'activeConnection.dat') then deletefile(ExtractFilepath(ParamStr(0)) + 'activeConnection.dat');

  //alles zur�cksetzen
   kontingentindex:= -1;
   selfdial:= false;  //alles erledigt ... r�cksetzen
   with onlineset do
   begin
    Datum         := EncodeDateTime(1970,01,01,0,0,0,0);
    Dauer         := '';
    tarif         := '';
    Einwahl       := 0.0;
    Rufnummer     := '';
    Preis         := 0.0;
    takt_a        := 60;
    takt_b        := 60;
    webseite      := '';
    vbegin        := EncodeTime(0,0,0,0);
    vend          := EncodeTime(0,0,0,0);
    wechselend    := EncodeTime(0,0,0,0);
    tag           := '';
    wechsel       := EncodeDateTime(1970,01,01,0,0,0,0);
    kosten        := 0;
    wechselpreis  := 0;
    wechseleinwahl:= 0;
    Einwahl2      := 0;
    download      := 0;
    upload        := 0;
    Mindestumsatz := 0.0;
    kosten_mindest:= 0.0;
    gesamtdauer   := 0;
   end;

   dauer:= 0;
   dauer2:= 0;
end;

//Programme beenden
if kill_list.count > 0 then
      for i:= 0 to kill_list.count -1 do
          if isexerunning(kill_list.strings[i]) then killtask(kill_list.strings[i]);
             kill_list.clear;

//Update �berpr�fen
   if fileexists(ExtractFilepath(ParamStr(0)) + 'UpdatedFiles.dat') then
      CheckForUpdates;
end;

procedure THauptfenster.hiderTimer(Sender: TObject);
begin
hider.Enabled:= false;
MainMenueClick(MM1_9);
end;

procedure THauptfenster.trenntickerChange(Sender: TObject);
begin
Autodiscled.ledon:= true;
end;

procedure THauptfenster.TrayDisconnectClick(Sender: TObject);
begin
  Dialbtn.click;
end;

procedure THauptfenster.TrayClick(Sender: TObject);
begin
if hauptfenster.Visible then
begin
  tray.HideMainForm;
  Hidetaskbar(handle);
end else
begin
  tray.ShowMainForm;
  showtaskbar(handle);
end;
end;

procedure THauptfenster.sntptimerTimer(Sender: TObject);
begin
// if not assigned(Uhrzeiteinstellen) then
if not timeupdaterunning then 
 begin
   sntptimer.enabled:= false;
   timeupdaterunning:= true;
   UhrzeitEinstellen:=TZeitThread.Create(true);
   UhrzeitEinstellen.Priority:=tpLower;
   UhrzeitEinstellen.FreeOnTerminate:=true;
   UhrzeitEinstellen.OnTerminate:= UhrzeitEinstellen.MyTerminate;
   UhrzeitEinstellen.Resume;
 end;
// AtomzeitThread.Start;
end;

procedure THauptfenster.FormDestroy(Sender: TObject);
begin

if assigned(atomserver) then atomserver.Free;

parameters.free;
kill_list.free;


//alles auf die platte schreiben - BEGIN

if assigned(SettingsOnline) then
begin
SettingsOnline.UpdateFile;
SettingsOnline.Free;
end;

if assigned(SettingsOffline) then
begin
SettingsOffline.UpdateFile;
SettingsOffline.Free;
end;

if assigned(SettingsScores) then
begin
SettingsScores.UpdateFile;
SettingsScores.Free;
end;

if assigned(SettingsKontingente) then
begin
SettingsKontingente.UpdateFile;
SettingsKontingente.Free;
end;

if assigned(SettingsTraffic) then
begin
SettingsTraffic.UpdateFile;
SettingsTraffic.Free;
end;
if assigned(UserSettings) then
begin
UserSettings.UpdateFile;
UserSettings.Free;
end;
if assigned(Settings) then
begin
settings.UpdateFile;
settings.free;
end;
//alles auf die platte schreiben - ENDE
rssread.free;

if assigned(edwebsite) then EdWebsite.Free;
if assigned(WebintLabel) then WebIntLabel.free;
if assigned(grad2) then begin grad2.Free; grad2:= nil; end;
if assigned(title2) then begin title2.Free; title2:= nil; end;
end;

procedure THauptfenster.ClearRasEntry;
begin
SetDialParams(''{user},''{password},'0'{number}); //W�hlstring
end;

procedure StartDial;
begin
with hauptfenster do
begin
  Cursor:= crHourglass;

  //schreiben der Verbindung (wichtig f�r Multilink);
 SetDialParams(hauptfenster.liste.Cells[9,hauptfenster.liste.row], //user
                hauptfenster.liste.Cells[10,hauptfenster.liste.row], // password
                hauptfenster.liste.Cells[8,hauptfenster.liste.row] //number
              );


   MagRasCon.EntryName:= 'LeastCosterXP';
   MagRasCon.GetEntryProps(true);
   //setzen der Paramter f�r die Verbindung (f�r RasDial)
  // MagRasCon.PhoneNumber :='' ;  // use the one in the phonebook

   MagRasCon.PhoneNumber := Modemstring+hauptfenster.liste.Cells[8,hauptfenster.liste.row] ;

   //setzen von username und passwort
   MagRasCon.UserName:= hauptfenster.liste.Cells[9,hauptfenster.liste.row];
   MagRasCon.Password:= hauptfenster.liste.Cells[10,hauptfenster.liste.row];

   // start connection (sets handle)
    DialHandle := 0 ;

  if allow_multilink then
  begin
  if setmultilink.checked then //wenn Kanalbuendelung
  begin
   onlineset.kosten:= onlineset.einwahl/100; //Einwahl 1x mehr berechnen
   MagRasCon.SubEntry:= 0;
  end
  else
   MagRasCon.SubEntry:= 1
  end
  else //wenn Mulitlink verboten
   MagRasCon.SubEntry:= 0;

  if MagRasCon.AutoConnectEx(DialHandle) <> 0 then
    begin //W�hlen war nicht erfolgreich
     DialStatus.text:= misc(M51,'M51');

     if DialHandle <> 0 then RasHangUp(DialHandle);
     ConnHandle:= 0; DialHandle:= 0;
     ClearRasEntry;
     dialing:= false;
     Cursor := crDefault;
     Dialbtn.caption:= misc(M24,'M24');

     if (AutoDialLed.ledon) then
      begin
       Autodial.Enabled:= true;
       status.simpletext:= misc(M25,'M25')+' ('+Datetimetostr(now)+')';
      end
      else status.simpletext:= misc(M52,'M52')+' ('+Datetimetostr(now)+')';

     aktualisierenclick(nil);
     exit;
    end;

  //w�hlen war erfolgreich
   DialBtn.caption:=misc(M53,'M53'); surfdauer.enabled:= false;
   end;
end;

function THauptfenster.StringVonMorgen(date: TDate): string;
var heute: word;
begin
 heute := DayoftheWeek(date);

 heute:= heute +1;
 if heute = 8 then heute:= 1;

 if isFeiertag(tomorrow) <> '' then Result:= '[feiertags]'
 else
 case heute of
 1:Result:= '[Mo]';
 2:Result:= '[Di]';
 3:Result:= '[Mi]';
 4:Result:= '[Do]';
 5:Result:= '[Fr]';
 6:Result:= '[Sa]';
 7:Result:= '[So]';
 end;
end;

procedure THauptfenster.DialBtnClick(Sender: TObject);
var buf: string;
    foundRasConn: boolean;
begin
if isonline then
  begin  // schon online
   status.SimpleText:=misc(M54,'M54')+' ' + verbindungsname+ ' '+misc(M55,'M55');
   Disconnecting:= true;
   disconnect;
   ForceDial.Checked:= false;
  end
else
 begin //offline
   reload.enabled:= false;   //reloaden disablen
   status.simpletext:= misc(M56,'M56');
   save_cfg;

   //RasVerbindung suchen und erstellen
   foundRasConn := FindRasConnection;
   if not FoundRasConn then CreateRAS;

    //selbst gew�hlte Verbindung w�hrend des Anw�hlens trennen
   if (dialbtn.Caption = misc(M53,'M53')) then
     begin if DialHandle <> 0 then RasHangUp(DialHandle); ClearRasEntry;  dialing:= false; Hauptfenster.Cursor := crDefault; ForceDial.Checked:= false; exit; end;

   if beliebig_check.Checked then
      begin
        if not webzugriff then
          status.simpletext:= misc(M57,'M57');
        exit;
      end;

   try
     if secondsbetween(timeofliste, now) > 60 then
      begin
        if not webzugriff then
           status.simpletext:= misc(M58,'M58');
        AktualisierenClick(nil);
        exit;
      end;

      if ((liste.Cells[1,liste.row] = '') and (liste.Cells[2,liste.row]='') and (liste.rowcount=2)) then
        begin
          status.simpletext:= misc(M59,'M59');
          exit;
        end;


      if (sender <> Dialbtn ) and (strtodate(liste.cells[13,liste.row]) < dateof(now)) then
       begin
         if not webzugriff then  status.simpletext:= misc(M60,'M60')+liste.cells[13,liste.row]+' '+ misc(M61,'M61');
         exit;
       end;

    except
      if not webzugriff then  status.simpletext:=misc(M62,'M62');
      exit;
    end;

    if liste.Cells[7,liste.row] = 'Blacklist' then
     begin
       if not webzugriff then status.simpletext:= misc(M63,'M63');
       exit;
     end;

    if ((modemname = '') or (modemtype='')) then
     begin
       status.simpletext:=  misc(M64,'M64');
       exit;
     end;

 //Autodial enabled ? erstmal abschalten
 if autodial.enabled then begin Autodial.Tag:= 10; autodial.interval:= settings.Readinteger('AutoConnect','Interval', 60)*1000; autodial.enabled:= false; AutoDialLEd.ledon:= false; end;

 //~~~~~~~~~~~~Fehler sind hier abgearbeitet~~~~~~~~~~~~~~~~~~

 //ScoreWert erh�hen (DialAll)
  if IndexOfScores(liste.Cells[1,liste.row])>-1 then
    inc(Scores[IndexOfScores(liste.Cells[1,liste.row])].gesamt);

  Kontingente_Laden;

  kanalbuendelung         := false; //Standardwert
  selfdial                := true; //LeastCoster ist der Dialer, das soll er auch wissen
  aktualisieren.enabled   := false;
  status.SimpleText       := misc(M65,'M65');
  dialing                 := true;

  //Datensatz in den Speicher �bernehmen
  onlineset.Datum         := now;
  onlineset.Tarif         := liste.Cells[1,liste.row];
  onlineset.Rufnummer     := liste.Cells[8,liste.row];
  onlineset.Preis         := StrToFloat(liste.Cells[4,liste.row]);
  onlineset.Einwahl       := StrToFloat(liste.Cells[5,liste.row]);
  onlineset.einwahl2      := onlineset.einwahl;
  onlineset.mindestumsatz := strtofloat(liste.cells[18,liste.row]);
  onlineset.kosten_mindest:= 0.0;
  onlineset.tag           := liste.Cells[17,liste.row];
  onlineset.vbegin        := StrToTime(liste.Cells[2,liste.row]);
  onlineset.vend          := StrToTime(liste.Cells[3,liste.row]);
  onlineset.webseite      := liste.Cells[11,liste.row];
  onlineset.kosten        := 0;
  onlineset.wechsel       := incday(now, 10*365);

  TaktToInteger(liste.Cells[6,liste.row],onlineset.Takt_a,onlineset.Takt_b);
  TaktLaenge   := onlineset.takt_a;

  //Logfile schreiben
  buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+misc(M67,'M67')+' ' + onlineset.Tarif +
              #9+  'LeastCosterXP - Server'   +#13#10;
  webserv1.status:= buf;
  webservform.logfile_add(buf);

 //Leerlaufinterval setzen
 AutoLeerlaufLed.LedOn   := leerlaufdisconnect.Enabled;
 leerlaufboxask.Checked  := leerlaufdisconnect.Ask;
 leertime.Value          := leerlaufdisconnectzeit;
 leerlauf.Interval       := leerlaufdisconnectzeit *60 * 1000;

  //Ausschalten bei Automatischem Trennen
  AutoAus.ItemIndex      := AutoAusIndex;

 //AutoConnect setzen
  AutoDialEinwahl.checked:= settings.Readbool('AutoConnect','mitEinwahl',false);
  AutoBase.Position      := Autosurfdauer;
  Autodiscled.ledon      := AutoDisconnect.Enabled;
  trennask.checked       := AutoDisconnect.Ask;

 //Autotrennen setzen
  //wenn Ende > als Beginn oder ende ist noch in der Zukunft
  if ( (Dateof(now) + Timeof(onlineset.vend)) > (Dateof(now) + timeof(onlineset.vbegin)))
     or
     ( (Dateof(now) + timeof(onlineset.vend)) > now )
  then
    trennticker.DateTime:= Dateof(now) + Timeof(onlineset.vend)
  else //wenn ende < beginn
  if (Dateof(now) + Timeof(onlineset.vend)) < (Dateof(now) + TimeOf(onlineset.vbegin)) then
  begin //auf morgen setzen
    trennticker.DateTime:= Dateof(incday(now,1)) + Timeof(onlineset.vend);
    // ... und schauen ob morgen noch g�ltig, wenn nicht, dann 00:00:00 beenden
    if (Ansicontainstext(liste.cells[17,liste.row],StringvonMorgen(now)) = false) then
          //auf n�chstes 0h setzen
          trennticker.DateTime:= incday(dateof(now) + timeof(EncodeTime(0,0,0,0)),1);
  end
  else //wenn ende = beginn (ganztags)
  if (Dateof(now) + Timeof(onlineset.vend)) = (Dateof(now) + Timeof(onlineset.vbegin)) then
  begin
    //wenn morgen nicht mehr g�ltig, dann 0h trennen
    if Ansicontainstext(liste.cells[17,liste.row],StringvonMorgen(now)) = false then
       trennticker.DateTime:= incday(dateof(now) + timeof(EncodeTime(0,0,0,0)),1)
    else
    Autodiscled.ledon:= false; //gilt noch morgen
  end;

  StartDial; // w�hlen geht hier los

end;
end;

procedure THauptfenster.surfdauerChange(Sender: TObject);
begin
str(surfdauer.Position mod 60, zeit_min);
str(surfdauer.Position div 60, zeit_std);

label3.Caption:= '( ' + zeit_std + ' h ' + zeit_min + ' min )';
label3.Refresh;

//beim ersten change nciht aktuelaisieren, weil Programm gerade gestartet
if startcount = 0 then exit;

//timer stoppen und starten
aktualisieren_timer.Enabled:= false;
aktualisieren_timer.Enabled:= true;

end;

procedure THauptfenster.AktualisierenClick(Sender: TObject);
var i: integer;
    found: boolean;
begin
found:= false;
if dialing then exit;

if not isonline then begin reload.enabled:= false; reload.enabled:= true; end;

if not beliebig_check.checked then
begin
 liste.tag:= 7;
 sort_descending:= false;
end;

tarifverw.loadlist;

if beliebig_check.checked then
begin
 GridSort(liste, Tarifprogress, 1,liste.RowCount-1, 7, 7, false);
 liste.Row:=1;
 listeclick(self);
end;
//tarif ausw�hlen
if onlineset.tarif <> '' then
begin
  for i:= 0 to liste.rowcount-1 do
   if liste.cells[1,i] = onlineset.tarif then
    begin
     liste.row:= i;
     found:= true;
     break;
    end;

 if (not found) and ForceDial.Checked
    then ForceDial.Checked:= false;   
end;

liste.Repaint;
end;

Procedure THauptfenster.SendMail(Subject,Mailtext,
                   FromName,FromAdress,
                   ToName,ToAdress,
                   AttachedFileName,
                   DisplayFileName:string;
                   ShowDialog:boolean);
var
  MapiMessage : TMapiMessage;
  MError      : Cardinal;
  Empfaenger  : Array[0..1] of TMapiRecipDesc;
  Absender    : TMapiRecipDesc;
  Datei       : Array[0..1] of TMapiFileDesc;
begin
  with MapiMessage do begin
    ulReserved := 0;

    lpszSubject        := PChar(Subject);     // Betreff
    lpszNoteText       := PChar(Mailtext);     // Body
    lpszMessageType    := nil;
    lpszDateReceived   := nil;
    lpszConversationID := nil;
    flFlags            := 0;

    // Absender festlegen
    Absender.ulReserved       := 0;
    Absender.ulRecipClass     := MAPI_ORIG;
    Absender.lpszName         := PChar(FromName);
    Absender.lpszAddress      := PChar(FromAdress);
    Absender.ulEIDSize        := 0;
    Absender.lpEntryID        := nil;
    lpOriginator              := @Absender;

    // Empf�nger festlegen (Hier: nur 1 Empf�nger)
    nRecipCount               := 1;

    Empfaenger[0].ulReserved  := 0;
    Empfaenger[0].ulRecipClass:= MAPI_TO;
    Empfaenger[0].lpszName    := PChar(ToName);
    Empfaenger[0].lpszAddress := PChar(ToAdress);
    Empfaenger[0].ulEIDSize   := 0;
    Empfaenger[0].lpEntryID   := nil;
    lpRecips                  := @Empfaenger;

    // Dateien anh�ngen (Hier: nur 1 Datei)
    if AttachedFileName = '' then nFileCount := 0
    else
    begin
     nFileCount           := 1;
     Datei[0].lpszPathName:= PChar(AttachedFilename);     // Name der Datei auf der Festplatte
     Datei[0].lpszFileName:= PChar(DisplayFilename);      // Name, der in der Email angezeigt wird
     Datei[0].ulReserved  := 0;
     Datei[0].flFlags     := 0;
     Datei[0].nPosition   := Cardinal(-1);
     Datei[0].lpFileType  := nil;
     lpFiles              := @Datei;
    end;
  end;

  // Senden
  if ShowDialog then
    MError := MapiSendMail(0, Application.Handle,
      MapiMessage, MAPI_DIALOG or MAPI_LOGON_UI, 0)
  else
   // Wenn kein Dialogfeld angezeigt werden soll:
    MError := MapiSendMail(0, Application.Handle, MapiMessage, 0, 0);

  Case MError of
    MAPI_E_AMBIGUOUS_RECIPIENT    : MessageDlg(misc(M70,'M70'),mterror,[mbok],0);
    MAPI_E_ATTACHMENT_NOT_FOUND   : MessageDlg(misc(M71,'M71'),mterror,[mbok],0);
    MAPI_E_ATTACHMENT_OPEN_FAILURE: MessageDlg(misc(M72,'M72'),mterror,[mbok],0);
    MAPI_E_BAD_RECIPTYPE          : MessageDlg(misc(M73,'M73'),mterror,[mbok],0);
    MAPI_E_FAILURE                : MessageDlg(misc(M74,'M74'),mterror,[mbok],0);
    MAPI_E_INSUFFICIENT_MEMORY    : MessageDlg(misc(M75,'M75'),mterror,[mbok],0);
    MAPI_E_LOGIN_FAILURE          : MessageDlg(misc(M76,'M76'),mterror,[mbok],0);
    MAPI_E_TEXT_TOO_LARGE         : MessageDlg(misc(M77,'M77'),mterror,[mbok],0);
    MAPI_E_USER_ABORT             : MessageDlg(misc(M78,'M78'),mterror,[mbok],0);
  End;
end; {Christian "NineBerry" Schwarz}

procedure THauptfenster.disconnectviatrennticker;
var buf: string;
begin
      Autodiscled.ledon:= false;
      disconnect;

      if not noballoon then tray.ShowBalloonHint(misc(M01,'M01'),misc(M79,'M79'),bitInfo, 10);

      Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9 +misc(M80,'M80')+#13#10;
      webserv1.status:= buf;
      webservform.logfile_add(buf);

      //Computer ausschalten wenn gew�nscht
      if ((autoaus.itemindex > 0) and (not assigned(shutter))) then
      begin
       Application.CreateForm(Tshutter, shutter);

       case Autoaus.ItemIndex of
            1: shutter.art:= 'logoff';
            2: shutter.art:= 'poweroff';
            3: shutter.art:= 'restart';
            4: shutter.art:= 'ruhezustand';
            5: shutter.art:= 'standby';
       end;
       autoaus.ItemIndex:= 0;
       shutter.show;
      end;
end;

procedure THauptfenster.OnConnect;
var buf: string;
    i: integer;
begin
   hauptfenster.cursor := crDefault;

   timerstarted:= false;

   ScoreTimer.enabled:= true;

   onlineset.dauer_takt:= 0;
   if taktlaenge > 0 then
   begin
      takt1.max:= taktlaenge;
      takt2.max:= taktlaenge;
      takt1.tag:= taktlaenge;
      takt2.tag:= 0;
      takt1.Visible:= not beliebig_check.checked;
      takt2.Visible:= not beliebig_check.checked;
   end
   else
   begin
      takt1.Visible:= false;
      takt2.Visible:= false;
   end;


   onlinetime_start:= gettickcount;
   onlinetime_starttime:= now; //als Referenzpunkt

   //Autotrennen wieder erm�glichen
   DisconnectStopped:= false;

   kontingentindex:= -1;
   if selfdial then //Kontingente
     begin
        onlineset.kosten:= onlineset.einwahl2/100;                         //einwahlgeb�hr addieren
        onlineset.kosten:= onlineset.kosten + onlineset.mindestumsatz/100; //mindestumsatz in � addieren

        if length(Kontingente) > 0 then
             for i:= 0 to (length(Kontingente)-1) do
                if kontingente[i].Tarif = onlineset.tarif then
                   begin
                    kontingentindex:= i;
                    break;
                   end;

        oCostlabel.Visible:= true;
    end
    else Dialstatus.text:= misc(M81,'M81');

    isonline:= true;
    AutoDialLed.ledon:= settings.Readbool('AutoConnect','AutoReConnect',false); //Wiedereinwahl setzen
    Aktualisieren.Enabled:= false;

   //Ausblenden der OfflineElemente und Einblenden des online-Mode
    modes.setOnlinemode;
    TrayDisconnect.Visible:= true;
    DialBtn.Font.Color     := clRed;
    DialBtn.Font.Size      := 8;
    DialBtn.caption        := misc(M82,'M82');
    Tray.IconIndex:=1; //Online-Tray-Symbol setzen

    //Men� >Tools > Online
    hauptfenster.MM2_3.Enabled:= true;

    //Onlineinfo zeigen
    if selfdial and settings.readbool('Onlineinfo','show', true )
                and (not Assigned(floatingW))
       then
         begin
             Application.CreateForm(TfloatingW, floatingW);
             floatingW.tarif.caption:= onlineset.Tarif;//edtarif.text;
             if settings.ReadBool('OnlineInfo', 'AutoWidth', true) then floatingW.setwidth;
             floatingW.valid.caption:= TimeToStr(onlineset.vbegin) + '-'+ TimeToStr(onlineset.vend);
             floatingW.preis.caption:= Format('%.2f  '+ misc(M12,'M12') +'/min',[onlineset.preis]);
             floatingW.Show;
        end;
    //Logfile schreiben
    buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+ misc(M83,'M83')+ ' ' + MagRasCon.CurConnName +' (detection)'+#13#10;
    webserv1.status:= buf;
    webservform.logfile_add(buf);

    loadprogs;             //Programme starten

    reload.enabled:= true; //aktualisieren der tariftabelle wieder aktivieren

   //Sound
    if fileexists(settings.readstring('LeastCoster','SoundON',  '' ))
      then sndPlaySound(PChar(settings.readstring('LeastCoster','SoundON',  '' )),SND_ASYNC);

    if settings.Readbool('lokale IP','IP_Notify',false) then ipemail.Enabled:= true;

   //~~~~~~~~~~~~~~~~~ SPEED
   // W2K/XP keep handle and subentry for perf stats - base 1
    if MagRasOSVersion >= OSW2K then
      begin
        MagRasPer.ResetPerfStats ;		// clear stats
        MagRasPer.PerfRasConn [1] := DialHandle ;
        LastXmit                  := MagRasPer.PerfXmitCur [0] ;
        LastRecv                  := MagRasPer.PerfRecvCur [0] ;
      end;

      LastTime := GetTickCount ;
      //verstecken, wenn online
      if settings.readbool('Dialer','Tray',false) and selfdial then MM1_9.Click;
      dialing:= false;
      aktualisieren.click;
      refreshall;
      oldtime:= now;
end;

procedure THauptfenster.OnDisconnect;
var buf: string;
begin
         //wenn noch am Wahlen, dann kurz warten
         if dialing then begin WaitOnDisconnect.enabled:= true; exit; end;

          ConnHandle         := 0;
          DialHandle         := 0;
          disconnectStopped  := false;
          actofftime         := now;
          onlineset.Endzeit  := timeof(now);

          isonline           := false;
          leerlauf.enabled   := false;

          takt1.Visible      := false;
          takt2.Visible      := false;

          takt1.tag          := 0;
          takt1.tag          := 0;

          rsstimer.enabled   :=false;

          if (allow_multilink and (modemname2<>'')) then
           SetMultilink.Visible:= true else SetMultilink.Visible:= false;

          modes.setOfflineMode;
    

          StatLED1.LEDon     := false;
          StatLED2.LEDon     := false;

          actofftime         := Timeof(now);
          status.SimpleText  := misc(M84,'M84')+': ' + ozeit.Caption;
          ozeit.caption      :='';

          TrayDisconnect.Visible  := false;
          Aktualisieren.Enabled   := true;
          AktualisierenClick(nil);
          Disconnecting           := false;
          Dialbtn.Font.Color      := clWindowText;
          Dialbtn.Font.Size       := 8;
          DialBtn.caption         := misc(M24,'M24');
          Tray.IconIndex          := 0; //setzen des Offline-Tray-Icons

           sntptimer.enabled               := false;  // Atimzeitupdate

          if selfdial then closer.Interval:= 500      //Autoexport und updaten
                      else closer.Interval:= 10000;
          closer.Enabled                  :=true;

          if Assigned(floatingW) then floatingW.close;

          // OfflineElemente sichtbar machen
          surfdauer.enabled               := true;
          Dialbtn.enabled                 := true;

          //Logfile schreiben
          Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+misc(M85,'M85')+#13#10;
          webserv1.status:= buf;
          webservform.logfile_add(buf);

         // Programme bei offline starten
          progcountoff:=0; loadprogsoff;
          webzugriff:= false;

          OCostlabel.Visible:= false;

          //Men� >Tools > Online
//          if isDSLOnline = false then
          hauptfenster.MM2_3.Enabled:= false;

          DialStatus.Text:= misc(M85,'M85') + ' ('+timetostr(timeof(now))+')';
          reload.enabled:= true;

          refreshall;

          //Sound
          if fileexists(settings.readstring('LeastCoster','SoundOFF',  '' )) then
              sndPlaySound(PChar(settings.readstring('LeastCoster','SoundOFF',  '' )),SND_ASYNC);

          ClearRasEntry;
          rssrunning:= false;

          //AutoDial anschalten, wenn offline
          if (AutoDialLed.ledon) then
          begin
            //feststellen, wie lange bis zum n�chsten Zeitfenster
            Autodial.tag:= disconnectseconds + 1; //Sekunden, die vor Zeitfensterende getrennt wurde
            if autodial.tag < 10 then autodial.tag:= 10;
            Autodialtimer(self); //Countdown starten
          end;

          kontingenteWarned:= false;
          Kanalbuendelung:= false;

          Tray.Hint:= 'LeastCosterXP' + #13#10+
                      misc(M49,'M49')+ ': ' + timetostr(settings.ReadTime('Tageskosten','Zeit',Encodetime(0,0,0,0))) + #13#10+
                      misc(M50,'M50')+ ': ' + format('%3m',[settings.ReadFloat('Tageskosten','Kosten',0)]) + #13#10+
                      misc(M28,'M28')+ ': ' + Inttostr(settings.ReadInteger('Tageskosten','Verbindungen',0)) + #13#10+
                      misc(M12,'M12')+'/min :' + format('%1.3f',[settings.ReadFloat('Tageskosten','Mittelwert',0)*100]);


          Hauptfenster.Cursor:= crDefault;
          aktualisieren.click;
          refreshall;
end;

procedure THauptfenster.Aktualisieren_timerTimer(Sender: TObject);
begin
aktualisieren_timer.enabled:= false;
aktualisieren_timer.Interval:= 500;

AktualisierenClick(Self);
end;

procedure THauptfenster.refreshall;
begin
hauptfenster.refresh;
liste.refresh;
trennask.refresh;
trennticker.refresh;
online.refresh;
label1.refresh;
if assigned(WebintLabel) then WebIntLabel.refresh;
label3.refresh;
datelabel.refresh;
edtarif.refresh;
edtime.refresh;
edwebsite.refresh;
costs.refresh;
ednumber.refresh;
surfdauer.refresh;
ozeit.refresh;
online.refresh;
dialstatus.refresh;
ocostlabel.refresh;
beliebig_time.refresh;
beliebig_date.refresh;
beliebig_check.refresh;
bevel1.refresh;
end;

procedure THauptfenster.FormActivate(Sender: TObject);
begin

refreshall;
if clock.visible then time.enabled:= true;

if assigned(floatingw) then
 SetWindowPos(floatingw.Handle,
             hauptfenster.handle,
             floatingw.Left, floatingw.Top, floatingw.Width,floatingw.Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

if firststart then
begin
  settings.WriteDate('LeastCoster','Donation', incday(Dateof(now),7));
  firststartcheck.enabled:= true;
  firststart:= false;
  exit;
end;

if startcount > 0 then
  if not isonline then aktualisierenclick(self);

if startcount > 1 then exit;
inc(startcount);
if startcount= 1 then // beim ersten Aktivieren des Mainforms
begin

  //wenn der Wert nicht existiert
  if settings.ReadDate('LeastCoster','Donation', incday(Dateof(now),+1000)) = incday(Dateof(now),+1000)
   then settings.WriteDate('LeastCoster','Donation', incday(Dateof(now),7));

  if settings.ReadDate('LeastCoster','Donation', incday(Dateof(now),+1000)) < Dateof(now)
    then DonateWindow.show;         

  //schauen ob ein parameter �bergeben wurde
  If (ParamCount>0) and (FileExists(ParamStr(1)))
    then
    begin
      if ansicontainstext(paramstr(1),'.lcx') then
      begin
        importfilename:=paramstr(1);
        startwithimport:= true;
        hauptfenster.MainMenueClick(Hauptfenster.MM1_1);
      end
      else showmessage(paramstr(1) +' '+misc(M86,'M86'));
    end;
end;
end;

procedure THauptfenster.beliebig_check1Click(Sender: TObject);
begin
if beliebig_check.checked then
begin
 beliebig_date.Datetime:= now;
 beliebig_time.datetime:= now;
end
else aktualisieren.tag:= -1;

 beliebig_date.visible:= beliebig_check.checked;
 beliebig_time.visible:= beliebig_check.checked;

 if isonline then
 begin
  takt1.Visible:= not beliebig_check.checked;
  takt2.Visible:= not beliebig_check.checked;
 end;

 aktualisierenClick(Self);
end;

procedure THauptfenster.beliebig_timeChange(Sender: TObject);
var lasth: integer;
begin
lasth:= beliebig_time.tag;
beliebig_time.tag:= hourof(beliebig_time.time);

if (lasth = 23) and (hourof(beliebig_time.time)=0) then
   beliebig_date.date:= incday(beliebig_date.date,1)
else
if (lasth = 0) and (hourof(beliebig_time.time)=23) then
   beliebig_date.date:= incday(beliebig_date.date,-1);

aktualisierenClick(Self);
end;

procedure THauptfenster.ReloadTimer(Sender: TObject);
begin
reload.interval:= 60000;
if webzugriff then begin reload.enabled:= false; exit; end;
aktualisierenclick(self);
end;

procedure THauptfenster.RsstimerTimer(Sender: TObject);
begin
rsstimer.enabled:= false;
if not nofeeds then
begin
//if isonline and not rssrunning
if not rssrunning then
     RssReader.StartRssUpdate;
//    else
//      if not isonline then
//      begin
//        ledrss.coloroff := clMaroon;
//        ledtimer.enabled:= false;
//        LEDRSS.Hint     := misc(M87,'M87')+' ( ' + timetostr(timeof(now)) + ' )';
//      end;

if rss_update > 0 then
  begin
   rsstimer.interval := rss_update * 60*1000;
   rsstimer.enabled  := true;
  end;
end;
end;

procedure THauptfenster.FormHide(Sender: TObject);
begin
  beliebig_check.checked:= false; //normale anzeige einschalten und Tabelle aktualisieren
  aktualisieren.click;
end;

procedure THauptfenster.ApplicationEvents1ShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
if msg.charcode = 112 then MainMenueClick(MM5_2)
else
if msg.charcode = 17 then
begin
     if ctrlcount = 0 then
     begin
      ctrl_start:= GetTickCount;
      ctrltimer.enabled:= true;
     end;
     ctrl_last:= gettickcount;
     ctrl_delay:= 1000;
     ctrlcount:= ctrlcount+1;
     ctrltimer.enabled:= false;
     ctrltimer.enabled:= true;
     //CTRL-Info �ffnen wenn ctrl lange genug gedr�ckt war und liste keinen Fokus hat
     if (((gettickcount - ctrl_start) > ctrl_delay) and (not liste.focused ))then
           if not assigned(Ctrlnfo) then
           begin
               Application.CreateForm(TCtrlnfo, Ctrlnfo);
               ctrlnfo.visible:= true;
               Ctrlnfo.show;
           end;
end;
end;

procedure THauptfenster.FormShow(Sender: TObject);
begin
  formhidden:= false;

  if assigned(Floatingw) then
   SetForegroundWindow(floatingw.handle);

  SetForegroundWindow(handle);
  SetActiveWindow(handle);
end;

procedure THauptfenster.TrayBalloonHintTimeout(Sender: TObject);
begin
  tray.hideBalloonHint;
end;

procedure THauptfenster.TrayBalloonHintShow(Sender: TObject);
begin
  hinttimer.enabled:= false;
  hinttimer.enabled:= true;
end;

procedure THauptfenster.LEDTimerTimer(Sender: TObject);
begin
 if isonline then
 begin
  LEDRSS.LEDon:= not LEDRSS.LEDon;
  if settings.ReadBool('Onlinecheck','Atomzeit', false) and timeupdaterunning then LEDTime.LEDon:= not LEDTime.LedOn;
 end;
end;

procedure THauptfenster.ListeKeyPress(Sender: TObject; var Key: Char);
begin
 if ((not isonline) and (key=#13)) then dialbtnclick(self);
end;

procedure THauptfenster.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
if(keypressed(vk_CONTROL) and (msg.charcode=66) ) then shellexecute(0,'open',PChar('http://www.google.de'),nil, nil,SW_SHOWNORMAL);
if ( (msg.charcode <> 17) ) then
   begin
      ctrlcount:=0;
      if assigned(ctrlnfo) then ctrlnfo.close;
   end;
end;

procedure THauptfenster.ctrltimerTimer(Sender: TObject);
begin
ctrltimer.enabled:= false;
ctrlcount:=0;
end;

procedure THauptfenster.LedRSSMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
with sender as TAMAdvLED do borderstyle:= brlowered;
end;

procedure THauptfenster.LedRSSMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
with sender as TAMAdvLED do borderstyle:= brraised;

if sender = LEDTime then MainMenueClick(MM2_3_2);

if sender = LEDRSS then
   if isonline and not rssrunning then MainMenueClick(MM2_3_3);
end;

procedure THauptfenster.leerlaufTimer(Sender: TObject);
begin
leerlauf.enabled:= false;
if isonline then
begin
 //Sound
 if (settings.readbool('Leerlauf','PlaySound', false) and fileexists(settings.readString('Leerlauf','Sound', '')))
    then sndPlaySound(PChar(settings.readString('Leerlauf','Sound', '')),SND_ASYNC);

 //Trennen
 if AutoLeerlaufLed.LedOn then
   if leerlaufboxask.checked then
   begin
     if not assigned(disconnect_leerlauf) then
     begin
      Application.CreateForm(Tdisconnect_leerlauf, disconnect_leerlauf);
      if leerlaufdisconnect.UseDelay then
       begin
       disconnect_leerlauf.usetimer:= true;
       disconnect_leerlauf.timer1.tag:= leerlaufdisconnect.Delay;
       end;
      disconnect_leerlauf.label1.caption:= misc(M88,'M88');
      disconnect_leerlauf.grad.endcolor:= $006FEE7E;{gr�n}
      disconnect_leerlauf.Show;
     end;
   end
   else disconnectviatrennticker;
end;
end;

procedure THauptfenster.LeertimeChange(Sender: TObject);
begin
  leerlauf.enabled:= false;
  leerlauf.interval:= leertime.value * 1000 * 60;
end;

procedure THauptfenster.warnung_unterdrueckenTimer(Sender: TObject);
begin
 warnung_unterdruecken.enabled:= false;
 hauptfenster.warnung_gezeigt:= false;
end;

procedure THauptfenster.AutoDialLEDMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
with sender as TAMAdvLed do
 begin
     borderStyle:= brRaised;
     LEDon:= not ledon;
 end;
end;

procedure THauptfenster.AutoDialLEDLedStateChanged(Sender: TObject;
  LedOn: Boolean; NumSwitch: Integer);
begin
with sender as TAMAdvLED do
  if ledon then hint:= misc(M89,'M89') else hint:= misc(M90,'M90');
end;

procedure THauptfenster.AutoDialer;
var i: word;
    error: boolean;
begin
error:= false;
Autodial.enabled:= false;

 reload.enabled:= false;

 if not isonline and not dialing then
   if (AutoDialLED.ledon = true) then
   begin
    surfdauer.position:= Autosurfdauer;
    surfdauerchange(self);
    //wenn Einwahlgeb�hr ber�cksichtigen, dann immer den ersten Eintrag w�hlen
    if AutoDialEinwahl.checked then i:= 1 else
    begin
     for i:= 1 to liste.rowcount-1 do
      if liste.cells[5,i] <> '' then
       if (strtofloat(liste.cells[5,i]) <> 0. ) then
       begin
        if (i = liste.rowcount-1) then error:=true;
       end else break;
    end;

    if error then i:= 0;

    if ((liste.cells[5,i] <> '') and (i> 0)) then
    begin
    liste.row:= i;
    Dialbtnclick(self);
    end
    else
    begin
         DialStatus.text:= misc(M25,'M25');
         Status.simpletext:= misc(M25,'M25') +' ('+datetimetostr(now)+')';
         Autodial.interval:= settings.Readinteger('AutoConnect','Interval', 60) * 1000;//60000;
         autodial.tag:= 10; //10 Sekunden Countdown
         AutoDial.enabled:= true;
    end;     
   end;
end;

procedure THauptfenster.AutodialTimer(Sender: TObject);
begin
 autodial.enabled:= false;
 autodial.interval:= settings.Readinteger('AutoConnect','Interval', 60) *1000; //60000; //einmal die minute reicht zu
  if not assigned(disconnect_leerlauf) then
    begin
     Application.CreateForm(Tdisconnect_leerlauf, disconnect_leerlauf);
     disconnect_leerlauf.Tag:= 2;
     disconnect_leerlauf.useConnectTimeOut:= true;
     disconnect_leerlauf.ConnectTimer.tag:= AutoDial.tag;
     disconnect_leerlauf.Label1.Caption:= misc(M91,'M91');
     disconnect_leerlauf.Label3.Caption:= misc(M92,'M92');
     disconnect_leerlauf.Label2.Caption:= inttostr(Autodial.tag) + ' '+misc(M93,'M93');
     disconnect_leerlauf.trennen.visible:= false;
     disconnect_leerlauf.grad.endcolor:= $0081E6EB; {gelb}//$009191DB; {rot}//$006FEE7E;{gr�n}
     disconnect_leerlauf.Show;
     end;
end;

procedure THauptfenster.ApplicationEvents1Activate(Sender: TObject);
begin
  if not isonline and not dialing then Aktualisierenclick(self);
  time.enabled:= clock.visible;
end;

procedure THauptfenster.AutoBaseChange(Sender: TObject);
var min, std: string;
begin
  str(AutoBase.Position mod 60, min);
  str(AutoBase.Position div 60, std);
  AutoBasis.Caption:= std + ' h ' + min + ' min';
end;

procedure THauptfenster.ipemailTimer(Sender: TObject);
var ToName, ToAdress, messagetext, port: String;
begin
ipemail.enabled:= false;
if (    (settings.Readstring('lokale IP','IP_Notify_Name','') <> '')
    and isonline
    and (settings.ReadString('lokale IP','IP_Notify_Adress','') <> '')) then
begin
toname:= settings.ReadString('lokale IP','IP_Notify_Adress','');
toadress:= settings.Readstring('lokale IP','IP_Notify_Name','');

port:= webservform.HttpServer1.Port;

if (webservform.HttpServer1.tag = 5) then //WebInterface l�uft
begin
messagetext:= misc(M94,'M94')+' : ' + ipAdress
              + #13#10#13#10
              + misc(M96,'M96')+': http://' +ipAdress+':'+port
              + #13#10#13#10
              + '---------------------------------------'
              + #13#10#13#10
             +misc(m95,'M95');
end
else //WebInterface l�uft nicht
begin
messagetext:= misc(M94,'M94')+' : ' + ipAdress
              + #13#10#13#10
              + '---------------------------------------'
              + #13#10#13#10
              +misc(m95,'M95');
end;
SendMail('LeastCosterXP Message' + datetimetostr(now),
           messagetext,
           '','', //FromName,FromAdress,
           ToAdress,ToAdress, //ToName, ToAdress
           '',//AttachedFileName,
           '',//DisplayFileName:string;
           false//ShowDialog:boolean
           );
end;
end;

procedure THauptfenster.CheckForUpdates;
begin
  hauptfenster.Cursor:= crHourglass;

  Hauptfenster.Cursor:= crDefault;
end;


procedure DrawColoredRect(var liste: TStringGrid; Rect: TRect; Acol, Arow: integer; color: string);
begin
  if ((color = '') or (color = 'none')) then exit;

  Liste.Canvas.Brush.Color := StringToColor(color);
  Liste.Canvas.FillRect(Rect);
  Liste.Canvas.TextOut(Rect.Left+2, Rect.Top+2, Liste.Cells[Acol, Arow]);
end;

procedure THauptfenster.ListeDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var kosten: real;
    kostenstring: string;
    l: integer;
begin
kosten:= 0.0;
liste.canvas.font.color:= clBlack;
if arow > 0 then
begin
  kostenstring:= liste.cells[7,arow];
  if not ansicontainsstr(kostenstring,misc(M98,'M98')) and not ansicontainsstr(kostenstring, 'Blacklist') then
   if (kostenstring <> '') then
    kosten := strtofloat(kostenstring);
end;


//wenn selektiert, dann highlighten
//showmessage(inttostr(length(selected)));
with liste do
if (arow > 0) and selected[arow] then
  begin
     Canvas.Brush.Color := clHighlight;//RGB(250,250,250);
     Canvas.FillRect(Rect);
     Canvas.Font.Color := clHighlightText;
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
  end
else
if (useColors and ( arow >0 )) then
begin
  if liste.cells[7,arow] = misc(M98,'M98') //abgelaufen
    then DrawColoredRect(liste,Rect,Acol, Arow,settings.ReadString('Basics','Color_A', ColortoString(RGB(255,220,220))))
  else
  if (liste.cells[7,arow] = 'Blacklist')
    then DrawColoredRect(liste,Rect,Acol, Arow,settings.ReadString('Basics','Color_K', ColortoString(RGB(255,220,200))))
  else
  if ((cells[7,arow] <> '' ) {and (cells[7,arow] <> 'Error!!!')} and (kosten = 0.0) )
    then DrawColoredRect(liste,Rect,Acol, Arow,settings.ReadString('Basics','Color_K', ColortoString(RGB(230,230,250))))
  else
  if ((cells[5,arow] <> '') and (strtofloat(cells[5,arow]) <> 0.0))
    then DrawColoredRect(liste,Rect,Acol, Arow,settings.ReadString('Basics','Color_E', ColortoString(RGB(250,250,200))))
  else
     DrawColoredRect(liste,Rect,Acol, Arow,settings.ReadString('Basics','Color_N', ColortoString(RGB(200,230,220))));

  //Pers�nliche Farben
  if length(Scores) > 0 then
  for l:= 0 to length(Scores)-1 do
  begin

   if (Scores[l].Color = '') then Scores[l].Color := 'none';
   if (liste.cells[1,arow] = Scores[l].Name) and (Scores[l].Color<>'none') and (not selected[arow])
     then DrawColoredRect(liste, rect, acol,arow, Scores[l].Color);

  end;

end //usecolors
else
if not usecolors then canvas.font.color:= clWindowtext;

with Liste.Canvas do
 if (ARow = 0) then //erste zeile
  begin
    font.color:= clwindowtext;
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := psSolid;

    MoveTo(Rect.right-1, Rect.top);
    Lineto(Rect.right-1, Rect.Bottom);
  end
  else //Rahmen zeichnen - selektierte Zeile
  if (arow = liste.row)  then
  begin

    with liste do
    begin
        if not useColors then
        begin
             Canvas.Brush.Color := clHighlight;
             Canvas.FillRect(Rect);
        end;
        if (selected[arow] or not usecolors) then canvas.Font.Color:= clHighlighttext else canvas.Font.Color:= ClWindowText;//clHighlighttext;
        Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
    end;

    Pen.Color := clBlack;
    Pen.Style := psSolid;
    Pen.Width := 2;

    MoveTo(Rect.left-1, Rect.top);
    Lineto(Rect.right-1, Rect.top);

    MoveTo(Rect.left-1, Rect.bottom);
    Lineto(Rect.right-1, Rect.bottom);
   end;

//Dreieck nach unten
with Liste.Canvas do
 if ((ARow = 0) and (ACol = Liste.tag)) then
  begin
    Pen.Color := clNavy;
    Pen.Width := 1;
    Pen.Style := psSolid;

    if sort_descending then
    begin
        MoveTo(rect.right - 15 , Rect.top+5);
        Lineto(rect.right - 10, Rect.Bottom - 5);
        Lineto(rect.right - 5, Rect.top+5);
        Lineto(rect.right - 15, Rect.top+5);
    end
    else
    begin
        MoveTo(rect.right -15, Rect.bottom -5);
        Lineto(rect.right -10, Rect.top + 5);
        Lineto(rect.right -5, Rect.bottom -5);
        Lineto(rect.right -15, Rect.bottom-5);
   end;
        brush.color:= clHotlight;
        Floodfill(rect.right  - 10, rect.top +8 ,clNavy,fsBorder);
        brush.color:= clBlack;
  end;
end;

procedure THauptfenster.ListeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i, widthl, widthr: integer;
begin
liste_last_x:= x;
liste.MouseToCell(X,Y,Column,Row);
liste.Repaint;

mousedownrow:= row;

if (row = 0) then
begin
  widthl:=0;
  widthr:=0;
  with liste do
  begin
       for i:=leftcol to column-1 do widthl:= widthl + ColWidths[i] + 1 ;
       for i:=leftcol to column do widthr:= widthr + ColWidths[i] + 1;
  end;
  GridEvents.OnMouseDown(liste, x,column, row, widthl, widthr);
end;

//rechtsklick abfangen -> Men� aufrufen
if (button = mbRight)  then
begin
  if row > 0 then
  begin
    TS1.Visible:= not (liste.cells[1,row] = '');
    TS2.Visible:= not (liste.cells[1,row] = '');
    TS3.Visible:= not (liste.cells[1,row] = '');
    TS4.Visible:= not (liste.cells[1,row] = '');
    TS5.Visible:= not (liste.cells[1,row] = '');

    liste.row:= Row;
    tarifstatus.items.items[0].enabled:= not (liste.cells[7, liste.row] = misc(M98,'M98'));
    listeMouseup(Sender, Button, Shift,X, Y);
  end
  else
  begin //wenn in leeren Bereich geklickt wurde
    TS1.Visible:= false;
    TS2.Visible:= false;
    TS3.Visible:= false;
    TS4.Visible:= false;
    TS5.Visible:= false;
  end;
  tarifstatus.popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

end;

procedure THauptfenster.TimeTimer(Sender: TObject);
begin
clock.caption:= Datetimetostr(now);
end;

procedure THauptfenster.ApplicationEvents1Deactivate(Sender: TObject);
begin
if clock.visible then
begin
     time.enabled:= false;
     clock.caption:= '';
end;
end;

procedure THauptfenster.rennen2Click(Sender: TObject);
begin
MagRasCon.DisconnectEx(SubHandle[2],2,3000, false);
end;

procedure THauptfenster.rennen1Click(Sender: TObject);
begin
disconnect;
end;

procedure THauptfenster.Verbinden2Methode1Click(Sender: TObject);
begin

with MagRasCon do
begin
     GetEntryProps(true);
     GetSubHandles(ConnHandle,2,SubHandle);
     SubEntry := 2;
     AutoConnectEx(Subhandle[2]);
     SubEntry:= 0;//wieder auf 0 zur�cksetzen
end;
end;

procedure THauptfenster.OCostLabelMouseEnter(Sender: TObject);
begin
if isonline then
with sender as TLabel do
if ansicontainsstr(caption,'> ')
 then
  hint:= misc(M99,'M99')
 else
  if ((gesamtdauer/60) >= 1.0) then
    hint:= Format(misc(M100,'M100')+ ' : %.4m',[onlineset.kosten/(gesamtdauer/60)]);
end;

procedure THauptfenster.TarifStatusPopup(Sender: TObject);
var addtoBL: boolean;
    i: integer;
begin

addtoBL:= true;

for i:= 1 to length(selected) -1 do
if selected[i] then
begin
 if (liste.cells[7, liste.row] = 'Blacklist') and (liste.cells[7,i] <> 'Blacklist') then begin addtoBL:= false; break; end
 else
 if (liste.cells[7, liste.row] <> 'Blacklist') and (liste.cells[7,i] = 'Blacklist') then begin addtoBL:= false; break; end;
end;

if (liste.cells[7, liste.row] = 'Blacklist') then TS1.caption:= misc(M101,'M101')
else TS1.caption:= misc(M102,'M102');

TS1.enabled:= addtoBL;
end;

procedure THauptfenster.WaitOnDisconnectTimer(Sender: TObject);
begin
WaitOnDisconnect.enabled:= false;
OnDisconnect;
end;

procedure THauptfenster.ScoreTimerTimer(Sender: TObject);
begin
Scoretimer.enabled:= false;
//ScoreWert erh�hen (erfolgreich gew�hlt)
  if (selfdial and (IndexOfScores(onlineset.tarif)>-1)) then
    inc(Scores[IndexOfScores(onlineset.tarif)].erfolgreich);
end;

//Profi-Einstellungen umschalten
procedure THauptfenster.MM3_2Click(Sender: TObject);
begin
if sender=MM3_2 then
   MM3_2.checked:= not MM3_2.checked;

if isonline then modes.setonlinemode else modes.setofflinemode;

aktualisieren.visible := MM3_2.checked;
WebServ.visible := MM3_2.checked;
LEDRSS.visible        := MM3_2.checked;
LEDTime.visible       := MM3_2.checked;
DialStatus.visible    := MM3_2.checked;
edtime.visible        := MM3_2.checked;
edtarif.visible       := MM3_2.checked;
beliebig_check.visible:= MM3_2.checked;
MM2_4.visible         := MM3_2.checked;
MM2_7.visible         := MM3_2.checked;
TS3.visible           := MM3_2.checked;

if MM3_2.checked then
begin
  label3.Top:= 393;//324;
  ozeit.Top:= 318;
  ocostlabel.Top:= 318;
  online.top:= 318;
  statLED1.Top:= 324;
  statLED2.Top:= 324;

  bevel1.top:= 291;
  surfdauer.top:= 388;
  bevel1.height:= 132;
  dialbtn.top:= 431;
  if assigned(WebintLabel) then WebIntLabel.top:= 483;
  setmultilink.top:= 483;
  hauptfenster.Constraints.minheight:= 575;
  hauptfenster.height:= 575;
end
else
begin
  bevel1.top:= 268;
  label3.Top:= 300;
  ozeit.Top:= 274;
  ocostlabel.Top:= 274;
  online.top:= 274;
  statLED1.Top:= 280;
  statLED2.Top:= 280;

  surfdauer.top:= 295;
  bevel1.height:= 85;
  dialbtn.top:= 360;
  if assigned(WebintLabel) then WebIntLabel.top:= 390;
  setmultilink.top:= 390;
  hauptfenster.Constraints.minheight:= 480;
  hauptfenster.height:= 480;
end;


end;

// Men�s #######################################################################
procedure THauptfenster.TarifStatusClick(Sender: TObject);
begin
 menues.TarifstatusClick(sender, row);
end;

procedure THauptfenster.MainMenueClick(Sender: TObject);
begin
 menues.MainMenueClick(sender);
end;

procedure THauptfenster.TrayMenueClick(Sender: TObject);
begin
 menues.TrayMenueClick(Sender);
end;

// Men�s ENDE ##################################################################

//~~~~~~~~~~~~~~~~~~~~~~~~~TARIFTABELLE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure THauptfenster.ListeClick(Sender: TObject);
var k, index: integer;
    vcost   : real;  
begin

try
 vcost:= strtofloat(liste.cells[7,liste.row]);
except
 vcost:= 1.0;
end;

index:= -1;

if (not isonline) and (not dialing) then
begin
 //Tarif setzen
  edtarif.text:= liste.cells[1,liste.row];
 //Zeitraum setzen
  if (liste.cells[2,liste.Row]=liste.cells[3,liste.Row]) then
     edtime.text:=misc(M111,'M111')
    else edtime.text:= liste.cells[2,liste.row] +'-'+liste.cells[3,liste.row];
 //Rufnummer setzen
  ednumber.text:= liste.cells[8,liste.row];

 //Kosten setzen
  costs.Font.Color:= clWindowtext;

  if ( (liste.cells[7,liste.row]=misc(M98,'M98')) or (liste.cells[7,liste.row]='Blacklist')) then
  begin
    costs.Font.Color:= clred;
    if (liste.cells[7,liste.row]=misc(M98,'M98')) then costs.Text:= misc(M112,'M112')+' ' + liste.cells[13,liste.row]
    else costs.text:= 'Blacklist';
  end
  else
  if ( (length(kontingente) > 0) and (vcost=0.0000)) then
  begin
    for k:=0 to length(kontingente)-1 do if kontingente[k].Tarif = edtarif.text then begin index:= k; break; end;
      if (index > -1) then
       begin
        if kontingente[index].freikB > 0 then
         costs.text:= Format(misc(M113,'M113')+' %05f MB',[kontingente[index].freikB/1024])
        else
        if kontingente[index].freisekunden > 0 then
          costs.text:= Format(misc(M113,'M113')+' %5.0f min',[kontingente[index].freisekunden/60])
       end;
      end
   else costs.Text:= Format('%1.4m',[vcost]);
 end;
 //Webseite setzen und unsichtbar machen, wenn leer
 if assigned(edwebsite) then
 begin
  edWebsite.caption:= liste.cells[11,liste.row];
  edwebsite.LinkedAdress := edWebsite.caption;
  if edWebsite.caption='' then edWebsite.Visible:= false else edWebsite.Visible:= true;
 end;
end;

procedure THauptfenster.ListeDblClick(Sender: TObject);
begin
if column <> 0 then OnDoubleClick(sender, column);
end;

procedure THauptfenster.ListeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i               : integer;
    thiscol, thisrow: integer;
    selectedtext    : string;
    selrow,c        : integer;
    inverse         : boolean;
    leftcol         : integer;
begin
liste.MouseToCell(x,y,thiscol, thisrow);

if row < 0 then begin liste.repaint; exit; end;

for i:=0 to liste.ColCount -1 do
  if (liste.ColWidths[i] > liste.width) then liste.ColWidths[i]:= liste.Width-15;

if ((row = 0) and (abs(x-liste_last_x) <3)) then //sortieren
  begin
     liste.DefaultDrawing:= false;
     selectedtext:= liste.cells[1,liste.row];
     leftcol:= liste.LeftCol;
     if liste.Tag = column then sort_descending:= not sort_descending else sort_descending:= false;
     inverse:= (liste.tag = column);

     liste.Tag:= column;

     case column of
      -1           : //keine Spalte ausgew�hlt
                      begin end;
      4,5,15,16,18 : //numerische Sortierung
                     GridSort(liste,Tarifprogress,1,liste.rowcount-1, column, 0,inverse);
        7          : //kostenspalte
                     GridSort(liste, Tarifprogress, 1,liste.RowCount-1, 7, 7, inverse);
      else        //alphanumerisch sortieren
                     GridSort(liste,Tarifprogress,1,liste.rowcount-1, column, 1,inverse);//Sort(liste,TarifProgress,column,1,liste.RowCount, false, sort_descending);
     end;

     //selektierten Eintrag wieder selektieren
     selrow:= 1;
     if liste.rowcount > 2 then
     for c:= 1 to liste.rowcount -1 do if (selectedtext = liste.cells[1, c]) then begin selrow:= c; break; end;

     liste.Row:= selrow;
     liste.LeftCol:= leftcol;
     //alle deselektieren
     for c:= 0 to length(selected) -1 do selected[c]:= false;
     selected[selrow]:= true;

     liste.DefaultDrawing:= true;
     liste.Refresh;
  end
else
begin
//showmessage(inttostr(row));
//wenn nicht ctrl gedr�ckt, dann alle anderen selektions vergessen
if not (ssctrl in shift) then
  begin
   if ((button=mbleft) or ((button=mbright) and not selected[row])) then
    for i:=0 to length(selected)-1 do selected[i]:= false;
  end;

if not ( mousedownrow = thisrow ) then
begin
 if ((mousedownrow> 0) and (thisrow > 0)) then
  if (thisrow > mousedownrow) then
   for i:= mousedownrow to thisrow do selected[i]:= not selected[i]
  else
   for i:= thisrow to mousedownrow do selected[i]:= not selected[i];
end
else
if ((button<> mbright)  or ((button=mbright) and not selected[row])) then
  selected[row]:= not selected[row];

liste.repaint;
end;
end;

procedure THauptfenster.ListeSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
liste.repaint;
end;

procedure THauptfenster.ListeMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var i: integer;
begin
//wenn nicht ctrl gedr�ckt, dann alle anderen selektions vergessen
if not (ssctrl in shift) then
    for i:=0 to length(selected)-1 do selected[i]:= false;
 if liste.row > 0 then selected[liste.row]:= true;
 liste.repaint;
end;

procedure THauptfenster.ListeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i: integer;
begin

//wenn nicht ctrl gedr�ckt, dann alle anderen selektions vergessen
if not ( ssctrl in shift) then
  if ((key=VK_UP) or (key=VK_DOWN)) then
  begin
      for i:=0 to length(selected)-1 do selected[i]:= false;
   if liste.row > 0 then selected[liste.row]:= true;
   liste.repaint;
  end;
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~TARIFTABELLE ENDE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure THauptfenster.DonateClick(Sender: TObject);
begin
  settings.WriteDate('LeastCoster','Donation', incday(Dateof(now),60));
  Shellexecute( handle, 'open', Pchar('https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=stefan_fruhner%40web%2ede&item_name=LeastCosterXP&no_shipping=2&no_note=1&tax=0&currency_code=EUR&lc=DE&bn=PP%2dDonationsBF&charset=UTF%2d8'), nil, nil, SW_SHOWMaximized);
end;

procedure THauptfenster.TrayMinimizeToTray(Sender: TObject);
begin
formhidden:= true;
HideTaskbar(handle);
end;

procedure THauptfenster.FormResize(Sender: TObject);
begin
ocostlabel.left:= ozeit.left + ozeit.width + 10;
LEDRSS.left := Hauptfenster.width - 30;
LEDTime.left := Hauptfenster.width - 50;

StatLED2.left := online.left -16;
StatLED1.left := online.left -26;

if assigned(title2) then title2.left:= round((hauptfenster.clientwidth/2) - (title2.width/2));
end;

procedure THauptfenster.S_1Click(Sender: TObject);
begin
 (sender as TMenuitem).checked:= not (sender as TMenuitem).checked;

 if (not (sender as TMenuitem).checked) then
  hauptfenster.Liste.ColWidths[(sender as TMenuitem).tag]:= -1
 else
  hauptfenster.Liste.ColWidths[(sender as TMenuitem).tag]:= 60;
end;

procedure THauptfenster.ForceDialClick(Sender: TObject);
begin
  ForceDial.checked:= not forceDial.checked;
end;

procedure THauptfenster.AutoDialStatusClick(Sender: TObject);
begin
AutoDialStatus.LEDON:= not AutoDialStatus.LEDON;
end;

procedure THauptfenster.AutoDialStatusLedStateChanged(Sender: TObject;
  LedOn: Boolean; NumSwitch: Integer);
begin
if AutoDialStatus.LEDON then
    AutoDialStatus.hint:= misc(M114,'M114')
  else
    AutoDialStatus.hint:= misc(M115,'M115');
end;

procedure THauptfenster.WebServClick(Sender: TObject);
begin
WebServForm.visible:= true;
end;

procedure THauptfenster.MM2_3_5Click(Sender: TObject);
begin
 TarifdateiLaden:=TTarifThread.Create(true);
 TarifdateiLaden.Priority:=tpLower;
 TarifdateiLaden.FreeOnTerminate:=true;
 TarifdateiLaden.OnTerminate:= TarifdateiLaden.MyTerminate;
 Tarifdateiladen.maxPreis:= settings.ReadFloat('Tariflisten','maxPreis',3.0);
 Tarifdateiladen.maxEinwahl:= settings.ReadFloat('Tariflisten','maxEinwahl',10.0);
 TarifdateiLaden.TarifUrl:= settings.ReadString('Tariflisten','Url','http://darkempire.da.funpic.de/php/Tarife/Preistabelle-LCXP.php');
 TarifDateiLaden.lastDate:= settings.ReadDateTime('Tariflisten','TarifDatum',0);
 TarifDateiLaden.AutoDel:= settings.ReadBool('Tariflisten','AutoDel',false);

//    URL := 'http://www.bongosoft.de/Preistabelle-lang.txt';
 TarifdateiLaden.Resume;

end;

end.
