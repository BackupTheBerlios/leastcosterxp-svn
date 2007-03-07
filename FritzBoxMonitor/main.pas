unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  IpHlpApi,IpIfConst,IpRtrMib,ipFunctions,iptypes, ExtCtrls, StrUtils,
  scktcomp, CoolTrayIcon, ComCtrls, Buttons, inifiles, HttpProt, Menus, ImgList,
  ToolWin, Gauges;

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
    PopupMenu1: TPopupMenu;
    searchNumber: TMenuItem;
    PopupMenu2: TPopupMenu;
    Eintraglschen1: TMenuItem;
    ReloadPhonebook: TMenuItem;
    reloadCallerList: TMenuItem;
    PageControl1: TPageControl;
    Tab1: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    LimitLabel: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    viewstats: TBitBtn;
    Tab2: TTabSheet;
    CallerList: TListView;
    Tab3: TTabSheet;
    PhoneBookList: TListView;
    PBName: TEdit;
    PBNumber: TEdit;
    PBadd: TButton;
    PBimportant: TCheckBox;
    PBVanity: TEdit;
    PBClear: TButton;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList2: TImageList;
    ToolButton2: TToolButton;
    Status: TStatusBar;
    error: TLabel;
    PBShort: TComboBox;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    EdtPrice: TEdit;
    Image1: TImage;
    Gauge1: TGauge;
    Label1: TLabel;
    reset: TButton;
    Website: TLabel;
    ToolButton9: TToolButton;
    procedure ToolButton9Click(Sender: TObject);
    procedure WebsiteClick(Sender: TObject);
    procedure WebsiteMouseLeave(Sender: TObject);
    procedure WebsiteMouseEnter(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure PBClearClick(Sender: TObject);
    procedure PhoneBookListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PBaddClick(Sender: TObject);
    procedure reloadCallerListClick(Sender: TObject);
    Procedure LoadPhonebookFromFile;
    Procedure LoadCallersFromFile(filter: integer);
    procedure ReloadPhonebookClick(Sender: TObject);
    procedure Eintraglschen1Click(Sender: TObject);
    procedure ReverseNumberLookup;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure viewstatsClick(Sender: TObject);
    procedure TrayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

    procedure TimerTimer(Sender: TObject);
    Procedure SocketMessage(Sender: TObject; Socket: TCustomWinSocket);
    Procedure DocData(sender: TObject; Buffer: Pointer; len: integer);
    Procedure ParseCallList(s:TStream; filterindex: integer);
    procedure FillPhonebook;
    procedure PBShortFill;
    Procedure StartMySocket;
    Procedure StopMySocket;
    function  AskForUpdate: boolean;
    Procedure UpdatePhonebook;
  private
    { Private-Deklarationen }
    PBselected: integer;
    ConnectionID: string;
    unsaved_Phonebook: boolean;
  public
    { Public-Deklarationen }
  end;

var
  Form1              : TForm1;
  sett               : TMemInifile;
  Socket             : TClientSocket;
  PhoneBook          : array of TPerson;
  PhoneBook_new      : array of TPerson;
  Caller             : array of TCaller;
  BoxAdress          : string;
  Phonebookliste     : TListitems;
  CallerListe        : TListitems;
  NetworkDevice      : integer;
  TData              : TTraffic;
  offsetIN, offsetOUT: cardinal;
  TIN, TOUT          : cardinal;
  LastIN, LastOUT    : cardinal;

implementation
uses RegExpr, Unit2, statistics, settings, DateUtils, shellapi;

{$R arrows.res}

procedure TForm1.StartMySocket;
begin
 Socket.Host:= sett.readstring('Fritzbox','IP','192.168.178.1');
 Socket.Port:= sett.ReadInteger('FritzBox','Port',1012);
 Socket.OnRead:= SocketMessage;
 Socket.Open;
end;

procedure TForm1.StopMySocket;
begin
 Socket.Close;
end;

function findnames(number: string): string;
var i: integer;
begin
 Result:= number;
 for i:= 0 to length(PhoneBook)-1 do
  if PhoneBook[i].number = number then
  begin
    Result:= Phonebook[i].name;
    if Result[1] = '!' then delete(Result,1,1);
    break;
  end;
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
if AnsiContainsStr(m,';RING;')  or AnsiContainsStr(m,';DISCONNECT;') or AnsiContainsStr(m,';CALL;')then
 begin
  s:= TStringlist.Create;
  r.Split(m,s);
  CallIn.Date.Caption:=  s.Strings[0];
 //Eingehende Anrufe: datum;RING;ConnectionID;Anrufer-Nr;Angerufene-Nummer;
  if s.strings[1] = 'RING' then
    begin
      CallIn.CallType.caption:= 'Incoming Call';

      CallIn.info2.caption   := FindNames(s.strings[3]);
      CallIn.Call:= s.strings[3];
      CallIn.info3.caption   := s.strings[4];
      CallIn.info4.caption   := 'ID: ' + s.strings[2];
      ConnectionID           := s.strings[2];
      CallIn.show;
    end
   else
//Ausgehende Anrufe: datum;CALL;ConnectionID;Nebenstelle;GenutzteNummer;AngerufeneNummer;
  if ( sett.ReadBool('FritzBox','monout',true) and (s.strings[1] = 'CALL')) then
    begin
      CallIn.CallType.caption:= 'Outgoing Call';
      CallIn.info2.caption   := FindNames(s.strings[5]);
      CallIn.Call            := s.strings[5];
      CallIn.info3.caption   := s.strings[3]+'@'+s.strings[4];
      CallIn.info4.caption   := 'ID: ' + s.strings[2];
      ConnectionID           := s.strings[2];
      CallIn.show;
    end
   else
//Ende der Verbindung: datum;DISCONNECT;ConnectionID;dauerInSekunden;
  if (s.strings[1] = 'DISCONNECT') and (s.strings[2] = ConnectionID) then CallIn.Hide;

  s.free;
 end;
 r.free;
end;

Procedure TForm1.DocData(sender: TObject; Buffer: Pointer; len: integer);
begin
 with sender as THttpCli do
  status.simpletext:= inttostr(RcvdCount) + ' bytes received.';
end;

procedure httpget(URL: string; var str: TStringStream);
var Http: THttpCli;
begin
  if BoxAdress = '' then exit;

  Http := THttpCli.Create(nil);
  http.OnDocData := Form1.DocData;
  with Http do
  begin
    Name := 'Http';
//    LocalAddr := BoxAdress;
    ProxyPort := '80';
    Agent := 'Mozilla/4.0 (compatible; ICS)';
    Accept := 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*';
    NoCache := true;
    ContentTypePost := 'application/x-www-form-urlencoded';
    MultiThreaded := False;
    RequestVer := '1.0';
    FollowRelocation := True;
    LocationChangeMaxCount := 5;
    BandwidthLimit := 10000;
    BandwidthSampling := 1000;
    Options := [];
//    SocksAuthentication := socksNoAuthentication;
  end;

  http.URL:= URL;
  http.RcvdStream:= TStringStream.Create('');
  http.get;

  http.RcvdStream.Position:= 0;
  str.CopyFrom(http.RcvdStream,http.RcvdStream.size);

  http.RcvdStream.free;
  http.RcvdStream:= nil;

  http.Free;
end;

procedure httppost(URL,Data: string);
var Http: THttpCli;
begin
  Http := THttpCli.Create(nil);
  http.OnDocData := Form1.DocData;
  with Http do
  begin
    Name := 'Http';
    LocalAddr := BoxAdress;
    ProxyPort := '80';
    Agent := 'Mozilla/4.0 (compatible; ICS)';
    Accept := 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*';
    NoCache := true;
    ContentTypePost := 'application/x-www-form-urlencoded';
    MultiThreaded := False;
    RequestVer := '1.0';
    FollowRelocation := True;
    LocationChangeMaxCount := 5;
    BandwidthLimit := 10000;
    BandwidthSampling := 1000;
    Options := [];
//    SocksAuthentication := socksNoAuthentication;
  end;

  Http.SendStream := TMemoryStream.Create;
  Http.SendStream.Write(Data[1], Length(Data));
  Http.SendStream.Seek(0, 0);
  Http.RcvdStream := TMemoryStream.Create;
  Http.URL := URL;
  Http.Post;

  http.RcvdStream.Free;
  http.RcvdStream:= nil;
  http.Free;
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

     index:= Networkdevice; //form3.device.tag;                     //dwIndex muss vorher festgelegt werden und mit index verglichen werden
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


procedure TForm1.FormCreate(Sender: TObject);
var f: TFileStream;
begin
//  form1.ClientHeight:= 290;
  unsaved_phonebook:= false;
  PBSelected:= -1;
  PhonebookListe := Tlistitems.Create(PhonebookList);
  CallerListe := Tlistitems.Create(CallerList);

  sett:= TMemIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.cfg');

  NetWorkDevice:= Sett.ReadInteger('Traffic','Device',0);
  BoxAdress    := sett.ReadString('FritzBox','IP','192.168.178.1');

  Application.ShowMainForm:= not sett.Readbool('program','minimized',false); //Mainform nicht anzeigen

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
    sett.writeDate('Traffic','DateofReset', dateof(now));
    sett.writeinteger('Traffic','lastReset',monthof(now));
    Status.Simpletext  := 'Click on the hammer icon to open the settings window.';  
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
   StartMySocket;

 LoadCallersFromFile(0);  
 LoadPhonebookFromFile;

 PageControl1.ActivePageIndex:= 0;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var f: TFileStream;
begin

  if unsaved_phonebook then AskforUpdate;

  f:= TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'traffic.dat',fmCreate);
  TData.TIn :=  TData.TIn  + TIn-OffsetIN;  //Summe abspeichern
  TData.TOut:=  TData.TOut + TOut-OffsetOUT;
  f.Write(TData, sizeof(TData));
  f.Free;

  sett.Free;
  Phonebookliste.Free;
  Callerliste.Free;
  Socket.Free;
end;

procedure MakeArrowsBlink(diffIn, DiffOut: longint; threshold: integer);
begin
with form1 do
  if (diffIN > threshold) and (diffOut > threshold)
    then tray.IconIndex:= 3
  else
  if (diffIN < threshold) and (diffOut > threshold)
    then tray.IconIndex:= 2
  else
  if (diffIN > threshold) and (diffOut < threshold)
    then tray.IconIndex:= 1
  else
  if (diffIN < threshold) and (diffOut < threshold)
    then tray.IconIndex:= 0;
end;

Procedure DoReset;
var f: textfile;
begin
   form1.Status.Simpletext:= 'Resetting statistics ... ';

   assignfile(f,'log.tsv');
   if fileexists('log.tsv')
     then append(f)
     else
     begin
         rewrite(f);
        writeln(f, 'date' +#9+ 'kB in' +#9+ 'kb out' +#9+ 'price');
     end;

   TData.TIn :=  TData.TIn  + TIn-OffsetIN;  //Summe abspeichern
   TData.TOut:=  TData.TOut + TOut-OffsetOUT;
   writeln(f, DateTostr(now) + #9 + Format('%.2f',[TData.TIn/1024]) + #9 + Format('%.2f',[TData.TOut/1024]) +#9 +Format('%.4f',[TData.Price]));
   closefile(f);

   TData.TIn  := 0;
   TData.TOut := 0;
   TData.Price:= 0;
   TIn        := 0;
   TOut       := 0;

   sett.writeinteger('Traffic','lastReset',monthof(now));
   sett.writeDate('Traffic','DateofReset', dateof(now));
   sett.UpdateFile;
   form1.Status.Simpletext:= 'log file log.tsv updated.'
end;

procedure ResetData;
begin
  if ( (dayof(now) >  sett.ReadInteger('Traffic','PeriodStart',1))
     and
       (monthof(now) > sett.Readinteger('Traffic','lastReset',0))
     )
     then DoReset;
end;

function DaysLeft(start: integer): integer;
var next: TDate;
begin
 if dayof(now) < start then
   next:= EncodeDate(yearof(now),monthof(now),start)
 else
   next:= EncodeDate(yearof(now),monthof(incmonth(now,1)),start);

 Result:= daysbetween(now, next);
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
    PStart               : integer;
begin
  limitreached:= false;
  GetSessionTraffic(TIn,Tout);

  inCurrent   := TIn-OffsetIN;
  outCurrent  := TOut-OffsetOUT;

  MakeArrowsBlink(inCurrent-LastIN, outCurrent-LastOut, 25);

  tray.hint:= 'SimpleTrayMonitor' +#13#10 +
              Format('in: %.2f kb/s',[(inCurrent-LastIn)/1024])  + #13#10+
              Format('out: %.2f kb/s',[(OutCurrent-LastOut)/1024]);

  LastIN:= inCurrent;
  LastOut:= OutCurrent;

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

  if (not limitreached) and (limit > 0) then
    Gauge1.Progress:= round((AllIn + Allout)*100/limit)
  else
  if (limitreached) and (limit > 0) then
    Gauge1.Progress:= round((AllIn + Allout)*100/limit)
  else
  if limit=0 then Gauge1.Progress:= 0;

    PStart:= sett.ReadInteger('Traffic','PeriodStart',1) +1;
    label1.caption:= 'Days left : ' + inttostr(Daysleft(PStart));

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
    if limit > 0 then limitlabel.Caption:= 'Your limit ist reached !';
  end
  else
    limitlabel.caption:= '';

   edtprice.text:= Format('%.4m',[TData.Price]);

   ResetData;
end;

procedure TForm1.TrayMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Tray.ShowMainForm;
end;

procedure TForm1.ParseCallList(s:TStream; filterindex: integer);
var data: string;
    r: TRegExpr;
    SL, CL: TStringList;
    i: integer;
    sep: string;
    liItem: TListItem;
begin
 Callerliste.Clear;
 SL:= TSTringlist.Create;
 CL:= TSTringlist.Create;

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
     if ((filterindex= 0) or (filterindex>4) or (strtoint(cl.strings[0])+1 = filterindex)) then //filtern
     begin
      liItem := CallerListe.Add;
      liItem.Caption := '';
      liitem.ImageIndex:= strtoint(cl.strings[0])+1;
      cl.Delete(0);
      cl.Append(inttostr(liitem.ImageIndex));
      liItem.SubItems:=cl;
      end;
   end;
 end;

SL.Free;
CL.Free;
end;

function ParsePhoneBook(s:TStream): integer;
var data: string;
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
    Phonebook[len].Name   := r.Replace(SL.strings[i],'$1',true);
    Phonebook[len].Number := r.Replace(SL.strings[i],'$2',true);
    Phonebook[len].short  := r.Replace(SL.strings[i],'$3',true);
    Phonebook[len].vanity := r.Replace(SL.strings[i],'$4',true);
    Phonebook[len].No     := len;

    Phonebook[len].Name   := AnsireplaceStr(Phonebook[len].Name, '&auml;','ä');
    Phonebook[len].Name   := AnsireplaceStr(Phonebook[len].Name, '&ouml;','ö');
    Phonebook[len].Name   := AnsireplaceStr(Phonebook[len].Name, '&uuml;','ü');
    Phonebook[len].Name   := AnsireplaceStr(Phonebook[len].Name, '&Auml;','Ä');
    Phonebook[len].Name   := AnsireplaceStr(Phonebook[len].Name, '&Ouml;','Ö');
    Phonebook[len].Name   := AnsireplaceStr(Phonebook[len].Name, '&Uuml;','Ü');
    Phonebook[len].Name   := AnsireplaceStr(Phonebook[len].Name, '&szlig;','ß');
  end;
 r.Free;
 SL.Free;
end;

procedure TForm1.viewstatsClick(Sender: TObject);
begin
 stats.show;
end;

procedure TForm1.FillPhonebook;
var CL: TStringList;
    i: integer;
    liItem: TListItem;
begin
 PhoneBookListe.Clear;
 cl:= TStringlist.Create;

   for i:= 0 to length(Phonebook) -1 do
   begin
      cl.Clear;

      cl.Add(Phonebook[i].Number);
      cl.Add(Phonebook[i].Short);
      cl.Add(Phonebook[i].vanity);
      cl.Add(inttostr(Phonebook[i].no));

      liItem := Phonebookliste.Add;
      liItem.SubItems:=cl;
      liItem.Caption := Phonebook[i].Name;
   end;

 cl.Free;
 PBShortFill;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
case PageControl1.ActivePageIndex of
0:  begin
     Callerlist.PopupMenu:= nil;
     PhoneBookList.PopupMenu:= nil;
    end;
1:  begin
     Callerlist.PopupMenu:= PopupMenu1;
     PhoneBookList.PopupMenu:= nil;
    end;
2:  begin
      Callerlist.PopupMenu:= nil;
      PhoneBookList.PopupMenu:= PopupMenu2;
      PbClear.click;
    end;
 end;
ToolButton1.Visible:=  (PageControl1.ActivePageIndex = 1);
ToolButton3.Visible:=  (PageControl1.ActivePageIndex = 1);
ToolButton4.Visible:=  (PageControl1.ActivePageIndex = 1);
ToolButton5.Visible:=  (PageControl1.ActivePageIndex = 1);
ToolButton6.Visible:=  (PageControl1.ActivePageIndex = 1);
ToolButton7.Visible:=  (PageControl1.ActivePageIndex = 2);
ToolButton8.Visible:=  (PageControl1.ActivePageIndex = 2);
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var number: string;
begin
 if callerlist.ItemIndex > -1 then
 begin
    number:=Callerlist.Items[Callerlist.itemindex].SubItems.strings[2];
{    if length(number) <= 8 then number := '030' + number;
    searchnumber.caption:= 'reverse lookup: ' + number;}
 end;
// searchNumber.visible:= (callerlist.ItemIndex > -1)
end;

procedure TForm1.ReverseNumberLookup;
var s,s2: string;
    r: TRegExpr;
    number: string;
    url: string;
    str: TStringStream;
    f: TFileStream;
    sl: TStringlist;
    i: integer;
begin

 number:=Callerlist.Items[Callerlist.itemindex].SubItems.strings[2];
// Vorwahl einfügen
// if length(number) <= 8 then number := '030' + number;

 r:= TRegExpr.create;

 str:= TStringStream.Create('');
 URL:= 'http://www1.dasoertliche.de/?form_name=search_inv&ph='+number;
 httpget(URL,str);

 s:= '';
 str.Position:=0;
 f:= TFileStream.Create('reverse.htm', fmCreate);
 f.copyfrom(str, str.size);
 f.Free;

 str.Position:=0;
 s:= str.DataString;
 s2:= s;
 sl:= TStringList.Create;
 r.Expression:= '#10';
 r.Split(s,sl);
 r.Expression:= '.*title=\"Details zu diesem Eintrag anzeigen\" class=\"entry\">([\w\s]*)</a>.*';
 for i:= 0 to sl.Count-1 do
  if r.Exec(sl.strings[i]) then
  begin
//    showmessage('gefunden');
    s:= r.Replace(sl.strings[i],'$1',true); //gefundener String
//    form3.memo1.Lines.Add(s);
    break;
  end;

 sl.Free;

  //Adressdaten filtern
{  r.Expression:= '.*div>([\w\s]*)<br>.*';
  if r.Exec(s2) then
  begin
    s2:= r.Replace(s2,'$1',true);
    memo1.Lines.Add(s2);
  end;
}
  str.free;
  r.free;
end;

procedure TForm1.Eintraglschen1Click(Sender: TObject);
var i    : integer;
    ident: integer;
    index: integer;
begin
 if PhoneBookList.ItemIndex > -1 then
  begin
   index:= PhoneBookList.ItemIndex;
   ident:= strtoint(PhoneBooklist.items[index].SubItems.Strings[3]);
   for i:= length(Phonebook)-1 downto 0 do
    if PhoneBook[i].No = ident then
      begin
        PhoneBook[i] := Phonebook[length(PhoneBook)-1];
        setlength(PhoneBook, length(PhoneBook)-1);
        FillPhoneBook;
        unsaved_phonebook:= true;
        break;
      end;
  end;
end;

Procedure TForm1.LoadPhonebookFromFile;
var f  : TFileStream;
    str: TStringStream;
begin
   if not fileExists('phonebook.dat') then exit;

   f:= TFileStream.Create('phonebook.dat',fmOpenRead);
   str:= TStringStream.Create('');
   str.CopyFrom(f,f.Size);
   f.free;

   ParsePhonebook(str);
   FillPhoneBook;
   str.free;
end;

Procedure TForm1.LoadCallersFromFile(filter: integer);
var f  : TFileStream;
    str: TStringStream;
begin
   if not fileExists('anrufliste.csv') then exit;

   f:= TFileStream.Create('anrufliste.csv',fmOpenRead);
   str:= TStringStream.Create('');
   str.CopyFrom(f,f.Size);
   f.free;
   ParseCallList(str,filter);
   str.free;
end;

function TForm1.AskForUpdate: boolean;
begin
  result:= false;
  if MessageDlg('There are unsaved phonebook entries which will be deleted if you continue. Do you want to upload all entries now ?', mtWarning, [mbYes, mbNo], 0)= mrYes
  then
  begin
    UpdatePhonebook;
    Phonebooklist.Enabled:= true;
    Phonebooklist.Cursor:= crDefault;
    result:= true;
  end;
end;


procedure TForm1.ReloadPhonebookClick(Sender: TObject);
var url: string;
    str: TStringStream;
    f  : TFileStream;
begin
 Phonebooklist.Cursor:= crHourGlass;
 Phonebooklist.Enabled:= false;

 if unsaved_phonebook then
  begin
    showmessage(booltostr(unsaved_phonebook));
   if AskforUpdate then exit;
  end;
  str:= TStringStream.Create('');

   URL:= 'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/fon/ppFonbuch.html&var:lang=de';
   httpget(URL,str);

   ParsePhonebook(str);
   FillPhoneBook;

   // abspeichern
   str.Position:= 0;
   f:= TFileStream.Create('phonebook.dat',fmcreate);
   f.CopyFrom(str,str.Size);
   f.free;

  str.free;
 Phonebooklist.Enabled:= true;
 Phonebooklist.Cursor:= crDefault;
end;

procedure TForm1.reloadCallerListClick(Sender: TObject);
var url : string;
    str : TStringStream;
    f   : TFileStream;
begin
 Callerlist.Cursor:= crHourGlass;
 Callerlist.Enabled:= false;
     str:= TStringStream.Create('');
      URL:= 'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/menus/menu2.html&var:lang=de&var:menu=fon&var:pagename=foncalls';
      httpget(URL,str);
      str.free;
     sleep(500);

     str:= TStringStream.Create('');
      URL:= 'http://'+BoxAdress+'/cgi-bin/webcm?getpage=../html/de/FRITZ!Box_Anrufliste.csv';
      httpget(URL,str);
      ParseCallList(str,0);
      callerlist.Tag:= 1;

      str.Position:= 0;
      f:= TFileStream.Create('anrufliste.csv',fmcreate);
      f.CopyFrom(str,str.Size);
      f.free;

     str.free;
 Callerlist.Enabled:= true;
 Callerlist.Cursor:= crDefault;
end;

procedure TForm1.PBShortFill;
var i: integer;
    index: integer;
begin
 PBShort.Clear;
 for i:= 0 to 99 do
  if i < 10 then
    Form1.PBShort.Items.Append(Format('0%d',[i]))
    else
    Form1.PBShort.Items.Append(Format('%d',[i]));

 for i:= 0 to length(Phonebook)-1 do
 begin
    index:= Form1.PBShort.Items.IndexOf(PhoneBook[i].short);
    Form1.PBShort.Items.Delete(index);
 end;

end;

procedure TForm1.PBaddClick(Sender: TObject);
var i: integer;
    ok: boolean;
    namestr: string;
begin
  ok:= true;

  if PBimportant.Checked then
      NameStr:= '!'+PBName.text
  else
      NameStr:= PBName.text;

  if (PBSelected = -1) then
  begin
   for i:= 0 to Phonebookliste.Count-1 do
   if NameStr = Phonebook[i].Name then
      begin //wenn schon in der Liste
        ok:= false;
        error.Caption:= 'Name already exists !';
        break;
      end;
  end
  else i:= PBSelected;

   if i > length(Phonebook)-1 then
   begin
    i:= length(Phonebook);
    setlength(PhoneBook, i+1);
   end;

   if ok then
   begin
     PhoneBook[i].Name   := NameStr;
     PhoneBook[i].Number := PBNumber.Text;
     PhoneBook[i].vanity := PBVanity.Text;
     PhoneBook[i].Short  := PBShort.Text;
     PhoneBook[i].No     := i;
     FillPhonebook;
     Phonebooklist.ItemIndex:= i;
     unsaved_phonebook:= true;
   end;
end;

procedure TForm1.PhoneBookListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var i: integer;
begin
PBselected:= strtoint(Item.SubItems[3]);
PBName.Text:= item.Caption;
PBNumber.Text:= item.SubItems[0];
PBVanity.Text:= item.SubItems[2];
PBimportant.checked:= (item.Caption[1] = '!');

PBShortFill;
i:= PBShort.items.Add(item.SubItems[1]);
PBshort.ItemIndex:= i;

PBadd.Caption:= 'change';
end;

procedure TForm1.PBClearClick(Sender: TObject);
begin
PBSelected:= -1;
PBName.Text:= '';
PBNumber.Text:= '';
PBVanity.Text:= '';
PBimportant.checked:= false;
PBShortFill;
PBshort.ItemIndex:= 0;
PBadd.Caption:= 'add';
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
 form3.show;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
ReloadCallerlistClick(self);
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
 LoadCallersFromFile((sender as TToolButton).ImageIndex);
end;

Procedure TForm1.UpdatePhonebook;
var i: integer;
    Data : String;
    EName: string;
begin
   Form1.Phonebooklist.Cursor:= crHourGlass;
   Form1.Phonebooklist.Enabled:= false;
    //Alles löschen
    Data:= '';
    for i:= 99 downto 0 do
    Data:= Data + 'telcfg:command/HotDialEntry'+inttostr(i)+'=delete'+'&';
    Data:= Data + 'Submit=Submit';

    httppost('http://'+BoxAdress+'/cgi-bin/webcm', Data);

    Data:= '';
    For i:= 0 to length(Phonebook)-1 do
    begin
       if Phonebook[i].important then EName:= '!'+Phonebook[i].Name else EName:= Phonebook[i].Name;
        Data := Data +
               'telcfg:settings/HotDialEntry'+inttostr(i)+'/Code=0'  + Phonebook[i].short  + '&' +
               'telcfg:settings/HotDialEntry'+inttostr(i)+'/Vanity=' + Phonebook[i].vanity + '&' +
               'telcfg:settings/HotDialEntry'+inttostr(i)+'/Number=' + Phonebook[i].Number + '&' +
               'telcfg:settings/HotDialEntry'+inttostr(i)+'/Name='   + EName               + '&';

//       Data := Data + 'telcfg:settings/HotDialEntry'+inttostr(Phonebook[i].No)+'/Code=0'+ Phonebook[i].short + '&' +
//               'telcfg:settings/HotDialEntry'+inttostr(Phonebook[i].No)+'/Vanity=' + '&' +
//               'telcfg:settings/HotDialEntry'+inttostr(Phonebook[i].No)+'/Number='+Phonebook[i].Number + '&' +
//               'telcfg:settings/HotDialEntry'+inttostr(Phonebook[i].No)+'/Name='+ EName + '&';

    end;

    Data:= Data + 'Submit=Submit';

   httppost('http://'+BoxAdress+'/cgi-bin/webcm', Data);
   unsaved_phonebook:= false;

   Form1.Phonebooklist.Cursor:= crDefault;
   Form1.Phonebooklist.Enabled:= true;
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
 UpdatePhonebook;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
ReloadPhonebook.Click;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
 Shellexecute( handle, nil, Pchar('https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=stefan_fruhner%40web%2ede&item_name=Watch_the_Box&no_shipping=2&no_note=1&tax=0&currency_code=EUR&lc=DE&bn=PP%2dDonationsBF&charset=UTF%2d8'), nil, nil, SW_SHOWMaximized);
end;

procedure TForm1.resetClick(Sender: TObject);
begin
DoReset;
end;

procedure TForm1.WebsiteMouseEnter(Sender: TObject);
begin
website.font.Color:= $005E2413;
end;

procedure TForm1.WebsiteMouseLeave(Sender: TObject);
begin
website.font.Color:= clBlue;
end;

procedure TForm1.WebsiteClick(Sender: TObject);
begin
Shellexecute( handle, nil, Pchar('http://www.mehrsurfen.de'), nil, nil, SW_SHOWMaximized);
end;

Procedure AddEntry(Entry: TPerson);
var Data : String;
    EName: string;
begin
 if entry.important then EName:= '!'+Entry.Name else EName:= Entry.Name;
 Data := 'telcfg:settings/HotDialEntry'+inttostr(Entry.No)+'/Code=0'+ inttostr(Entry.No) + '&' +
         'telcfg:settings/HotDialEntry'+inttostr(Entry.No)+'/Vanity=' + '&' +
         'telcfg:settings/HotDialEntry'+inttostr(Entry.No)+'/Number='+Entry.Number + '&' +
         'telcfg:settings/HotDialEntry'+inttostr(Entry.No)+'/Name='+ EName + '&' +
         'Submit=Submit';

 httppost('http://'+BoxAdress+'/cgi-bin/webcm', Data);
end;

Procedure DeleteEntry(Entry: TPerson);
var
    Data : String;
begin
    Data:= 'telcfg:command/HotDialEntry'+inttostr(Entry.No)+'=delete'+'&' +
           'Submit=Submit';
    httppost('http://'+BoxAdress+'/cgi-bin/webcm', Data);
end;


procedure TForm1.ToolButton9Click(Sender: TObject);
begin
showmessage('WatchTheBox'
             + #13#10 +
             'This is an early version, so it may be buggy. If your find bug or wish to have some new features, feel free to contact me at www.mehrsurfen.de > Forum.'
             + #13#10#13#10 +
             'This programm is free for personal use, but comes with no warranty. So you use it at your own risk.'
             + #13#10#13#10 +
             'credits: '
             +#13#10 +
             #9 +'Stefan Grandner '+#9+' : icon art (arrows)'
             +#13#10 +
             #9 +'Stefan Fruhner  '+#9#9+' : programming');
end;

end.
