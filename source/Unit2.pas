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
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
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
    GroupBox4: TGroupBox;
    serverautostart: TCheckBox;
    PoEdit: TEdit;
    Label5: TLabel;
    StartButton: TButton;
    StopButton: TButton;
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
    GroupBox14: TGroupBox;
    Suchen: TSpeedButton;
    Pfad: TLabeledEdit;
    Button2: TButton;
    DSurfer: TLabeledEdit;
    selectshowtime: TSpinEdit;
    RadioButton3: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    Label1: TLabel;
    GroupBox15: TGroupBox;
    pledelete: TButton;
    pleopen: TButton;
    resetdate: TButton;
    lasttime: TEdit;
    lasttimelabel: TLabel;
    autoread: TCheckBox;
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
    GroupBox5: TGroupBox;
    Label26: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    userbox1: TComboBox;
    Button1: TButton;
    loeschen: TBitBtn;
    pw: TEdit;
    pw2: TEdit;
    oldpw: TEdit;
    username: TEdit;
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
    procedure FontBClick(Sender: TObject);

    procedure beendenClick(Sender: TObject);
    procedure SuchenClick(Sender: TObject);
    procedure selectshowtimeChange(Sender: TObject);
    procedure RadioButton3Enter(Sender: TObject);
    procedure RadioButton2Enter(Sender: TObject);
    procedure RadioButton1Enter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure PoEditExit(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure userbox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure loeschenClick(Sender: TObject);
    procedure filluserbox;
    procedure autostartClick(Sender: TObject);
    procedure AtomboxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autostartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure minimiertMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PfadMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure selectshowtimeMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RadioButton2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RadioButton1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AusgabeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autoreadMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DSurferMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RASMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PoEditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StartButtonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StopButtonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure serverautostartMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure serverdeleteClick(Sender: TObject);
    procedure ServeraddbuttonClick(Sender: TObject);
    procedure IPMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure serverdeleteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ServeraddbuttonMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ServerboxEnter(Sender: TObject);
    procedure showatomlogClick(Sender: TObject);
    procedure showatomlogMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure updateboxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure gelbMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure gelbChange(Sender: TObject);
    procedure rotChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure edvorwahlKeyPress(Sender: TObject; var Key: Char);
    procedure modemlabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure vorwahllabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DeviceDropDown(Sender: TObject);
    procedure BitBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PfadChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RssListMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RssUpdateMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure rssupClick(Sender: TObject);
    procedure rssdownClick(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox3Change(Sender: TObject);
    procedure bgbuttonClick(Sender: TObject);
    procedure OnlineInfoClick(Sender: TObject);
    procedure loadprogramstrings(activate: string);
    procedure FormCreate(Sender: TObject);
    procedure OnlineInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure bgeditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure scaleMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure resetdateClick(Sender: TObject);
    procedure lasttimeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure resetdateMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure forwardtableMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure hidetrayMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pleopenClick(Sender: TObject);
    procedure pledeleteClick(Sender: TObject);
    procedure programs_suchenClick(Sender: TObject);
    procedure programs_addClick(Sender: TObject);
    procedure ProgramsCloseUp(Sender: TObject);
    procedure programs_offlineClick(Sender: TObject);
    procedure programs_onlineClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure programs_pathMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure programs_timeoutMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure programs_mintimeMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure programs_paramsMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure programs_killMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SoundOnButClick(Sender: TObject);
    procedure SoundOnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure noFeedsClick(Sender: TObject);
    procedure usernameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure oldpwMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pw2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pwMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PageControl1Change(Sender: TObject);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autotrennenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure autotrennenaskMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure autotrennenwaitMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure autotrennenconfirmMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure AutoEinwahlMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure leerlaufminutenMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure autotrennenaskClick(Sender: TObject);
    procedure autotrennenwaitClick(Sender: TObject);
    procedure autotrennenClick(Sender: TObject);
    procedure leerlaufClick(Sender: TObject);
    procedure leerlaufaskClick(Sender: TObject);
    procedure leerlaufwaitClick(Sender: TObject);
    procedure LeerlaufPlaySoundClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure LeerlaufschwelleMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DaystoSaveLogsMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button8Click(Sender: TObject);
    procedure Button8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AutoSurfdauerChange(Sender: TObject);
    procedure AutoConnectOnStartMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure AutoReConnectMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure AutoConnectEinwahlMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure Label30MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox18MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ipmail_nameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ipmail_adressMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure atomrepeatClick(Sender: TObject);
    procedure AtomboxClick(Sender: TObject);
    procedure ipmail_activeClick(Sender: TObject);
    procedure rightClick(Sender: TObject);
    procedure leftMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button9Click(Sender: TObject);
    procedure noBalloonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MultilinkClick(Sender: TObject);
    procedure setupmodemsClick(Sender: TObject);
    procedure setupmodemsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MultilinkMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure opendaysMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
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

uses Unit1, addons, registry, floating, DateUtils, ZLIBArchive;


{$R *.dfm}

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



procedure TLCXPSettings.SuchenClick(Sender: TObject);
begin
 open.Filter:= 'exe|*.exe';
 open.execute;
 Pfad.text := lowercase(open.filename);
 if((AnsiContainstext(pfad.text,'discountsurfer.exe')= false)
      and (AnsiContainstext(pfad.text,'oleco.exe')=false)
      and (AnsiContainstext(pfad.text,'smartsurfer.exe')=false)
      )  then
 begin Pfad.text := 'Fehler !!! '+extractfilename(Pfad.Text)+' ist ein ungültiger Eintrag!'; hauptfenster.oleco.Visible:= true; hauptfenster.oleco.Enabled:= false; hauptfenster.smurf.Visible:= false; end
 else
 begin
 hauptfenster.prog:= Extractfilename(Pfad.text);
 hauptfenster.path:= Extractfilepath(Pfad.text);
 Dsurfer.EditLabel.Caption:= 'Titelleiste von ' +  hauptfenster.prog;

 //welcher button im Hauptfenster?
  if ansicontainstext(hauptfenster.prog,'smartsurfer') then
  begin
  hauptfenster.oleco.Visible:= false;
  hauptfenster.smurf.Visible:= true;
  end
  else
  if ansicontainstext(hauptfenster.prog,'oleco') or ansicontainstext(hauptfenster.prog,'discountsurfer') then
  begin
  hauptfenster.oleco.Visible:= true;
  hauptfenster.smurf.Visible:= false;
  end
  else
  begin
  hauptfenster.oleco.Visible:= false;
  hauptfenster.smurf.Visible:= false;
  end

 end;

 if ansicontainstext(pfad.Text,'oleco.exe') or ansicontainstext(pfad.Text,'discountsurfer.exe')
 then
 begin
 radiobutton1.Enabled:= true;
 radiobutton2.Enabled:= true;
 radiobutton3.Enabled:= true;
 selectshowtime.Enabled:= true;
 label1.Enabled:= true;
 end
 else
 begin
 radiobutton1.Enabled:= false;
 radiobutton2.Enabled:= false;
 radiobutton3.Enabled:= false;
 selectshowtime.Enabled:= false;
 label1.Enabled:= false;
 end;

end;

procedure TLCXPSettings.filluserbox;
var
  counter: integer;
begin

  UserSettings.ReadSections(userbox1.items);

  userbox1.ItemIndex := userbox1.items.IndexOf('active');
  userbox1.items.Delete(userbox1.itemindex);

  if userbox1.Items.count >0 then for counter:=0 to userbox1.Items.Count-1 do
  begin
    userbox1.items[counter]:=Webservform.crypter.DoDecrypt(userbox1.items[counter])
  end;
  userbox1.items.Append('<neuer User>');
  userbox1.ItemIndex := 0;

end;

procedure TLCXPSettings.selectshowtimeChange(Sender: TObject);
begin
try
    settings.writeinteger('Einwahl anzeigen','grenze',selectshowtime.value); {Einwahlgrenze}
except
    settings.writeinteger('Einwahl anzeigen','grenze',0); {Einwahlgrenze} 
end;
    radiobutton1.checked:= false;
    radiobutton2.checked:= false;
end;


procedure TLCXPSettings.RadioButton3Enter(Sender: TObject);
begin
selectshowtime.enabled:= true;
end;

procedure TLCXPSettings.RadioButton2Enter(Sender: TObject);
begin
selectshowtime.enabled:= false;
end;

procedure TLCXPSettings.RadioButton1Enter(Sender: TObject);
begin
selectshowtime.enabled:= false;
end;

procedure TLCXPSettings.BitBtn1Click(Sender: TObject);
begin
bitBtn1.caption:= 'OK';
edit2.Text:= getlocalips;
//ShowMessage('Wenn Sie bereits online sind, dann ist eine der ausgegebenen IP-Adressen nicht lokal. Diese bitte löschen !!');
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

procedure TLCXPSettings.beendenClick(Sender: TObject);
var i: integer;
begin

 //Pfad Speichern
 if fileexists(Pfad.text) then
 begin
  settings.writestring('Pfad von Oleco/ Discountsurfer','path',Extractfilepath(pfad.text));
  settings.writestring('Pfad von Oleco/ Discountsurfer','prog',Extractfilename(pfad.text));
  hauptfenster.path:=Extractfilepath(pfad.text);
  hauptfenster.prog:=Extractfilename(pfad.text);
  if ansicontainstext(hauptfenster.prog,'oleco') or ansicontainstext(hauptfenster.prog,'discountsurfer')
  then
  begin
   hauptfenster.Oleco.visible:= true;
   hauptfenster.oleco.enabled:= true;
   hauptfenster.smurf.visible:= false;
  end
  else
  if ansicontainstext(hauptfenster.prog,'smartsurfer') then
  begin
   hauptfenster.smurf.visible:= true;
   hauptfenster.smurf.enabled:= true;
   hauptfenster.Oleco.visible:= false;
  end;

  if Dsurfer.Text= '' then
  begin
  showmessage('Die Titelzeile von '+Extractfilename(Pfad.text)+' ist nicht eingetragen. Bitte korrigieren !!');
  exit;
  end
  else hauptfenster.Menu.items.Items[1].items[5].enabled:= true;
 end
 else //wenn datei nicht existtiert
 begin
 if ((not (pfad.text='')) and (not ansicontainstext(pfad.text,'fehler !!!')) and (not ansicontainstext(pfad.text,'nicht angegeben')))
 then showmessage(Extractfilename(Pfad.text) +' konnte nicht gefunden werden !')
 else
   begin
     settings.writestring('Pfad von Oleco/ Discountsurfer','path','');
     settings.writestring('Pfad von Oleco/ Discountsurfer','prog','');
     hauptfenster.path:='';
     hauptfenster.prog:='';
     hauptfenster.smurf.visible:= false;
     hauptfenster.Oleco.visible:= false;
     hauptfenster.oleco.enabled:= false;
     hauptfenster.Menu.items.Items[1].items[5].enabled:= false;
   end

 end;

 //Einwahl anzeigen ? - > Value
 if Radiobutton1.Checked then settings.writeinteger('Einwahl anzeigen','grenze',-2)
 else if Radiobutton2.Checked then settings.writeinteger('Einwahl anzeigen','grenze',-1);

  //IP speichern
  settings.writestring('lokale IP','IP',Edit2.text);
 //Notification
  settings.writebool('lokale IP','IP_Notify',ipmail_active.checked);
  settings.writestring('lokale IP','IP_Notify_Name',ipmail_name.text);
  settings.writeString('lokale IP','IP_Notify_Adress',ipmail_adress.text);

 //Server Autostart
  settings.writebool('Server','Autostart',serverautostart.Checked);
  settings.writestring('Server','Port',Poedit.text);
  settings.writestring('Server','Titel',DSurfer.Text);

  settings.writeBool('LeastCoster','autostart',autostart.Checked);
  settings.writeBool('LeastCoster','minimiert',minimiert.checked);
  settings.writebool('LeastCoster','autoread', autoread.checked);
  settings.writebool('LeastCoster','MinimizeOnClose', minimize.checked);
  settings.writeinteger('LeastCoster','DaysToSaveLogs', DaysToSaveLogs.Value);
  Hauptfenster.DaysToSaveLogs:= DaysToSaveLogs.Value;
  Hauptfenster.minimizeonclose:= minimize.checked;
  settings.writebool('LeastCoster','noBalloon', noBalloon.checked);
  settings.writestring('LeastCoster','SoundON',   soundon.text );
  settings.writestring('LeastCoster','SoundOFF',   soundoff.text );

  hauptfenster.noBalloon:= noBalloon.checked;

  hauptfenster.clock.visible:= time.checked;
  if hauptfenster.clock.visible then hauptfenster.DateLabel.Constraints.MaxWidth:= 402
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

  Hauptfenster.AutoBlackList := AutoBlacklist.value;
  Hauptfenster.AutoBlackListScore := AutoBlacklistScore.value;
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

  hauptfenster.AutoSurfdauer      := AutoSurfdauer.position;

  hauptfenster.AutoDialLED.ledon:= AutoReConnect.Checked;
  hauptfenster.Autobasis.caption:= inttostr(AutosurfDauer.position div 60) + ' h '+ inttostr(AutosurfDauer.position mod 60) +' min';
  hauptfenster.AutoBase.position:= Autosurfdauer.position;
  hauptfenster.AutoDialEinwahl.Checked:= AutoConnectEinwahl.Checked;

  if (assigned(floatingW)and (not hauptfenster.isonline)) then floatingW.Close;

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
        Hint:= 'Das automatische Atomzeit-Update ist deaktiviert';
   end
   else
   begin
        Coloroff:= clMaroon;
        LEDOn:= false;
        Hint:= 'Noch kein Atomzeit-Update seit dem Start.';
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
          hauptfenster.ledRss.ColorOff:= clGray; hauptfenster.ledrss.Hint:= 'RSSFeeds sind deaktiviert.';
     end
     else
     begin
          hauptfenster.ledRss.ColorOff:= clMaroon; hauptfenster.ledrss.Hint:= 'Noch kein Rss-Feed Update seit dem Start.';
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

//AutoCheck
 if not autoread.Checked then
 begin
  if ansicontainstext(hauptfenster.prog,'oleco') or ansicontainstext(hauptfenster.prog,'discountsurfer')
  then hauptfenster.Menu.items.Items[0].Items[3].Items[0].enabled:= true
  else hauptfenster.Menu.items.Items[0].Items[3].Items[0].enabled:= false;
 end;

  //Leere Zeilen in der Rsslist löschen
 if rsslist.RowCount > 3 then
 for i:= rsslist.RowCount-2 downto 0 do
         if rsslist.Strings[i] = '=' then rsslist.DeleteRow(i+1);
 //abspeichern
 rsslist.Strings.SaveToFile(extractfilepath(paramstr(0)) + 'Rsslist.txt');

 LCXPSettings.Close;
end;

procedure TLCXPSettings.PoEditExit(Sender: TObject);
begin
webservform.portedit.Text:= Poedit.text;
end;

procedure TLCXPSettings.StartButtonClick(Sender: TObject);
var i, Code: integer;
begin
Val(PoEdit.Text, I, Code);
  { Error during conversion to integer? }
  if Code <> 0 then
  begin
    MessageDlg('Fehler bei der Eingabe des Ports', mtWarning, [mbOk], 0);
    Poedit.Text:= '85';
    exit;
  end;
webservform.startbutton.click;
stopbutton.Enabled:= true;
startbutton.Enabled:=false;
end;

procedure TLCXPSettings.StopButtonClick(Sender: TObject);
begin
Webservform.Stopbutton.click;
stopbutton.Enabled:= false;
startbutton.Enabled:=true;

end;

procedure TLCXPSettings.userbox1Change(Sender: TObject);
var i: integer;
begin

 i:= userbox1.ItemIndex;
 if not (userbox1.items[i]= '<neuer User>') then username.Text:= userbox1.items[i]
  else username.Text:='';
 pw.Text:= '';
 pw2.Text:= '';
 oldpw.Text:= '';
 
end;




procedure TLCXPSettings.Button1Click(Sender: TObject);
var oldpw_buf, pw_buf: string;
begin
if username.text <> '' then
begin
oldpw_buf:= 'Sorry no password to read:'+oldpw.text + #0;
pw_buf:= 'Sorry no password to read:'+pw.Text + #0;


if UserSettings.sectionexists(webservform.crypter.doencrypt(username.text)) then
begin
if (GetMD5(@oldpw_buf[1], Length(oldpw_buf) - 1) = UserSettings.readstring(webservform.crypter.doencrypt(username.text),webservform.crypter.doencrypt('pass'),'no password!!')) then
  if (pw.text=pw2.text) then UserSettings.writestring(webservform.crypter.DoEncrypt(username.text),webservform.crypter.doencrypt('pass'),GetMD5(@pw_buf[1], Length(pw_buf) - 1))
    else showmessage('Die beiden Passwortfelder stimmen nicht überein !')
  else showmessage('Falsches Passwort !!')
end
else if (pw.text=pw2.text) then
begin
UserSettings.writestring(webservform.crypter.DoEncrypt(username.text),webservform.crypter.doencrypt('pass'),GetMD5(@pw_buf[1], Length(pw_buf) - 1));
username.Text:='';
oldpw.Text:='';
pw.Text:= '';
pw2.Text:= '';
end
else showmessage('Die beiden Passwortfelder stimmen nicht überein !');

end;
filluserbox;

end;

procedure TLCXPSettings.loeschenClick(Sender: TObject);
var oldpw_buf: string;
begin
if username.text <> '' then
begin

if UserSettings.sectionexists(webservform.crypter.doencrypt(username.text)) then
  begin
  oldpw_buf:= 'Sorry no password to read:'+oldpw.text + #0;
  if (GetMD5(@oldpw_buf[1], Length(oldpw_buf) - 1)) = UserSettings.readstring(webservform.crypter.doencrypt(username.text),webservform.crypter.doencrypt('pass'),'no password!!') then
    UserSettings.erasesection(webservform.crypter.DoEncrypt(username.text))
      else showmessage('Falsches Passwort !!')
  end;

end;
filluserbox;
username.Text:='';
oldpw.Text:='';
pw.Text:= '';
pw2.Text:= '';

end;


procedure TLCXPSettings.autostartClick(Sender: TObject);

begin
// letzter Parameter: true, wenn key zu löschen/ false wenn nicht
if autostart.checked = true then
CreateAutorunEntry(Application.Title,'"'+ParamStr(0)+'"', akRun,false)
else
CreateAutorunEntry(Application.Title,'"'+ParamStr(0)+'"', akRun,true);
end;

procedure TLCXPSettings.AtomboxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Atomzeit:' +chr(13)+chr(10)+
'Damit es nicht zu unnötigen Tarifüberschreitungen kommt, muss die Uhrzeit des Computers immer genau sein. Mit dem Atomzeit-Update wird die Uhrzeit bei Online-Verbindung mit einem Time-Server abgeglichen.'+
 #13#10+
'Achtung: andere Atomzeit-Update Programme und die Windows-Funktion müssen deaktiviert sein.';
end;

procedure TLCXPSettings.autostartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Autostart:' +chr(13)+chr(10)
              + 'LeastCoster XP startet mit Windows. Wenn der Webserver nach dem Einschalten der Rechners zur Verfügung stehen soll, dann unbedingt aktivieren !'
end;

procedure TLCXPSettings.minimiertMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'minimiert:' +chr(13)+chr(10)
              + 'Der LeastCoster startet nur in der Tray-Leiste (kleines graues Symbol, das bei Onlineverbindung gelb wird). Ein Klick darauf maximiert den LeastCoster.'
end;

procedure TLCXPSettings.PfadMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.Text:= 'Pfad:' +chr(13)+chr(10)
              + 'Welches Programm soll als Ausweichprogramm benutzt werden, sollten keine Tarife vorliegen ? '+
              'Wird Oleco oder Discountsurfer gewählt, so kann das Kostenprotokoll, in das LeastCoster-eigene Protokoll importiert werden. (> Protokolle > Automatisch importieren)';
end;

procedure TLCXPSettings.Label1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Tarife mit Einwahlgebühr:' +chr(13)+chr(10)
              + '(a) werden ausgeblendet wenn die gewünschte Surfdauer kleiner ist als eingestellt' + chr(13)+chr(10)+
                '(b) werden immer bzw. (c) nie angezeigt' + chr(13)+chr(10) +
                'empfohlene:Einstellung: 15 min';
end;

procedure TLCXPSettings.selectshowtimeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Tarife mit Einwahlgebühr:' +chr(13)+chr(10)
              + '(a) werden ausgeblendet wenn die gewünschte Surfdauer kleiner ist als eingestellt' + chr(13)+chr(10)+
                '(b) werden immer bzw. (c) nie angezeigt' + chr(13)+chr(10) +
                'empfohlene:Einstellung: 15 min';
end;

procedure TLCXPSettings.RadioButton2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Tarife mit Einwahlgebühr:' +chr(13)+chr(10)
              + '(a) werden ausgeblendet wenn die gewünschte Surfdauer kleiner ist als eingestellt' + chr(13)+chr(10)+
                '(b) werden immer bzw. (c) nie angezeigt' + chr(13)+chr(10) +
                'empfohlene:Einstellung: 15 min';
end;

procedure TLCXPSettings.RadioButton1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Tarife mit Einwahlgebühr:' +chr(13)+chr(10)
              + '(a) werden ausgeblendet wenn die gewünschte Surfdauer kleiner ist als eingestellt' + chr(13)+chr(10)+
                '(b) werden immer bzw. (c) nie angezeigt' + chr(13)+chr(10) +
                'empfohlene:Einstellung: 15 min';
end;

procedure TLCXPSettings.Label2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Protokolldateien:' +chr(13)+chr(10)
       +' ... werden im eingestellten Ordner abgelegt.'+chr(13)+chr(10)
       +'Achtung: Sie werden bei jeder Aktualisierung überschrieben, um eine bestimmte Datei zu behalten, muss sie umbenannt oder kopiert werden.';
end;

procedure TLCXPSettings.AusgabeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Protokolldateien:' +chr(13)+chr(10)
       +' ... werden im eingestellten Ordner abgelegt.'+chr(13)+chr(10)
       +'Achtung: Sie werden bei jeder Aktualisierung überschrieben, um eine bestimmte Datei zu behalten, muss sie umbenannt oder kopiert werden.';
end;

procedure TLCXPSettings.autoreadMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Automatischer Kostenprotokoll-Import:' +chr(13)+chr(10)
              +'Nach jeder Verbindung werden die Daten von Oleco::NetLCR bzw. Discountsurfer autmatisch importiert. So ist eine chronologische Auflistung im Kostenprotokoll gewährleistet.';

end;

procedure TLCXPSettings.DSurferMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Titelleiste:' +chr(13)+chr(10)
              +'Welchen Namen hat das Oleco/ Discountsurfer-Fenster ?'+chr(13)+chr(10)
              +'Vor allem wichtig zur Fernsteuerung über das WebInterface.' +chr(13)+chr(10)
              +'Achtung: Groß- und Kleinschreibung beachten !';
end;

procedure TLCXPSettings.CheckBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'keinen Onlinecheck' +chr(13)+chr(10)+
              ' ... die WebInterface-Funktionen "verbinden" und "trennen" sind dann nicht möglich !! '+chr(13)+chr(10)+
              ' ... kein Atomzeitabgleich, kein Update, keine Onlineanzeige möglich ';;
end;

procedure TLCXPSettings.RASMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.text:= 'Onlinecheck' +chr(13)+chr(10)+
              '(a) RAS: empfohlen - Überprüfung der DFÜ-Verbindungen (auch für Win9x)' +chr(13)+chr(10)+
              '(b) IP: Überprüfung der IP-Adressen des Rechners. Es müssen die Adressen eingetragen werden, die der Rechner hat, wenn er offline ist. Der Button hilft beim herausfinden.';
end;

procedure TLCXPSettings.PoEditMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Port' +chr(13)+chr(10)+
              'Auf welchem Port soll das WebInterface bereitgestellt werden ?' +chr(13)+chr(10)+
              'Empfohlene Einstellung: 85'+chr(13)+chr(10)+
              'Die Adresse des Interfaces ist dann http://{servername}:{port}, z.B. http://192.168.0.1:85 .';
end;

procedure TLCXPSettings.StartButtonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Start' +chr(13)+chr(10)+
             '... startet das WebInterface';
end;

procedure TLCXPSettings.StopButtonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Stop' +chr(13)+chr(10)+
             '... beendet das WebInterface';
end;

procedure TLCXPSettings.serverautostartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Automatischer Start' +chr(13)+chr(10)+
             '... startet das WebInterface bei Programmstart.';
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
//    showmessage(TrimRight(Title));
    ActiveCaption := TrimRight(Title);
  end;
end;

procedure TLCXPSettings.Button2Click(Sender: TObject);
var titel: string;
begin
titel:= 'test';
if fileexists(Pfad.text)=false then showmessage('Die Datei '+Pfad.text +' gibt es nicht.'+ chr(13) + 'Bitte die Einstellungen überprüfen')
else
  begin
   //starten
   ShellExecute(0,'open',Pchar(Pfad.text),Pchar ('') ,nil,SW_hide);

   sleep(6000);

   //Titel bestimmen
   titel := activecaption();
   if not ansicontainstext(titel,'LeastCosterXP') then askedclose(PAnsichar(titel))
   else showmessage('Titel nicht gefunden. Bitte Versuch wiederholen.');
   DSurfer.Text:= titel;


   end;



end;

procedure TLCXPSettings.Button2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= 'Titel herausfinden' +chr(13)+chr(10)+
              'Oleco/Discountsurfer wird geöffnet, die Titelleiste wird ausgelesen, anschließend wird Oleco wieder geschlossen. Der Vorgang dauert ca. 3s .';
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

procedure TLCXPSettings.IPMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.text:= 'Onlinecheck' +chr(13)+chr(10)+
              '(a) RAS: empfohlen - Überprüfung der DFÜ-Verbindungen (auch für Win9x)' +chr(13)+chr(10)+
              '(b) IP: Überprüfung der IP-Adressen des Rechners. Es müssen die Adressen eingetragen werden, die der Rechner hat, wenn er offline ist. Der Button hilft beim herausfinden.';
end;

procedure TLCXPSettings.Label6MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Atomzeit-Server' +chr(13)+chr(10)+
              'Server, die das SNTP-Protokoll unterstützen, können hier eingetragen werden.'
            + 'Der LeastCoster XP versucht die Liste in angegebener Reihenfolge abzuarbeiten, wenn ein Server nicht antwortet.';
end;

procedure TLCXPSettings.serverdeleteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Atomzeit-Server löschen' +chr(13)+chr(10)+
              '... löscht den markierten Server.';
end;

procedure TLCXPSettings.ServeraddbuttonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Atomzeit-Server hinzufügen' +chr(13)+chr(10)+
              '... fügt den in der Textbox eingetragenen Server der Liste hinzu.' +chr(13)+chr(10)
              +'ACHTUNG: Es findet keine Überprüfung statt !';
end;

procedure TLCXPSettings.ServerboxEnter(Sender: TObject);
begin
memo1.text:= 'Atomzeit-Server' +chr(13)+chr(10)+
              'Server, die das SNTP-Protokoll unterstützen, können hier eingetragen werden.'
            + 'Der LeastCoster XP versucht die Liste in angegebener Reihenfolge abzuarbeiten, wenn ein Server nicht antwortet.';

end;

procedure TLCXPSettings.showatomlogClick(Sender: TObject);
begin
if fileexists(extractfilepath(paramstr(0))+'log\atomzeit.txt') then
ShellExecute(0,'open',Pchar(extractfilepath(paramstr(0))+'log\atomzeit.txt'),'' ,nil,SW_SHOWNORMAL)
//ShellExecute(0,'open',Pchar('notepad.exe'),Pchar(extractfilepath(paramstr(0))+'log\atomzeit.txt') ,nil,SW_SHOWNORMAL)
end;

procedure TLCXPSettings.showatomlogMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Logfile anzeigen' +chr(13)+chr(10)+
              'Die Änderungen der Uhrzeit werden in der Datei "Atomzeit.txt" protokolliert.'
              + #13#10
              +'Ein Klick auf diesen Button öffnet das Logfile';
end;

procedure TLCXPSettings.updateboxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Programmupdates' +chr(13)+chr(10)+
              '... Überprüfung auf Updates (empfohlen)';
end;

procedure TLCXPSettings.Label10MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Einfärbung der Balkendiagramme' +chr(13)+chr(10)+
              'Die Balkendiagramme werden blau, gelb und rot eingefärbt. Hier einzutragen sind die vorrausichtlichen Monatskosten.' +chr(13)+chr(10)+
              'Dier Wert wird intern durch die Anzahl der Tage geteilt. Eine Einfärbung findet dann statt wenn der jeweilige Anteil an einem Tag überschritten wurde.' +chr(13)+chr(10)+
              'Standardwerte: gelb: 10 | rot 15';
end;

procedure TLCXPSettings.gelbMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
memo1.text:= 'Einfärbung der Balkendiagramme' +chr(13)+chr(10)+
              'Die Balkendiagramme werden blau, gelb und rot eingefärbt. Hier einzutragen sind die vorrausichtlichen Monatskosten.' +chr(13)+chr(10)+
              'Dier Wert wird intern durch die Anzahl der Tage geteilt. Eine Einfärbung findet dann statt wenn der jeweilige Anteil an einem Tag überschritten wurde.' +chr(13)+chr(10)+
              'Standardwerte: gelb: 10 | rot 15';
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

procedure TLCXPSettings.modemlabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= 'Modem' +chr(13)+chr(10)+
              'Welches Modem wird verwendet um ins Internet zu gehen ?';
end;

procedure TLCXPSettings.vorwahllabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= 'Modem-Vorwahlstring' +chr(13)+chr(10)+
              'Manchmal ist es notwendig eine Nummer vorzuwählen um z.B. eine Telefonanlage zu passieren.' + #13#10
             +'z.B.: "0,"';
end;

procedure TLCXPSettings.DeviceDropDown(Sender: TObject);
begin
 memo1.text:= 'Modem' +chr(13)+chr(10)+
              'Welches Modem wird verwendet um ins Internet zu gehen ?';
end;

procedure TLCXPSettings.BitBtn1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.text:= 'IP-Adresse' +chr(13)+chr(10)+
              'Listet alle dem Computer zugewiesenen IP-Adressen auf.'+
              'Sofern der Rechner Offline ist und er KEINE Netzwerkverbindungen besitzt muss hier  der Wert 127.0.0.1 erscheinen ...'+
              'Einstellung hat keine Relevanz - nur zur Info ... ';
end;

procedure TLCXPSettings.PfadChange(Sender: TObject);
begin
DSurfer.Text:= '';
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

procedure TLCXPSettings.RssListMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Adressen:' +chr(13)+chr(10)
              +'Tragen Sie hier den Namen und die Adresse Ihrer zu beobachtenden RSS-Feeds ein. Die Reihenfolge wird wie sie hier ist übernommen und im Menü angezeigt.';
end;

procedure TLCXPSettings.RssUpdateMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Update' +chr(13)+chr(10)
              +'Die eingestellten RSS-Feeds werden bei Online-Verbindungen aktualisiert und dann alle xx Minuten neu heruntergeladen.';
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
    code, i: integer;
    showtime: integer;
begin

leastcosterrow:=0;
hauptfenster.Enabled:= false;

//netzwerkeinstellungen öffen ausblenden wenn nicht WinXP
if (MagRasOSVersion >= OSW2K) then button8.Visible:= true else
begin
button8.Visible:= false;
device2.Visible:= false;
multilink.visible:= false;
end;
PageControl1.ActivePageIndex:= 0;

groupbox14.Visible:=  hauptfenster.MM3_2.checked;
groupbox11.Visible:=  hauptfenster.MM3_2.checked;
tabsheet2.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet4.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet5.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet6.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet7.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet8.tabVisible :=  hauptfenster.MM3_2.checked;
tabsheet9.tabVisible :=  hauptfenster.MM3_2.checked;


for i:= 0 to hauptfenster.pluglist.count-1 do
    Plugbox.Items.Append(hauptfenster.pluglist.strings[i]);

memo1.Text:= 'Hinweise:' +chr(13)+chr(10)+
              ' werden beim Zeigen auf ein Objekt angezeigt.';
filluserbox;

  username.text:= '';
  pw.text:= '';
  pw2.Text:='';


pfad.text:= settings.Readstring('Pfad von Oleco/ Discountsurfer','path','')+settings.Readstring('Pfad von Oleco/ Discountsurfer','prog','');
DSurfer.Text:= settings.ReadString('Server','Titel','');
open.initialDir:= settings.Readstring('Pfad von Oleco/ Discountsurfer','path','C:\Programme\');

if ansicontainstext(pfad.Text,'oleco.exe') or ansicontainstext(pfad.Text,'discountsurfer.exe')
 then
 begin
 radiobutton1.Enabled:= true;
 radiobutton2.Enabled:= true;
 radiobutton3.Enabled:= true;
 selectshowtime.Enabled:= true;
 label1.Enabled:= true;
 end
 else
 begin
 radiobutton1.Enabled:= false;
 radiobutton2.Enabled:= false;
 radiobutton3.Enabled:= false;
 selectshowtime.Enabled:= false;
 label1.Enabled:= false;
 end;

 showtime := settings.Readinteger('Einwahl anzeigen','grenze',20); {Einwahlgrenze}

//Oleco/DSurfer
if settings.Readstring('Einwahl anzeigen','grenze','') <> '' then
begin
val(settings.Readstring('Einwahl anzeigen','grenze',''),showtime,code);
if code = 0 then
if showtime > 0 then begin selectshowtime.value:= showtime; radiobutton3.Checked:= true; selectshowtime.enabled:= true; end;
if ((showtime = -1)or (settings.Readstring('Einwahl anzeigen','grenze','') = '') ) then begin radiobutton2.checked:= true; selectshowtime.value:= 0; selectshowtime.enabled:= false; end;    {an}
if ( (settings.Readstring('Einwahl anzeigen','grenze','') ='-2') or (showtime=0) ) then begin radiobutton1.checked:= true; selectshowtime.value:= 0; selectshowtime.enabled:= false; end;{aus}
end;

lasttime.text:= settings.ReadString('lastdate','1','') + ' ' + settings.ReadString('lastdate','3','');
autoread.checked:= settings.readbool('LeastCoster','autoread',false);
noballoon.Checked:= hauptfenster.noBalloon;

time.checked:= Hauptfenster.clock.Visible;

autostart.Checked:= settings.ReadBool('LeastCoster','autostart',false);
minimiert.Checked:= settings.ReadBool('LeastCoster','minimiert',false);
minimize.checked:= Hauptfenster.MinimizeOnClose;
DaysToSaveLogs.Value:= Hauptfenster.DaysToSaveLogs;

SoundOn.Text:=   settings.readstring('LeastCoster','SoundON',  '' );
SoundOFF.Text:=  settings.readstring('LeastCoster','SoundOFF',  '' );

//WebInterface
Poedit.text:= settings.ReadString('Server','Port','85');
webservform.PortEdit.Text:= Poedit.Text;
serverautostart.checked:= settings.readbool('Server','Autostart',false);
startbutton.Enabled:= false;
stopbutton.enabled:= false;
if (webservform.HttpServer1.Tag = 0 ) then startbutton.enabled:= true else stopbutton.Enabled:= true;
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
  DisconnectSeconds.Value:= Hauptfenster.DisconnectSeconds; 
  autotrennen_konti.checked:= settings.Readbool('Autotrennen','Kontingente',true);
  autotrennenclick(self);

  AutoBlacklist.value:= hauptfenster.AutoBlacklist;
  AutoBlacklistScore.value:= hauptfenster.AutoBlacklistScore;

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
  AutoSurfdauer.Position     := settings.Readinteger('AutoConnect','Basiszeit',1);
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
 rsslist.InsertRow('LeastCosterXP','http://rss.groups.yahoo.com/group/leastcosterxp/rss',false);
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

end;

procedure TLCXPSettings.OnlineInfoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'OnlineInfo' +chr(13)+chr(10)
              +'Das Infofenster wird angezeigt, sobald sie eine Verbindung mit LeastCosterXP herstellen.';
end;

procedure TLCXPSettings.bgeditMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'OnlineInfo' +chr(13)+chr(10)
              +'Geben Sie hier das gewünschte Hintergrundbild an.'
              + #13#10+'Maße: 180x200 pixel (groß) | 65x200 pixel (klein) ';
end;

procedure TLCXPSettings.scaleMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Umskalieren' +chr(13)+chr(10)
              +'Das Hintergrundbild wird auf die Fenstergröße skaliert. Auch beim minimieren. Wenn nicht angehakt, wird das Bild auf die Größe der Gesamtansicht skaliert.';
end;

procedure TLCXPSettings.resetdateClick(Sender: TObject);
begin
 resetlastdate:= true;
 lasttime.text:= '';
end;

procedure TLCXPSettings.lasttimeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Datum des letzten Imports' +chr(13)+chr(10)
              +'Damit nicht jedes mal das komplette Kostenprotokoll von Oleco::NetLCR oder Discountsurfer importiert wird, merkt sich LeastCosterXP, welche Datensätze bereits importiert wurden.';
end;

procedure TLCXPSettings.resetdateMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Reset - Datum des letzten Imports' +chr(13)+chr(10)
              +'Es kann in seltenen Fällen vorkommen, dass Daten doppelt importiert wurden. Aus diesem Grunde kann man unter Export, alle Daten von Oleco::NetLCR o. Discountsurfer wieder löschen.'
              +' Damit aber ältere Datensätze wieder importiert werden, muss das Datum zurückgesetzt werden.'
              +chr(13)+chr(10)
              +'Achtung: Werden die Daten nicht vor dem nächsten Import gelöscht, kommt es zu Dopplungen im Kostenprotokoll.';
end;

procedure TLCXPSettings.forwardtableMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Anzeige im Voraus' +chr(13)+chr(10)
              +'Im Online-Modus wird die Tariftabelle für die kommenden Minuten angezeigt. Hier wird angezeigt, wie lange im Voraus die Tabelle berechnet wird.'
              +chr(13)+chr(10)
              +'Achtung: Auch die Warnung, wenn ein Tarif teurer wird, endet oder ein billigerer Tarif zur Verfügung steht, richtet sich anch dieser Zeit.';
end;

procedure TLCXPSettings.hidetrayMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Verstecken nach dem Online- Wechsel' +chr(13)+chr(10)
              +'Das Hauptfenster wird nach dem Onlinewechsel minimiert und im Tray versteckt.';

end;

procedure TLCXPSettings.pleopenClick(Sender: TObject);
var name: string;
begin
name := Extractfilepath(pfad.text) + 'ple.cst';
if fileexists(name) then
  ShellExecute(0,'open',Pchar(name),Pchar ('') ,nil,SW_NORMAL);
end;

procedure TLCXPSettings.pledeleteClick(Sender: TObject);
var name: string;
begin
name:= Extractfilepath(pfad.text) + 'ple.cst';
if not deletefiletorecyclebin(name)
then showmessage('Fehler beim Löschen von '+name+'.');
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
     showmessage('Fehler: Die Datei '+extractfilename(programs_path.text)+'existiert nicht !');
     exit;
end;

if programs_path.text <> '' then
begin
      //namen
     if programs_add.Caption = '&speichern' then
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
        ini:= SettingsOnline//TmemInifile.Create(Extractfilepath(paramstr(0)) + 'online.ini')
     else
     if programs_offline.Checked then
        ini:= SettingsOffline;//TmemInifile.Create(Extractfilepath(paramstr(0)) + 'offline.ini');

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

programs_add.Caption:= '&hinzufügen';
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
            ini:= SettingsOffline;//TmemInifile.Create(Extractfilepath(paramstr(0)) + 'offline.ini');
            mode_online:= false;
          end
    else  begin
            ini:= SettingsOnline;//TmemInifile.Create(Extractfilepath(paramstr(0)) + 'online.ini');
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

    programs_add.Caption:= '&speichern';
   end
   else bitbtn2.click;

end;

procedure TLCXPSettings.programs_offlineClick(Sender: TObject);
begin
programs_kill.Enabled:= false;
if (( programs_add.caption = '&speichern') and mode_online)  then mode_change:= true
else mode_change:= false;
end;

procedure TLCXPSettings.programs_onlineClick(Sender: TObject);
begin
programs_kill.Enabled:= true;
if ((programs_add.caption = '&speichern') and not mode_online) then mode_change:= true
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
            ini:= SettingsOffline //TmemInifile.Create(Extractfilepath(paramstr(0)) + 'offline.ini')
    else
            ini:= SettingsOnline; //TmemInifile.Create(Extractfilepath(paramstr(0)) + 'online.ini');
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
programs_add.Caption:= '&hinzufügen';
opendays.Value:= 0;
end;

procedure TLCXPSettings.programs_pathMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Programmstart' +chr(13)+chr(10)+
              ' ... wechselt der Rechner in den OFFLINE- oder ONLINE-Zustand können Programme gestartet werden';
end;

procedure TLCXPSettings.programs_timeoutMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Timeout' +chr(13)+chr(10)+
              ' ... gibt die Zeit in Millisekunden an, die vor dem Start des Programms gewartet werden soll.';
end;

procedure TLCXPSettings.programs_mintimeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'mindeste Basiszeit' +chr(13)+chr(10)+
              ' ... nur wenn die eingestellte Surfdauer den Mindestwert in Minuten überschreitet, dann wird das Programm gestartet. ';
end;

procedure TLCXPSettings.programs_paramsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Parameter' +chr(13)+chr(10)+
              ' Manche Programme können Kommandozeilenparameter verarbeiten, um spezielle Funktionen auszuführen. Diese Parameter sind der Hilfe des jeweiligen Programms zu entnehmen.';
end;

procedure TLCXPSettings.programs_killMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'Programm wieder beenden' +chr(13)+chr(10)+
              ' Ein Programm, das bei ONLINE-Verbindungen gestartet wird, kann beendet werden.'
              +#13#10 +
              'Achtung: Das Programm wird dann einfach "abgeschossen". Es kann zu Datenverlust kommen.';
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

procedure TLCXPSettings.SoundOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Sound' +chr(13)+chr(10)
              +'Beim Verbinden und Trennen kann je ein Sound abgespielt werden. Dieser muss im Wave- Format vorliegen';
end;

procedure TLCXPSettings.noFeedsClick(Sender: TObject);
begin
if noFeeds.checked then
   begin
        Rsslist.Enabled:= false;
        rssup.Enabled:= false;
        rssdown.Enabled:= false;
        button4.Enabled:= false;
        button5.enabled:= false;
        rssupdate.Enabled:= false;
        label13.Enabled:= false;
        label_min.Enabled:= false;
        label49.Enabled:= false;
        label50.Enabled:= false;
        Rss_maxitems.Enabled:= false;
        Rss_oldItems.enabled:= false;
   end
   else
   begin
        Rsslist.Enabled:= true;
        rssup.Enabled:= true;
        rssdown.Enabled:= true;
        button4.Enabled:= true;
        button5.enabled:= true;
        rssupdate.Enabled:= true;
        label13.Enabled:= true;
        label_min.Enabled:= true;
        label49.Enabled:= true;
        label50.Enabled:= true;
        Rss_maxitems.Enabled:= true;
        Rss_oldItems.enabled:= true;
   end;
end;

procedure TLCXPSettings.usernameMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.Text:= 'User' +chr(13)+chr(10)
              +'Geben Sie hier dem Namen an, mit dem sich ein User beim WebInterface einloggen soll.';
end;

procedure TLCXPSettings.oldpwMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.Text:= 'altes Passwort' +chr(13)+chr(10)
              +'Wenn Sie einen neuen Benutzer hinzufügen, dann können sie dieses Feld leer lassen. Zum Ändern und Löschen, aber muss Ihnen das Benutzerpasswort bekannt sein.';
end;

procedure TLCXPSettings.pw2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.Text:= 'Passwortbestätigung' +chr(13)+chr(10)
              +'Bitte geben Sie hier ihr Passwort ein zweites Mal ein. Dies ist eine Sicherheitsabfrage, um zu vermeiden, dass Sie sich beim ersten mal vertippt haben';
end;

procedure TLCXPSettings.pwMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 memo1.Text:= 'neues Passwort' +chr(13)+chr(10)
              +'Tragen Sie hier das Passwort ein. Möchten Sie ihr Passwort ändern, dann muss zusätzlich das zuvor gültige Passwrot angegeben werden (siehe ''altes Passwort'').';
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

procedure TLCXPSettings.GroupBox2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Automatisches Trennen' +chr(13)+chr(10)
              +'Diese Einstellungen werden bei Online-Wechsel automatisch gesetzt und können dann aber individuell für die Verbindung angepasst werden.';
end;

procedure TLCXPSettings.autotrennenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if sender = autotrennen_konti then
memo1.Text:= 'Trennen zum Ende von Kontingenten' +chr(13)+chr(10)
              +'60s bevor ein Kontingent aufgebraucht ist, wird ein Hinweis angezeigt und die Verbindung nach 30s getrennt. Bei Volumenkontingenten wird getrennt sobald weniger als 512kB übrig sind.'
else
memo1.Text:= 'Trennen zum Ende des Tarifes' +chr(13)+chr(10)
              +'Das automatisches Trennen wird zur Uhrzeit des Tarifendes programmiert.';
end;

procedure TLCXPSettings.autotrennenaskMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= '... mit Nachfrage' +chr(13)+chr(10)
              +'Wenn gewünscht erscheint ein Hinweisfenster vor dem Trennen der Verbindung.';
end;

procedure TLCXPSettings.autotrennenwaitMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Warten bis zum Trennen' +chr(13)+chr(10)
              +'... das Hinweisfenster wartet xx Sekunden und trennt nach Ablauf dieser Zeit, wenn nicht zuvor auf ''Stop'' gedrückt wurde.';
end;

procedure TLCXPSettings.autotrennenconfirmMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Nur nach Bestätigung' +chr(13)+chr(10)
              +'Das Hinweisfenster erscheint, aber es wird nur getrennt, wenn ''Jetzt trennen'' gedrückt wird.';
end;

procedure TLCXPSettings.AutoEinwahlMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Ausschalten' +chr(13)+chr(10)
              +'Nach dem automatischen Trennen kann der Computer im jeweiligen Modus ausgeschaltet werden.' +#13#10 +
              'Auch dies ist die Standardeinstellung, die bei jedem Online-Wechsel aktiviert wird.';
end;

procedure TLCXPSettings.leerlaufminutenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 memo1.Text:= 'Trennen bei Leerlauf und Leerlaufzeit' +chr(13)+chr(10)
              + 'Werden keine Daten über die aktuelle Verbindung empfangen oder gesendet, so ist die Verbindung im Leerlauf und verursacht unnötig Kosten. Nach einer zulässigen Leerlaufzeit von xx Minuten können solche Verbindungen getrennt werden.';
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
// autotrennenwaitclick(sender);
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

procedure TLCXPSettings.LeerlaufschwelleMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.Text:= 'Leerlaufschwelle' +chr(13)+chr(10)
              + 'Die Verbindung wird als im Leerlauf betrachtet, wenn die Summe aus gesendeten und empfangenen Bytes kleiner als diese Leerlaufschwelle ist.'
              +  ' Je kleiner dieser Wert ist, desto empfindlicher ist die Leerlauferkennung auf Datenbewegungen. Ist dieser Wert zu groß gewählt, so wird nahezu jede Verbindung gemeldet.' +#13#10
              + 'Empfehlung: 500 bytes/Sekunde';
end;

procedure TLCXPSettings.DaystoSaveLogsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.Text:= 'Log-Dateien' +chr(13)+chr(10)
              + 'Datensätze die älter als xx Tage sind werden automatisch aus den Log-Dateien entfernt.'
              +  'So wird vermieden, dass die Log-Dateien immer länger werden.'
end;

procedure TLCXPSettings.Button8Click(Sender: TObject);
begin
ShellExecute(GetActiveWindow,'open','rundll32.exe','shell32.dll,Control_RunDLL ncpa.cpl,,4',NIL,SW_NORMAL);
end;

procedure TLCXPSettings.Button8MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Netzwerk- und DFÜ-Verbindungen' +chr(13)+chr(10)
              + '... öffnet das Fenster Netzwerk- und DFÜ-Verbindungen.';
end;

procedure TLCXPSettings.AutoSurfdauerChange(Sender: TObject);
var zeit_min, zeit_std: string;
begin
str(Autosurfdauer.Position mod 60, zeit_min);
str(Autosurfdauer.Position div 60, zeit_std);

label33.Caption:= zeit_std + ' h ' + zeit_min + ' min';
end;

procedure TLCXPSettings.AutoConnectOnStartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Auto-Verbinden bei Programmstart' +chr(13)+chr(10)
              +'Beim Programmstart wird ein einziger Einwahlversuch unternommen. Ist Wiedereinwahl aktiv, so wird solange gewählt, bis der Rechner tatsächlich online ist.';
end;

procedure TLCXPSettings.AutoReConnectMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Wiedereinwahl' +chr(13)+chr(10)
              +'Wird die Verbindung getrennt, so kann eine automatische Wiedereinwahl mit dem billigsten Tarif veranlasst werden. Dies wird versucht, bis der Rechner online ist oder durch drücken der ''stop''-Taste abgebrochen.';
end;

procedure TLCXPSettings.AutoConnectEinwahlMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= '... Einwahlgebühr berücksichtigen' +chr(13)+chr(10)
              + 'Nur wenn dieser Haken gesetzt ist, dann wird auch ein Tarif mit Einwahlgebühr gewählt, ansonsten wir gesucht bis ein Tarif ohne EWG gefunden ist.';
end;

procedure TLCXPSettings.Label30MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Basiszeit bei Auto-Einwahl' +chr(13)+chr(10)
              + 'Da der Computer automatisch entscheiden muss, welches der für ihn billgste Tarif ist, muss er die gewünschte Basiszeit selbst setzen. Dieser Wert wird hier angegeben.';
end;

procedure TLCXPSettings.GroupBox18MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'eMail-Benachrichtigung' +chr(13)+chr(10)
              + 'Sie können sich per email benachrichtigen lassen, wenn der Computer eine Verbindung herstellt. So haben Sie immer Zugriff auf Dienste des Computers wenn Sie unterwegs sind.'
              + ' Voraussetzung ist ein eingerichtetes eMail-Programm (welches unter Umständen eine Warnmeldung beim Versenden gibt > bitte deaktivieren).';
end;

procedure TLCXPSettings.ipmail_nameMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'eMail-Benachrichtigung : Name' +chr(13)+chr(10)
              +'Bitte tragen Sie Ihren Namen ein, wie er in der eMail erscheinen soll.'
              +#13#10
              +'Ist das Feld leer findet KEIN Versand statt.'
end;

procedure TLCXPSettings.ipmail_adressMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'eMail-Benachrichtigung : Adresse' +chr(13)+chr(10)
              +'Bitte tragen Sie Ihre eMail-Adresse hier ein.'
              +#13#10
              +'Eine Überprüfung der Adresse findet nicht statt. Für Spamming übernimmt der Autor keine Haftung.'
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
 if serverbox.itemindex = serverbox.Items.count -1 then exit//newplace:= 0
 else
 if serverbox.itemindex < serverbox.Items.count -1 then newplace:= serverbox.itemindex + 1;
 end
 else
if sender = left then
 begin
 if serverbox.itemindex = 0 then exit//newplace:= serverbox.Items.count -1
 else
 if serverbox.itemindex > 0 then newplace:= serverbox.itemindex - 1;
 end;


 serverbox.Items.Exchange(serverbox.itemindex, newplace);
 serverbox.ItemIndex:= newplace;

end;

procedure TLCXPSettings.leftMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if sender = left then
   memo1.Text:= 'Atomzeit-Server: Sortierung' +chr(13)+chr(10)
              +'... verschiebt den ausgewählten Server nach oben in der Prioritätenliste.'
else
if sender = right then
   memo1.Text:= 'Atomzeit-Server: Sortierung' +chr(13)+chr(10)
              +'... verschiebt den ausgewählten Server nach unten in der Prioritätenliste.';


end;

procedure TLCXPSettings.Button9Click(Sender: TObject);
begin
if directoryexists(ExtractFilePath(ParamStr(0)) + 'BackUp') then
  Shellexecute( 0, nil, Pchar(ExtractFilePath(ParamStr(0)) + 'BackUp'), nil, nil, SW_SHOW)
end;

procedure TLCXPSettings.noBalloonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.Text:= 'keine BalloonTips' +chr(13)+chr(10)
              +'BalloonTips sind diese kleinen gelben Fensterchen, die hin und wieder neben der Windows-Uhr erscheinen. Möchten Sie, dass der LeastCosterXP nicht auf diesem Wege mit Ihnen kommuniziert, so können Sie diese Hinweise hier ausschalten.'
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

procedure TLCXPSettings.setupmodemsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.Text:= 'benutze Einstellungen der DFÜ-Verbindung' +chr(13)+chr(10)
              +'Die Modem-Einstellungen der DFÜ-Verbindung blieben unangetastet. Nur in Ausnahmefällen nötig, wenn Kanalbündelung erwünscht ist und das zeite Modem einen identischen Namen hat. Die DFÜ-Verbindung LeastCosterXP MUSS dann korrekt eingerichtet sein.'
              + #13#10 + 'Empfehlung: daektiviert lassen, solange es keine Probleme gibt';
end;

procedure TLCXPSettings.MultilinkMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.Text:= 'Multilink' +chr(13)+chr(10)
              +'... auch Kanalbündelung genannt. Es kann ein zweites Modem angegeben werden um dieses zu realisieren. Nicht unter Windows 9x. Ist dieser Haken gesetzt, so wird die Verbindung beim nächsten Mal mit beidem Modems aufgebaut.'+#13#10
              +'Ist diese Option gesetzt ist das Zuschalten des 2. Kanales möglich.';
end;

procedure TLCXPSettings.opendaysMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
memo1.text:= 'alle xx Tage' +chr(13)+chr(10)+
              ' ... das Programm wird nur jeden x-ten Tag nach dem letzten Aufruf ausgeführt';
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
                   state.caption:= 'aktiviert';
                   activate.caption:= 'deaktivieren';
                   state.font.color:= clgreen;
                   activate.Tag:= 1;
              end
              else
              begin
                   state.caption:= 'deaktiviert';
                   activate.caption:= 'aktivieren';
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
     then showmessage('Sie müssen nun das Verzeichnis PlugIns\'+ plugbox.items.strings[i] + ' löschen !');
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

end.
