unit unit1;

{BonGoBon - Stefan Fruhner

BonGoBon listet Tarife, die von BongoSoft.de bereitgestellt werden im Soft-LCR
LeastCosterXP auf. Dieses Programm darf frei bearbeitet und verändert werden,
insofern mir eine eMail mit dem veränderten Code gesendet wird.

(C) 2006 Stefan Fruhner - autor@leastcosterxp.de

Dieses Programm ist freie Software. Sie können es unter den Bedingungen der GNU
General Public License, wie von der Free Software Foundation veröffentlicht,
weitergeben und/oder modifizieren.

Die Veröffentlichung dieses Programms erfolgt in der Hoffnung, daß es Ihnen von
Nutzen sein wird, aber OHNE IRGENDEINE GARANTIE, sogar ohne die implizite
Garantie der MARKTREIFE oder der VERWENDBARKEIT FÜR EINEN BESTIMMTEN ZWECK.
Details finden Sie in der GNU General Public License.

Es gelten insbes. folgende Regeln:

   1. Das Programm darf ohne jede Einschränkung für jeden Zweck genutzt werden.
   2. Kopien des Programms dürfen kostenlos oder auch gegen Geld verteilt werden,
      wobei der Quellcode mitverteilt oder dem Empfänger des Programms auf Anfrage
      zum Selbstkostenpreis zur Verfügung gestellt werden muss. Dem Empfänger müssen
      dieselben Freiheiten gewährt werden – wer z. B. eine Kopie gegen Geld empfängt,
      hat weiterhin das Recht, diesen dann kommerziell oder auch kostenlos zu verbreiten.
      Lizenzgebühren sind nicht erlaubt. Niemand ist verpflichtet, Kopien zu verteilen,
      weder im Allgemeinen, noch an irgendeine bestimmte Person – aber wenn er es tut,
      dann nur nach diesen Regeln.[1]
   3. Die Arbeitsweise eines Programms darf studiert und den eigenen Bedürfnissen
      angepasst werden.
   4. Es dürfen auch die gemäß Freiheit 3 veränderten Versionen des Programms
      unter den Regeln von Freiheit 2 vertrieben werden, wobei dem Empfänger des
      Programms der Quellcode der veränderten Version verfügbar gemacht werden muss.
      Veränderte Versionen müssen nicht veröffentlicht werden; aber wenn sie
      veröffentlicht werden, dann darf dies nur unter den Regeln von Freiheit 2
      geschehen.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HttpProt, ComCtrls, TFlatSpinEditUnit,
  TFlatProgressBarUnit, TFlatEditUnit, TFlatButtonUnit, ExtCtrls, SRGrad,
  BMDThread, AppEvnts;

type

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

  TForm1 = class(TForm)
    Http: THttpCli;
    Label1: TLabel;
    maxE: TFlatSpinEditFloat;
    Progress: TFlatProgressBar;
    maxP: TFlatSpinEditFloat;
    Label2: TLabel;
    Start: TFlatButton;
    Bevel1: TBevel;
    Status: TStatusBar;
    SRGradient1: TSRGradient;
    Label3: TLabel;
    FlatButton1: TFlatButton;
    Timer1: TTimer;
    FlatButton2: TFlatButton;
    BMDThread1: TBMDThread;
    ApplicationEvents1: TApplicationEvents;
    ResetB: TFlatButton;
    procedure ResetBClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure BMDThread1Terminate(Sender: TObject; Thread: TBMDExecuteThread;
      var Data: Pointer);
    procedure BMDThread1Execute(Sender: TObject; Thread: TBMDExecuteThread;
      var Data: Pointer);
    procedure FlatButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure HttpDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
    procedure BonGoParse(txtinput:TStringStream);
    procedure StartClick(Sender: TObject);
  private
    { Private declarations }
        lastdate: TDateTime;
        GCanClose:boolean;
        procedure WMNCHitTest(var M: TWMNCHitTest);
         message wm_NCHitTest;

  public
    { Public declarations }
  end;
  
  function DownloadStart(var lastdate:TDateTime; http:THttpCli):boolean  ;
  function DownloadResume(http:THttpCli) :boolean ;
  function GetFileVersion(Path: string): string;

var
  Form1: TForm1;

implementation
uses RegExpr, StrUtils, DateUtils, IniFiles, zlib;

{$R *.dfm}
procedure Compress(InputFileName, OutputFileName: string);
var InputStream, OutputStream: TFileStream;
  CompressionStream: ZLib.TCompressionStream;
begin
  InputStream:=TFileStream.Create(InputFileName, fmOpenRead);
  try
    OutputStream:=TFileStream.Create(OutputFileName, fmCreate);
    try
      CompressionStream:=TCompressionStream.Create(clMax, OutputStream);
      try
        CompressionStream.CopyFrom(InputStream, InputStream.Size);
      finally
        CompressionStream.Free;
      end;
    finally
      OutputStream.Free;
    end;
  finally
    InputStream.Free;
  end;
end;

procedure Decompress(InputFileName, OutputFileName: string);
var InputStream, OutputStream: TFileStream;
  DeCompressionStream: ZLib.TDeCompressionStream;
  Buf: array[0..4095] of Byte;
  Count: Integer;
begin
  InputStream:=TFileStream.Create(InputFileName, fmOpenRead);
  try
    OutputStream:=TFileStream.Create(OutputFileName, fmCreate);
    try
      DecompressionStream := TDecompressionStream.Create(InputStream);
      try
        while true do
        begin
          Count := DecompressionStream.Read(Buf[0], SizeOf(Buf));
          if Count = 0 then
            break
          else
            OutputStream.Write(Buf[0], Count);
        end;
      finally
        DecompressionStream.Free;
      end;
    finally
      OutputStream.Free;
    end;
  finally
    InputStream.Free;
  end;
end;


procedure TForm1.WMNCHitTest (var M: TWMNCHitTest);
begin
  inherited;
  if M.Result = htClient then
    M.Result := htCaption;
end;

procedure TForm1.BonGoParse(txtinput:TStringStream);
var r    : TRegExpr;
    i    : integer;
    split: TStringlist;
    Beginn, Ende, gilt : String;
    preis, einwahl: string;
    tag  : integer;

    DatenSatz: TTarif;
    Tarife: array of TTarif;
    Datei: file of TTarif;

    fname, cname: string;
begin

 setlength(Tarife,0);

 r:= TRegExpr.Create;
 status.simpletext:= 'Lese ' + ExtractFileName(http.URL) + ' (' +datetimetostr(lastdate)+' )';

 txtinput.Position:=0;

 split:= TStringlist.Create;
 r.Expression:= #10;   //Zeilentrenner ist in diesem Fall nur #10, da unix-Datei
 r.Split(txtinput.DataString,Split); //zeilenweise aufsplitten

 Progress.Max:= split.Count-1;
 Progress.position:= 0;
 progress.Refresh;

 for i:= 0 to SPlit.count -1 do
 begin

  r.Expression:= '(.*)  (.*)  (\d)  (\d{1,2})  (\d{1,2})  (.*)  (.*)  (.*)  (\d*)  (.*)  (.*)  (.*)';

  //wenn der String matched
  if r.exec(split.strings[i]) then
  begin
   Datensatz.tarif := r.Replace(split.Strings[i], '$1 $2', true);

   Beginn := r.Replace(split.Strings[i], '$4', true);
   if strtoint(beginn) < 10 then beginn:= '0'+Beginn
   else if beginn = '24' then beginn:= '00';
   DatenSatz.Beginn := EncodeTime(strToint(beginn),0,0,0);

   Ende:= r.Replace(split.Strings[i], '$5', true);
   if strtoint(Ende) < 10 then ende:= '0'+Ende
   else if ende = '24' then ende:= '00';
   DatenSatz.Ende   := EncodeTime(StrToInt(ende),0,0,0);

   Preis:= r.Replace(split.Strings[i], '$6', true);
   preis:= AnsiReplaceStr(Preis,ThousandSeparator, DecimalSeparator);
   DatenSatz.Preis   := StrToFloat(Preis);

   Einwahl:= r.Replace(split.Strings[i], '$7', true);
   Einwahl:= AnsiReplaceStr(Einwahl,ThousandSeparator, DecimalSeparator);
   DatenSatz.Einwahl:= StrToFloat(einwahl);

   tag:= strtoint(r.Replace(split.Strings[i], '$3', true));
   case (tag) of
    0: gilt:= '[Mo][Di][Mi][Do][Fr]';
    1: gilt:= '[Sa][So][feiertags]';
    2: gilt:= '[Sa]';
    3: gilt:= '[So]';
    4: gilt:= '[Mo][Di][Mi][Do][Fr][Sa][So][feiertags]';
   end;
   Datensatz.Tag         := gilt;
   DatenSatz.Nummer      := r.Replace(split.Strings[i], '$9', true);
   DatenSatz.Takt        := r.Replace(split.Strings[i], '$8', true);
   DatenSatz.User        := r.Replace(split.Strings[i], '$10', true);
   DatenSatz.Passwort    := r.Replace(split.Strings[i], '$11', true);
   DatenSatz.Webseite    := r.Replace(split.Strings[i], '$12', true);
   DatenSatz.eingetragen := dateof(lastdate);
   DatenSatz.expires     := dateof(incDay(lastdate,2));
   DatenSatz.validfrom   := dateof(lastdate);

   DatenSatz.Editor      := 'BonGo';
   DatenSatz.DeleteWhenExpires:= false;

    //wenn Tarif innerhalb der Bedingungen, dann mitnehmen
    if((maxP.Value >= DatenSatz.Preis) and ( maxE.Value >= DatenSatz.Einwahl)) then
    begin
      //neue Länge setzen
      setlength(Tarife,length(Tarife)+1);
      //an der neuen freien Stelle hinzufügen
      Tarife[length(Tarife)-1]  := DatenSatz;
    end;
  end;  //Ende der Match-Bedingung

    progress.position:= i;
 end;  //ende der BonogDatei

 split.Clear;
 status.simpletext:= 'Suche Tarife.lcx';


 //ab hier die alten Tarife einlesen
 if fileexists('..\..\Tarife.lcx') then
 begin
   cname:='..\..\Tarife.lcx';
   fname:=changeFileExt(fname, '.$$$');
   Decompress(cname, fname);

   assignFile(Datei,fname);
   ReSet(Datei);

   Progress.min:= 0;
   Progress.Max:= FileSize(Datei);
   
   while not eof(Datei) do
    begin
     Read(Datei, Datensatz);
//     showmessage(Datensatz.Editor + ' ' + inttostr(length(Tarife)));
     //nur speichern wenn nicht schon ein Bongotarif
     if not (DatenSatz.Editor = 'BonGo') then
      begin //anhängen
        //neue Länge setzen
          setlength(Tarife,length(Tarife)+1);
        //an der neuen freien Stelle hinzufügen
          Tarife[length(Tarife)-1] := DatenSatz;
      end;
      Progress.Position:= Progress.Position + 1;
    end;
   closefile(Datei);
   DeleteFile(fname);
   RenameFile('..\..\Tarife.lcx','..\..\Tarife.lcx.bak');
 end; //if fileExists

 //abspeichern
  status.simpletext:= 'Schreibe neue Tarife.lcx ...';
  if length(Tarife) > 0 then
  begin

    cname:='..\..\Tarife.lcx';
    fname:=changeFileExt(fname, '.$$$');

    assignFile(Datei,fname);
    ReWrite(Datei);

    Progress.min:= 0;
    Progress.Max:= length(tarife);

    For i:= 0 to length(tarife)-1 do
    begin
      write(Datei, Tarife[i]);
      progress.position:= Progress.Position + 1;
    end;

    CloseFile(Datei);
    Compress(fname, cname);
    DeleteFile(fname);
  end;

 //Sicherungskopie löschen
 if fileexists('..\..\Tarife.lcx.bak') then deletefile('..\..\Tarife.lcx.bak');
 
 split.Free;

 r.Free;
 status.simpletext:= 'Tarife.lcx erstellt.';
end;

procedure TForm1.StartClick(Sender: TObject);
begin
 BMDThread1.Start;
end;

procedure TForm1.HttpDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
progress.Position:= round (100* http.RcvdCount/http.ContentLength);
end;

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
    ini: TInifile;
begin
 form1.tag:= 0;

 ini:= TInifile.create(ExtractFilepath(paramstr(0)) + 'BonGoBon.ini');

  MaxP.Value:= ini.Readfloat('settings','MaxPreis',1.0);
  MaxE.Value:= ini.Readfloat('settings','MaxEinwahl',3.0);

  form1.Top := ini.Readinteger('settings','top', 0);
  form1.left:= ini.Readinteger('settings','left', 0);

  lastdate:= ini.ReadDateTime('settings','lastdate', encodedate(1970,02,02));

 ini.free;

 for i:= 0 to paramcount do
 begin
  if (paramstr(i)='-set') then form1.Tag:= 1; //Settings und manueller Betrieb
  if (paramstr(i)='-start') then form1.Tag:= 2; //automatischer Betrieb
 end;
 
 if not(form1.Tag = 2) then form1.WindowState:=wsNormal;


end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var ini: TInifile;
begin
CanClose:=not BMDThread1.Runing;

if not CanClose then
begin
  GCanClose:=true;
  exit;
end;

ini:= TInifile.create(ExtractFilepath(paramstr(0)) + 'BonGoBon.ini');

ini.Writefloat('settings','MaxPreis',MaxP.Value);
ini.Writefloat('settings','MaxEinwahl',MaxE.Value);

ini.writeinteger('settings','top', form1.Top);
ini.writeinteger('settings','left', form1.left);

ini.WriteDateTime('settings','lastdate', lastdate);

ini.free;

end;


procedure TForm1.FlatButton1Click(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  timer1.enabled:= false;
  BMDThread1.Start;
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
Application.Minimize;
end;

procedure TForm1.BMDThread1Execute(Sender: TObject; Thread: TBMDExecuteThread ;     var Data: Pointer);
var txt:TStringStream;
    datum: TDateTime;
begin
//initialisieren
 Datum:= 0;
 TXT := TStringStream.Create('');
//disablen der Buttons
 MaxP.Enabled:= false;
 MaxE.Enabled:= false;
 Start.Enabled:= false;
 ResetB.enabled:= false;

 Progress.Min     := 0;
 progress.Max     := 100;
 Progress.Position:= 0;
 progress.Refresh;

 http.RcvdStream:= txt;

 if not( DownloadStart(Datum,http) and (Datum > lastdate)) then
  begin

   if Datum = lastdate then status.simpletext:= 'Die Tarifdaten sind noch aktuell.'
    else status.simpletext:= 'Konnte Dateidatum nicht identifizieren !';
      //form1.Refresh;
      //wieder alles enabled schalten
      MaxP.Enabled:= true;
      MaxE.Enabled:= true;
      Start.Enabled:= true;
      ResetB.Enabled:= true;

      // schließen wenn nicht im manullen Modus
      if form1.tag=2 then form1.close;
      exit;

  end;

 //neues Datum merken
 lastdate:= Datum;

 Progress.Min     := 0;
 progress.Max     := 100;
 Progress.Position:= 0;
 progress.Refresh;
 //zeigen, wenn neuer Download
 if form1.tag=2 then form1.WindowState:=wsNormal;

 status.SimpleText:='Lade ' + http.URL + ' ( ' + DatetimetoStr(Datum) + ' )';

 if DownloadResume(http) then BonGoParse(txt);

 //wieder alles enabled schalten
 MaxP.Enabled:= true;
 MaxE.Enabled:= true;
 Start.Enabled:= true;
 ResetB.Enabled:= true;

 txt.free;

// schließen wenn nicht im manullen Modus
 if form1.tag=2 then form1.close;
end;

function DownloadStart(var lastdate:TDateTime; http:THttpCli):boolean  ;
var r: TRegExpr;
    TempString: String;
    unix: Cardinal;
begin
  Result := false;

 http.contentrangebegin:= inttostr(0);
 http.ContentRangeEnd:= inttostr(100);

 try
   http.Get;
 except
  Result:=false;
  exit;
 end;

 //Timestamp auslesen
 r:= TRegExpr.Create;
   r.Expression:= '.* Preistabelle-lang.txt version=\"1.0\" timestamp=\"(.{1,10}).{0,}\".*';
   tempstring:= (http.RcvdStream As TStringStream).DataString;
   if r.exec(tempstring) then
   begin
    Result:= true;
    unix:= strtoint( r.replace(tempstring,'$1', true));
    lastdate := unixToDateTime(unix);
   end
   else Result:=false;
 r.free;
end;

function DownloadResume(http:THttpCli) :boolean ;
begin
 //weiterladen
 http.RcvdStream.Position:= http.RcvdStream.Size;
 http.ContentRangeBegin:= inttostr(http.rcvdStream.Size);
 http.ContentRangeEnd:= '';

 try
  http.Get;
 except
  Result:= false;
  exit;
 end;
 Result:=true;
end;

procedure TForm1.BMDThread1Terminate(Sender: TObject; Thread: TBMDExecuteThread;
  var Data: Pointer);
begin
 if GCanClose then form1.Close;
end;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
 ApplicationEvents1.OnIdle:= nil;
 //form1.Hide;
 if form1.tag = 2 then BMDThread1.Start;
 form1.Label3.Caption:=      form1.Label3.Caption + GetFileVersion(ParamStr(0));
end;

function GetFileVersion(Path: string): string;
var
  lpVerInfo: pointer;
  rVerValue: PVSFixedFileInfo;
  dwInfoSize: cardinal;
  dwValueSize: cardinal;
  dwDummy: cardinal;
  lpstrPath: pchar;

begin
  if Trim(Path) = EmptyStr
  then lpstrPath := pchar(ParamStr(0))
  else lpstrPath := pchar(Path);

  dwInfoSize := GetFileVersionInfoSize(lpstrPath, dwDummy);

  if dwInfoSize = 0
  then begin
    Result := 'No version specification';
    Exit;
  end;

  GetMem(lpVerInfo, dwInfoSize);
  GetFileVersionInfo(lpstrPath, 0, dwInfoSize, lpVerInfo);
  VerQueryValue(lpVerInfo, '\', pointer(rVerValue), dwValueSize);

  with rVerValue^ do
  begin
    Result := IntTostr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntTostr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntTostr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntTostr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(lpVerInfo, dwInfoSize);

end;

procedure TForm1.ResetBClick(Sender: TObject);
begin
 lastdate:= EncodeDate(1970,01,02) + timeof(now);
end;

end.
