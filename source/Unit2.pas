unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, ExtCtrls, StrUtils,
  Spin, Grids, shellapi, files, inifiles,webserv1,
  ICSMD5, ValEdit,mmsystem, ComCtrls, magsubs1;

var editpath: string;

type TAutorunKind = (akUserRun, akUserRunOnce, akRun, akRunOnce, akRunServices, akRunServicesOnce);
type
  TLCXPSettings = class(TForm)
    open: TOpenDialog;
    Memo1: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    beenden: TBitBtn;
    TabSheet8: TTabSheet;
    Label27: TLabel;
    AutoEinwahl: TGroupBox;
    GroupBox2: TGroupBox;
    autotrennen: TCheckBox;
    autotrennenask: TCheckBox;
    autotrennenwaitval: TSpinEdit;
    Label29: TLabel;
    autotrennenwait: TRadioButton;
    autotrennenconfirm: TRadioButton;
    GroupBox3: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    leerlauf: TCheckBox;
    leerlaufminuten: TSpinEdit;
    leerlaufask: TCheckBox;
    leerlaufwait: TRadioButton;
    leerlaufwaitval: TSpinEdit;
    leerlaufconfirm: TRadioButton;
    GroupBox6: TGroupBox;
    Label24: TLabel;
    Label23: TLabel;
    SoundOn: TEdit;
    SoundOff: TEdit;
    Label25: TLabel;
    SoundOffBut: TButton;
    SoundOnBut: TButton;
    GroupBox7: TGroupBox;
    OnlineInfo: TCheckBox;
    Label17: TLabel;
    bgedit: TEdit;
    bgbutton: TButton;
    GroupBox9: TGroupBox;
    modemlabel: TLabel;
    Device: TComboBox;
    vorwahllabel: TLabel;
    edvorwahl: TEdit;
    GroupBox11: TGroupBox;
    BitBtn2: TBitBtn;
    programs_add: TBitBtn;
    programs_params: TEdit;
    programs_path: TEdit;
    programs_kill: TCheckBox;
    Programs: TComboBox;
    BitBtn3: TBitBtn;
    programs_online: TRadioButton;
    programs_offline: TRadioButton;
    programs_style: TComboBox;
    programs_mintime: TSpinEdit;
    programs_timeout: TSpinEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label19: TLabel;
    programs_suchen: TSpeedButton;
    GroupBox12: TGroupBox;
    label_min: TLabel;
    RssUpdate: TSpinEdit;
    Label13: TLabel;
    Button4: TButton;
    Button5: TButton;
    RssList: TValueListEditor;
    rssdown: TBitBtn;
    rssup: TBitBtn;
    Label14: TLabel;
    noFeeds: TCheckBox;
    settingbox: TGroupBox;
    minimiert: TCheckBox;
    noBalloon: TCheckBox;
    autostart: TCheckBox;
    GroupBox16: TGroupBox;
    Leerlaufsound: TEdit;
    leerlaufsoundbut: TButton;
    LeerlaufPlaySound: TCheckBox;
    GroupBox17: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    gelb: TEdit;
    rot: TEdit;
    Button6: TButton;
    DaystoSaveLogs: TSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    Button3: TButton;
    Button7: TButton;
    Leerlaufschwelle: TSpinEdit;
    Label12: TLabel;
    Label28: TLabel;
    Button8: TButton;
    GroupBox1: TGroupBox;
    AutoAus: TComboBox;
    AutoConnectOnStart: TCheckBox;
    AutoReConnect: TCheckBox;
    AutoConnectEinwahl: TCheckBox;
    AutoSurfdauer: TTrackBar;
    Label30: TLabel;
    Label33: TLabel;
    GroupBox10: TGroupBox;
    Label6: TLabel;
    Label37: TLabel;
    Atombox: TCheckBox;
    showatomlog: TButton;
    serverdelete: TButton;
    Serveraddbutton: TButton;
    Serveradd: TEdit;
    Serverbox: TComboBox;
    AtomInterval: TSpinEdit;
    GroupBox18: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    ipmail_name: TEdit;
    ipmail_adress: TEdit;
    ipmail_active: TCheckBox;
    GroupBox19: TGroupBox;
    Label15: TLabel;
    forwardtable: TSpinEdit;
    Label16: TLabel;
    hidetray: TCheckBox;
    GroupBox8: TGroupBox;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    atomrepeat: TCheckBox;
    left: TButton;
    right: TButton;
    Multilink: TCheckBox;
    Device2: TComboBox;
    setupmodems: TCheckBox;
    autotrennen_konti: TCheckBox;
    Label36: TLabel;
    opendays: TSpinEdit;
    Label38: TLabel;
    GroupBox22: TGroupBox;
    keepfiles: TCheckBox;
    updatebox: TCheckBox;
    Button10: TButton;
    Label39: TLabel;
    DisconnectSeconds: TSpinEdit;
    TabSheet9: TTabSheet;
    GroupBox20: TGroupBox;
    Label41: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    AutoBlacklist: TSpinEdit;
    Label43: TLabel;
    Label44: TLabel;
    AutoBlackListScore: TSpinEdit;
    Label45: TLabel;
    GroupBox23: TGroupBox;
    DFUE: TButton;
    DFUE2: TButton;
    keepfiles_one: TCheckBox;
    TabSheet10: TTabSheet;
    GroupBox24: TGroupBox;
    unregister: TButton;
    register: TButton;
    readme: TMemo;
    PlugBox: TListBox;
    Label46: TLabel;
    Label47: TLabel;
    plugSettings: TButton;
    State: TStaticText;
    activate: TButton;
    GroupBox25: TGroupBox;
    InfoBG: TLabel;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    InfoSpecialText: TLabel;
    InfoText: TLabel;
    minimize: TCheckBox;
    SetOnlineInfoWidth: TCheckBox;
    time: TCheckBox;
    Rss_oldItems: TCheckBox;
    Rss_maxitems: TSpinEdit;
    Label49: TLabel;
    Label50: TLabel;
    FontDialog1: TFontDialog;
    Fontedit: TEdit;
    FontB: TButton;
    Label18: TLabel;
    OpenWebsite: TCheckBox;
    AutoConnectInterval: TSpinEdit;
    Label48: TLabel;
    AutoD_start: TDateTimePicker;
    AutoD_End: TDateTimePicker;
    AutoD: TCheckBox;
    Label51: TLabel;
    AutoD_Day: TComboBox;
    Button9: TButton;
    Button11: TButton;
    AutoL: TValueListEditor;
    UseAutoBlacklist: TCheckBox;
    TabSheet2: TTabSheet;
    holidays: TValueListEditor;
    holicheck: TLabel;
    holiday_delete: TButton;
    holiday_insert: TButton;
    procedure holiday_insertClick(Sender: TObject);
    procedure holiday_deleteClick(Sender: TObject);
    procedure holidaysValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: string);
    procedure plugSettingsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure unregisterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure registerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure activateMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox24MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Rss_oldItemsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Rss_maxitemsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RssUpdateMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure noFeedsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UseAutoBlacklistClick(Sender: TObject);
    procedure GroupBox20MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AutoLMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AutoDMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label30MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AutoConnectEinwahlMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure AutoConnectIntervalMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure AutoReConnectMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AutoConnectOnStartMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LeerlaufPlaySoundMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DisconnectSecondsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autotrennenconfirmMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure autotrennenwaitMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autotrennenaskMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autotrennen_kontiMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autotrennenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DFUE2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DFUEMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ipmail_adressMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ipmail_nameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ipmail_activeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure atomrepeatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ServerboxEnter(Sender: TObject);
    procedure rightMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure leftMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure GroupBox10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure InfoSpecialTextMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure InfoBGMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure InfoTextMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FonteditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure bgeditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SetOnlineInfoWidthMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure OnlineInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure keepfiles_oneMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure keepfilesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure updateboxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label23MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure programs_addMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure opendaysMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure programs_mintimeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure programs_timeoutMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure programs_paramsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure programs_pathMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure programs_killMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OpenWebsiteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure hidetrayMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label15MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure vorwahllabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MultilinkMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure modemlabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure setupmodemsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure gelbMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Button7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DaystoSaveLogsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure noBalloonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure timeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure minimizeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure minimiertMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autostartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AutoDClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FontBClick(Sender: TObject);

    procedure beendenClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure autostartClick(Sender: TObject);
    procedure serverdeleteClick(Sender: TObject);
    procedure ServeraddbuttonClick(Sender: TObject);
    procedure showatomlogClick(Sender: TObject);
    procedure gelbChange(Sender: TObject);
    procedure rotChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure edvorwahlKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure rssupClick(Sender: TObject);
    procedure rssdownClick(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox3Change(Sender: TObject);
    procedure bgbuttonClick(Sender: TObject);
    procedure OnlineInfoClick(Sender: TObject);
    procedure loadprogramstrings(activate: string);
    procedure FormCreate(Sender: TObject);
    procedure programs_suchenClick(Sender: TObject);
    procedure programs_addClick(Sender: TObject);
    procedure ProgramsCloseUp(Sender: TObject);
    procedure programs_offlineClick(Sender: TObject);
    procedure programs_onlineClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SoundOnButClick(Sender: TObject);
    procedure noFeedsClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure autotrennenaskClick(Sender: TObject);
    procedure autotrennenwaitClick(Sender: TObject);
    procedure autotrennenClick(Sender: TObject);
    procedure leerlaufClick(Sender: TObject);
    procedure leerlaufaskClick(Sender: TObject);
    procedure leerlaufwaitClick(Sender: TObject);
    procedure LeerlaufPlaySoundClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure AutoSurfdauerChange(Sender: TObject);
    procedure atomrepeatClick(Sender: TObject);
    procedure AtomboxClick(Sender: TObject);
    procedure ipmail_activeClick(Sender: TObject);
    procedure rightClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure MultilinkClick(Sender: TObject);
    procedure setupmodemsClick(Sender: TObject);
    procedure DFUEClick(Sender: TObject);
    procedure DFUE2Click(Sender: TObject);
    procedure keepfilesClick(Sender: TObject);
    procedure registerClick(Sender: TObject);
    procedure PlugBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure unregisterClick(Sender: TObject);
    procedure plugSettingsClick(Sender: TObject);
    procedure activateClick(Sender: TObject);
    Procedure PlugOnMouseUp;
    procedure LoadAutoL;

   private
    { Private declarations }
     resetlastdate: boolean;
     onlineprogs, offlineprogs: TStringlist;
     mode_online, mode_change: boolean;
  public
    { Public declarations }

  end;

var

  LCXPSettings: TLCXPSettings;

implementation

uses Unit1, addons, registry, floating, DateUtils, ZLIBArchive, RegExpr, tarifverw, inilang, messagestrings;

{$R *.dfm}

procedure TLCXPSettings.LoadAutoL;
var i: integer;
begin
Autol.strings.Clear;
for i:= 0 to length(Hauptfenster.AutoDialTimes) -1 do
  AutoL.InsertRow(AutoD_day.Items.Strings[Hauptfenster.AutoDialTimes[i].tag],
                       Timetostr(Hauptfenster.AutoDialTimes[i].von) + ' - ' +
                       Timetostr(Hauptfenster.AutoDialTimes[i].bis),
                      true);
end;

function CreateAutorunEntry(const AName, AFilename: String; const AKind: TAutorunKind; delete: boolean): Boolean;
var
 Reg: TRegistry;
begin
 Result:=False;
 Reg := TRegistry.create;
 try

   if (AKind=akUserRun) or (AKind=akUserRunOnce) then
     Reg.Rootkey:= HKEY_CURRENT_USER
   else
     Reg.RootKey := HKEY_LOCAL_MACHINE;

   case AKind of
     akRun, akUserRun        : Result:=Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
     akRunOnce, akUserRunOnce: Result:=Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\RunOnce', True);
     akRunServices           : Result:=Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\RunServices', True);
     akRunServicesOnce       : Result:=Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\RunServicesOnce', True);
   end;

   if not delete then
   begin
   Reg.WriteString(AName, AFilename);
   end
   else
   begin
   reg.DeleteValue(AName)
   end;
 finally
   Reg.Free;
 end;
end;

procedure TLCXPSettings.BitBtn1Click(Sender: TObject);
begin
  bitBtn1.caption:= misc(M119,'M119');
  edit2.Text:= getlocalips;
end;

procedure copy(sourcefilename, targetfilename: string);
Var
   S,T: TFileStream;

 Begin
   S:=TFileStream.Create( sourcefilename, fmOpenRead );
   try
     T:=TFileStream.Create( targetfilename, fmOpenWrite );
     try
        T.CopyFrom(S, S.Size ) ;
     finally
        T.Free;
     end;
   finally
      S.Free;
   end;
  End;

procedure saveholidays;
var holi: Tholidays;
    f   : file of THolidays;
    i   : integer;
    err: boolean;
begin
with LCXPsettings do
begin
  assignfile(f, extractfilepath(paramstr(0))+'holidays.dat');
  rewrite(f);

  setlength(holidaylist,0);

  for i:= 1 to holidays.rowcount-1 do
  begin
   err:= false;
   holi.name:= holidays.Keys[i];
   try
    holi.date:= strtodate(holidays.Strings.ValueFromIndex[i-1]);
   except
    err:= true;
   end;
   if not err then
   begin
    write(f,holi);
    setlength(holidaylist,i);
    holidaylist[i-1]:= holi;
   end;
  end;
 closefile(f);
end;
end;

procedure TLCXPSettings.beendenClick(Sender: TObject);
var i: integer;
begin

  saveholidays;

  //IP speichern
  settings.writestring('lokale IP','IP',Edit2.text);
 //Notification
  settings.writebool('lokale IP','IP_Notify',ipmail_active.checked);
  settings.writestring('lokale IP','IP_Notify_Name',ipmail_name.text);
  settings.writeString('lokale IP','IP_Notify_Adress',ipmail_adress.text);

  settings.writeBool('LeastCoster','autostart',autostart.Checked);
  settings.writeBool('LeastCoster','minimiert',minimiert.checked);

  settings.writebool('LeastCoster','MinimizeOnClose', minimize.checked);
  settings.writeinteger('LeastCoster','DaysToSaveLogs', DaysToSaveLogs.Value);
  Hauptfenster.DaysToSaveLogs:= DaysToSaveLogs.Value;
  Hauptfenster.minimizeonclose:= minimize.checked;
  settings.writebool('LeastCoster','noBalloon', noBalloon.checked);
  settings.writestring('LeastCoster','SoundON',   soundon.text );
  settings.writestring('LeastCoster','SoundOFF',   soundoff.text );

  hauptfenster.noBalloon:= noBalloon.checked;

  hauptfenster.clock.visible:= time.checked;
  if not hauptfenster.clock.visible then hauptfenster.DateLabel.Constraints.MaxWidth:= 402
                                    else hauptfenster.DateLabel.Constraints.MaxWidth:= 222;

  //Dialerfunktion
  settings.writeBool('Dialer','SetUpModem', not setupmodems.checked);
  settings.writestring('Dialer','Device', Device.Items.Names[Device.ItemIndex]);
  settings.writestring('Dialer','Devicetype',device.Items.Values[Device.Items.Names[Device.ItemIndex]]);

  settings.writeBool('Dialer','Multilinkallowed', multilink.checked);
  settings.writestring('Dialer','Device2', Device2.Items.Names[Device2.ItemIndex]);
  settings.writestring('Dialer','Devicetype2',device2.Items.Values[Device2.Items.Names[Device2.ItemIndex]]);

  settings.writestring('Dialer','Vorwahl',edVorwahl.text);
  settings.writebool('Dialer','Tray',hidetray.Checked);
  settings.Writebool('Dialer','OpenWeb',openWebsite.checked);

  hauptfenster.SetUpModems:= not setupmodems.checked; 
  hauptfenster.modemname:=Device.Items.Names[Device.ItemIndex];
  Hauptfenster.modemtype:=device.Items.Values[Device.Items.Names[Device.ItemIndex]];

  hauptfenster.allow_multilink:= multilink.checked;
  Hauptfenster.setMultilink.visible:= multilink.checked;
  if multilink.checked then
  begin
  hauptfenster.modemname2:=Device2.Items.Names[Device2.ItemIndex];
  Hauptfenster.modemtype2:=device2.Items.Values[Device2.Items.Names[Device2.ItemIndex]];
  end
  else
  begin
   hauptfenster.modemname2:='';
   Hauptfenster.modemtype2:='';
  end;

  if (multilink.checked and (hauptfenster.modemname2='')) then hauptfenster.SetMultilink.Visible:= false;

  Hauptfenster.modemstring:= edVorwahl.text;

  //OnlineInfo
  settings.writebool('Onlineinfo','show', onlineinfo.checked );
  settings.writestring('Onlineinfo','BGColor',   colorbox1.Items.Strings[colorbox1.ItemIndex] );
  settings.writestring('Onlineinfo','TextColor',   colorbox2.Items.Strings[colorbox2.ItemIndex] );
  settings.writestring('Onlineinfo','SpecialTextColor',   colorbox3.Items.Strings[colorbox3.ItemIndex] );
  settings.writestring('Onlineinfo','BGImage',   bgedit.text );
  if fontedit.Text = '' then fontedit.Text:= 'MS Sans Serif';
  settings.writestring('Onlineinfo','Font',   fontedit.text );

  settings.writeBool('OnlineInfo', 'AutoWidth', SetOnlineInfoWidth.Checked);

  //Autotrennen
  settings.writebool('Autotrennen','Enabled',autotrennen.Checked);
  settings.writebool('Autotrennen','Ask',autotrennenask.Checked);
  settings.writebool('Autotrennen','UseDelay',autotrennenwait.Checked);
  settings.writeinteger('Autotrennen','Delay',autotrennenwaitval.value);
  settings.writebool('Autotrennen','WaitForUser',autotrennenconfirm.checked);
  settings.writeinteger('Autotrennen','DisconnectSeconds',Disconnectseconds.value);
  Hauptfenster.disconnectseconds:= Disconnectseconds.value;

  hauptfenster.Autodiscled.ledon:= autotrennen.Checked;
  hauptfenster.trennask.Checked:= autotrennenask.Checked;
  hauptfenster.Autodisconnect.Enabled:= autotrennen.Checked;
  hauptfenster.Autodisconnect.Ask:= autotrennenask.Checked;
  hauptfenster.Autodisconnect.UseDelay:= autotrennenwait.Checked;
  hauptfenster.Autodisconnect.WaitforUser:=autotrennenconfirm.checked;
  hauptfenster.Autodisconnect.Delay:= autotrennenwaitval.value;

  settings.writebool('Autotrennen','Kontingente',autotrennen_konti.checked);

  settings.WriteBool('AutoBlacklist','active',UseAutoBlacklist.checked);
  settings.Writeinteger('AutoBlacklist','Value',AutoBlacklist.Value);
  settings.Writeinteger('AutoBlacklist','Score',AutoBlacklistScore.Value);

  //Leerlauf
  settings.writebool('Leerlauf','Enabled',leerlauf.Checked);
  settings.writeinteger('Leerlauf','LeerlaufZeit',leerlaufminuten.Value);
  settings.writebool('Leerlauf','Ask',leerlaufask.Checked);
  settings.writebool('Leerlauf','UseDelay',leerlaufwait.Checked);
  settings.writeinteger('Leerlauf','Delay',leerlaufwaitval.value);
  settings.writebool('Leerlauf','WaitForUser',leerlaufconfirm.checked);
  settings.writebool('Leerlauf','PlaySound', leerlaufplaysound.checked);
  settings.WriteString('Leerlauf','Sound', leerlaufsound.text);
  settings.writeinteger('Leerlauf','Schwelle',leerlaufschwelle.value);

  Hauptfenster.AutoLeerlaufLed.LedOn:=leerlauf.Checked;
  Hauptfenster.leerlaufboxask.Checked:=leerlaufask.Checked;
  Hauptfenster.Leerlaufdisconnect.Enabled:= leerlauf.Checked;
  Hauptfenster.Leerlaufdisconnect.Ask:= leerlaufask.Checked;
  Hauptfenster.Leerlaufdisconnect.UseDelay:= leerlaufwait.Checked;
  Hauptfenster.Leerlaufdisconnect.WaitforUser:= leerlaufconfirm.Checked;
  Hauptfenster.Leerlaufdisconnect.Delay:= leerlaufwaitval.value;
  Hauptfenster.Leerlaufdisconnectzeit:= leerlaufminuten.Value;
  hauptfenster.leerlaufschwelle:= leerlaufschwelle.value;

  //Ausschalten nach Auto-Trennen
  settings.writeinteger('Ausschalten','Value',AutoAus.ItemIndex);
  hauptfenster.AutoAusindex:= AutoAus.ItemIndex;
  Hauptfenster.Autoaus.itemindex:=AutoAus.ItemIndex;

  //AutoVerbinden
  settings.writebool('AutoConnect','AutoStartConnect',AutoConnectOnStart.Checked);
  settings.writebool('AutoConnect','AutoReConnect',AutoReConnect.Checked);
  settings.writebool('AutoConnect','mitEinwahl',AutoConnectEinwahl.Checked);
  settings.writeinteger('AutoConnect','Basiszeit',AutoSurfdauer.position);
  settings.writeinteger('AutoConnect','Interval', AutoConnectInterval.Value);

  settings.WriteBool    ('AutoConnect','atTime', AutoD.Checked);
  //die Einwahlzeiten speichern
  SaveAutoDialTimes;
  hauptfenster.AutoSurfdauer      := AutoSurfdauer.position;

  hauptfenster.AutoDialLED.ledon:= AutoReConnect.Checked;
  hauptfenster.Autobasis.caption:= inttostr(AutosurfDauer.position div 60) + ' h '+ inttostr(AutosurfDauer.position mod 60) +' min';
  hauptfenster.AutoBase.position:= Autosurfdauer.position;
  hauptfenster.AutoDialEinwahl.Checked:= AutoConnectEinwahl.Checked;

  Hauptfenster.AutoDialStatus.Visible:= settings.ReadBool('AutoConnect','atTime', false);
  Hauptfenster.AutoDialStatus.LEDON:= settings.ReadBool('AutoConnect','atTime', false);

  if (assigned(floatingW)and (not isonline)) then floatingW.Close;

  //Atomzeit und Update
   settings.writeBool('Onlinecheck','Atomzeit',Atombox.Checked);
   settings.writeBool('Onlinecheck','Update',Updatebox.Checked);
   settings.writebool('Onlinecheck','BackUpUpdate', keepfiles.checked);
   settings.writebool('Onlinecheck','BackUpLast', keepfiles_one.checked);
   settings.writeInteger('Onlinecheck','AtomInterval',AtomInterval.Value);
   settings.writeBool('Onlinecheck','AtomRepeat',AtomRepeat.Checked);

   if (settings.ReadBool('Onlinecheck','Atomzeit', false) <> Atombox.Checked) then
   with hauptfenster.ledTime do
   if not atombox.checked then
   begin
        Coloroff:= clgray;
        LEDOn:= false;
        Hint:= misc(M45,'M45');
   end
   else
   begin
        Coloroff:= clMaroon;
        LEDOn:= false;
        Hint:= misc(M122,'M122');
   end;

  settings.writeinteger('Onlinecheck','Vorschub',forwardtable.Value);
  hauptfenster.lookforward:= forwardtable.Value;

  //Rss-Update
  settings.writeInteger('RSS','Update',Rssupdate.Value);
  settings.writebool('RSS', 'noFeeds', noFeeds.checked);
  settings.writebool('RSS', 'oldFeeds', Rss_olditems.checked);
  settings.writeinteger('RSS','maxItems', Rss_maxitems.Value);

  hauptfenster.rss_update := rssupdate.value;
  hauptfenster.Rss_max    := Rss_maxitems.Value;
  hauptfenster.rss_old    := Rss_olditems.checked;

   if (noFeeds.checked <> hauptfenster.nofeeds) then
    if nofeeds.checked then
     begin
          hauptfenster.ledRss.ColorOff:= clGray; hauptfenster.ledrss.Hint:= misc(M46,'M46');
     end
     else
     begin
          hauptfenster.ledRss.ColorOff:= clMaroon; hauptfenster.ledrss.Hint:= misc(M123,'M123');
     end;

   hauptfenster.nofeeds:= nofeeds.checked;

 //Kostenprotokolle
    if gelb.text='' then gelb.Text:= '10';
    if rot.text='' then gelb.Text:= '15';
    settings.WriteString('Kostengrenzen','rot',rot.text); {Kostengrenzen rot/ gelb}
    settings.WriteString('Kostengrenzen','gelb', gelb.text);

  //lösche die section [lastdate]
    if resetlastdate then settings.EraseSection('lastdate');

 //Einstellungen auf die Platte schreiben
 settings.UpdateFile;

 SettingsOnline.UpdateFile;
 SettingsOffline.UpdateFile;

 //Atomzeitserver auf die Platte speichern
 serverbox.Items.SaveToFile(extractfilepath(paramstr(0))+'Atomzeitserver.txt');
 //Atomzeitserver im Speicher aktualisieren
 atomserver.clear;
 atomserver.Assign(serverbox.items);

 //Leere Zeilen in der Rsslist löschen
 if rsslist.RowCount > 3 then
 for i:= rsslist.RowCount-2 downto 1 do
 begin
     //leerzeichen entfernen
      rsslist.Values[rsslist.Keys[i]]:= trim(rsslist.Values[rsslist.Keys[i]]);

     //leere Bezeichner setzen
     if (rsslist.Values[rsslist.Keys[i]] <> '')
        and (rsslist.Values[rsslist.Keys[i]] <> 'http://')
        and (rsslist.keys[i] = '')
      then rsslist.Keys[i]:= 'RSS'+ inttostr(i);

      if (rsslist.Strings[i] = '=')
               then begin  rsslist.DeleteRow(i+1); end;
 end;

 //abspeichern
 rsslist.Strings.SaveToFile(extractfilepath(paramstr(0)) + 'Rsslist.txt');

 LCXPSettings.Close;
end;

procedure TLCXPSettings.autostartClick(Sender: TObject);
begin
// letzter Parameter: true, wenn key zu löschen/ false wenn nicht
if autostart.checked = true then
CreateAutorunEntry(Application.Title,'"'+ParamStr(0)+'"', akRun,false)
else
CreateAutorunEntry(Application.Title,'"'+ParamStr(0)+'"', akRun,true);
end;

function ActiveCaption(): string;
var
  Handle: THandle;
  Len: LongInt;
  Title: string;
begin
  Result := '';
  Handle := GetForegroundWindow;
  if Handle <> 0 then
  begin
    Len := GetWindowTextLength(Handle) + 1;
    SetLength(Title, Len);
    GetWindowText(Handle, PChar(Title), Len);
    ActiveCaption := TrimRight(Title);
  end;
end;

procedure TLCXPSettings.serverdeleteClick(Sender: TObject);
begin
  serverbox.Items.Delete(serverbox.ItemIndex);
  serverbox.ItemIndex:=0;
end;

procedure TLCXPSettings.ServeraddbuttonClick(Sender: TObject);
begin
  if serveradd.text <> '' then serverbox.Items.append(serveradd.Text);
  serveradd.text:='';
end;

procedure TLCXPSettings.showatomlogClick(Sender: TObject);
begin
  if fileexists(extractfilepath(paramstr(0))+'log\atomzeit.txt') then
    ShellExecute(0,'open',Pchar(extractfilepath(paramstr(0))+'log\atomzeit.txt'),'' ,nil,SW_SHOWNORMAL)
end;

procedure TLCXPSettings.gelbChange(Sender: TObject);
var code, value: integer;
     temp: string;
begin
 temp:= gelb.Text;
  val(temp,value,code);
 if code <> 0 then begin delete(temp,code,1); gelb.text:= temp; end;
 if value <= 0 then gelb.text:= '1';
end;

procedure TLCXPSettings.rotChange(Sender: TObject);
var code, value1,value2: integer;
    temp: string;
begin
 temp:= rot.Text;
  val(temp,value1,code);
 if code <> 0 then begin delete(temp,code,1); rot.text:= temp; end;
  val(gelb.text,value2, code);
 if value2 >= value1 then rot.text:= inttostr(value1+1); 
end;

procedure TLCXPSettings.Button3Click(Sender: TObject);
begin
 gelb.text := '10';
 rot.Text  := '15';
end;

procedure TLCXPSettings.edvorwahlKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9',',','#','*','+','-', Char(VK_BACK)]) then
  Key := #0;
end;

procedure TLCXPSettings.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
onlineprogs.Free;
offlineprogs.free;

hauptfenster.enabled:= true;
if not hauptfenster.Visible then hauptfenster.Visible:= true;
LCXPSettings.Release;
LCXPSettings:= nil;
end;

procedure TLCXPSettings.Button5Click(Sender: TObject);
begin
rsslist.insertrow('','',true);
end;

procedure TLCXPSettings.Button4Click(Sender: TObject);
var filename: string;
    f: textfile;
begin
if (rsslist.Keys[RSSList.row]<>'LeastCosterXP') then
begin
filename:= extractfilepath(paramstr(0)) + 'RSS\'+rsslist.Keys[rsslist.row] + '.xml';
RssList.DeleteRow(rsslist.Row);
if fileexists(filename) then
  begin
    assignfile(f,filename);
    erase(f);
  end;
end;
end;

procedure TLCXPSettings.rssupClick(Sender: TObject);
var key, value: string;
    activerow: integer;
begin
activerow:= rsslist.row;
key:= rsslist.Keys[rsslist.row-1];
value:= rsslist.Values[rsslist.Keys[rsslist.row-1]];
if (key<>'LeastCosterXP') and (key<>'Name') then
begin
     if rsslist.Row < rsslist.RowCount-1 then
        begin
             rsslist.DeleteRow(rsslist.Row-1);
             rsslist.InsertRow(Key, value,false);
        end
     else
     if rsslist.row=rsslist.RowCount-1 then
        begin
             rsslist.DeleteRow(rsslist.Row-1);
             rsslist.InsertRow(Key, value,true);
        end;
     rsslist.row:= activerow-1;
end;
end;

procedure TLCXPSettings.rssdownClick(Sender: TObject);
var key, value: string;
    activerow: integer;
begin
activerow:= rsslist.row;
key:= rsslist.Keys[rsslist.row];
value:= rsslist.Values[rsslist.Keys[rsslist.row]];
if not (key='LeastCosterXP') then
begin
if rsslist.Row < rsslist.RowCount-2 then
begin
rsslist.DeleteRow(rsslist.Row);
rsslist.row:= activerow+1;
rsslist.InsertRow(Key, value,false);
end
else
if rsslist.row=rsslist.RowCount-2 then
begin
rsslist.DeleteRow(rsslist.Row);
rsslist.InsertRow(Key, value,true);
rsslist.Row:= rsslist.rowcount-1;
end;
end;
end;

procedure TLCXPSettings.ColorBox1Change(Sender: TObject);
begin
if assigned(floatingW) then
begin
floatingW.Color:= colorbox1.Selected;
floatingW.visbar.position:= floatingW.visbar.position -1;
floatingW.visbar.position:= floatingW.visbar.position +1; 
floatingW.repaint;
floatingW.visbar.Repaint;
floatingW.refresh;
floatingW.visbar.Refresh;
end;

end;

procedure TLCXPSettings.ColorBox2Change(Sender: TObject);
begin
if assigned(floatingW) then
floatingW.Font.Color:= Colorbox2.Selected;
end;

procedure TLCXPSettings.ColorBox3Change(Sender: TObject);
begin
if assigned(floatingW) then
with floatingW do
begin
OCostLabel.font.Color:= Colorbox3.Selected;
ozeit.font.Color:= Colorbox3.Selected;
ocostlabel.Refresh;
ozeit.refresh;
end;
end;

procedure TLCXPSettings.bgbuttonClick(Sender: TObject);
begin
 open.Filter:= 'bmp, jpg|*.jpg;.bmp; *.JPG; *.BMP;';
 if open.execute then
 begin
 bgedit.Text:= open.FileName;
 if assigned(floatingW) then
 with floatingW do
   begin
     background:= TPicture.Create;
     background.LoadFromFile(open.filename);
     image1.Picture:= background;
     background.free;
     repaint;
     visbar.Repaint;
     refresh;
     visbar.Refresh;
   end;
 end;

end;

procedure TLCXPSettings.OnlineInfoClick(Sender: TObject);
begin
if OnlineINfo.checked then
begin
colorbox1.Enabled:= true;
colorbox2.Enabled:= true;
colorbox3.Enabled:= true;
bgedit.Enabled:= true;
bgbutton.Enabled:= true;
label17.Enabled:= true;

InfoBG.Enabled:= true;
infotext.Enabled:= true;
infospecialtext.Enabled:= true;
if ((not assigned(floatingW)) and (pagecontrol1.ActivePageIndex = 3)) then
 Application.CreateForm(TfloatingW, floatingW);
end
else
begin
colorbox1.Enabled:= false;
colorbox2.Enabled:= false;
colorbox3.Enabled:= false;
bgedit.Enabled:= false;
bgbutton.Enabled:= false;
label17.Enabled:= false;
InfoBG.Enabled:= false;
infotext.Enabled:= false;
infospecialtext.Enabled:= false;
if assigned(floatingW) then floatingW.Close;
end;
end;

procedure TLCXPSettings.loadprogramstrings(activate: string);
var i: integer;
begin
programs.items.clear;
programs.items.Add('ONLINE');
programs.items.Add('----------------------------------------');

if onlineprogs.count > 0 then
   for i:= 0 to onlineprogs.Count -1 do
      programs.items.Add(onlineprogs.Strings[i]);

programs.items.Add('----------------------------------------');
programs.items.Add('OFFLINE');
programs.items.Add('----------------------------------------');

if offlineprogs.count > 0 then
   for i:= 0 to offlineprogs.Count -1 do
       programs.items.Add(offlineprogs.Strings[i]);
if activate='' then
programs.itemindex:= 0
else
programs.itemindex:= programs.Items.IndexOf(activate);
end;

procedure TLCXPSettings.FormCreate(Sender: TObject);
var leastcosterrow: integer;
    i: integer;
begin

leastcosterrow:=0;
hauptfenster.Enabled:= false;

CL:=loadIni('lang\'+settings.readstring('LeastCoster','language',''));
if CL<>nil then fillProps([LCXPSettings],CL);

//netzwerkeinstellungen öffen ausblenden wenn nicht WinXP
if (MagRasOSVersion >= OSW2K) then button8.Visible:= true else
begin
button8.Visible:= false;
device2.Visible:= false;
multilink.visible:= false;
end;
PageControl1.ActivePageIndex:= 0;

groupbox11.Visible:=  hauptfenster.MM3_2.checked;

tabsheet4.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet6.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet7.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet8.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet9.tabVisible :=  hauptfenster.MM3_2.checked;

for i:= 0 to hauptfenster.pluglist.count-1 do
    Plugbox.Items.Append(hauptfenster.pluglist.strings[i]);

memo1.Text:= Misc(Help00,'Help00');

noballoon.Checked:= hauptfenster.noBalloon;

time.checked:= Hauptfenster.clock.Visible;

autostart.Checked:= settings.ReadBool('LeastCoster','autostart',false);
minimiert.Checked:= settings.ReadBool('LeastCoster','minimiert',false);
minimize.checked:= Hauptfenster.MinimizeOnClose;
DaysToSaveLogs.Value:= Hauptfenster.DaysToSaveLogs;

SoundOn.Text:=   settings.readstring('LeastCoster','SoundON',  '' );
SoundOFF.Text:=  settings.readstring('LeastCoster','SoundOFF',  '' );

//Dialfunktion
device.Clear;
with hauptfenster.MagRasCon do
begin
//Modems einlesen
GetDeviceList;
if DeviceNameList.Count <> 0 then
         for I := 0 to DeviceNameList.Count - 1 do
            if ((lowercase(DeviceTypelist[i]) = 'modem') or
                (lowercase(DeviceTypelist[i]) = 'isdn')) then
             begin
                Device.Items.Add(Format('%s=%s', [DeviceNameList [I],lowercase(DeviceTypeList [I])]));
                Device2.Items.Add(Format('%s=%s', [DeviceNameList [I],lowercase(DeviceTypeList [I])]));
             end ;
end;


//Modems setzen
Device.ItemIndex:= Device.Items.IndexOf(hauptfenster.modemname+'='+hauptfenster.modemtype);
Device2.ItemIndex:= Device2.Items.IndexOf(hauptfenster.modemname2+'='+hauptfenster.modemtype2);

//wenn noch kein Modem selektiert ist, dann erstes Modem auswählen
if ((Device.itemindex = -1) and (device.items.Count > 0)) then device.itemindex:= 0;
//wenn noch kein Modem selektiert ist, dann zweites Modem auswählen
if (MagRasOSVersion >= OSW2K)then
begin
  if ((Device2.itemindex = -1) and (device2.items.Count > 1)) then device2.itemindex:= 1;

  Multilink.checked:= Hauptfenster.allow_multilink;
  device2.enabled:= multilink.checked;
end;

SetupModems.checked:= not hauptfenster.setupmodems;
setupmodemsclick(self);

edVorwahl.text:= settings.Readstring('Dialer','Vorwahl', '');
hidetray.Checked := settings.readbool('Dialer','Tray',false);
OpenWebsite.checked := settings.readbool('Dialer','OpenWeb',true);

//Onlineaktionen
atombox.Checked      := settings.ReadBool('Onlinecheck','Atomzeit', false);
updatebox.Checked    := settings.ReadBool('Onlinecheck','Update', true);
keepfiles.checked    := settings.Readbool('Onlinecheck','BackUpUpdate', true);
keepfiles_one.checked:= settings.Readbool('Onlinecheck','BackUpLast', true);
keepfilesclick(self);

AtomInterval.Value:= settings.ReadInteger('Onlinecheck','Atominterval', 60);
AtomRepeat.Checked:= settings.ReadBool('Onlinecheck','AtomRepeat',false);
atomboxclick(self);
AtomRepeatClick(self);

edit2.text:= settings.Readstring('lokale IP','IP','127.0.0.1;');
forwardtable.Value:= settings.Readinteger('Onlinecheck','Vorschub',5);
if forwardtable.Value < 3 then forwardtable.Value:= 3; //mininmalwert setzen, wenn unterschritten 

//IP-Notification
  ipmail_active.checked:= settings.Readbool('lokale IP','IP_Notify',false);
  ipmail_name.text:= settings.Readstring('lokale IP','IP_Notify_Name','');
  ipmail_adress.text:= settings.ReadString('lokale IP','IP_Notify_Adress','');
  ipmail_activeclick(self);
//Infofenster
onlineinfo.checked:=   settings.Readbool('Onlineinfo','show', true );
onlineinfoclick(self);
colorbox1.ItemIndex:= colorbox1.Items.IndexOf(settings.Readstring('Onlineinfo','BGColor', 'clBtnFace'));
colorbox2.ItemIndex:= colorbox2.Items.IndexOf(settings.Readstring('Onlineinfo','TextColor',   'clWindowText'));
colorbox3.ItemIndex:= colorbox3.Items.IndexOf(settings.Readstring('Onlineinfo','SpecialTextColor',   'clGreen'));
bgedit.Text:=   settings.readstring('Onlineinfo','BGImage',  '' );
fontedit.Text:=   settings.Readstring('Onlineinfo','Font',  'MS Sans Serif' );
Setonlineinfowidth.checked:= settings.ReadBool('OnlineInfo', 'AutoWidth', true);

//Autotrennen
  autotrennen.Checked       := settings.Readbool('Autotrennen','Enabled',true);
  autotrennenask.Checked    := settings.Readbool('Autotrennen','Ask',false);
  autotrennenwait.Checked   := settings.Readbool('Autotrennen','UseDelay',false);
  autotrennenwaitval.value  := settings.Readinteger('Autotrennen','Delay',30);
  autotrennenconfirm.checked:= settings.Readbool('Autotrennen','WaitForUser',true);
  DisconnectSeconds.Value   := Hauptfenster.DisconnectSeconds;
  autotrennen_konti.checked := settings.Readbool('Autotrennen','Kontingente',true);
  autotrennenclick(self);

  UseAutoBlacklist.checked  := settings.ReadBool('AutoBlacklist','active',false);
  AutoBlacklist.value       := settings.Readinteger('AutoBlacklist','Value',10);
  AutoBlacklistScore.value  := settings.Readinteger('AutoBlacklist','Score',50);

  //Leerlauf
  leerlauf.Checked       := settings.readbool('Leerlauf','Enabled',true);
  leerlaufminuten.Value  := settings.Readinteger('Leerlauf','LeerlaufZeit',5);
  leerlaufask.Checked    := settings.Readbool('Leerlauf','Ask',true);
  leerlaufwait.Checked   := settings.Readbool('Leerlauf','UseDelay',true);
  leerlaufwaitval.value  := settings.Readinteger('Leerlauf','Delay',30);
  leerlaufconfirm.checked:= settings.Readbool('Leerlauf','WaitForUser',false);
  leerlaufschwelle.value := settings.Readinteger('Leerlauf','Schwelle',500);
  leerlaufclick(self);

  leerlaufplaysound.checked:= settings.readbool('Leerlauf','PlaySound', false);
  leerlaufsound.text := settings.readString('Leerlauf','Sound', '');

  leerlaufplaysoundclick(self);
  //Ausschalten nach Auto-Trennen
  AutoAus.ItemIndex:= settings.Readinteger('Ausschalten','Value',0);

  //AutoVerbinden
  AutoConnectOnStart.Checked := settings.Readbool('AutoConnect','AutoStartConnect',false);
  AutoReConnect.Checked      := settings.Readbool('AutoConnect','AutoReConnect',false);
  AutoConnectEinwahl.Checked := settings.Readbool('AutoConnect','mitEinwahl',false);
  AutoConnectInterval.Value  := settings.Readinteger('AutoConnect','Interval', 60);
  AutoSurfdauer.Position     := settings.Readinteger('AutoConnect','Basiszeit',1);

  AutoD.Checked       := settings.ReadBool    ('AutoConnect','atTime', false);
  LoadAutoL;
  Autodclick(self);

  Autosurfdauerchange(self);

//Rss-Update
rssupdate.Value:= settings.readInteger('RSS','Update',60);
noFeeds.Checked:=  settings.readbool('RSS', 'noFeeds', false);
noFeedsclick(self);
Rss_oldItems.Checked:= hauptfenster.rss_old;
Rss_maxitems.Value:= hauptfenster.Rss_max;

serverbox.Items.Assign(atomserver);
serverbox.ItemIndex:=0;

rot.Text:= settings.ReadString('Kostengrenzen','rot','15'); {Kostengrenzen rot/ gelb}
gelb.text:= settings.ReadString('Kostengrenzen','gelb','10');

if fileexists(extractfilepath(paramstr(0))+'Rsslist.txt') then
begin
 rssList.Strings.LoadFromFile(extractfilepath(paramstr(0))+'Rsslist.txt');
 if not rsslist.FindRow('LeastCosterXP', LeastCosterRow) then
 begin
 rsslist.row:= 1;
 rsslist.InsertRow('LeastCosterXP','http://darkempire.funpic.de/phpBB2/rdf.php?f=3',false);
 end;
end;

//"Programme starten"
onlineprogs:= TStringlist.create;
offlineprogs:= TStringlist.create;
SettingsOnline.ReadSections(onlineprogs);
SettingsOffline.ReadSections(offlineprogs);

loadprogramstrings('');
programs_style.ItemIndex:= 2;
programs_online.checked:= true;

if hauptfenster.pluglist.Count > 0 then
begin
  plugbox.Selected[0]:= true;
  PlugOnMouseUp;
end;

if length(holidaylist) > 0 then
  for i:= 0 to length(holidaylist)-1 do
   holidays.InsertRow(holidaylist[i].name,Datetostr(holidaylist[i].date), true);

holidays.TitleCaptions[0]:= misc(M270,'M270');
holidays.TitleCaptions[1]:= misc(M271,'M271');

end;

procedure TLCXPSettings.programs_suchenClick(Sender: TObject);
begin
 open.Filter:= '*.*|*.*';
 if programs_path.Text <> '' then open.InitialDir:= extractfilepath(programs_path.Text);
 if open.execute then
 programs_path.text := lowercase(open.filename);
end;

procedure TLCXPSettings.programs_addClick(Sender: TObject);
var ini: Tmeminifile;
    section: string;
begin

if not fileexists(programs_path.text) then
begin
     showmessage(extractfilename(programs_path.text)+' ' + misc(M43,'M43'));
     exit;
end;

if programs_path.text <> '' then
begin
      //namen
     if programs_add.Caption = misc(M128,'M128') then
     begin
          section:= programs.Items.Strings[programs.itemindex];
          if mode_change then
               if mode_online then
               begin
                  bitbtn3click(self); //löschen
                  offlineprogs.Append(section);                  
               end
               else
               begin
                  bitbtn3click(self); //löschen
                  onlineprogs.Append(section);
               end;
     end
     else
     begin
         section:= extractfilename(programs_path.text) +' ('+ datetimetostr(now)+')';
         if programs_online.checked then onlineprogs.Append(section)
         else
         if programs_offline.checked then offlineprogs.Append(section)
     end;

     //speichern
     if programs_online.Checked then
        ini:= SettingsOnline
     else
     if programs_offline.Checked then
        ini:= SettingsOffline;

     if programs_online.Checked or programs_offline.Checked then
     begin
          ini.WriteString(section,'Pfad',programs_path.text);
          ini.WriteString(section,'Param',programs_params.text);
          ini.WriteInteger(section,'mintime',programs_mintime.Value);
          ini.WriteInteger(section,'timeout',programs_timeout.Value);
          ini.WriteInteger(section,'Days',opendays.Value);
          if not ini.ValueExists(section,'DaytoRun')
           then ini.WriteDate(section,'DaytoRun',Dateof(now));

          if programs_online.checked then
             ini.WriteBool(section,'kill',programs_kill.checked);

          case programs_style.ItemIndex  of
           0: ini.WriteString(section,'Style','MAXIMIZE');
           1: ini.WriteString(section,'Style','MINIMIZE');
           2: ini.WriteString(section,'Style','SHOWNORMAL');
           3: ini.WriteString(section,'Style','HIDE');
          end;

     end;

loadprogramstrings(section);

programs_add.Caption:= misc(M129,'M129');
bitbtn2.click;
end;
end;

procedure TLCXPSettings.ProgramsCloseUp(Sender: TObject);
var ini: TmemIniFile;
    section, style: string;
begin
if ( (programs.ItemIndex <> 0) and
     (programs.ItemIndex <> 1) and
     (programs.ItemIndex <> onlineprogs.Count+2) and
     (programs.ItemIndex <> onlineprogs.Count+3) and
     (programs.ItemIndex <> onlineprogs.Count+4))
   then
   begin
    if(programs.ItemIndex > onlineprogs.Count+2) then
          begin
            ini:= SettingsOffline;
            mode_online:= false;
          end
    else  begin
            ini:= SettingsOnline;
            mode_online:= true;
          end;
     section:= programs.items.strings[programs.itemindex];
     programs_path.text    := ini.ReadString(section,'Pfad','');
     programs_params.text  := ini.ReadString(section,'Param','');
     programs_mintime.Value:= ini.ReadInteger(section,'mintime',1);
     programs_timeout.Value:= ini.ReadInteger(section,'timeout',0);
     style                 := ini.ReadString(section,'style','SHOWNORMAL');
     opendays.Value        := ini.ReadInteger(section,'Days',1);

     if style = 'MAXIMIZE' then programs_style.itemindex:= 0
     else
     if style = 'MINIMIZE' then programs_style.itemindex:= 1
     else
     if style = 'SHOWNORMAL' then programs_style.itemindex:= 2
     else
     if style = 'HIDE' then programs_style.itemindex:= 3
     else programs_style.itemindex:= 2;

     if(programs.ItemIndex < onlineprogs.Count+2) then
     begin
          programs_online.checked:= true;
          programs_kill.enabled:= true;
          programs_kill.checked:=  ini.ReadBool(section,'kill',false);
     end
     else
     begin
          programs_offline.checked:= true;
          programs_kill.enabled:= false;
     end;

    programs_add.Caption:= misc(M128,'M128');
   end
   else bitbtn2.click;

end;

procedure TLCXPSettings.programs_offlineClick(Sender: TObject);
begin
  programs_kill.Enabled:= false;
  if (( programs_add.caption = misc(M128,'M128')) and mode_online)  then mode_change:= true
  else mode_change:= false;
end;

procedure TLCXPSettings.programs_onlineClick(Sender: TObject);
begin
  programs_kill.Enabled:= true;
  if ((programs_add.caption = misc(M128,'M128')) and not mode_online) then mode_change:= true
  else mode_change:= false;
end;

procedure TLCXPSettings.BitBtn3Click(Sender: TObject);
var ini: TmeminiFile;
begin
if ( (programs.ItemIndex <> 0) and
     (programs.ItemIndex <> 1) and
     (programs.ItemIndex <> onlineprogs.Count+2) and
     (programs.ItemIndex <> onlineprogs.Count+3) and
     (programs.ItemIndex <> onlineprogs.Count+4))
   then
   begin
    if(programs.ItemIndex > onlineprogs.Count+2) then
            ini:= SettingsOffline
    else
            ini:= SettingsOnline; 
    ini.EraseSection(programs.Items.Strings[programs.itemindex]);

    if(programs.ItemIndex > onlineprogs.Count+2) then
     offlineprogs.Delete(offlineprogs.IndexOf(programs.Items.Strings[programs.itemindex]))
    else
     onlineprogs.Delete(onlineprogs.IndexOf(programs.Items.Strings[programs.itemindex]));

    programs.items.Delete(programs.ItemIndex);

    loadprogramstrings('');
    if sender = BitBtn3 then BitBtn2Click(self);
   end;
end;

procedure TLCXPSettings.BitBtn2Click(Sender: TObject);
begin
  programs.ItemIndex:= 0;
  programs_online.checked:= true;
  programs_offline.checked:= false;
  programs_path.text:='';
  programs_params.text:= '';
  programs_mintime.value:= 1;
  programs_timeout.Value:= 0;
  programs_kill.Checked:= false;
  programs_style.itemindex:= 2;
  programs_kill.Enabled:= true;
  programs_add.Caption:= misc(M129,'M129');
  opendays.Value:= 0;
end;

procedure TLCXPSettings.SoundOnButClick(Sender: TObject);
begin
 open.Filter:= '*.wav|*.wav;*.WAV';
 if open.execute then
 begin
 if sender = leerlaufsoundbut then leerlaufsound.Text:= open.FileName else
 if sender = SoundOffBut then  soundOFF.Text:= open.FileName else
 if sender = SoundOnBut then soundON.Text:= open.FileName;
 if fileexists(open.filename) then sndPlaySound(PChar(open.filename),SND_ASYNC);
 end;
end;

procedure TLCXPSettings.noFeedsClick(Sender: TObject);
begin
   Rsslist.Enabled:= not noFeeds.checked;
   rssup.Enabled:= not noFeeds.checked;
   rssdown.Enabled:= not noFeeds.checked;
   button4.Enabled:= not noFeeds.checked;
   button5.enabled:= not noFeeds.checked;
   rssupdate.Enabled:= not noFeeds.checked;
   label13.Enabled:= not noFeeds.checked;
   label_min.Enabled:= not noFeeds.checked;
   label49.Enabled:= not noFeeds.checked;
   label50.Enabled:= not noFeeds.checked;
   Rss_maxitems.Enabled:= not noFeeds.checked;
   Rss_oldItems.enabled:= not noFeeds.checked;
end;

procedure TLCXPSettings.PageControl1Change(Sender: TObject);
begin

case pagecontrol1.ActivePageIndex of
3: begin
      if ((not assigned(floatingW)) and (onlineinfo.checked )) then
       Application.CreateForm(TfloatingW, floatingW);
    end;
else if (assigned(floatingW) and not isonline) then floatingW.close;
end;
end;

procedure TLCXPSettings.autotrennenaskClick(Sender: TObject);
begin
 autotrennenwait.Enabled:= autotrennenask.Checked;
 autotrennenwaitval.Enabled:= autotrennenask.Checked;
 autotrennenconfirm.Enabled:= autotrennenask.Checked;
 label29.enabled:=  autotrennenask.checked;
 if autotrennenask.Checked then  autotrennenwaitclick(sender);
end;

procedure TLCXPSettings.autotrennenwaitClick(Sender: TObject);
begin
 autotrennenwaitval.enabled:= autotrennenwait.Checked;
end;

procedure TLCXPSettings.autotrennenClick(Sender: TObject);
begin
if not autotrennen.checked then
begin
 label29.Enabled:= false;
 autotrennenask.Enabled:= false;
 autotrennenwaitval.enabled:= false;
 label29.Enabled:= false;
 autotrennenwait.Enabled:= false;
 autotrennenconfirm.Enabled:= false;
end
else
begin
 label29.Enabled:= true;
 autotrennenask.Enabled:= true;
 autotrennenaskclick(sender);
end;
end;

procedure TLCXPSettings.leerlaufClick(Sender: TObject);
begin
leerlaufminuten.Enabled:= leerlauf.Checked;
leerlaufask.Enabled:= leerlauf.Checked;
label31.Enabled:= leerlauf.Checked;
if not leerlauf.Checked then
begin
 leerlaufwait.Enabled:= leerlauf.Checked;
 leerlaufwaitval.Enabled:= leerlauf.Checked;
 leerlaufconfirm.Enabled:= leerlauf.Checked;
 label32.Enabled:= leerlauf.Checked;
end
else
begin
 leerlaufminuten.Enabled:= true;
 leerlaufask.Enabled:= true;
 leerlaufaskclick(self);
end;
end;

procedure TLCXPSettings.leerlaufaskClick(Sender: TObject);
begin
 leerlaufwait.Enabled:= leerlaufask.checked;
 leerlaufwaitval.Enabled:= leerlaufask.checked;
 leerlaufconfirm.Enabled:= leerlaufask.checked;
 label32.Enabled:= leerlaufask.checked;
end;

procedure TLCXPSettings.leerlaufwaitClick(Sender: TObject);
begin
 leerlaufwaitval.Enabled:= leerlaufwait.Checked
end;

procedure TLCXPSettings.LeerlaufPlaySoundClick(Sender: TObject);
begin
leerlaufsound.enabled:= leerlaufplaysound.Checked;
leerlaufsoundbut.enabled:= leerlaufplaysound.Checked;
end;

procedure TLCXPSettings.Button7Click(Sender: TObject);
begin
if fileexists(extractfilepath(paramstr(0))+'www\log\log.txt') then
ShellExecute(0,'open',Pchar('notepad.exe'),Pchar(extractfilepath(paramstr(0))+'www\log\log.txt') ,nil,SW_SHOWNORMAL)
end;

procedure TLCXPSettings.Button8Click(Sender: TObject);
begin
ShellExecute(GetActiveWindow,'open','rundll32.exe','shell32.dll,Control_RunDLL ncpa.cpl,,4',NIL,SW_NORMAL);
end;

procedure TLCXPSettings.AutoSurfdauerChange(Sender: TObject);
var zeit_min, zeit_std: string;
begin
str(Autosurfdauer.Position mod 60, zeit_min);
str(Autosurfdauer.Position div 60, zeit_std);

label33.Caption:= zeit_std + ' h ' + zeit_min + ' min';
end;

procedure TLCXPSettings.atomrepeatClick(Sender: TObject);
begin
Atominterval.Enabled:=  atomrepeat.checked;
end;

procedure TLCXPSettings.AtomboxClick(Sender: TObject);
begin
serverbox.enabled:= Atombox.checked;
serverdelete.enabled:=Atombox.checked;
serveraddbutton.enabled:=Atombox.checked;
serveradd.enabled:=Atombox.checked;
end;

procedure TLCXPSettings.ipmail_activeClick(Sender: TObject);
begin
ipmail_name.enabled:= ipmail_active.Checked;
ipmail_adress.enabled:=ipmail_active.Checked;
end;

procedure TLCXPSettings.rightClick(Sender: TObject);
var newplace: integer;
begin
newplace:= 0;
 if sender = right then
 begin
 if serverbox.itemindex = serverbox.Items.count -1 then exit
 else
 if serverbox.itemindex < serverbox.Items.count -1 then newplace:= serverbox.itemindex + 1;
 end
 else
if sender = left then
 begin
 if serverbox.itemindex = 0 then exit
 else
 if serverbox.itemindex > 0 then newplace:= serverbox.itemindex - 1;
 end;


 serverbox.Items.Exchange(serverbox.itemindex, newplace);
 serverbox.ItemIndex:= newplace;

end;

procedure TLCXPSettings.Button10Click(Sender: TObject);
begin
if directoryexists(ExtractFilePath(ParamStr(0)) + 'BackUp') then
  Shellexecute( 0, nil, Pchar(ExtractFilePath(ParamStr(0)) + 'BackUp'), nil, nil, SW_SHOW)
end;

procedure TLCXPSettings.MultilinkClick(Sender: TObject);
begin
Device2.enabled:= multilink.checked;
end;

procedure TLCXPSettings.setupmodemsClick(Sender: TObject);
begin
 multilinkclick(self);
 Device.Enabled:= not setupmodems.Checked;
 Device2.Enabled:= not setupmodems.Checked;
 multilink.enabled:= not setupmodems.Checked;
end;

procedure TLCXPSettings.DFUEClick(Sender: TObject);
var regist: TRegistry;
begin
  //Einwählen abschalten
  regist:=TRegistry.create;
  try
    regist.RootKey:=HKEY_CURRENT_USER;
    regist.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings',false);
    regist.WriteInteger('EnableAutodial',0);
    regist.CloseKey;
  finally
    regist.free;
  end;
end;
procedure TLCXPSettings.DFUE2Click(Sender: TObject);
var regist: TRegistry;
begin
 //Einwählen einschalten
  regist:=TRegistry.create;
  try
    regist.RootKey:=HKEY_CURRENT_USER;
    regist.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings',false);
    regist.WriteInteger('EnableAutodial',1);
    regist.CloseKey;
  finally
    regist.free;
  end;
end;


procedure TLCXPSettings.keepfilesClick(Sender: TObject);
begin
keepfiles_one.enabled:= keepfiles.checked;
end;

procedure TLCXPSettings.registerClick(Sender: TObject);
var folder: string;
    arch: TZLBArchive;
begin
 open.Filter:= 'LeastCosterXP PlugIn|*.lcp';
 if open.execute then
 begin

  folder:= ExtractFileName(open.FileName);  //Dateiname
  folder:= AnsiReplaceText(folder,'.lcp',''); //-> Ordner extrahieren

  if not directoryExists(Extractfilepath(Paramstr(0)) + 'PlugIns') then
   mkdir(Extractfilepath(Paramstr(0)) + 'PlugIns');

  if not directoryExists(Extractfilepath(Paramstr(0)) + 'PlugIns\'+folder) then
  begin
   mkdir(Extractfilepath(Paramstr(0)) + 'PlugIns\'+folder);

   //Kompressor erzeugen
    arch := TZLBArchive.Create(Self);
    with arch do
    begin
      Name := 'arch';
      CompressionLevel := fcMaximum;
      SavePaths := True;
      ExtractWithPath:= true;
    end;

   arch.OpenArchive(open.filename);
   try
     arch.ExtractAll(Extractfilepath(Paramstr(0)) + 'PlugIns\'+folder);
   finally
     arch.CloseArchive;
     arch.free;
   end;
   hauptfenster.pluglist.Append(folder);
   Plugbox.Items.Append(folder);
   plugbox.selected[plugbox.Items.IndexOf(folder)]:= true;
   PlugOnMouseUp;
  end;
 end;
end;

Procedure TLCXPSettings.PlugOnMouseUp;
var i: integer;
    ini:TiniFile;
begin
with LCXPSettings do
begin
readme.Clear;
plugsettings.enabled:= false;
for i:= 0 to Plugbox.Count-1 do
  if Plugbox.Selected[i] then
  begin

     if fileexists(ExtractFilePath(paramstr(0)) + 'PlugIns\'+plugbox.Items.Strings[i]+'\readme.txt')
     then readme.Lines.LoadFromFile(ExtractFilePath(paramstr(0)) + 'PlugIns\'+plugbox.Items.Strings[i]+'\readme.txt');

     if fileexists(ExtractFilePath(ParamStr(0)) + 'PlugIns\'+plugbox.items.Strings[i]+'\'+plugbox.items.Strings[i]+'.ini') then
            begin
              ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PlugIns\'+plugbox.items.Strings[i]+'\'+plugbox.items.Strings[i]+'.ini');

              plugsettings.Enabled:= ini.SectionExists('Settings');

              if ini.ReadBool('General', 'enabled', true) then
              begin
                   state.caption:= misc(M130,'M130');
                   activate.caption:= misc(M133,'M133');
                   state.font.color:= clgreen;
                   activate.Tag:= 1;
              end
              else
              begin
                   state.caption:= misc(M132,'M132');
                   activate.caption:= misc(M131,'M131');
                   state.font.color:= clred;
                   activate.Tag:= 0;
              end;
              ini.Free;
              end;
  end;
end;
end;

procedure TLCXPSettings.PlugBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  plugOnMouseUp;
end;

procedure TLCXPSettings.unregisterClick(Sender: TObject);
var i: integer;
begin
for i:= 0 to PlugBox.Count-1 do
    if plugbox.Selected[i] then
    begin
     if not DelDir(extractfilepath(paramStr(0)) + 'PlugIns\'+plugbox.items.Strings[i])
      then showmessage(misc(M134,'M134')+' PlugIns\'+ plugbox.items.strings[i]);
     hauptfenster.pluglist.Delete(hauptfenster.pluglist.IndexOf(plugbox.items.Strings[i]));
     plugbox.DeleteSelected;
     if plugbox.count > 0 then plugbox.selected[0]:= true;
     PlugOnMouseUp;
     break;
    end;
end;

procedure TLCXPSettings.plugSettingsClick(Sender: TObject);
var i: integer;
    ini: TInifile;
    run, param: string;
begin

for i:=0 to plugbox.Count-1 do
 if plugbox.Selected[i] then
 begin
  if fileexists(ExtractFilePath(ParamStr(0)) + 'PlugIns\'+plugbox.items.Strings[i]+'\'+plugbox.items.Strings[i]+'.ini') then
  begin
  run:= ExtractFilepath(paramstr(0)) + 'PlugIns\'+ plugbox.items.strings[i]+'\';

  ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PlugIns\'+plugbox.items.Strings[i]+'\'+plugbox.items.Strings[i]+'.ini');

  if ini.SectionExists('Settings') then
  begin
     run:= run + ini.ReadString('Settings','run','');
     param:= ini.ReadString('Settings','param','');
     ShellExecute(0,'open',Pchar(run),Pchar(param) ,nil,SW_SHOWNORMAL);
  end;
   ini.Free;
  end;
 end;

end;

procedure TLCXPSettings.activateClick(Sender: TObject);
var ini: TIniFile;
    i: integer;
begin

for i:= 0 to PlugBox.Count-1 do
    if plugbox.Selected[i] then
    begin
     ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PlugIns\'+plugbox.items.Strings[i]+'\'+plugbox.items.Strings[i]+'.ini');

      if activate.tag = 0 then
         ini.WriteBool('General', 'enabled', true)
       else
           ini.WriteBool('General', 'enabled', false);
     ini.free;
     plugOnmouseup;
    end;
end;

procedure TLCXPSettings.FontBClick(Sender: TObject);
begin
fontdialog1.Font.name:= fontedit.text;
if FontDialog1.Execute then
begin
 fontedit.Text:=  FontDialog1.Font.Name;
 if assigned(floatingw) then
 begin
  floatingw.Font.name:=FontDialog1.Font.Name;
  floatingw.ozeit.Font.name:=  floatingw.Font.Name;
  floatingw.ocostlabel.font.name:= floatingw.Font.Name;

  floatingw.Font.size:=FontDialog1.Font.Size;
  floatingw.ozeit.Font.size:=  floatingw.Font.Size*2;
  floatingw.ocostlabel.font.size:= floatingw.Font.Size *2;
 end;
end;
end;

function checkdays(key: string; S: TComboBox):boolean;
begin
result:= false;
if (S.Items.Strings[S.itemindex] = Key)
     or ((key = S.Items.Strings[7]) and (S.itemindex = 9)) //täglich > wochenende
     or ((key = S.Items.Strings[7]) and (S.itemindex = 8)) //täglich > wochentags
     or ((key = S.Items.Strings[9]) and (S.itemindex = 7)) //wochenende > täglich
     or ((key = S.Items.Strings[8]) and (S.itemindex = 7)) //wochentags > täglich
     or ((key = S.Items.Strings[7]) and (S.itemindex <= 6))//täglich > ein Tag
     or ((key = S.Items.Strings[8]) and ((S.itemindex <= 4) ))//wochentags > ein Tag der Woche
     or ((key = S.Items.Strings[9]) and ((S.itemindex = 5) or (S.itemindex = 6))) //wochenende > sa,So
     or ((key = S.Items.Strings[0]) and ((S.itemindex = 7) or (S.itemindex = 8))) //montag > täglich, wochentags
     or ((key = S.Items.Strings[1]) and ((S.itemindex = 7) or (S.itemindex = 8))) //Dienstag > täglich, wochentags
     or ((key = S.Items.Strings[2]) and ((S.itemindex = 7) or (S.itemindex = 8))) //mittwoch > täglich, wochentags
     or ((key = S.Items.Strings[3]) and ((S.itemindex = 7) or (S.itemindex = 8))) //Donnerstag > täglich, wochentags
     or ((key = S.Items.Strings[4]) and ((S.itemindex = 7) or (S.itemindex = 8))) //Freitag > täglich, wochentags
     or ((key = S.Items.Strings[5]) and ((S.itemindex = 7) or (S.itemindex = 9))) //Samstag > täglich, wochenEnde
     or ((key = S.Items.Strings[6]) and ((S.itemindex = 7) or (S.itemindex = 9))) //Sonntag > täglich, wochenEnde
  then result:= true;
end;

procedure TLCXPSettings.Button9Click(Sender: TObject);
var i: integer;
    check: boolean;
    von, bis, start, ende: TDateTime;
    r: Tregexpr;
    s: TStringlist;
    l: integer;
begin

start := Dateof(now) + timeof(AutoD_start.time);
ende  := Dateof(now) + timeof(AutoD_end.time);
if ende < start then ende:= incday(ende,1);

r:= TRegExpr.Create;
r.Expression:= ' - ';
s:= TStringList.Create;

check:= false;

if (Autol.Keys[1] <> '') then
  for i:= 1 to Autol.rowcount-1 do
  begin
   if checkdays(Autol.keys[i], AutoD_Day) then
    begin
      s.Clear;
      r.Split(autol.Strings.ValueFromIndex[i-1],s);
      von:=  Dateof(now) + strtotime(s.strings[0]);
      bis:=  Dateof(now) + strtotime(s.strings[1]);

      if bis < von then bis:= incday(bis,1);

      if ( ((start >= von) and (start< bis))
         or ((ende <= bis) and (ende > von))
         or ((start = von) and (ende = bis)) )
        then begin check:= true; break; end;
     end;
  end;

if not check then
 begin
  l:= length(Hauptfenster.AuToDialTimes);
  setlength(Hauptfenster.AuToDialTimes,l+1);
  hauptfenster.AutoDialTimes[l].tag:= Autod_day.itemindex;
  hauptfenster.AutoDialTimes[l].von:= AutoD_start.time;
  hauptfenster.AutoDialTimes[l].bis:= AutoD_end.time;
  loadAutoL;
  Autol.Row:= Autol.RowCount-1;
 end;
s.free;
r.Free;
end;

procedure TLCXPSettings.Button11Click(Sender: TObject);
var i: integer;
    von, bis, start, ende: TDateTime;
    r: Tregexpr;
    s: TStringlist;
    l: integer;
    n: string;
begin
if (autol.row > 0) and (Autol.keys[1] <> '') then
begin

  r:= TRegExpr.Create;
  r.Expression:= ' - ';
  s:= TStringList.Create;

  s.Clear;
  r.Split(autol.Strings.ValueFromIndex[autol.row-1],s);
  von :=  Dateof(now) + strtotime(s.strings[0]);
  bis :=  Dateof(now) + strtotime(s.strings[1]);
  n   :=  Autol.Keys[Autol.row];

  if bis < von then bis:= incday(bis,1);

  l:= length(Hauptfenster.AuToDialTimes);

  for i:= l-1 downto 0 do
  begin
     start := Dateof(now) + timeof(Hauptfenster.AutoDialTimes[i].von);
     ende  := Dateof(now) + timeof(Hauptfenster.AutoDialTimes[i].bis);
     if ende < start then ende:= incday(ende,1);

     if (start=von) and (ende=bis)
         and (Hauptfenster.AutoDialTimes[i].tag = AutoD_Day.items.IndexOf(n))
         then
         begin
          Hauptfenster.AutoDialTimes[i]:= Hauptfenster.AutoDialTimes[l-1];
          setlength(Hauptfenster.AutoDialTimes, l-1);
          break;
         end;
  end;
  LoadAutoL;
end;
end;

procedure TLCXPSettings.AutoDClick(Sender: TObject);
begin
AutoD_day.enabled   := AutoD.checked;
AutoD_start.Enabled := AutoD.checked;
AutoD_End.Enabled   := AutoD.checked;
Autol.Enabled       := AutoD.checked;
if not AutoD.checked then autol.font.Color:= clsilver else autol.font.Color:= clWindowText;
Button9.Enabled     := AutoD.checked;
Button11.Enabled    := AutoD.checked;
end;

procedure TLCXPSettings.UseAutoBlacklistClick(Sender: TObject);
begin
Label40.enabled             := UseAutoBlacklist.checked;
Label42.enabled             := UseAutoBlacklist.checked;
Label43.enabled             := UseAutoBlacklist.checked;
Label44.enabled             := UseAutoBlacklist.checked;
Label45.enabled             := UseAutoBlacklist.checked;
AutoBlacklist.Enabled       := UseAutoBlacklist.checked;
AutoBlackListScore.Enabled  := UseAutoBlacklist.checked;
end;

procedure TLCXPSettings.autostartMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.Text:= misc(Help01,'Help01');
end;

procedure TLCXPSettings.minimiertMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.Text:= misc(Help02,'Help02');
end;

procedure TLCXPSettings.minimizeMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.Text:= misc(Help03,'Help03');
end;

procedure TLCXPSettings.timeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
memo1.Text:= misc(Help04,'Help04');
end;

procedure TLCXPSettings.noBalloonMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.Text:= misc(Help05,'Help05');
end;

procedure TLCXPSettings.DaystoSaveLogsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= misc(Help06,'Help06');
end;

procedure TLCXPSettings.Button3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
memo1.Text:= misc(Help07,'Help07');
end;

procedure TLCXPSettings.Button7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
memo1.Text:= misc(Help08,'Help08');
end;

procedure TLCXPSettings.gelbMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
memo1.Text:= misc(Help09,'Help09');
end;

procedure TLCXPSettings.setupmodemsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= misc(Help19,'Help19');
end;

procedure TLCXPSettings.modemlabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.text:= misc(Help20,'Help20');
end;

procedure TLCXPSettings.MultilinkMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.text:= misc(Help21,'Help21');
end;

procedure TLCXPSettings.vorwahllabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= misc(Help22,'Help22');
end;

procedure TLCXPSettings.Button8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help23,'Help23');
end;

procedure TLCXPSettings.Label15MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help24,'Help24');
end;

procedure TLCXPSettings.hidetrayMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help25,'Help25');
end;

procedure TLCXPSettings.OpenWebsiteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help26,'Help26');
end;

procedure TLCXPSettings.GroupBox11MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help27,'Help27');
end;

procedure TLCXPSettings.BitBtn3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help28,'Help28');
end;

procedure TLCXPSettings.programs_killMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help29,'Help29');
end;

procedure TLCXPSettings.programs_pathMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help30,'Help30');
end;

procedure TLCXPSettings.programs_paramsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help31,'Help31');
end;

procedure TLCXPSettings.programs_timeoutMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help32,'Help32');
end;

procedure TLCXPSettings.programs_mintimeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help33,'Help33');
end;

procedure TLCXPSettings.opendaysMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help34,'Help34');
end;

procedure TLCXPSettings.programs_addMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help35,'Help35');
end;

procedure TLCXPSettings.BitBtn2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help36,'Help36');
end;

procedure TLCXPSettings.Label23MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help37,'Help37');
end;

procedure TLCXPSettings.updateboxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help38,'Help38');
end;

procedure TLCXPSettings.keepfilesMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help39,'Help39');
end;

procedure TLCXPSettings.keepfiles_oneMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help40,'Help40');
end;

procedure TLCXPSettings.Button10MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help41,'Help41');
end;

procedure TLCXPSettings.OnlineInfoMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help42,'Help42');
end;

procedure TLCXPSettings.SetOnlineInfoWidthMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help43,'Help43');
end;

procedure TLCXPSettings.bgeditMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help44,'Help44');
end;

procedure TLCXPSettings.FonteditMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help44,'Help45');
end;

procedure TLCXPSettings.InfoTextMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   memo1.text:= misc(Help44,'Help46');
end;

procedure TLCXPSettings.InfoBGMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help47,'Help47');
end;

procedure TLCXPSettings.InfoSpecialTextMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help48,'Help48');
end;

procedure TLCXPSettings.GroupBox10MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help49,'Help49');
end;

procedure TLCXPSettings.leftMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help50,'Help50');
end;

procedure TLCXPSettings.rightMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help51,'Help51');
end;

procedure TLCXPSettings.ServerboxEnter(Sender: TObject);
begin
 memo1.text:= misc(Help52,'Help52');
end;

procedure TLCXPSettings.atomrepeatMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help53,'Help53');
end;

procedure TLCXPSettings.ipmail_activeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help54,'Help54');
end;

procedure TLCXPSettings.ipmail_nameMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help55,'Help55');
end;

procedure TLCXPSettings.ipmail_adressMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help56,'Help56');
end;

procedure TLCXPSettings.DFUEMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help57,'Help57');
end;

procedure TLCXPSettings.DFUE2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help58,'Help58');
end;

procedure TLCXPSettings.GroupBox8MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   memo1.text:= misc(Help59,'Help59');
end;

procedure TLCXPSettings.GroupBox2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   memo1.text:= misc(Help60,'Help60');
end;

procedure TLCXPSettings.autotrennenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help61,'Help61');
end;

procedure TLCXPSettings.autotrennen_kontiMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help62,'Help62');
end;

procedure TLCXPSettings.autotrennenaskMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help63,'Help63');
end;

procedure TLCXPSettings.autotrennenwaitMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help64,'Help64');
end;

procedure TLCXPSettings.autotrennenconfirmMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help65,'Help65');
end;

procedure TLCXPSettings.DisconnectSecondsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help66,'Help66');
end;

procedure TLCXPSettings.GroupBox3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help67,'Help67');
end;

procedure TLCXPSettings.LeerlaufPlaySoundMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help68,'Help68');
end;

procedure TLCXPSettings.Label12MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help69,'Help69');
end;

procedure TLCXPSettings.GroupBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help70,'Help70');
end;

procedure TLCXPSettings.AutoConnectOnStartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help71,'Help71');
end;

procedure TLCXPSettings.AutoReConnectMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help72,'Help72');
end;

procedure TLCXPSettings.AutoConnectIntervalMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help73,'Help73');
end;

procedure TLCXPSettings.AutoConnectEinwahlMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= misc(Help74,'Help74');
end;

procedure TLCXPSettings.Label30MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help75,'Help75');
end;

procedure TLCXPSettings.AutoDMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help76,'Help76');
end;

procedure TLCXPSettings.AutoLMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.text:= misc(Help77,'Help77');
end;

procedure TLCXPSettings.GroupBox20MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help78,'Help78');
end;

procedure TLCXPSettings.GroupBox12MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help89,'Help89');
end;

procedure TLCXPSettings.noFeedsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help90,'Help90');
end;

procedure TLCXPSettings.RssUpdateMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help91,'Help91');
end;

procedure TLCXPSettings.Rss_maxitemsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help92,'Help92');
end;

procedure TLCXPSettings.Rss_oldItemsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help93,'Help93');
end;

procedure TLCXPSettings.GroupBox24MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help94,'Help94');
end;

procedure TLCXPSettings.activateMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help95,'Help95');
end;

procedure TLCXPSettings.registerMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help96,'Help96');
end;

procedure TLCXPSettings.unregisterMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help97,'Help97');
end;

procedure TLCXPSettings.plugSettingsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:= misc(Help98,'Help98');
end;

procedure TLCXPSettings.holidaysValidate(Sender: TObject; ACol, ARow: Integer;
  const KeyName, KeyValue: string);
//var d: TDate;
begin
if (acol = 1) then
  begin
    try
//      d:= StrTodate(keyvalue);
      holicheck.caption:= '';
    except
//      d:= dateof(now);
      holicheck.caption := Keyvalue+ ' ' +misc(M269,'M269');
    end;

  end;
end;

procedure TLCXPSettings.holiday_deleteClick(Sender: TObject);
begin
  Holidays.DeleteRow(holidays.row);
end;

procedure TLCXPSettings.holiday_insertClick(Sender: TObject);
begin

if holidays.row < holidays.rowcount-1 then
begin
  holidays.Row:= holidays.row+1;
  holidays.InsertRow('','',false);
end else holidays.InsertRow('','',true);
end;

end.
