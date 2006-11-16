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
  AMAdvLed, uSchUpdater,
  SNTPSend, BMDThread;

type

 TMyThread = class(TThread)
 protected
   procedure Execute; override;
 end;

 TExecuteWaitEvent = procedure(const ProcessInfo: TProcessInformation;
                                    var ATerminate: Boolean) of object;

//Tarifliste
  TTarif = record
    Tarif: String[50];
    Tag: String[39];
    Nummer,User,Passwort, Editor: String[20];
    Webseite: String[70];
    Takt: String[5];
    Preis, Einwahl: real;
    Beginn, Ende: TTime;
    eingetragen,validfrom, expires:TDate;
    DeleteWhenExpires: boolean;
  end;

  TTarif2 = record
    Data: TTarif;
    ident: String[70];
   end;

//Rss - Reader
  TInhalt = record
    title, link: String;
    checked: boolean;
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
       FreiSekunden: LongInt;   //reicht für ~214GB
       FreikB: Real;
       MB_both: boolean;
       ResetTag: integer;
       NextReset, LastReset: TDate;
    end;

    Onlinewerte = record
      Datum,Startzeit,Dauer,Kosten,Tarif,
      Endzeit, Rufnummer,Preis, Einwahl, Takt,
      vbegin, vend, Webseite, tag: string;
      Einwahl2, kostenbisjetzt: real;
      wechselpreis, wechseleinwahl: real;
      wechsel: TDatetime;
      upload, download: Cardinal;
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
    MM1_4_1: TMenuItem;
    MM1_5_1: TMenuItem;
    Tray: TCoolTrayIcon;
    PopupMenu1: TPopupMenu;
    PM14: TMenuItem;
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
    PM3: TMenuItem;
    PM4: TMenuItem;
    PM1: TMenuItem;
    PM11: TMenuItem;
    PM2: TMenuItem;
    Icons: TImageList;
    PM15: TMenuItem;
    PM5: TMenuItem;
    PM6: TMenuItem;
    PM7: TMenuItem;
    PM8: TMenuItem;
    PM10: TMenuItem;
    PM9: TMenuItem;
    MM2_2_2: TMenuItem;
    MM1_5: TMenuItem;
    sntptimer: TTimer;
    MM2_3_2: TMenuItem;
    MM2_3_4: TMenuItem;
    MM5: TMenuItem;
    UpdateTimer: TTimer;
    MM2_1: TMenuItem;
    MM2_4: TMenuItem;
    Liste: TStringGrid;
    DialBtn: TBitBtn;
    Aktualisieren: TBitBtn;
    costs: TEdit;
    DialStatus: TEdit;
    surfdauer: TTrackBar;
    Oleco: TBitBtn;
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
    MM2_5_1: TMenuItem;
    MM2_5_2: TMenuItem;
    smurf: TBitBtn;
    MM1_4: TMenuItem;
    MM1_8: TMenuItem;
    MM2_6: TMenuItem;
    MM2_7: TMenuItem;
    MM2_7_1: TMenuItem;
    MM2_7_2: TMenuItem;
    MM1_7: TMenuItem;
    MM1_6: TMenuItem;
    Reload: TTimer;
    MM5_1: TMenuItem;
    MM5_2: TMenuItem;
    MM4: TMenuItem;
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
    MM2_8: TMenuItem;
    TarifStatus: TPopupMenu;
    TS1: TMenuItem;
    TS4: TMenuItem;
    TS2: TMenuItem;
    TS2_1: TMenuItem;
    TS2_2: TMenuItem;
    TS2_3: TMenuItem;
    TS2_4: TMenuItem;
    TS5: TMenuItem;
    MM5_3: TMenuItem;
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
    AtomzeitThread: TBMDThread;
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
    procedure AtomzeitThreadExecute(Sender: TObject; Thread: TBMDExecuteThread;
      var Data: Pointer);
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
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PM15Click(Sender: TObject);
    procedure TrayClick(Sender: TObject);
    procedure sntptimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DialBtnClick(Sender: TObject);
    procedure surfdauerChange(Sender: TObject);
    procedure AktualisierenClick(Sender: TObject);
    procedure OlecoClick(Sender: TObject);
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
    procedure PlugInClick(Sender: TObject);
    procedure RsstimerTimer(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
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
    procedure UpdaterError(Sender: TObject;
              ErrorCode: TSchSimpleUpdaterError; Parameter, ErrMessage: String);
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
    procedure StartPlugIns(event: string);
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

    actevent: String;
    FTerminate: Boolean;
    procedure DoOnExecuteWait(const ProcessInfo: TProcessInformation;
                                   var ATerminate: Boolean);

    public
    { Public declarations }
      isonline: boolean;
      Selected: array of boolean;

     //Rss im Menü
      RSSItems: array of array of tInhalt;
      Rss_max: word;
      rss_old: boolean;

      EdWebSite, WebIntLabel: TSRLabel;

      closeallowed: boolean;
      autoclose: boolean;
      ConnectionCostVisible: boolean;
      MinimizeonClose: boolean;
      IPAdress: string;
      lastpluginclicked: string;
      disconnectseconds: integer;
      DisconnectStopped: boolean;

      ctrlcount: integer;
      onlineset: Onlinewerte;
      modemname, modemtype, modemname2, modemtype2, modemstring: string;
      allow_multilink: boolean;
      timeofliste: TDatetime;
      path, prog : string;
      webzugriff: boolean; //kommt eine Anfrage vom WebInterface ?
      startwithimport:boolean;
      importfilename: string;
      rss_update: integer;
      tarife: array of TTarif2;
      lookforward: integer;
      selfdial: boolean;
      noFeeds: boolean;
      noBalloon: boolean;
      Autodisconnect, Leerlaufdisconnect: Automatics;
      leerlaufdisconnectzeit, AutoAusindex: integer;

      AutoSurfdauer : integer;

      DaysToSaveLogs, leerlaufschwelle: integer;
      Kontingente: Array of Kontingentdatensatz;
      kontingentindex: integer;
      warnung_gezeigt: boolean;
      UseColors: boolean;
      SetupModems: boolean;
      Scores : array of TScores;
      AutoBlacklist, AutoBlacklistScore: integer;
      //LangStrings : array of String;
      german: boolean;
      TarifeDisabled,neuladen: boolean;
      pluglist: TStringlist;
      rssrunning: boolean; //läuft RSS-Update ?
  end;

var
  Hauptfenster: THauptfenster;
  progcount, progcountoff: integer;
  zeit_min, zeit_std : string;
 // showtime: integer;
  maxkostenrot, maxkostengelb: real;
  oprog, oprogoff: programs;
  lastupdate: TDatetime;
  updateinterval: integer;
  onlinetime_start, onlinetime2_start,onlinetime_ende: integer;
  onlinetime_starttime: TDatetime;
  startcount: integer;
  verbindungsname: string;
  nooncheck: boolean;
  dauer, dauer2, taktlaenge, taktlaenge2: integer; //onlinedauer in s
  dauer_takt: longint;
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

  settings            : TMemIniFile; //was die lcr.cfg enthält
  UserSettings        : TMemIniFile; //die user.pwd
  SettingsTraffic     : TMemIniFile; //traffic.ini
  SettingsScores      : TMemIniFile; //Scores.ini
  SettingsKontingente : TMemIniFile; //Kontingente.ini
  SettingsOnline      : TMemIniFile; //online.ini
  SettingsOffline     : TMemIniFile; //Offline.ini

  atomserver: TStringlist;

implementation

uses Unit2, Unit4, WebServ1, screen, shutdown, Unit3, tarifverw,
  Tarifmanager, Strutils,DateUtils, floating, unit8, Unit6, mmsystem,
  leerlauf, StringRoutine, Unit7, Unit9, GridEvents, modes, menues, RSSReader, Protokolle, httpprot;

{$R *.dfm}


procedure ShowUsersWebStart;
var Http: THttpCli;
    Outfile: TStringStream;
begin

http:= ThttpCli.Create(nil);
 //Zähler für die Einwahlen >>> Quelltext im Forum erfragen 
 http.URL:=  'http://darkempire.funpic.de/php/count/count.php?user=LCXP';

 outfile:= TStringStream.Create('');

  try
   http.RcvdStream := outfile;
   http.Get;
  finally
   outfile.free;
   http.free;
  end;

 // Shellexecute( handle, 'open', Pchar(ExtractFilepath(ParamStr(0)) + 'www\WebStart.htm'), nil, PChar(GetCurrentDir), SW_SHOW);
 if settings.readbool('Dialer','OpenWeb',true) then
   Shellexecute(0, 'open', Pchar(hauptfenster.onlineset.webseite), nil, nil, SW_SHOWmaximized);

end;

// Benden des Programms ##############################ANFANG####################
//Beenden von Windows abfangen
procedure THauptfenster.WMQueryEndSession (var M: TWMQueryEndSession);
begin
 M.Result:=1;
 MinimizeOnClose:= false; //minimieren bei Schließen abschalten
 fastDisconnectOnExit;
 hauptfenster.close;
end;

procedure THauptfenster.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var msg: string;
begin

if not MinimizeOnClose then closeallowed:= true;

canclose:= closeallowed;

if closeallowed = false then
   begin
      //tray.hidemainform;
      hauptfenster.Visible:= false;
      formhidden:= true;
      if not noballoon then tray.ShowBalloonHint('Hinweis', 'Der LeastCoster ist nun im Tray minimiert.' + #13 +
                                                             'Doppelklick zum maximieren.', bitInfo, 10);
   end
   else
   begin
    save_cfg;
    if ((not isonline) and (webservform.HttpServer1.tag = 0)) then CanClose:= True//PerformExit
    else
    begin
     if (isonline and selfdial) then msg := 'Wenn Sie LeastCosterXP jetzt beenden, wird die aktuelle Verbindung getrennt ! Schließen ?'
      else
     if (isonline and not selfdial) then msg := 'Wenn Sie LeastCosterXP jetzt beenden, wird die aktuelle Verbindung nicht protokolliert ! Schließen ?'
      else
     if (not isonline and (webservform.HttpServer1.tag = 5)) then msg := 'Beim Beenden stehen die WebInterface-Funktionen nicht mehr zur Verfügung ! Schließen ?';

     if not autoclose then      //Meldung machen
     begin
      if MessageDlg(msg, mtConfirmation,[mbYes, mbNo], 0) = mrYes then
        CanClose:= true
       else
        begin CanClose:= false; closeallowed:= false; end;
     end else {AutoClose} canClose:= true;     
    end;
   end;
   
if canclose then
    if assigned(RssRead.MyThread) then //wenn RSS-Update noch läuft
    begin
     canclose:= false; //beenden erstmal verbieten
     RSSRead.shutdown:= true; //herunterfahren im RSSReader erlauben
     RssRead.MyThread.thread.terminate; //bei der nächsten gelegenheit RSS-Reader schließen
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
      if ansicontainstext(params.strings[0],'.lcz') or ansicontainstext(params.strings[0],'.lcx') then
      begin
        importfilename:= params.strings[0];
        startwithimport:= true;
        hauptfenster.MainMenueClick(Hauptfenster.MM1_1);
      end
      else showmessage('Datei '+ params.strings[0] +' ist ungültig');
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


procedure THauptfenster.PlugInClick(Sender: TObject);
begin
with sender as TMenuItem do
begin
 lastpluginclicked:= stripHotkey(caption);
 StartPlugins('menu');
end;
end;

procedure SetLEDs;
begin

with hauptfenster do
begin
case MagRasCon.StateSubEntry of
0: if MagRasCon.ConnectState <> RASCS_Connected then //wenn der 0. Eintrag gelöscht wird
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
      oleco.enabled:= true;
      smurf.enabled:= true;
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
          StatLED2.LEDon:= true; //schalten damit einwahl nicht doppelt gezählt wird

          //Einwahlgebühren für den zweiten Kanal addieren
          if selfdial then onlineset.kostenbisjetzt:= onlineset.kostenbisjetzt + onlineset.einwahl2/100;
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

procedure THauptfenster.IsOntimerTimer(Sender: TObject);
var h,m,s: word;
    delaytime, k, index: integer;
    ConnCount: integer;
    curxmit, currecv, interval: LongWORD ;
    noerror: boolean;
    beginn, ende: TDateTime;
begin
//isontimer.enabled:= false; //damit sich der Timer nicht selbst in die Quere kommt

MagRasCon.GetConnections;
ConnCount := MagRasCon.Connections.Count;

If ((ConnHandle=0) and( ConnCount > 0)) then //wenn keine Connection bekannt war
begin
     OnConnect;
     if selfdial then ConnHandle:= DialHandle
     else
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

if ConnHandle > 0 then
begin
  if MagRasOSVersion = OSW9x then
  begin
   MagRasCon.GetConnectStatusEx(ConnHandle,1);
   setLEDs;
  end
  else
  begin
     MagRasCon.GetConnectStatusEx(Subhandle[1],1);
     setLEDs;
     MagRasCon.GetConnectStatusEx(Subhandle[2],2);
     setLEDs;
  end;
end;

if ConnCount = 0 then
  begin
        if StatLED1.LEDon then StatLED1.LEDon:= false;
        if StatLED2.LEDon then StatLED2.LEDon:= false;
        if isonline then OnDisconnect; //wenn noch kein OnDisconnect kam, dann jetzt
       isontimer.enabled:= true;
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
 zeitumrechnen(gesamtdauer,h,m,s);

 if dauer >= 60 then begin taktlaenge:= taktlaenge2; takt1.Max:= taktlaenge; takt2.max:= taktlaenge; end;

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
  OCostLabel.Caption:= Format('%.4f',[onlineset.kostenbisjetzt])+ ' €';
  onlineset.Kosten:= Format('%.5f',[onlineset.kostenbisjetzt]);
 end
 else
 begin
  onlineset.Kosten:= Format('%.5f',[onlineset.kostenbisjetzt]);
  OCostlabel.Font.Color:= clRed;
  OCostLabel.Caption:= Format('> %.4f',[onlineset.kostenbisjetzt])+ ' €';
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
    or not ansicontainstext(status.simpletext,' | Rufnummer: ')
    or not ansicontainstext(status.simpletext,' | Verbindung: ')
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

   Hauptfenster.PopupMenu1.Items.Items[2].Caption:='IP: ' +chr(9)+ IpAdress;
   status.SimpleText:= 'IP: '+ IpAdress+' | Rufnummer: '+ actnumber+ ' | Verbindung: '+ MagRasCon.CurConnName;
 end;

 if  ((IPAdress <> '0.0.0.0') and (IPAdress <> '' ) and not timerstarted) then
 begin //einwahl war erfolgreich
          timerstarted:= true;
          ForceDial.Checked:= false;

          if selfdial then
          begin
           ShowUsersWebStart;
           StartPlugIns('OnConnect');
          end;
          // erst Atomzeit, dann Update
          sntptimer.interval:= 2000;
          sntptimer.enabled:= settings.ReadBool('Onlinecheck','Atomzeit', false);
          updatetimer.Enabled:= settings.ReadBool('Onlinecheck','Update', true);

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
            disconnect_leerlauf.Label1.Caption:= 'Ende des Freikontingents';
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
                      disconnect_leerlauf.Label1.Caption:= 'Automatisches Trennen';
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
       else   //wenn windows Speed nciht unterstützt
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

        //mitteln über 10s
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

          beginn := Dateof(Now) + strtotime(onlineset.vbegin);
          Ende   := Dateof(Now) + strtotime(onlineset.vend);

          if Ende < beginn then incday(ende);

        //WarnFenster freigeben, wenn es schon existiert
          If Assigned(PriceWarning) then Pricewarning.close.click;

           Application.CreateForm(TPriceWarning, PriceWarning);
           PriceWarning.warn.Caption:= 'Große Zeitdifferenz nach Atomzeitupdate : ' +timetostr(now-oldtime);
           PriceWarning.info.Caption:= 'Sie sind online mit  ' + onlineset.Tarif +'('+onlineset.Preis +', ' +onlineset.vbegin +'-'+onlineset.vend +')';

           if ((now > beginn) and (now < ende)) then
           begin
             PriceWarning.info2.Caption:= 'Der gewählte Tarif ist noch gültig. Trennen ist nicht nötig.';
             Pricewarning.trennen2.Caption:= 'Um ' + onlineset.vend + ' trennen';
             Pricewarning.Timer1.enabled:= true;
         end;
         if ((now < beginn) or (now > ende)) then
         begin
           PriceWarning.info2.Caption:= 'Der gewählte Tarif ist im Moment NICHT gültig. Trennen wird empfohlen.';
           Pricewarning.trennen2.visible:= false;
           Pricewarning.Timer1.enabled:= true;
         end;
         Pricewarning.Show;
         pricewarning.BringToFront;

    end;

oldtime:= now;
isontimer.enabled:= true; //neustart des Onlinetimers wenn noch online
end;
end;

procedure THauptfenster.MagRasConStateEvent(Sender: TObject;
  ConnState: TRasStateRec);
begin

if not (ConnState.ConnectState = ERROR_INVALID_PORT_HANDLE) then
  Dialstatus.text:= ConnState.statusstr; //Status ausgeben

//nur wenn eine fremde Verbindung aufgebaut wurde ist DialHandle 0
//oder
//nur beim ersten Wählen (wenn dailing=true) hier beenden (wird ja im OnlineTimer abgehandelt)
if isonline and ((DialHandle = 0) or (dialing=false)) then exit;//beenden wenn schon online (damit frende Verbindungen nicht neu auslösen)

if ConnState.ConnectState = RASCS_Connected then
begin
     selfdial:= true;
     surfdauer.enabled:= true;
     aktualisieren.enabled:= true;
     oleco.enabled:= true;
     smurf.enabled:= true;
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
 DialBtn.caption:='&Wählen';
 Aktualisieren.enabled:= true;
 aktualisieren.click;
 surfdauer.enabled:= true;
 oleco.enabled:= true;
 smurf.enabled:= true;
 reload.enabled:= true;
 ClearRasEntry;
 Hauptfenster.Cursor := crDefault;

 if (AutoDialLed.ledon) then
 begin
  Autodial.Enabled:= true;
  status.simpletext:= 'Autoeinwahl gescheitert ('+Datetimetostr(now)+')';
 end
 else status.simpletext:= 'Verbindung beendet. ('+Datetimetostr(now)+')';
 aktualisierenclick(self);

 if ForceDial.Checked then Dialbtn.Click;

 exit;
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
     info.Edit.lines.add('Übersicht aller aktiven Verbindungen');
     info.Edit.lines.add('Verbindungen'+chr(9)+': ' + inttostr(MagRasCon.Connections.Count));
     info.Edit.lines.add('');

     For i:= 0 to MagRasCon.Connections.Count-1 do
     begin
      if MagRasCon.Connections.RasConn(i) = ConnHandle then
         info.Edit.lines.add('Ihre Verbindung: ');
      info.Edit.lines.add('Verbindung Nr.'+chr(9)+': ' + inttostr(i));
      info.Edit.lines.add('Name'+chr(9)+chr(9)+': ' + MagRasCon.Connections.EntryName(i));      info.Edit.lines.add('Modemname'+chr(9)+': ' + MagRasCon.Connections.DeviceName(i));
      info.Edit.lines.add('Modemtyp'+chr(9)+': ' + MagRasCon.Connections.DeviceType(i));
      if MagRasCon.Connections.RasConn(i) = ConnHandle then
      begin
             if (StatLED1.LedOn and statled2.ledon) then
              info.Edit.lines.add('Multilinkgeräte'+chr(9)+': 2')
             else
              info.Edit.lines.add('Multilinkgeräte'+chr(9)+': 1');

      info.Edit.lines.add('Download'+chr(9)+': ' + inttostr(onlineset.download));
      info.Edit.lines.add('Upload'+chr(9)+chr(9)+': ' + inttostr(onlineset.upload));
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
     onlineset.Endzeit:= timetostr(timeof(now));
     closertimer(nil); //Verbindung aufschreiben

     ClearRasEntry;

     //Logfile schreiben
     Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Verbindung getrennt, weil Windows beendet wird.'+#13#10;
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
    bShowDialingProgress    := true;  //Status während des Wählens anzeigen
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
    Status.SimpleText := 'Created New Entry OK' ;
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
 status.simpletext:= 'Bitte die Einstellungen überprüfen !';
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
 oprog[i].section := programs.Strings[i];
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
//einstellungsfenster öffnen
MainMenueClick(MM3_1);
showmessage('Dies scheint der erste Start vom LeastCoster zu sein. Bitte nehmen Sie zunächst alle Einstellungen vor.');
end;


procedure THauptfenster.PerformExit;
var i: integer;
    buf: string;
begin
 //alle aktiven Benutzer ausloggen
    UserSettings.erasesection('active');


    //sichern der Einstellungen
    settings.writeinteger('lasttime','base', hauptfenster.surfdauer.position);

    for i:= 1 to liste.colcount-1 do     //abspeichern der Tabellenbreiten
    settings.writeinteger('Tariflist','Col'+inttostr(i),hauptfenster.liste.ColWidths[i]);
    settings.writebool('Tariflist','Colors', usecolors);
    settings.writeBool('LeastCoster','ConnectionCost', ConnectionCostVisible );
    settings.WriteBool('Tariflist','Clock', clock.Visible);

    //wenn gerade gewählt wird
    with hauptfenster do
    if (dialbtn.Caption = 'a&bbrechen') then
    begin if ConnHandle <> 0 then RasHangUp(ConnHandle); end;

   //wenn noch online
    if (isonline and selfdial) then
    begin
     disconnect;
     onlineset.Endzeit:= timetostr(timeof(now));
     closertimer(nil);

     //Logfile schreiben
     Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Verbindung getrennt und LeastCosterXP beendet'+#13#10;
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
       if not noballoon then tray.ShowBalloonHint('Starte Programm',Extractfilename(oprog[progcount].path)+ ' läuft bereits.',bitInfo,10);
 end
 else
     if not noballoon then tray.ShowBalloonHint('Starte Programm','Das Programm Nr. '+inttostr(progcount) + ' mit dem Namen ' +oprog[progcount].path +' existiert nicht.'+ chr(13) +'Bitte die Einstellungen überprüfen !',bitInfo,10);
//     else showmessage('Das Programm Nr. '+inttostr(progcount) + ' mit dem Namen ' +oprog[progcount].path +' existiert nicht.'+ chr(13) +'Bitte die Einstellungen überprüfen !');
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

{exe ausführen}
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
   end else if not noballoon then tray.ShowBalloonHint('Starte Programm',Extractfilename(oprogoff[progcountoff].path)+ ' läuft bereits.',bitInfo,10);
  end
 else
 if not noballoon then tray.ShowBalloonHint('Starte Programm','Das Programm Nr. '+inttostr(progcountoff) + ' mit dem Namen ' +oprogoff[progcountoff].path +' existiert nicht.'+ chr(13) +'Bitte die Einstellungen überprüfen !',bitInfo,10);
// else showmessage('Das Programm Nr. '+inttostr(progcountoff) + ' mit dem Namen ' +oprogoff[progcountoff].path +' existiert nicht.'+ chr(13) +'Bitte die Einstellungen überprüfen !');
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

procedure THauptfenster.FormCreate(Sender: TObject);
var con: TmemInifile;
    i: integer;
    sr : TSearchRec;
    F: string;
    ple: TIniFile;
    reg: TRegistry;
begin
closeallowed:= false;
autoclose:= false;
ConnHandle:= 0;
Disconnecting:= false;
neuladen:= false;

//lcz-Dateien wieder unregistrieren -> nicht mehr nötig
if reg.keyexists('.lcz') then UnInstallExt('.lcz');

Rssread:= TRss.Create;

//gradienten erzeugen
if MagRasOSVersion > OSW9x then
begin
  grad2 := TSRGradient.Create(self);
  grad2.parent:= hauptfenster;
  grad2.Align:= alClient;
  grad2.Direction:= gdUpLeft;
  grad2.EndColor:= $00DBAF95;
  grad2.StartColor:= clBtnFace;
  grad2.Style:= gsPyramid;
  grad2.SendToBack;//nach hinten schieben
end;

 EdWebsite := TSRLabel.Create(self);
 EdWebsite.Parent := hauptfenster;
 with EdWebsite do
  begin
    Name := 'EdWebsite';
    Left := 27;
    Top := 374;
    Width := 60;
    Height := 13;
    Constraints.MaxWidth := 360;
    Constraints.MinWidth := 60;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlue;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold];
    ParentFont := False;
    Transparent := true;
    HoverFontColor:=clHotlight;
    Font.Color:= clBlue;
    LinkActive:= true;
    LinkType:= ltWWW;
    ShortenFilenames:= false;
    ShowHighlight:= false;
    ShowShadow:= false;
    Style:= lsCustom;
    UnderlineOnEnter:= false;
    Visible:= true;
  end;


  WebIntLabel := TSRLabel.Create(Self);
  WebIntLabel.Parent := hauptfenster;
  with WebIntLabel do
  begin
    Name := 'WebIntLabel';
    Left := 135;
    Top := 483;
    Width := 149;
    Height := 16;
    Anchors := [akLeft, akTop, akRight];
    Caption := '>>> WebInterface <<<';
    Font.Color := clBlue;
    Font.Height := -13;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold];
    ParentFont := False;
    Transparent := True;
    HoverFontColor:=clHotlight;
    Font.Color:= clBlue;
    LinkActive:= true;
    LinkType:= ltWWW;
    ShortenFilenames:= false;
    ShowHighlight:= false;
    ShowShadow:= false;
    Style:= lsCustom;
    UnderlineOnEnter:= false;
    Visible := False;
  end;


//Fenstertitle erzeugen
Title2:= TSRLabel.Create(self);

title2.Parent:= Hauptfenster;
title2.Alignment:= taCenter;
title2.Anchors:= [akTop];
title2.BevelStyle:= bvnone;
title2.Caption:= 'LeastCosterXP';
title2.Hint:= 'www.leastcosterxp.de';
title2.HoverFontColor:=$000000BF;
title2.Left:= 120;
title2.Height:= 29;
title2.Font.Color:= $0000007B;
title2.Font.Name:= 'Verdana';
title2.font.Style:= [fsBold];
title2.Font.Size:= 15;
title2.Layout:= tlTop;
title2.LinkActive:= true;
title2.LinkedAdress:= 'http://www.leastcosterxp.de';
title2.LinkType:= ltWWW;
title2.ShadowColor:= $00D7E0E1;
title2.ShadowOffset:= 3;
title2.ShortenFilenames:= false;
title2.ShowHighlight:= true;
title2.ShowShadow:= true;
title2.Style:= lsCustom;
title2.Top:= 0;
title2.Transparent:= true;
title2.UnderlineOnEnter:= false;
title2.Width:= 166;
title2.Visible:= true;

settings            := TMemIniFile.Create(extractfilepath(paramstr(0))+'lcr.cfg');
UserSettings        := TMemIniFile.Create(extractfilepath(paramstr(0))+'user.pwd');
SettingsTraffic     := TMemIniFile.Create(extractfilepath(paramstr(0))+'traffic.ini');
SettingsKontingente := TMemIniFile.Create(extractfilepath(paramstr(0))+'Kontingente.ini');
SettingsScores      := TMemIniFile.Create(extractfilepath(paramstr(0))+'Scores.ini');
SettingsOnline      := TMemInifile.Create(ExtractFilepath(Paramstr(0)) + 'online.ini');
SettingsOffline     := TMemInifile.Create(ExtractFilepath(Paramstr(0)) + 'offline.ini');

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

TarifeDisabled:= false;

KontingenteWarned:= false;
parameters:= TStringList.Create;
kill_list:= TStringList.Create;
parameters.Duplicates:= dupIgnore;
atomcount:= 0;

startwithimport:= false;
importfilename:= '';
selfdial:= false;
webzugriff:= false;
isonline:= false;
rascheck:= true;
writeme:= false;
startcount:=0;
firststart:= false;
rssrunning:= false;

warnung_gezeigt:= false;
dialing:= false;
beliebig_check.checked:= false;
Hauptfenster.Caption:= 'LeastCosterXP '+GetFileVersion(application.exename);
ozeit.caption:= '';
usecolors:= true;
TS6_2.checked:= false;
AutoBlackList      := 10;
AutoBlackListScore := 50;
disconnectseconds  := 5;
minimizeonclose:= true;
ConnectionCostvisible:= true;
TS6_1.Checked:= not ConnectionCostvisible;
DaysToSaveLogs:= 60;

german:= true;

F:= ExtractFilepath(Paramstr(0));

if not directoryexists(F+ 'log')  then mkdir(F + 'log');
if not directoryexists(F + 'www') then mkdir(F + 'www');
if not directoryexists(F + 'www\log') then mkdir(F + 'www\log');
if not directoryexists(F + 'www\files') then mkdir(F + 'www\files');
if not directoryexists(F + 'www\img') then mkdir(F + 'www\img');
if not directoryexists(F + 'RSS')  then mkdir(F + 'RSS');
if not directoryexists(F + 'PlugIns')  then mkdir(F + 'PlugIns');

pluglist:= TStringlist.Create;
//einlesen aller PlugInverzeichnisse
if FindFirst(ExtractFilePath(paramStr(0))+ 'PlugIns\*.*', faAnyFile, SR) = 0 then
    repeat
       if ((Sr.Attr and faDirectory) <> 0) then
        if ( (sr.name <> '.') and (sr.name<>'..')) then begin pluglist.Append(sr.name); end;
    until FindNext(SR) <> 0;
findclose(sr);

//einlesen der manuellen PlugIns-Menüpunkte
for i:= 0 to pluglist.Count -1 do
begin
 if fileexists(ExtractFilePath(paramStr(0))+ 'PlugIns\'+pluglist.Strings[i]+'\'+pluglist.Strings[i]+'.ini') then
 begin
  con:= TmeminiFile.Create(ExtractFilePath(paramStr(0))+ 'PlugIns\'+pluglist.Strings[i]+'\'+pluglist.Strings[i]+'.ini');
   if con.readbool('General','enabled', false)=true then
     if con.SectionExists('menu') then
         menu.Items.items[1].items[7].Add(NewItem(pluglist.strings[i],TextToShortCut(''),False,True,PlugInClick,0,'Item1'));
  con.Free;
 end;

end;

//prüfen ob RAS installiert
if not MagRasCon.TestRas then
begin
 Dialbtn.Enabled:= false;
 status.simpletext:= 'Kein RAS installiert !';
end;

//Atomserver einlesen
atomserver:= TStringlist.Create;
if fileexists(extractfilepath(paramstr(0))+'Atomzeitserver.txt') then
 atomserver.LoadFromFile(extractfilepath(paramstr(0))+'Atomzeitserver.txt');

//Einträge prüfen und wenn leer setzen
if (atomserver.count = 0) then
begin
  atomserver.Append('ntps1-0.cs.tu-berlin.de');
  atomserver.savetoFile(extractfilepath(paramstr(0))+'Atomzeitserver.txt');
end
else
begin
  //leere einträge entfernen
    for i:= atomserver.count-1 downto 0 do
     if atomserver.strings[i] = '' then atomserver.Delete(i);
  //wenn alle leer waren, dann jetzt einen anfügen
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

   //minimiert starten wenn gewünscht
  application.showmainform:= not settings.ReadBool('LeastCoster','minimiert',false);

  //wenn datei übergeben wurde mainform anzeigen
  If (ParamCount>0) and (FileExists(ParamStr(1))) then application.showmainform:= true;

  path:=  settings.ReadString('Pfad von Oleco/ Discountsurfer','path','');{Pfad/ progname}
  prog:=  settings.ReadString('Pfad von Oleco/ Discountsurfer','prog','');

  //Zeit des letzten Oleco-Imports
  //wenn die ple.cst gelöscht wurde, dann letztes Datum Vergessen
  if not fileexists(path+'ple.cst') then
     begin
      settings.writestring('lastdate','1','');
      settings.writestring('lastdate','3','');
     end;

  if not (path='') then Menu.items.Items[1].items[5].enabled:= true
  else Menu.items.Items[1].items[5].enabled:= false;

  //letzten Basiszeitwert setzen
  surfdauer.Position:= settings.Readinteger('lasttime','base',15);

  //atomzeit
  if not settings.ReadBool('Onlinecheck','Atomzeit', false) then
  begin
   LEDTime.ColorOff:= clGray;
   LEDTime.Hint:= 'Das automatische Atomzeitupdate ist deaktiviert.'
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

   //AuotBlackList
   AutoBlackList      := settings.Readinteger('AutoBlacklist','Value',10);
   AutoBlackListScore := settings.Readinteger('AutoBlacklist','Score',50);

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
   else AutoDial.Interval:= 60000;

  //Rss-Update
   rss_update := settings.ReadInteger('RSS','Update',60);
   noFeeds    := settings.ReadBool('Rss', 'noFeeds', false);
   Rss_max    := settings.ReadInteger('RSS','maxItems', 40);
   rss_old    := settings.Readbool('RSS','oldFeeds', true);

   if noFeeds then
      begin
           ledRss.ColorOff:= clGray;
           ledrss.Hint:= 'RSSFeeds sind deaktiviert.';
      end;

  clock.Visible:= settings.ReadBool('Tariflist','Clock', false);
  if not clock.Visible then Datelabel.Constraints.MaxWidth:= 402;

  //Tagesstatistik löschen, wenn Tag gewechselt
  if settings.ReadDate('Tageskosten','Date',encodedate(1970,1,1)) <> dateof(now)
   then settings.EraseSection('Tageskosten');

 if fileexists(ExtractFilepath(ParamStr(0)) + 'UpdatedFiles.dat') then
      CheckForUpdates;


  //Autoimport
 //Auto-Auswerten + Menueeintrag ausblenden
   if (settings.readbool('LeastCoster','autoread',false) and (prog <> '')) then
   begin
    menu.Items.Items[0].Items[3].Items[0].Enabled:= true;
    //nur ausführen, wenn Oleco zur Überwachung installiert
    if ansicontainstext(prog,'oleco.exe') or ansicontainstext(prog,'discountsurfer.exe') then
       Protokolle.OlecoImport(sender);
   end;

  datensaetze:= 0;
  if ansicontainstext(prog,'oleco') or ansicontainstext(prog,'discountsurfer') then
  begin
     if fileexists(path+'ple.cst') then
     begin
       ple:= Tinifile.Create(path+'ple.cst');
       datensaetze:= ple.ReadInteger('online','count',0);
       ple.Free;
     end;
  end
  else
   menu.items.items[0].items[3].items[0].enabled:= false;
  if datensaetze = settings.ReadInteger('lastdate','count',0) then writeme:= true;


  RSSRead.LoadRSSList;

  tarifverw.ladetarife;
  Kontingente_Laden;

  //csv und html logs updaten sowie die Tagesstatistik
  Protokolle.CreateAllLogs;
  Protokolle.WebAuswertungErstellen;

  //LogFiles trimmen
  ShortenLogFiles(Extractfilepath(paramstr(0)) + 'www\log\log.txt',DaysToSaveLogs);
  ShortenLogFiles(Extractfilepath(paramstr(0)) + 'log\atomzeit.txt',DaysToSaveLogs);

  tray.iconvisible:= true;

  if not MagRasCon.TestRas then
   status.SimpleText:='Fehler: Kein RAS installiert !'
   else
   status.SimpleText:='Programm bereit.';

  StartPlugins('OnStart');

end;

//wird nach dem Trennen ausgeführt ... hier wird alles gespeichert
procedure THauptfenster.closerTimer(Sender: TObject);
var i: integer;
begin
closer.Enabled:= false;

if (not selfdial) then
begin
 askedclose(PAnsichar(settings.ReadString('Server','Titel','')));
 if settings.readbool('LeastCoster','autoread',false) then //wenn Autoimport
     begin
       //nur ausführen, wenn Oleco zur Überwachung installiert
      if ansicontainstext(prog,'oleco.exe') or ansicontainstext(prog,'discountsurfer.exe') then
         Protokolle.OlecoImport(sender);

       //Auto-Export
       Protokolle.CreateAllLogs;
      end;
end
else
begin
   Protokolle.append_own_data;
   SaveTrafficData(onlineset.Tarif, Dauer, onlineset.download, onlineset.upload);

    //alles zurücksetzen
    kontingentindex:= -1;

//Auto-Export
  Protokolle.CreateAllLogs;

   selfdial:= false;  //alles erledigt ... rücksetzen
   with onlineset do
   begin
    Datum:= ''; Dauer:=''; Kosten:=''; tarif:='';
    Einwahl:= ''; Rufnummer:=''; Preis:= ''; Einwahl:=''; takt:='';
    webseite:= ''; vbegin:= ''; vend:= ''; tag:='';
    wechsel:= EncodeDateTime(1970,01,01,0,0,0,0);//strtodatetime('01.01.1970 00:00:00');
    kostenbisjetzt:= 0; wechselpreis:= 0; wechseleinwahl:= 0;
    Einwahl2:= 0;
    download:= 0; upload:= 0;
   end;

   dauer:= 0;
end;

SettingsTraffic.UpdateFile;//auf die Platte schreiben

//Programme beenden
if kill_list.count > 0 then
      for i:= 0 to kill_list.count -1 do
          if isexerunning(kill_list.strings[i]) then killtask(kill_list.strings[i]);
             kill_list.clear;

//Update überprüfen
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

procedure THauptfenster.PopupMenu1Popup(Sender: TObject);
begin


if isOnline then
   begin
      hauptfenster.PopupMenu1.Items.Items[3].Caption:='Onlinezeit: ' +chr(9)+ ozeit.Caption;
      Popupmenu1.Items.Items[6].Caption:= 'Dauer:'+ chr(9) + timetostr(strtotime(ozeit.caption)+settings.ReadTime('Tageskosten','Zeit',Encodetime(0,0,0,0)));
      Popupmenu1.Items.Items[7].Caption:= 'Kosten:'+ chr(9) + '> '+format('%3m',[settings.ReadFloat('Tageskosten','Kosten',0)]);
      Popupmenu1.Items.Items[8].Caption:= 'Verbindungen:'+ chr(9) + Inttostr(settings.ReadInteger('Tageskosten','Verbindungen',0)+1);
      Popupmenu1.Items.Items[9].Caption:= 'cent/min:'+ chr(9) + '~ ' +format('%1.3f',[settings.ReadFloat('Tageskosten','Mittelwert',0)*100]);
   end
   else
    begin
    Popupmenu1.Items.Items[6].Caption:= 'Dauer:'+ chr(9) + timetostr(settings.ReadTime('Tageskosten','Zeit',Encodetime(0,0,0,0)));
    Popupmenu1.Items.Items[7].Caption:= 'Kosten:'+ chr(9) + format('%3m',[settings.ReadFloat('Tageskosten','Kosten',0)]);
    Popupmenu1.Items.Items[8].Caption:= 'Verbindungen:'+ chr(9) + Inttostr(settings.ReadInteger('Tageskosten','Verbindungen',0));
    Popupmenu1.Items.Items[9].Caption:= 'cent/min:'+ chr(9) + format('%1.3f',[settings.ReadFloat('Tageskosten','Mittelwert',0)*100]);
    end;

end;

procedure THauptfenster.PM15Click(Sender: TObject);
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
 sntptimer.enabled:= false;
 timeupdaterunning:= true;
 AtomzeitThread.Start;
end;

procedure THauptfenster.FormDestroy(Sender: TObject);
begin
atomserver.Free;
parameters.free;
kill_list.free;
pluglist.free;

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
SetDialParams(''{user},''{password},'0'{number}); //Wählstring
end;

procedure StartDial;
begin
with hauptfenster do
begin
  Cursor:= crHourglass;

  //schreiben der Verbindung (wichtig für Multilink);
 SetDialParams(hauptfenster.liste.Cells[9,hauptfenster.liste.row], //user
                hauptfenster.liste.Cells[10,hauptfenster.liste.row], // password
                hauptfenster.liste.Cells[8,hauptfenster.liste.row] //number
              );


   MagRasCon.EntryName:= 'LeastCosterXP';
   MagRasCon.GetEntryProps(true);
   //setzen der Paramter für die Verbindung (für RasDial)
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
   onlineset.kostenbisjetzt:= strtofloat(onlineset.einwahl); //Einwahl 1x mehr berechnen
   MagRasCon.SubEntry:= 0;
  end
  else
   MagRasCon.SubEntry:= 1
  end
  else //wenn Mulitlink verboten
   MagRasCon.SubEntry:= 0;

  if MagRasCon.AutoConnectEx(DialHandle) <> 0 then
    begin
     DialStatus.text:= 'Dialing failed.';

     if DialHandle <> 0 then RasHangUp(DialHandle);
     ConnHandle:= 0; DialHandle:= 0;
     ClearRasEntry;
     dialing:= false;
     Cursor := crDefault;
     Dialbtn.caption:= '&Wählen';

     if (AutoDialLed.ledon) then
      begin
       Autodial.Enabled:= true;
       status.simpletext:= 'Autoeinwahl gescheitert ('+Datetimetostr(now)+')';
      end
      else status.simpletext:= 'Wählen abgebrochen. ('+Datetimetostr(now)+')';

     aktualisierenclick(nil);
     exit;
    end;

  //wählen war erfolgreich
   DialBtn.caption:='a&bbrechen'; surfdauer.enabled:= false; oleco.enabled:= false; smurf.enabled:= false;
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
{
procedure WriteWebStart;
var f: textfile;
begin
assignfile(f,extractfilepath(paramstr(0)) + 'www\WebStart.htm');
rewrite(f);
writeln(f,'<html>');
writeln(f,'<head><title>LeastCosterXP</title></head>');
writeln(f,'<frameset rows="100,*" cols="*">');
writeln(f,'<frame src="http://home.pages.at/darkempire/fin.htm" name="SomeAds">');
writeln(f,'<frame src="',hauptfenster.onlineset.webseite,'" name="MainFrame">');
writeln(f,'</frameset>');
writeln(f,'</html>');
closefile(f);


end;
}
procedure THauptfenster.DialBtnClick(Sender: TObject);
var buf: string;
    foundRasConn: boolean;
    taktstring: string;
begin

if isonline then
  begin  // schon online
  status.SimpleText:='Die Verbindung ' + verbindungsname+ ' wird getrennt.';
  Disconnecting:= true;
  disconnect;
  ForceDial.Checked:= false;
  end
else
  begin //offline
  reload.enabled:= false;   //reloaden disablen

  status.simpletext:= 'Prüfe Anfrage ...';

  save_cfg;

  //RasVerbindung suchen und erstellen
  foundRasConn := FindRasConnection;
  if not FoundRasConn then CreateRAS;

  //selbst gewählte Verbindung während des Anwählens trennen
  if (dialbtn.Caption = 'a&bbrechen') then
    begin if DialHandle <> 0 then RasHangUp(DialHandle); ClearRasEntry;  dialing:= false; Hauptfenster.Cursor := crDefault; exit; end;

  if beliebig_check.Checked then
  begin
   if not webzugriff then
   status.simpletext:= 'Keine Einwahl solange ''Zeige beliebige Zeit'' aktiviert ist !';
   exit;
  end;

  try
   if secondsbetween(timeofliste, now) > 60 then
   begin
    if not webzugriff then
    status.simpletext:= 'Die Tarifliste ist älter als 60s. Sie wird aktualisiert.' + #13#10+
                        'Bitte danach erneut versuchen';
    AktualisierenClick(nil);
    exit;
   end;

  if ((liste.Cells[1,liste.row] = '') and (liste.Cells[2,liste.row]='') and (liste.rowcount=2)) then
  begin
   status.simpletext:= 'Kein Eintrag in der Tarifliste aktiv.';
   exit;
  end;

  if sender <> Dialbtn then
  if strtodate(liste.cells[13,liste.row]) < dateof(now) then
  begin
   if not webzugriff then  status.simpletext:= 'Dieser Tarif ist am '+liste.cells[13,liste.row]+' abgelaufen !!';
   exit;
  end;

except
  if not webzugriff then  status.simpletext:='Ein unbekannter Fehler trat auf. Bitte die Liste aktualisieren und neu versuchen zu wählen.';
  exit;
end;

  if ansicontainstext(costs.text,'Dauer überschreitet Tarifende') then
  begin
  if not webzugriff then
   status.simpletext:= 'Dauer überschreitet Tarifende !';
   exit;
  end;

  if liste.Cells[7,liste.row] = 'Blacklist' then
   begin
   if not webzugriff then
   status.simpletext:= 'Tarife der Blacklist werden nicht gewählt.';
   exit;
  end;

  if ((modemname = '') or (modemtype='')) then
  begin
   status.simpletext:= 'Es wurde kein gültiges Modem eingtragen !';
   exit;
  end;

 //Autodial enabled ? erstmal abschalten
 if autodial.enabled then begin Autodial.Tag:= 10; autodial.interval:= 60000; autodial.enabled:= false; AutoDialLEd.ledon:= false; end;

 //~~~~~~~~~~~~Fehler sind hier abgearbeitet~~~~~~~~~~~~~~~~~~

 //ScoreWert erhöhen (DialAll)
 if IndexOfScores(liste.Cells[1,liste.row])>-1 then
  inc(Scores[IndexOfScores(liste.Cells[1,liste.row])].gesamt);

  Kontingente_Laden;
  kanalbuendelung:= false; //Standardwert
  selfdial:= true; //LeastCoster ist der Dialer, das soll er auch wissen
  aktualisieren.enabled:= false;

  status.SimpleText:= 'Wähle ... ';
  dialing:= true;
  //Datensatz in den Speicher übernehmen

  onlineset.Datum:= DateTimetoStr(now);
  onlineset.Tarif:= liste.Cells[1,liste.row];
  onlineset.Rufnummer:= liste.Cells[8,liste.row];
  onlineset.Preis:= liste.Cells[4,liste.row];
  onlineset.Einwahl:= liste.Cells[5,liste.row];
  onlineset.einwahl2:= strtofloat(onlineset.einwahl);
  onlineset.Takt:= liste.Cells[6,liste.row];
  onlineset.tag:= liste.Cells[17,liste.row];

  taktstring:= onlineset.takt;
  Delete(taktstring,pos('/', taktstring),length(taktstring) - pos('/', taktstring) +1);
  try
    taktlaenge:= strtoint(taktstring);
    if taktlaenge > 60 then taktlaenge:= 60;
  except
    taktlaenge:= 60; //wenn Fehler dann minutentakt annehmen
  end;

  taktstring:= onlineset.takt;
  Delete(taktstring,1, pos('/', taktstring)  );
  try
    taktlaenge2:= strtoint(taktstring);
  except
    taktlaenge2:= 60; //wenn Fehler dann minutentakt annehmen
  end;

  onlineset.vbegin:= liste.Cells[2,liste.row];
  onlineset.vend:= liste.Cells[3,liste.row];
  onlineset.webseite:= liste.Cells[11,liste.row];
  onlineset.kostenbisjetzt:= 0;
  onlineset.wechsel:= incday(now, 10*365);

//  WriteWebStart;   //Datei schreiben, die geöffnet wird

  //Logfile schreiben
  buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Anwahlversuch (LeastCosterXP) ' + onlineset.Tarif +
              #9+  'LeastCosterXP - Server'   +#13#10;
  webserv1.status:= buf;
  webservform.logfile_add(buf);

 //Leerlaufinterval setzen
 AutoLeerlaufLed.LedOn:= leerlaufdisconnect.Enabled;
 leerlaufboxask.Checked:= leerlaufdisconnect.Ask;
 leertime.Value:= leerlaufdisconnectzeit;
 leerlauf.Interval:= leerlaufdisconnectzeit *60 * 1000;

 //Ausschalten bei Automatischem Trennen
 AutoAus.ItemIndex:= AutoAusIndex;

 //AutoConnect setzen
  AutoDialEinwahl.checked:= settings.Readbool('AutoConnect','mitEinwahl',false);
  AutoDialLEd.ledon:= settings.Readbool('AutoConnect','AutoReConnect',false);
  AutoBase.Position:= Autosurfdauer;

  Autodiscled.ledon:= AutoDisconnect.Enabled;
  trennask.checked:= AutoDisconnect.Ask;

 //Autotrennen setzen
// try

   //wenn Ende > als Beginn oder ende ist noch in der Zukunft
  if ( (Dateof(now) + strtotime(liste.Cells[3,liste.row])) > (Dateof(now) + strtotime(liste.Cells[2,liste.row])))
     or
     ( (Dateof(now) + strtotime(liste.Cells[3,liste.row])) > now )
  then
    trennticker.DateTime:= Dateof(now) + strtotime(liste.Cells[3,liste.row])
  else //wenn ende < beginn
  if (Dateof(now) + strtotime(liste.Cells[3,liste.row])) < (Dateof(now) + strtotime(liste.Cells[2,liste.row])) then
  begin //auf morgen setzen
    trennticker.DateTime:= incday(Dateof(now),1) + strtotime(liste.Cells[3,liste.row]);
    // ... und schauen ob morgen noch gültig, wenn nicht, dann 00:00:00 beenden
    if (Ansicontainstext(liste.cells[17,liste.row],StringvonMorgen(now)) = false) then
          //auf nächstes 0h setzen
          trennticker.DateTime:= incday(dateof(now) + EncodeTime(0,0,0,0),1);
  end
  else //wenn ende = beginn (ganztags)
  if (Dateof(now) + strtotime(liste.Cells[3,liste.row])) = (Dateof(now) + strtotime(liste.Cells[2,liste.row])) then
  begin
    //wenn morgen nicht mehr gültig, dann 0h trennen
    if Ansicontainstext(liste.cells[17,liste.row],StringvonMorgen(now)) = false then
       trennticker.DateTime:= incday(dateof(now) + EncodeTime(0,0,0,0),1)
    else
    Autodiscled.ledon:= false; //gilt noch morgen
  end;

  StartDial; // wählen geht hier los

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
begin
if dialing then exit;

if neuladen then
begin

 neuladen:= false;
 save_cfg;

 tarifverw.LadeTarife;

 if not disconnecting then
 if isonline and (onlineset.tarif <> '') and tarifverw.CheckOnlineset = false then //Tarif nicht mehr vorhanden
 begin
   if assigned(disconnect_leerlauf) then disconnect_leerlauf.close;
    Application.CreateForm(Tdisconnect_leerlauf, disconnect_leerlauf);
    disconnect_leerlauf.usetimer:= true;
    disconnect_leerlauf.timer1.tag:= 30;
    disconnect_leerlauf.Label1.Caption:= 'Tarif wurde verändert !';
    disconnect_leerlauf.Show;
 end;

end; //if neuladen ...

if not isonline then begin reload.enabled:= false; reload.enabled:= true; end;

if not beliebig_check.checked then
begin
 liste.tag:= 7;
 sort_descending:= false;
end;

tarifverw.loadlist;

if beliebig_check.checked then
begin
 Sort(liste,TarifProgress,liste.tag,1,liste.RowCount, true, sort_descending);
 liste.Row:=1;
 listeclick(self);
end;
//tarif auswählen
if onlineset.tarif <> '' then
begin
  for i:= 0 to liste.rowcount-1 do
  begin
   if liste.cells[1,i] = onlineset.tarif then liste.row:= i;
  end;
end;

liste.Repaint;
end;

procedure THauptfenster.OlecoClick(Sender: TObject);
var ini, initmp: textfile;
    zeile, buf: string;
    wort: string[9];
    checkexe: boolean;
    h:HWnd;
    showtime: integer;
begin
save_cfg;
checkexe:= false;

showtime := settings.Readinteger('Einwahl anzeigen','grenze',20); {Einwahlgrenze}

if (IsExeRunning('_discountsurfer.exe')    or IsExeRunning('_oleco.exe')
    or IsExeRunning('discountsurfer.exe')  or IsExeRunning('oleco.exe')
    or IsExeRunning('smartsurfer.exe'))
   then checkexe:= true
else
begin
if not webzugriff then
   begin //Logfile schreiben
   buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Onlinesession vorbereitet ('+prog+')' +
              #9+  'LeastCosterXP - Server'   +#13#10;
   webserv1.status:= buf;
   webservform.logfile_add(buf);
   end;
end;

if ansicontainstext(prog,'oleco.exe') or ansicontainstext(prog,'discountsurfer.exe') then
begin

  zeit_min:= inttostr(surfdauer.position);
  checkexe:=false;

  if fileexists(path+'lcr.ini')  then
  begin
    assignfile(ini,path+'lcr.ini');
    reset(ini);
    assignfile(initmp,path+'lcr.$$$');
    rewrite(initmp);

    repeat
          readln(ini,zeile);
          if ((zeile='PCselection=1') or (zeile='PCselection=2')) then zeile:='PCselection=0';
          if ((zeile = 'showstartpriceprov=1') and (surfdauer.Position <= showtime )) then zeile := 'showstartpriceprov=0';
          if ((zeile = 'showstartpriceprov=1') and (surfdauer.Position > showtime )) then zeile := 'showstartpriceprov=1';
          if ((zeile = 'showstartpriceprov=0') and (surfdauer.Position <= showtime )) then zeile := 'showstartpriceprov=0';
          if ((zeile = 'showstartpriceprov=0') and (surfdauer.Position > showtime )) then zeile := 'showstartpriceprov=1';
          if (zeile = 'atomtime=1') then zeile := 'atomtime=0';

          if ((settings.readinteger('Einwahl anzeigen','grenze',0)=-2) and (zeile = 'showstartpriceprov=1')) then zeile := 'showstartpriceprov=0';
          if ((settings.readinteger('Einwahl anzeigen','grenze',0)=-2) and (zeile = 'showstartpriceprov=0')) then zeile := 'showstartpriceprov=0';

          if ((settings.readinteger('Einwahl anzeigen','grenze',0)=-1) and (zeile = 'showstartpriceprov=1')) then zeile := 'showstartpriceprov=1';
          if ((settings.readinteger('Einwahl anzeigen','grenze',0)=-1) and (zeile = 'showstartpriceprov=0')) then zeile := 'showstartpriceprov=1';
          wort:= zeile;

          if wort='basetime=' then zeile:='basetime=' + zeit_min;
          writeln(initmp,zeile);
  until eof(ini);
  closefile(initmp);
  closefile(ini);
  assignfile(ini, path+'lcr.ini');
  erase(ini);
  assignfile(initmp, path+'lcr.$$$');
  rename(initmp, path+'lcr.ini');
  end;
end
else
if ansicontainstext(prog,'smartsurfer.exe') then
begin {tue was Smartsurferspezifisches }end;

//wenn Programm nicht läuft
if not checkexe then
  begin
 if fileexists(path+prog) then
  begin
   ShellExecute(handle,'open',Pchar(path+prog),Pchar ('') ,nil,SW_SHOWNORMAL);
   tray.IconVisible:= true;
//   tray.HideMainForm;
   hauptfenster.Visible:= false;
   formhidden:= true;
   if not noballoon then tray.ShowBalloonHint('Hinweis',
                            'Der LeastCoster ist nun im Tray minimiert.' + #13 +
                            'Doppelklick zum maximieren.', bitInfo, 10);
   end else timer_an.enabled:= true;
  end
else //prog läuft
begin
try
 h:=FindWindow(nil,PAnsichar(settings.ReadString('Server','Titel','')));
 postmessage(h,WM_SYSCOMMAND,SC_RESTORE,0);
 BringWindowToTop(h);
except end;
end;
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
    Absender.ulReserved:=0;
    Absender.ulRecipClass:=MAPI_ORIG;
    Absender.lpszName:= PChar(FromName);
    Absender.lpszAddress:= PChar(FromAdress);
    Absender.ulEIDSize:=0;
    Absender.lpEntryID:=nil;
    lpOriginator := @Absender;

    // Empfänger festlegen (Hier: nur 1 Empfänger)
    nRecipCount := 1;

    Empfaenger[0].ulReserved:=0;
    Empfaenger[0].ulRecipClass:=MAPI_TO;
    Empfaenger[0].lpszName:= PChar(ToName);
    Empfaenger[0].lpszAddress:= PChar(ToAdress);
    Empfaenger[0].ulEIDSize:=0;
    Empfaenger[0].lpEntryID:=nil;
    lpRecips := @Empfaenger;

    // Dateien anhängen (Hier: nur 1 Datei)
    if AttachedFileName = '' then nFileCount := 0
    else
    begin
     nFileCount := 1;

     // Name der Datei auf der Festplatte
     Datei[0].lpszPathName:= PChar(AttachedFilename);

     // Name, der in der Email angezeigt wird
     Datei[0].lpszFileName:= PChar(DisplayFilename);
     Datei[0].ulReserved:=0;
     Datei[0].flFlags:=0;
     Datei[0].nPosition:=Cardinal(-1);
     Datei[0].lpFileType:=nil;
     lpFiles := @Datei;
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
{    MAPI_E_AMBIGUOUS_RECIPIENT:
      MessageDlg('Empfänger nicht eindeutig.',mterror,[mbok],0);
    MAPI_E_ATTACHMENT_NOT_FOUND:
      MessageDlg('Datei zum Anhängen nicht gefunden',mterror,[mbok],0);

    MAPI_E_ATTACHMENT_OPEN_FAILURE:
      MessageDlg('Datei zum Anhängen konnte nicht geöffnet werden.',mterror,[mbok],0);

    MAPI_E_BAD_RECIPTYPE:
      MessageDlg('Empfängertyp nicht MAPI_TO, MAPI_CC oder MAPI_BCC.',mterror,[mbok],0);

    MAPI_E_FAILURE:
      MessageDlg('Unbekannter Fehler.',mterror,[mbok],0);

    MAPI_E_INSUFFICIENT_MEMORY:
      MessageDlg('Nicht genug Speicher.',mterror,[mbok],0);
}
    MAPI_E_LOGIN_FAILURE:
      MessageDlg('Benutzerlogin (z.B. bei Outlook) fehlgeschlagen.',mterror,[mbok],0);

    MAPI_E_TEXT_TOO_LARGE:
      MessageDlg('Text zu groß.',mterror,[mbok],0);

 {   MAPI_E_TOO_MANY_FILES:
      MessageDlg('Zu viele Dateien zum Anhängen.',mterror,[mbok],0);

    MAPI_E_TOO_MANY_RECIPIENTS:
      MessageDlg('Zu viele Empfänger angegeben.',mterror,[mbok],0);

     MAPI_E_UNKNOWN_RECIPIENT:  MessageDlg('Empfänger nicht in Adressbuch gefunden. '+
     '(Nur möglich, wenn Emailadresse nicht angegeben.)',mterror,[mbok],0);
}
    MAPI_E_USER_ABORT:
      MessageDlg('Benutzer hat Senden abgebrochen oder MAPI nicht installiert.',mterror,[mbok],0);
 {   SUCCESS_SUCCESS: begin end;
     // MessageDlg('Erfolgreich !!! (Aber Absenden nicht garantiert.)',mtinformation,[mbok],0);}
  End;
end; {Christian "NineBerry" Schwarz}

procedure THauptfenster.disconnectviatrennticker;
var buf: string;
begin
      Autodiscled.ledon:= false;
      disconnect;
      if not noballoon then
      tray.ShowBalloonHint('Hinweis','Die Verbindung wurde soeben getrennt.',bitInfo, 10);

      Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9 +'Verbindung getrennt (automatisch ausgelöst)'+#13#10;
      webserv1.status:= buf;
      webservform.logfile_add(buf);

      //Computer ausschalten wenn gewünscht
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

   dauer_takt:= 0;
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


   //Autotrennen wieder ermöglichen
   DisconnectStopped:= false;

   kontingentindex:= -1;
   if selfdial then //Kontingente
     begin
            onlineset.kostenbisjetzt:= onlineset.einwahl2/100;

            if length(Kontingente) > 0 then
               for i:= 0 to (length(Kontingente)-1) do
                  if kontingente[i].Tarif = onlineset.tarif then
                   begin
                    kontingentindex:= i;
                    break;
                   end;

            oCostlabel.Visible:= true;
    end
    else Dialstatus.text:= 'Online/Connected';

          isonline:= true;
          Aktualisieren.Enabled:= false;

          //Ausblenden der OfflineElemente und Einblenden des online-Mode
          modes.setOnlinemode;
          
           DialBtn.Font.Color:= clRed;
           DialBtn.Font.Size:= 8;
           DialBtn.caption:= '&Trennen !';

           hauptfenster.PopupMenu1.Items.Items[0].Caption:='ONLINE';
           hauptfenster.PopupMenu1.Items.Items[2].Visible:=true;
           hauptfenster.PopupMenu1.Items.Items[3].Visible:=true;
           hauptfenster.PopupMenu1.Items.Items[4].Visible:=true;
           hauptfenster.PopupMenu1.Items.Items[14].Visible:=true;
           Tray.IconIndex:=1; //Online-Tray-Symbol setzen

           hauptfenster.menu.Items.Items[1].Items[2].Enabled:= true;

           //Onlineinfo zeigen
          if selfdial and settings.readbool('Onlineinfo','show', true )
                      and (not Assigned(floatingW))
          then
            begin
             Application.CreateForm(TfloatingW, floatingW);
             floatingW.tarif.caption:= onlineset.Tarif;//edtarif.text;
            if settings.ReadBool('OnlineInfo', 'AutoWidth', true) then floatingW.setwidth;
            floatingW.valid.caption:= onlineset.vbegin + '-'+ onlineset.vend;//edtime.text;
            floatingW.preis.caption:= onlineset.preis + ' c/min';
            floatingW.Show;
           end;

           //Logfile schreiben
           buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Verbunden mit ' + MagRasCon.CurConnName +' (detection)'+#13#10;
           webserv1.status:= buf;
           webservform.logfile_add(buf);

           //Programme starten
           progcount:=0;
           loadprogs;

           //aktualisieren der tariftabelle wieder aktivieren
           reload.enabled:= true;

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
             LastXmit := MagRasPer.PerfXmitCur [0] ;
             LastRecv := MagRasPer.PerfRecvCur [0] ;
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

          ConnHandle:= 0;
          DialHandle:= 0 ;
          disconnectStopped:= false;
          actofftime:= now;
          onlineset.Endzeit:= timetostr(timeof(now));

          isonline:= false;
          leerlauf.enabled:= false;

          takt1.Visible:= false;
          takt2.Visible:= false;

          takt1.tag:= 0;
          takt1.tag:= 0;

          rsstimer.enabled:=false;
          updatetimer.enabled:= false;

          if (allow_multilink and (modemname2<>'')) then
           SetMultilink.Visible:= true else SetMultilink.Visible:= false;

          modes.setOfflineMode;

          StatLED1.LEDon:= false;
          StatLED2.LEDon:= false;

          actofftime:= Timeof(now);
          status.SimpleText:= 'Letzte Onlinesession dauerte: ' + ozeit.Caption;
          ozeit.caption:='';

          Aktualisieren.Enabled:= true;
          AktualisierenClick(nil);
          Disconnecting:= false;
          Dialbtn.Font.Color:= clWindowText;
          Dialbtn.Font.Size:= 8;
          DialBtn.caption:= '&Wählen';
          hauptfenster.PopupMenu1.Items.Items[0].Caption:='OFFLINE';
          hauptfenster.PopupMenu1.Items.Items[2].Visible:=false;
          hauptfenster.PopupMenu1.Items.Items[3].Visible:=false;
          hauptfenster.PopupMenu1.Items.Items[14].Visible:=false;
          Tray.IconIndex:=0; //setzen des Offline-Tray-Icons

          sntptimer.enabled:= false;
          //Oleco schließen und Autoexport und updaten
          if selfdial then closer.Interval:= 500
          else closer.Interval:= 10000;
          closer.Enabled:=true;

          if Assigned(floatingW) then floatingW.close;

          // OfflineElemente sichtbar machen
          surfdauer.enabled:= true;
          Dialbtn.enabled:= true;

           //Logfile schreiben
           Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Verbindung getrennt (detection)'+#13#10;
           webserv1.status:= buf;
           webservform.logfile_add(buf);

          // Programme bei offline starten
           progcountoff:=0; loadprogsoff;
           webzugriff:= false;

           OCostlabel.Visible:= false;
           hauptfenster.menu.Items.Items[1].Items[2].Enabled:= false;
           DialStatus.Text:= 'Verbindung getrennt. ('+timetostr(timeof(now))+')';
           reload.enabled:= true;

           if ( assigned(screenshot) and (not screenshot.Visible)) then screenshot.close;
           refreshall;

          //Sound
          if fileexists(settings.readstring('LeastCoster','SoundOFF',  '' )) then
              sndPlaySound(PChar(settings.readstring('LeastCoster','SoundOFF',  '' )),SND_ASYNC);

              
          ClearRasEntry;

          rssrunning:= false;

          //AutoDial anschalten, wenn offline
          if (AutoDialLed.ledon) then
          begin
            //feststellen, wie lange bis zum nächsten Zeitfenster
            Autodial.tag:= disconnectseconds + 1; //Sekunden, die vor Zeitfensterende getrennt wurde
            if autodial.tag < 10 then autodial.tag:= 10;
            Autodialtimer(self); //Countdown starten
          end;

          kontingenteWarned:= false;
          Kanalbuendelung:= false;
          Hauptfenster.Cursor:= crDefault;
          aktualisieren.click;
          refreshall;
          StartPlugins('Disconnect');
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

  //schauen ob ein parameter übergeben wurde
  If (ParamCount>0) and (FileExists(ParamStr(1)))
    then
    begin
      if ansicontainstext(paramstr(1),'.lcz') or ansicontainstext(paramstr(1),'.lcx')  then
      begin
        importfilename:=paramstr(1);
        startwithimport:= true;
        hauptfenster.MainMenueClick(Hauptfenster.MM1_1);
      end
      else showmessage('Datei '+ paramstr(1) +' ist ungültig');
    end;

end;
end;

procedure THauptfenster.beliebig_check1Click(Sender: TObject);
begin
if beliebig_check.checked then
begin
 beliebig_date.Datetime:= now;
 beliebig_time.datetime:= now;
 beliebig_date.visible:= true;
 beliebig_time.visible:= true;
end
else
begin
 aktualisieren.tag:= -1;
 beliebig_date.visible:= false;
 beliebig_time.visible:= false;
end;

 if isonline then
 begin
  takt1.Visible:= not beliebig_check.checked;
  takt2.Visible:= not beliebig_check.checked;
 end;

 aktualisierenClick(Self);
end;

procedure THauptfenster.beliebig_timeChange(Sender: TObject);
begin
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
if isonline and not rssrunning then
  begin
   RssReader.StartRssUpdate;
  end
  else
  if not isonline then
  begin
  ledrss.coloroff:= clMaroon;
  ledtimer.enabled:= false;
  LEDRSS.Hint:= 'kein RSS-Update (nicht online) ( ' + timetostr(timeof(now)) + ' )';
  end;

if rss_update > 0 then
  begin
   rsstimer.interval:= rss_update * 60*1000;
   rsstimer.enabled:= true;
  end;
end;  
end;

procedure THauptfenster.UpdateTimerTimer(Sender: TObject);
begin
updatetimer.Enabled:= false;
if not isexerunning('update.exe') then
  if settings.ReadBool('Onlinecheck','Update', true) then
    ShellExecute(handle,'open',Pchar(extractfilepath(paramstr(0))+'update.exe'),Pchar ('') ,nil,SW_SHOWNORMAL)
else updatetimer.Enabled:= true;
end;

procedure THauptfenster.FormHide(Sender: TObject);
begin
//normale anzeige einschalten und Tabelle aktualisieren
beliebig_check.checked:= false;
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
     //CTRL-Info öffnen wenn ctrl lange genug gedrückt war und liste keinen Fokus hat
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
if(keypressed(vk_CONTROL) and (msg.charcode=66) ) then shellexecute(0,'open',PChar('http://www.google.de'),nil, nil,SW_SHOWNORMAL);//label2click(self);
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
      disconnect_leerlauf.label1.caption:= 'Ihre Verbindung ist im Leerlauf.';
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
//with sender do
if ledon then hint:= 'aktiv' else hint:= 'inaktiv';

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
    //wenn Einwahlgebühr berücksichtigen, dann immer den ersten Eintrag wählen
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
         DialStatus.text:= 'Autodial failed ...';
         Status.simpletext:= 'Autodial fehlgeschlagen' +' ('+datetimetostr(now)+')';
         Autodial.interval:= 60000;
         autodial.tag:= 10; //10 Sekunden Countdown
         AutoDial.enabled:= true;
    end;     
   end;
end;

procedure THauptfenster.AutodialTimer(Sender: TObject);
begin
 autodial.enabled:= false;
 autodial.interval:= 60000; //einmal die minute reicht zu
  if not assigned(disconnect_leerlauf) then
    begin
     Application.CreateForm(Tdisconnect_leerlauf, disconnect_leerlauf);
     disconnect_leerlauf.Tag:= 2;
     disconnect_leerlauf.useConnectTimeOut:= true;
     disconnect_leerlauf.ConnectTimer.tag:= AutoDial.tag;
     disconnect_leerlauf.Label1.Caption:= 'Automatisches Verbinden';
     disconnect_leerlauf.Label3.Caption:= 'gewählt.';
     disconnect_leerlauf.Label2.Caption:= inttostr(Autodial.tag) + ' Sekunden';
     disconnect_leerlauf.trennen.visible:= false;
     disconnect_leerlauf.Show;
     end;
end;

procedure THauptfenster.ApplicationEvents1Activate(Sender: TObject);
begin
if not isonline and not dialing then Aktualisierenclick(self);
if clock.visible then time.enabled:= true;
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

if (webservform.HttpServer1.tag = 5) then //WebInterface läuft
begin
messagetext:= 'Die aktuelle IP-Adresse Ihres Computers lautet : ' + ipAdress
              + #13#10#13#10
              + 'Ihr LeastCosterXP WebInterface: http://' +ipAdress+':'+port
              + #13#10#13#10
              + '---------------------------------------'
              + #13#10#13#10
              + 'Diese eMail wurde automatisch versandt und ist ein'
              + ' Service bereitgestellt von ' + Hauptfenster.caption + ' ( http://www.leastcosterxp.de )'
              + #13#10#13#10
              + 'Keine Haftung für unerwünschtes Spamming. Sollten Sie diese eMail bekommen, ohne zu wissen warum, so wenden Sie sich direkt an den Absender.';
end
else //WebInterface läuft nicht
begin
messagetext:= 'Die aktuelle IP-Adresse Ihres Computers lautet : ' + ipAdress
              + #13#10#13#10
              + '---------------------------------------'
              + #13#10#13#10
              + 'Diese eMail wurde automatisch versandt und ist ein'
              + ' Service bereitgestellt von ' + Hauptfenster.caption + ' ( http://www.leastcosterxp.de  )'
              + #13#10#13#10
              + 'Keine Haftung für unerwünschtes Spamming. Sollten Sie diese eMail bekommen, ohne zu wissen warum, so wenden Sie sich direkt an den Absender.';
end;
SendMail('LeastCosterXP Message ' + datetimetostr(now),
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
var Files: TStringlist;
    value, path: string;
    i, j: integer;
    Updater: TSchupdater;
begin
hauptfenster.Cursor:= crHourglass;
Updater:= TSchUpdater.Create(self);
Updater.Language:= sulaDeutsch;
Updater.AutoRestartApp:= false;

Updater.SaveOriginalFiles:= settings.Readbool('Onlinecheck','BackUpUpdate', true);

if settings.Readbool('Onlinecheck','BackUpUpdate', true) //wenn Backup erstellen
  and settings.Readbool('Onlinecheck','BackUpLast', true) //und nur das letzte Backup behalten
  then //dann jetzt den BackUp-Ordner löschen
     if DirectoryExists(extractfilepath(paramstr(0)) + 'BackUp') then
        deldir(extractfilepath(paramstr(0)) + 'BackUp');


Updater.UpdateSrc:= ExtractFilepath(ParamStr(0)) + 'Updates';

if fileexists(ExtractFilepath(ParamStr(0)) + 'UpdatedFiles.dat') then
begin
  Files:= TStringList.create;
  Files.LoadFromFile(ExtractFilepath(ParamStr(0)) + 'UpdatedFiles.dat');

  //gehe alle strings durch
  for i:= 0 to Files.count -1 do
  begin
   value:= '';
   path:= '';
   j:= AnsiPos('|',Files.strings[i]);

   value:= Files.strings[i];
   Delete(Value,j, length(value)-j+1);

   if (j < length(Files.strings[i])+1) then
   begin
    Path:= Files.strings[i];
    Delete(Path,1,j);
   end;

   if not AnsiContainstext(Value,'LeastCoster.exe') then
   begin
   Updater.AppendToOtherFiles(ExtractFileName(Value),path);
   end;
  end; //ende For schleife

  Files.Free;
  if not AutoDialLED.LEDon then  
  if MessageDlg('Es wurden Dateien heruntergeladen, die jetzt ausgetauscht werden. Soll sich LeastCosterXP jetzt neu starten ? ', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then
      begin
      Updater.AutoRestartApp:= true;
      autoclose:= true;    //beenden auch zulassen
      closeallowed:= true; //beenden auch zulassen
      end;
  Updater.UpdateSrc := ExtractFilePath(ParamStr(0)) + 'Updates';
  Updater.SaveDir:= ExtractFilePath(ParamStr(0)) + 'BackUp';
  Updater.SaveOriginalFiles:= true;
  Updater.DeleteUpdateSrc:= false;

  if (Updater.DoUpdate = true) then
  begin
  Updater.DeleteUpdateDirectory;
  DeleteFile(ExtractFilepath(ParamStr(0)) + 'UpdatedFiles.dat');
  end;

  Updater.free;
  Hauptfenster.Cursor:= crDefault;
end;

end;
procedure THauptfenster.UpdaterError(Sender: TObject;
  ErrorCode: TSchSimpleUpdaterError; Parameter, ErrMessage: String);
begin
status.simpletext:= errmessage;
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
  if not ansicontainsstr(kostenstring,'abgelaufen') and not ansicontainsstr(kostenstring, 'Blacklist') then
   if (kostenstring <> '') then
    kosten := strtofloat(kostenstring);
end;

with liste do
//wenn selektiert, dann highlighten
if selected[arow] and (arow > 0) then
  begin
     Canvas.Brush.Color := clHighlight;//RGB(250,250,250);
     Canvas.FillRect(Rect);
     Canvas.Font.Color  := clHighlightText;
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
  end
else
if (useColors and ( arow >0 )) then
begin
  if liste.cells[7,arow] = 'abgelaufen' then
  begin
     Canvas.Brush.Color := StringToColor(settings.ReadString('Basics','Color_A', ColortoString(RGB(255,220,220))));
     Canvas.FillRect(Rect);
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
  end
  else
  if liste.cells[7,arow] = 'Blacklist' then
  begin
     Canvas.Brush.Color := StringToColor(settings.ReadString('Basics','Color_K', ColortoString(RGB(255,220,200))));
     Canvas.FillRect(Rect);
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
  end
  else
  if ((cells[7,arow] <> '' ) {and (cells[7,arow] <> 'Error!!!')} and (kosten = 0.0) ) then
  begin
     Canvas.Brush.Color := StringToColor(settings.ReadString('Basics','Color_K', ColortoString(RGB(230,230,250))));
     Canvas.FillRect(Rect);
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
  end
  else
  if ((cells[5,arow] <> '') and (strtofloat(cells[5,arow]) <> 0.0)) then
  begin
     Canvas.Brush.Color := StringToColor(settings.ReadString('Basics','Color_E', ColortoString(RGB(250,250,200))));
     Canvas.FillRect(Rect);
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
  end
  else
  begin
     Canvas.Brush.Color := StringToColor(settings.ReadString('Basics','Color_N', ColortoString(RGB(200,230,220))));
     Canvas.FillRect(Rect);
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
  end;
  //Persönliche Farben
  if length(Scores) > 0 then
  for l:= 0 to length(Scores)-1 do
  begin
   if (liste.cells[1,arow] = Scores[l].Name) and (Scores[l].Color<> 'none') and (not selected[arow]) then
    begin
     Canvas.Brush.Color := StringToColor(Scores[l].Color);
     Canvas.FillRect(Rect);
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
    end
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
//liste_clicked := true;

liste_last_x:= x;
liste.MouseToCell(X,Y,Column,Row);


//liste.Repaint;
//if (row < 0) then exit;
if (row > 0) then
begin
  mousedownrow:= row;

  widthl:=0;
  widthr:=0;
  with liste do
  begin
       for i:=leftcol to column-1 do widthl:= widthl + ColWidths[i] + 1 ;
       for i:=leftcol to column do widthr:= widthr + ColWidths[i] + 1;
  end;

  GridEvents.OnMouseDown(sender, x,column, row, widthl, widthr);
end;

//rechtsklick abfangen -> Menü aufrufen
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
    tarifstatus.items.items[0].enabled:= not (liste.cells[7, liste.row] = 'abgelaufen');
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
     SubEntry:= 0;//wieder auf 0 zurücksetzen
end;
end;

procedure THauptfenster.OCostLabelMouseEnter(Sender: TObject);
begin
if isonline then
with sender as TLabel do
if ansicontainsstr(caption,'> ')
 then
  hint:= 'Die Kosten können nicht berechnet werden. Der aktuelle Preis ist unbekannt !'
 else
  if ((gesamtdauer/60) >= 1.0) then
    hint:= Format('Durchschnittliche Kosten/min : %.4f €',[onlineset.kostenbisjetzt/(gesamtdauer/60)]);
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

if (liste.cells[7, liste.row] = 'Blacklist') then TS1.caption:= 'aus Blacklist entfernen'
else TS1.caption:= 'zur Blacklist hinzufügen';

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
//ScoreWert erhöhen (erfolgreich gewählt)
  if (selfdial and (IndexOfScores(onlineset.tarif)>-1)) then
  inc(Scores[IndexOfScores(onlineset.tarif)].erfolgreich);
end;

//Plugins <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

procedure TMyThread.Execute;
var ini2: TIniFile;
    i: integer;
    name: string;
    wait, disableTarife, LoadTarife, Hidden: boolean;
    run, params: string;
    enabled: boolean;
begin

  if Hauptfenster.pluglist.count > 0 then
   for i:= 0 to Hauptfenster.pluglist.count-1 do
   begin

      name:= Hauptfenster.pluglist.strings[i];
      if (hauptfenster.actevent = 'menu') and (hauptfenster.lastpluginclicked <> name) then continue;

      if FileExists(ExtractFilePath(ParamStr(0)) + 'PlugIns\' + name +'\'+ name+'.ini') then
      begin
       ini2:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PlugIns\' + name +'\'+ name+'.ini');

        wait          := ini2.ReadBool(hauptfenster.actevent,'wait', false);
        LoadTarife    := ini2.ReadBool(hauptfenster.actevent,'GetProviderList', false);
        disableTarife := ini2.ReadBool(hauptfenster.actevent,'DisableProviderSettings', false);

        run           := ini2.ReadString(hauptfenster.actevent, 'run', '');
        hidden        := ini2.ReadBool(hauptfenster.actevent, 'hidden', false);
        params        := ini2.ReadString(hauptfenster.actevent, 'params', '');

        enabled:= ini2.ReadBool('General', 'enabled', true);
       ini2.Free;

       if not enabled then continue;

       if isonline then
       begin
        params :=  Ansireplacestr(params,'%DB',ExtractFilepath(Paramstr(0)) + 'Tarife.lcx');
        params :=  Ansireplacestr(params,'%IP',hauptfenster.IPAdress);
        params :=  Ansireplacestr(params,'%Tarif',Hauptfenster.onlineset.Tarif);
       end;

       hauptfenster.TarifeDisabled:= disableTarife;
       //wenn disabled dann warten
       if disableTarife then wait:= true;

       hauptfenster.FTerminate := False;
       hauptfenster.ExecuteFile(ExtractFilePath(ParamStr(0)) + 'PlugIns\' + name+'\'+run, params, '', wait,hidden, nil{DoOnExecuteWait});

//       fertig:
       //Tarifmanager wieder aktivieren
       hauptfenster.TarifeDisabled:= false;

       //tarife einlesen
       hauptfenster.neuladen:= loadtarife;
     end;

      //wenn Klick aus dem hauptmenu, dann kommt ide Schleife hier nur beim richtigen PlugIn an
      // dann abbrechen
      if hauptfenster.actevent = 'menu' then break;
   end;
   hauptfenster.lastpluginclicked:= '';
end;

procedure THauptfenster.StartPlugIns(event: string);
var
 MyThread: TMyThread;
begin
 actevent:= event;
 MyThread:=TMyThread.Create(true);
 MyThread.Priority:=tpLower;
 MyThread.FreeOnTerminate:=true;
 MyThread.Resume;
end;

procedure THauptfenster.DoOnExecuteWait(const ProcessInfo: TProcessInformation;
                                   var ATerminate: Boolean);
begin
  ATerminate := FTerminate;
end;

//Profi-Einstellungen umschalten
procedure THauptfenster.MM3_2Click(Sender: TObject);
begin
if sender=MM3_2 then
   MM3_2.checked:= not MM3_2.checked;

if isonline then modes.setonlinemode else modes.setofflinemode;

aktualisieren.visible := MM3_2.checked;
LEDRSS.visible        := MM3_2.checked;
LEDTime.visible       := MM3_2.checked;
DialStatus.visible    := MM3_2.checked;
edtime.visible        := MM3_2.checked;
edtarif.visible       := MM3_2.checked;
beliebig_check.visible:= MM3_2.checked;
MM2_4.visible         := MM3_2.checked;
MM2_6.visible         := MM3_2.checked;
MM2_7.visible         := MM3_2.checked;
TS3.visible           := MM3_2.checked;

if MM3_2.checked then
begin
  label3.Top:= 324;
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
  label3.Top:= 280;
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

if ansicontainstext(prog,'smartsurfer') then
  begin
   oleco.Visible:= false;
   smurf.Visible:= MM3_2.Checked;
  end
  else
   if ansicontainstext(prog,'oleco') or ansicontainstext(prog,'discountsurfer') then
   begin
     oleco.Visible:= MM3_2.Checked;
     smurf.Visible:= false;
   end
 else begin hauptfenster.oleco.Visible:= false; hauptfenster.smurf.Visible:= false; end;
end;

//Atomzeit-Update
procedure THauptfenster.AtomzeitThreadExecute(Sender: TObject;
  Thread: TBMDExecuteThread; var Data: Pointer);
var   log: textfile;
      Time: TSntpSend;
      error: boolean;
      oldtime: TDateTime;
begin

error:= false;

LedTime.ColorOff:= clGray;
LedTime.Hint:= 'Atomzeit-Update um '+ timetostr(timeof(now)) + ' gestartet';

if not isonline or (atomserver.count = 0) then
begin //wenn offline tue nix
      menu.Items.Items[1].Items[2].items[1].Enabled:= true;
      timeupdaterunning:= false;
      exit;
end;

menu.Items.Items[1].Items[2].items[1].Enabled:= false;

if (IPAdress = '0.0.0.0') or (IPAdress='') then
begin // wenn keine IP, dann setze eine Runde aus
      menu.Items.Items[1].Items[2].items[1].Enabled:= true;
      sntptimer.interval:= 5000;
      sntptimer.Enabled:= true;
      timeupdaterunning:= false;
      exit;
end;

//Atomzeitserver setzen
 if atomcount < atomserver.Count then
 begin

//Datei anlegen, wenn sie nicht existiert und öffnen
     assignfile(log,extractfilepath(paramstr(0))+'log\atomzeit.txt');
     if fileexists( extractfilepath(paramstr(0))+'log\atomzeit.txt') then
     append(log)
     else begin
      rewrite(log);
      writeln(log,'alte Zeit' + chr(9) + 'neue Zeit' + chr(9) + 'Zeitdifferenz in s'+ chr(9) + 'Server');
     end;
 //zeile hinzufügen
      writeln(log,datetimetostr(now) +chr(9)+'Starte Atomzeit-Update mit ' + atomserver.strings[atomcount]);

     time:= TSNTPSend.Create;
   try
     time.TargetHost:= atomserver.strings[atomcount];
     time.SyncTime:= true;
     time.Timeout:= 10000;
     time.MaxSyncDiff:= 1.7*10E308;

     atomcount:= atomcount+1;
     if atomcount = atomserver.Count then atomcount:= 0;

    oldtime:= now;
    if time.GetSNTP = true then
     begin
      writeln(log,datetimetostr(oldtime) +chr(9)+datetimetostr(now)+ chr(9)+timetostr(now-oldtime) + chr(9) + time.targethost);
      menu.Items.Items[1].Items[2].items[1].Enabled:= true;

      LEDTime.ColorOff:= cllime;
      LEDTime.ledon:= false;
      LedTime.Hint:= 'Erfolgreiches Atomzeit-Update um '+ timetostr(timeof(now));
   end
   else //wenn nicht erfolgreiches update
   begin
    writeln(log,datetimetostr(now) + chr(9) + 'Fehler beim Verbinden mit '+time.targethost );
    sntptimer.interval:= 5000;
    error:= true;
   end;

  finally
    time.Free;
    closefile(log);
   end;
  end;

 if error then
 begin
     sntptimer.Enabled:= true; //wenn nicht erfolgreich nochmal starten
     timeupdaterunning:= false;
     exit;
 end;

//wenn erfolgreich, dann neues Interval setzen
sntptimer.interval:= settings.ReadInteger('Onlinecheck','Atominterval', 60)*60000;
//nur neu starten, wenn wiederholt werden soll
sntptimer.Enabled:= settings.ReadBool('Onlinecheck','AtomRepeat',false);
timeupdaterunning:= false;
end;

// Menüs #######################################################################
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

// Menüs ENDE ##################################################################

//~~~~~~~~~~~~~~~~~~~~~~~~~TARIFTABELLE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure THauptfenster.ListeClick(Sender: TObject);
var k, index: integer;
begin
index:= -1;

if (not isonline) and (not dialing) then
begin
 //Tarif setzen
  edtarif.text:= liste.cells[1,liste.row];
 //Zeitraum setzen
  if (liste.cells[2,liste.Row]=liste.cells[3,liste.Row]) then
     edtime.text:='ganztags'
    else edtime.text:= liste.cells[2,liste.row] +'-'+liste.cells[3,liste.row];
 //Rufnummer setzen
  ednumber.text:= liste.cells[8,liste.row];

 //Kosten setzen
  costs.Font.Color:= clWindowtext;

  if ( (liste.cells[7,liste.row]='abgelaufen') or (liste.cells[7,liste.row]='Blacklist')) then
  begin
    costs.Font.Color:= clred;
    if (liste.cells[7,liste.row]='abgelaufen') then costs.Text:= 'ungültig seit ' + liste.cells[13,liste.row]
    else costs.text:= 'Blacklist';
  end
  else
  if ( (length(kontingente) > 0) and (liste.cells[7,liste.row]='0,0000')) then
  begin
    for k:=0 to length(kontingente)-1 do if kontingente[k].Tarif = edtarif.text then begin index:= k; break; end;
      if (index > -1) then
       begin
        if kontingente[index].freikB > 0 then
         costs.text:= Format('noch frei %05f MB',[kontingente[index].freikB/1024])
        else
        if kontingente[index].freisekunden > 0 then
          costs.text:= Format('noch ca. frei %5.0f min',[kontingente[index].freisekunden/60])
       end;
      end
   else   costs.Text:=liste.cells[7,liste.row] + ' €';

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
var i: integer;
    thiscol, thisrow: integer;
    selectedtext: string;
    selrow,c: integer;
begin
liste.MouseToCell(x,y,thiscol, thisrow);

if row < 0 then begin liste.repaint; exit; end;

for i:=0 to liste.ColCount -1 do
  if (liste.ColWidths[i] > liste.width) then liste.ColWidths[i]:= liste.Width-15;

if ((row = 0) and (abs(x-liste_last_x) <3)) then
  begin
     selectedtext:= liste.cells[1,liste.row];

     if liste.Tag = column then sort_descending:= not sort_descending else sort_descending:= false;
      liste.Tag:= column;

     case column of
    -1: begin end;
    4,5,7:Sort(liste,TarifProgress,column,1,liste.RowCount, true, sort_descending);
     else Sort(liste,TarifProgress,column,1,liste.RowCount, false, sort_descending); end;

     //selektierten Eintrag wieder selektieren
     selrow:= 1;
     if liste.rowcount > 2 then
     for c:= 1 to liste.rowcount -1 do if (selectedtext = liste.cells[1, c]) then begin selrow:= c; break; end;

     liste.Row:= selrow;
     //alle deselektieren
     for c:= 0 to length(selected) -1 do selected[c]:= false;
     selected[selrow]:= true;

   liste.Repaint;
  end
else
begin

//wenn nicht ctrl gedrückt, dann alle anderen selektions vergessen
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
//wenn nicht ctrl gedrückt, dann alle anderen selektions vergessen
if not (ssctrl in shift) then
    for i:=0 to length(selected)-1 do selected[i]:= false;
 if liste.row > 0 then selected[liste.row]:= true;
 liste.repaint;

end;

procedure THauptfenster.ListeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i: integer;
begin

//wenn nicht ctrl gedrückt, dann alle anderen selektions vergessen
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

end.
