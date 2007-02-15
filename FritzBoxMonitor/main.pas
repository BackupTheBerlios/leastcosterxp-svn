unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  IpHlpApi,IpIfConst,IpRtrMib,ipFunctions,iptypes, ExtCtrls, StrUtils,
  scktcomp, CoolTrayIcon, ComCtrls, Buttons, inifiles, HttpProt, Menus;

type

  TTraffic = Record
      StartOfPeriod: TDateTime;
      TIn: Cardinal;
      TOut: Cardinal;
      todayU,thisweekU, thismonthU : Cardinal;
      todayD,thisweekD, thismonthD : Cardinal;
      DateofToday: TDateTime;
      Price: real;
  end;

  TPerson = Record
      Name     : string;
      Number   : string;
      short    : string;
      vanity   : string;
      No       : integer;
      important: boolean;
   end;

   TCaller = Record
      Typ             : string;
      Datum           : string;
      Name            : string;
      Rufnummer       : string;
      Nebenstelle     : string;
      EigeneRufnummer : string;
      Dauer           : string;
    end;

  TForm1 = class(TForm)
    Timer: TTimer;
    Tray: TCoolTrayIcon;
    Panel2: TPanel;
    Panel3: TPanel;
    BtnSave: TBitBtn;
    BtnCancel: TBitBtn;
    Page: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ULDLSelect: TComboBox;
    MoWeSelect: TComboBox;
    Limit: TEdit;
    RadioMB: TRadioButton;
    RadioGB: TRadioButton;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    PriceMB: TRadioButton;
    PriceGB: TRadioButton;
    Price: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Period: TComboBox;
    GroupBox4: TGroupBox;
    Device: TComboBox;
    FritzBox: TTabSheet;
    FBMon: TCheckBox;
    FBIP: TLabeledEdit;
    FBPort: TLabeledEdit;
    Label7: TLabel;
    Button1: TButton;
    Http: THttpCli;
    Button2: TButton;
    Memo1: TMemo;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    LimitLabel: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    CallerList: TListView;
    viewstats: TBitBtn;
    TabSheet4: TTabSheet;
    PhoneBookList: TListView;
    PopupMenu1: TPopupMenu;
    searchNumber: TMenuItem;
    PopupMenu2: TPopupMenu;
    Eintraglschen1: TMenuItem;
    ReloadPhonebook: TMenuItem;
    reloadCallerList: TMenuItem;
    procedure reloadCallerListClick(Sender: TObject);
    procedure ReloadPhonebookClick(Sender: TObject);
    procedure Eintraglschen1Click(Sender: TObject);
    procedure searchNumberClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure viewstatsClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure TrayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure GetDeviceList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DeviceCloseUp(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    Procedure SocketMessage(Sender: TObject; Socket: TCustomWinSocket);
    Procedure StartSocket;
    Procedure StopSocket;
    Procedure ParseCallList(s:TStream);
    procedure FillPhonebook;
  private
    { Private-Deklarationen }
    offsetIN, offsetOUT: cardinal;
    TIN, TOUT: cardinal;
    TData: TTraffic;
    sett: TMemInifile;
    Socket: TClientSocket;

  public
    { Public-Deklarationen }
  end;

var
  Form1    : TForm1;
  PhoneBook: array of TPerson;
  Caller   : array of TCaller;
  BoxAdress: string;
  
implementation
uses RegExpr, Unit2, statistics;


procedure TForm1.StartSocket;
begin
 Socket.Host:= sett.readstring('Fritzbox','IP','192.168.178.1');
 Socket.Port:= sett.ReadInteger('FritzBox','Port',1012);
 Socket.OnRead:= SocketMessage;
 Socket.Open;
end;

procedure TForm1.StopSocket;
begin
 Socket.Close;
end;

Procedure TForm1.SocketMessage(Sender: TObject; Socket: TCustomWinSocket);
var m: string;
    s: TStringlist;
    r: TRegExpr;
begin
 m:= Socket.ReceiveText;
//Zustandegekommene Verbindung: datum;CONNECT;ConnectionID;Nebenstelle;Nummer;
 r:= TRegExpr.Create;
 r.Expression:= ';';
if AnsiContainsStr(m,';RING;')  or AnsiContainsStr(m,';DISCONNECT;')then
 begin
  s:= TStringlist.Create;
  r.Split(m,s);
  CallIn.Date.Caption:=  s.Strings[0];
 //Eingehende Anrufe: datum;RING;ConnectionID;Anrufer-Nr;Angerufene-Nummer;
  if s.strings[1] = 'RING' then
    begin
      CallIn.CallType.caption:= 'Incoming Call';
      CallIn.info2.caption   := s.strings[3];
      CallIn.info3.caption   := s.strings[4];
      CallIn.info4.caption   := 'ID: ' + s.strings[2];
      CallIn.show;
    end
   else
//Ende der Verbindung: datum;DISCONNECT;ConnectionID;dauerInSekunden;
  if s.strings[1] = 'DISCONNECT' then CallIn.Hide
   else
//Ausgehende Anrufe: datum;CALL;ConnectionID;Nebenstelle;GenutzteNummer;AngerufeneNummer;
  if s.strings[1] = 'CALL' then
    begin
      CallIn.CallType.caption:= 'Outgoing Call';
      CallIn.info2.caption   := s.strings[5];
      CallIn.info3.caption   := s.strings[3]+'@'+s.strings[4];
      CallIn.info4.caption   := 'ID: ' + s.strings[2];
      CallIn.show;
    end;
  s.free;
 end;
 r.free;
end;

procedure GetSessionTraffic(var Tin, Tout:Cardinal);
var
  IfTable: PMIB_IFTABLE;
  dwSize: Cardinal;
  i: Integer;
  index: word;
begin
  IfTable := nil;
  dwSize := 0;
  ZeroMemory(@IfTable, sizeof(IfTable));
  try
    VVGetIfTable(IfTable, dwSize, TRUE);
    if IfTable <> nil then
    begin

     index:= form1.device.tag;                     //dwIndex muss vorher festgelegt werden und mit index verglichen werden
     for i := 0 to IfTable.dwNumEntries - 1 do
      begin
           if IfTable.table[i].dwType <> MIB_IF_TYPE_LOOPBACK then
            if iftable.table[i].dwIndex = index then
            begin
              TIn := IfTable.table[i].dwInOctets;
              TOut:= IfTable.table[i].dwOutOctets
            end;
      end;
    end;
  finally
    Freemem(IfTable);
  end;
end;

{$R *.dfm}
procedure TForm1.GetDeviceList;
var PAdapter, PMem: PipAdapterInfo;
    OutBufLen: ULONG;
begin
Device.clear;
  VVGetAdaptersInfo(PAdapter, OutBufLen);
  PMem := PAdapter;
  try
    while PAdapter <> nil do
      with Device do
      begin
        Device.Items.Append(PAdapter.Description + ' ['+ inttostr(PAdapter.Index)+']');
        PAdapter := PAdapter.Next;
      end;
    except
   end;
end;

procedure TForm1.DeviceCloseUp(Sender: TObject);
var s: string;
begin
    s:= Device.Items.Strings[Device.itemindex];
    Delete(s,1,Pos(' [',s)+1);
    Delete(s,Pos(']',s),1);

    Device.Tag:= strToInt(s);
end;

procedure TForm1.FormCreate(Sender: TObject);
var f: TFileStream;
    i: integer;
    Deviceindex: integer;
begin
  form1.ClientHeight:= 290;

  sett:= TMemIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.cfg');

  GetDeviceList;
    DeviceIndex:= Sett.ReadInteger('Traffic','Device',0);

    for i:= 0 to device.Items.Count-1 do
       if AnsiContainsStr(Device.Items.Strings[i],' ['+ inttostr(DeviceIndex)+']')
         then Device.itemindex:= i; //letztes Device einstellen

 BtnCancelClick(Self);
 Application.ShowMainForm:= false; //Mainform nicht anzeigen

 Device.OnCloseUp(self); //Device setzen



 if fileexists(ExtractFilePath(ParamStr(0)) + 'traffic.dat') then
    begin
     f:= TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'traffic.dat',fmOpenRead);
      f.Read(TData, sizeof(TData));
     f.Free;
    end
   else
   begin
    TData.tin          := 0;
    TData.tout         := 0;
    TData.todayD       := 0;
    TData.thisweekD    := 0;
    TData.thismonthD   := 0;
    TData.todayU       := 0;
    TData.thisweekU    := 0;
    TData.thismonthU   := 0;
    TData.DateofToday  := now;
    TData.StartofPeriod:= now;
    TData.Price        := 0.0;
   end;

 TIn      := 0;
 TOut     := 0;
 OffSetIN := 0;                             //Offset bestimmen
 OffSetOUT:= 0;
 GetSessionTraffic(OffsetIN,OffsetOUT);

 edit1.Text:= '0';
 edit2.Text:= '0';
 edit3.Text:= inttostr(TData.TIn);
 edit4.Text:= inttostr(TData.TOut);

 Socket:= TClientSocket.Create(self);
 if sett.ReadBool('FritzBox','useMonitor',false) then //Fritz!Box Listener starten
   StartSocket;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var f: TFileStream;
begin
  f:= TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'traffic.dat',fmCreate);
   TData.TIn          :=  TData.TIn  + TIn-OffsetIN;  //Summe abspeichern
   TData.TOut         :=  TData.TOut + TOut-OffsetOUT;
  f.Write(TData, sizeof(TData));
  f.Free;

  sett.Free;

  Socket.Free;
end;

procedure TForm1.TimerTimer(Sender: TObject);
var inCurrent, outCurrent: cardinal;
    lastReset            : TDateTime;
    ULDL, VUnit, PUnit   : byte;
    limitreached         : boolean;
    limit                : cardinal;
    diff                 : Extended;
    AllIn, AllOut        : Real;
    PricePerUnit         : Real;
begin

  limitreached:= false;
  GetSessionTraffic(TIn,Tout);

  inCurrent   :=  TIn-OffsetIN;
  outCurrent  := TOut-OffsetOUT;

  edit1.text  := Format('%.2f MB', [inCurrent / 1024 / 1024]);
  edit2.text  := Format('%.2f MB', [outCurrent / 1024 / 1024]);

  allIn       :=  (TData.TIn + inCurrent) / 1024 / 1024; //in MB
  allOut      := (TData.TOut+ outCurrent) / 1024 / 1024;

  edit3.text  := Format('%.2f MB', [allIn]);
  edit4.text  := Format('%.2f MB', [allOut]);

  if (allIn=0.0) and (allOut=0.0) then exit;

  uldl        := sett.ReadInteger('Traffic','VolumeMode',0); //0: both, 1: DL, 2: UL
  VUnit       := sett.ReadInteger('Traffic','VolumeUnit',0); //0: MB, 1GB
  PUnit       := sett.ReadInteger('Traffic','PriceUnit',0); //0: MB, 1GB
  limit       := sett.ReadInteger('Traffic','VolumeLimit',0); //in der Einheit VUnit
  PricePerUnit:= sett.ReadFloat('Traffic','Price',0.0);

  if vUnit = 1 then  //in Gigabyte umrechnen
  begin
   allIn  := allIn / 1024;
   allOut := allOut/ 1024;
  end;
  diff:= 0;
  case uldl of
  0: if limit <= allIn + allOut then
      begin limitreached:= true; diff:= allIn  + allOut - limit; end;
  1: if limit <= allIn then
      begin limitreached:= true; diff:= allIn  - limit; end;
  2: if limit <= allOut then
      begin limitreached:= true; diff:= allOut - limit; end;
  end;

  if limitreached then
  begin
    case PUnit of
    0: //MB
      if VUnit = 0 then //diff ist in MB
        TData.Price:= TData.Price + (diff * PricePerUnit)
      else              //diff ist in GB
        TData.Price:= TData.Price + (diff * 1024 * PricePerUnit);
    1: //GB
      if VUnit = 0 then //diff ist in MB
        TData.Price:= TData.Price + (diff /1024 * PricePerUnit)
      else              //diff ist in GB
        TData.Price:= TData.Price + (diff * PricePerUnit);
    end;
    limitlabel.Caption:= 'Your limit ist reached !' + inttostr(limit) + ' ' + floattostr(allin + allOut)
  end
  else
    limitlabel.caption:= '';

end;

procedure TForm1.TrayMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Tray.ShowMainForm;
end;

procedure TForm1.Panel2Click(Sender: TObject);
begin
 if panel2.tag=0 then
  begin
   form1.ClientHeight:= form1.clientheight + panel3.height;
   panel3.Visible:= true;
   panel2.Tag:= 1;
   panel2.BevelOuter:= bvlowered;
   panel2.caption:= '> Close the settings panel here <';
  end
  else
  begin
   form1.ClientHeight:= form1.clientheight - panel3.height;
   panel3.Visible:= false;
   panel2.Tag:= 0;
   panel2.BevelOuter:= bvraised;
   panel2.caption:= '> Open the settings panel here <';
  end
end;

procedure TForm1.BtnSaveClick(Sender: TObject);
var Vunit, Punit: byte;
begin

 
 if RadioMB.Checked then VUnit:= 0 else VUnit:= 1;
 if PriceMB.Checked then PUnit := 0 else PUnit:= 1;

 sett.WriteInteger('Traffic','Device',Device.tag);
 sett.WriteInteger('Traffic','VolumeMode',ULDLSelect.ItemIndex);
 sett.WriteInteger('Traffic','VolumeLimit',strtoint(limit.text));
 sett.WriteInteger('Traffic','VolumeUnit',VUnit);
 sett.WriteInteger('Traffic','PeriodStart',Period.ItemIndex);
 sett.WriteInteger('Traffic','PeriodUnit',MoWeSelect.ItemIndex);
 sett.WriteFloat('Traffic','Price',StrToFloat(price.text));
 sett.WriteInteger('Traffic','PriceUnit',PUnit);

 sett.WriteBool('FritzBox','useMonitor',FBMon.Checked);
 sett.writestring('Fritzbox','IP',FBIP.Text);
 sett.WriteInteger('FritzBox','Port',strtoint(FBPort.text));
 BoxAdress:= sett.ReadString('FritzBox','IP','192.168.178.1');
 sett.UpdateFile;

 //FritzBox Listener starten
 if FBMon.Checked and not socket.Active then begin stopSocket; StartSocket; end
 else //oder beenden falls er noch läuft
 if not FBMOn.Checked and socket.Active then StopSocket;
end;

procedure TForm1.BtnCancelClick(Sender: TObject);
begin
 Device.tag          := sett.ReadInteger('Traffic','Device',0);
 Device.ItemIndex    := Device.Tag;

 ULDLSelect.ItemIndex:= sett.ReadInteger('Traffic','VolumeMode',0);
 limit.text          := sett.ReadString('Traffic','VolumeLimit','');

 MoWeSelect.ItemIndex:= sett.ReadInteger('Traffic','PeriodUnit',2);
 Period.ItemIndex    := sett.ReadInteger('Traffic','PeriodStart',0);
 price.text          := FloattoStr(sett.ReadFloat('Traffic','Price',0.0));

 FBMon.Checked       := sett.ReadBool('FritzBox','useMonitor', false);
 FBIP.Text           := sett.readstring('Fritzbox','IP','192.168.178.1');
 FBPort.text         := sett.ReadString('FritzBox','Port','1012');

 RadioMB.Checked     := (sett.ReadInteger('Traffic','VolumeUnit',1) = 0);
 RadioGB.Checked     := (sett.ReadInteger('Traffic','VolumeUnit',1) = 1);

 PriceMB.Checked     := (sett.ReadInteger('Traffic','PriceUnit',1) = 0);
 PriceGB.Checked     := (sett.ReadInteger('Traffic','PriceUnit',1) = 1);

 BoxAdress:= sett.ReadString('FritzBox','IP','192.168.178.1'); 
end;

procedure TForm1.ParseCallList(s:TStream);
var f: TFileStream;
    data: string;
    r: TRegExpr;
    SL, CL: TStringList;
    i: integer;
    len: integer;
    sep: string;
    liItem: TListItem;
    liste : TListitems;
begin
 Callerlist.Clear;
 SL:= TSTringlist.Create;
 CL:= TSTringlist.Create;

 Liste := Tlistitems.Create(CallerList);
// Callerlist.Items.Clear;

 s.Position:= 0;
 Data:= (s as TstringStream).ReadString(s.size);
 r:= TRegExpr.Create;
 r.Expression:= #10;
 r.Split(Data,SL);

 if sl.Count > 2 then
 begin
   r.Expression:= 'sep=(.*)';
   sep:= r.Replace(sl.strings[0],'$1',true);
   r.Expression:= sep;

   for i:= 2 to sl.count -1 do
   begin
    cl.Clear;
    r.Split(sl.strings[i],cl);
    if cl.Count = 7 then
    begin
      liItem := liste.Add;
      liItem.Caption := cl.strings[0];
      cl.Delete(0);
      liItem.SubItems:=cl;
     end;
   end;
 end;

SL.Free;
CL.Free;

s.Position:= 0;
f:= TFileStream.Create('anrufliste.csv',fmcreate);
f.CopyFrom(s,s.Size);
f.free;

end;

function ParsePhoneBook(s:TStream): integer;
var f: TFileStream;
    data: string;
    r: TRegExpr;
    SL: TStringList;
    i: integer;
    len: integer;
begin

 s.Position:= 0;

 SL:= TSTringlist.Create;

 Data:= (s as TstringStream).ReadString(s.size);
 r:= TRegExpr.Create;
 r.Expression:= #10;
 r.Split(Data,SL);

 r.Expression:= '.*TrFon\(\"(.*)\", \"(.*)\", \"(.*)\", \"(.*)\"\).*';
 setlength(Phonebook, 0);
 for i:=0 to SL.Count-1 do
  if r.Exec(SL.strings[i]) then
  begin
    setlength(Phonebook, length(Phonebook)+1);
    len:= Length(phonebook) -1;
    Phonebook[len].Name  := r.Replace(SL.strings[i],'$1',true);
    Phonebook[len].Number:= r.Replace(SL.strings[i],'$2',true);
    Phonebook[len].short := r.Replace(SL.strings[i],'$3',true);
    Phonebook[len].vanity:= r.Replace(SL.strings[i],'$4',true);
  end;
// abspeichern
// s.Position:= 0;
// f:= TFileStream.Create('phonebook',fmcreate);
//  f.CopyFrom(s,s.Size);
// f.free;
 r.Free;
 SL.Free;

// showmessage(inttostr(length(phonebook)));
end;


procedure TForm1.Button1Click(Sender: TObject);
var stream: TMemoryStream;
    s: string;
begin
 http.URL:= 'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/FRITZ!Box_Anrufliste.csv';
 http.RcvdStream:= TStringStream.Create('');
 http.get;
 ParseCallList(http.RcvdStream);
 http.RcvdStream.free;
 http.RcvdStream:= nil;

 http.URL:= 'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/fon/ppFonbuch.html&var:lang=de';
 http.RcvdStream:= TStringStream.Create('');
 http.get;
 ParsePhonebook(http.RcvdStream);
 http.RcvdStream.free;
 http.RcvdStream:= nil;
end;

Procedure AddEntry(Entry: TPerson);
var Data : String;
    EName: string;  
begin
 if entry.important then EName:= '!'+Entry.Name;
 Data := 'telcfg:settings/HotDialEntry'+inttostr(Entry.No)+'/Code='+ inttostr(Entry.No) + '&' +
         'telcfg:settings/HotDialEntry'+inttostr(Entry.No)+'/Vanity=' + '&' +
         'telcfg:settings/HotDialEntry'+inttostr(Entry.No)+'/Number='+Entry.Number + '&' +
         'telcfg:settings/HotDialEntry'+inttostr(Entry.No)+'/Name='+ EName + '&' +
         'Submit=Submit';
 Form1.Http.SendStream := TMemoryStream.Create;
 Form1.Http.SendStream.Write(Data[1], Length(Data));
 Form1.Http.SendStream.Seek(0, 0);
 Form1.Http.RcvdStream := TMemoryStream.Create;
 Form1.Http.URL := 'http://'+BoxAdress+'/cgi-bin/webcm';
 Form1.Http.PostAsync;
end;

Procedure DeleteEntry(Entry: TPerson);
var
    Data : String;
begin

    Data:= 'telcfg:command/HotDialEntry'+inttostr(Entry.No)+'=delete'+'&' +
           'Submit=Submit';
//    showmessage(Data);
    Form1.Http.SendStream := TMemoryStream.Create;
    Form1.Http.SendStream.Write(Data[1], Length(Data));
    Form1.Http.SendStream.Seek(0, 0);
    Form1.Http.RcvdStream := TMemoryStream.Create;
    Form1.Http.URL := 'http://'+BoxAdress+'/cgi-bin/webcm';
    Form1.Http.PostAsync;
end;


procedure TForm1.viewstatsClick(Sender: TObject);
begin
stats.show;
end;

procedure TForm1.FillPhonebook;
var data: string;
    r: TRegExpr;
    SL, CL: TStringList;
    i: integer;
    len: integer;
    sep: string;
    liItem: TListItem;
    liste : TListitems;
begin

 PhoneBookList.Clear;

 SL:= TSTringlist.Create;
 CL:= TSTringlist.Create;

 Liste := Tlistitems.Create(PhonebookList);
 cl    := TStringlist.Create;

   for i:= 0 to length(Phonebook) -1 do
   begin

      cl.Clear;
//      cl.Add(Phonebook[i].Name);
      cl.Add(Phonebook[i].Number);
      cl.Add(Phonebook[i].Short);
      cl.Add(Phonebook[i].vanity);

      liItem := liste.Add;
      liItem.SubItems:=cl;
      liItem.Caption := Phonebook[i].Name;

   end;


end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 http.URL:= 'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/fon/ppFonbuch.html&var:lang=de';
 http.RcvdStream:= TStringStream.Create('');
 http.get;
 ParsePhonebook(http.RcvdStream);
 FillPhoneBook;
 http.RcvdStream.free;
 http.RcvdStream:= nil;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
case PageControl1.ActivePageIndex of
0:  begin
     Callerlist.PopupMenu:= nil;
     PhoneBookList.PopupMenu:= nil;
    end;
1:  if callerlist.tag = 0 then
    begin
     Callerlist.PopupMenu:= PopupMenu1;
     PhoneBookList.PopupMenu:= nil;
//  Laden der liste von der FritzBox
//   reloadCallerList.Click;
    end;
2:  if length(phonebook) = 0 then
    begin
      Callerlist.PopupMenu:= nil;
      PhoneBookList.PopupMenu:= PopupMenu2;
//   Laden des Telefonbuches von der FritzBox
//    ReloadPhonebook.Click;
    end;
end;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var number: string;
begin
 if callerlist.ItemIndex > -1 then
 begin
    number:=Callerlist.Items[Callerlist.itemindex].SubItems.strings[2];
    if length(number) <= 8 then number := '030' + number;
    searchnumber.caption:= 'reverse lookup: ' + number;
 end;
 searchNumber.visible:= (callerlist.ItemIndex > -1)
end;

procedure TForm1.searchNumberClick(Sender: TObject);
var s,s2: string;
    r: TRegExpr;
    number: string;
begin
//http://www1.dasoertliche.de/?form_name=search_inv&ph=%Number%

 number:=Callerlist.Items[Callerlist.itemindex].SubItems.strings[2];
 if length(number) <= 8 then number := '030' + number;

 r:= TRegExpr.create;
 http.URL:= 'http://www1.dasoertliche.de/?form_name=search_inv&ph='+number;
 http.RcvdStream:= TStringStream.Create('');
 http.get;
 s:= '';
 http.RcvdStream.Position:=0;
 s:= (http.RcvdStream as TStringStream).ReadString(http.RcvdStream.size);
 s2:= s;
 r.Expression:= '.*title=\"Details zu diesem Eintrag anzeigen\" class=\"entry\">([\w\s]*)</a>.*';
 if r.Exec(s) then
 begin
   s:= r.Replace(s,'$1',true);
   memo1.Lines.Add(s);
 end;
// r.Expression:= '<\/div>([\w\s]*)<br>.*<input name=\"notepadItemsHitList\"';
 r.Expression:= '.*div>([\w\s]*)<br>.*';
 if r.Exec(s2) then
 begin
   s2:= r.Replace(s2,'$1',true);
   memo1.Lines.Add(s2);
 end;

 http.RcvdStream.free;
 http.RcvdStream:= nil;
 r.free;
end;

procedure TForm1.Eintraglschen1Click(Sender: TObject);
begin

 if PhoneBookList.ItemIndex > -1 then
  begin
   PhoneBook[PhoneBookList.ItemIndex].No:= PhoneBookList.ItemIndex;
   DeleteEntry(PhoneBook[PhoneBookList.ItemIndex]);
  end;

end;

procedure TForm1.ReloadPhonebookClick(Sender: TObject);
begin
  http.URL:= 'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/fon/ppFonbuch.html&var:lang=de';
  http.RcvdStream:= TStringStream.Create('');
  http.get;
  ParsePhonebook(http.RcvdStream);
  FillPhoneBook;
  http.RcvdStream.free;
  http.RcvdStream:= nil;
end;

procedure TForm1.reloadCallerListClick(Sender: TObject);
var Data: string;
begin
     Http.RcvdStream := TMemoryStream.Create;
     http.URL:=  'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/menus/menu2.html&var:lang=de&var:menu=fon&var:pagename=foncalls';
     Http.Get;

     sleep(500);
     http.RcvdStream:= nil;

     http.URL:= 'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/FRITZ!Box_Anrufliste.csv';
     http.RcvdStream:= TStringStream.Create('');
     http.get;
     ParseCallList(http.RcvdStream);
     http.RcvdStream.free;
     http.RcvdStream:= nil;
     callerlist.Tag:= 1;
end;

end.
