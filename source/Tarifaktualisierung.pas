unit Tarifaktualisierung;

interface
uses sysutils, classes, strUtils, HttpProt, dateUtils;

type
  TTarifThread = class(TThread)

  public
   maxPreis, maxEinwahl: Real;
   TarifUrl: string;
   AutoDel: Boolean;
   lastdate: TDateTime;
   procedure MyTerminate(sender: TObject);

  private
//   lastdate: TDateTime;
   Http: THttpCli;
   error: boolean;
  
   procedure HttpDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
   function DownloadStart(var lastdate:TDateTime; http:THttpCli):boolean  ;
   function DownloadResume(http:THttpCli) :boolean ;
   procedure ParseTarifDatei(txtinput:TStringStream);
   procedure ParseBonGoDatei(txtinput:TStringStream);

  protected
   procedure Execute; override;



end;



implementation
uses unit1, RegExpr, tarifverw;

procedure DeleteAllFrom(editor: string);
var i: integer;
begin
 for i:= length(Hauptfenster.tarife)-1  downto 0 do
   if hauptfenster.tarife[i].Editor = editor then
   begin
    hauptfenster.tarife[i] := hauptfenster.tarife[length(hauptfenster.tarife)-1];
    setlength(Hauptfenster.tarife, length(hauptfenster.tarife)-1);
   end;
end;

procedure TaktToInteger(takt: string; var tleft, tright: integer);
var taktstring: string;
begin
//takt_a
  taktstring:= takt;
  Delete(taktstring,pos('/', taktstring),length(taktstring) - pos('/', taktstring) +1);
  try
    tleft:= strtoint(taktstring);
    if tleft > 60 then tleft:= 60;
  except
    tleft:= 60; //wenn Fehler dann minutentakt annehmen
  end;
//takt B
  taktstring:= takt;
  Delete(taktstring,1, pos('/', taktstring)  );
  try
    tright:= strtoint(taktstring);
  except
    tright:= 60; //wenn Fehler dann minutentakt annehmen
  end;
end;


procedure TTarifThread.HttpDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
//progress.Position:= round (100* http.RcvdCount/http.ContentLength);
end;

procedure TTarifThread.Execute;
var txt:TStringStream;
    datum: TDateTime;
begin
  Hauptfenster.Aktualisieren.Enabled:= false;
  Hauptfenster.Reload.Enabled:= false;
  error:= false;
  Http := THttpCli.Create(nil);
  with Http do
  begin
    Url       := TarifUrl;
    LocalAddr := '0.0.0.0';
    ProxyPort := '80';
    Agent := 'Mozilla/4.0 (compatible; ICS)';
    Accept := 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*';
    NoCache := True;
    ContentTypePost := 'application/x-www-form-urlencoded';
    MultiThreaded := False;
    RequestVer := '1.0';
    FollowRelocation := True;
    LocationChangeMaxCount := 5;
    BandwidthLimit := 10000;
    BandwidthSampling := 1000;
    Options := [];
    OnDocData := HttpDocData;
//    SocksAuthentication := socksNoAuthentication;
  end;

//initialisieren
 Datum            := 0;
 TXT              := TStringStream.Create('');

 http.RcvdStream:= txt;

 error:= not DownloadStart(Datum,http);

// if (error and (Datum > lastdate)) then
  if (Datum <= lastdate) then
  begin

   if Datum = lastdate then Hauptfenster.status.simpletext:= 'Die Tarifdaten sind noch aktuell.'
    else Hauptfenster.status.simpletext:= 'Konnte Dateidatum nicht identifizieren !';
   sleep(3000); 
   exit;

  end;

 txt.free;
 TXT              := TStringStream.Create('');
 http.RcvdStream:= txt;

 //neues Datum merken
 lastdate:= Datum;
 settings.WriteDateTime('Tariflisten','TarifDatum',lastdate);

 Hauptfenster.status.SimpleText:='Lade ' + http.URL + ' ( ' + DatetimetoStr(Datum) + ' )';

 if DownloadResume(http) then
 begin

  if ansicontainsstr(http.url, 'www.bongosoft.de') then
   ParseBonGoDatei(txt)
  else
   ParseTarifDatei(txt);

 WriteTarifeToHD;
 Tarifverw.LadeTarife;
 end
 else
    error:= true;

 txt.free;
end;

procedure TTarifThread.MyTerminate(sender: TObject);
begin
if not error then
 Hauptfenster.Status.SimpleText:= 'Tarifdaten aktualisiert.'
 else
 Hauptfenster.Status.SimpleText:= 'Fehler beim Laden der Tarifdaten';

 Hauptfenster.Aktualisieren.Enabled:= true;
 Hauptfenster.Reload.Enabled:= true;
 Hauptfenster.aktualisierenclick(self);
end;


function TTarifThread.DownloadStart(var lastdate:TDateTime; http:THttpCli):boolean  ;
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
// ### Preistabelle.php version="1.0" timestamp="1180038366"
  if ansicontainsstr(http.url, 'www.bongosoft.de') then
   r.Expression:= '.* Preistabelle-lang.txt version=\"1.0\" timestamp=\"(.{1,10}).{0,}\".*'
  else
   r.Expression:= '.* Preistabelle.php version="1.0" timestamp=\"(.{1,10}).{0,}\".*';

   tempstring:= (http.RcvdStream As TStringStream).DataString;

   if r.exec(tempstring) then
   begin
    Result  := true;
    unix    := strtoint( r.replace(tempstring,'$1', true));
    lastdate:= unixToDateTime(unix);
   end
   else Result:=false;
 r.free;
end;

function TTarifThread.DownloadResume(http:THttpCli) :boolean ;
begin
 http.ContentRangeBegin:= '';
 http.ContentRangeEnd:= '';

 try
  http.Get;
 except
  Result:= false;
  exit;
 end;
 Result:=true;
end;


procedure TTarifThread.ParseTarifdatei(txtinput:TStringStream);
var r,r2                 : TRegExpr;
    i                 : integer;
    split             : TStringlist;
    Beginn, Ende, gilt: String;
    preis, einwahl    : string;
    tag               : integer;
    tempdate          : string;
    DatenSatz         : TTarif02;
    Tarife            : array of TTarif02;
begin
 setlength(Tarife,0);

 r:= TRegExpr.Create;
 r2:=TRegExpr.Create;
 Hauptfenster.status.simpletext:= 'Lese ' + ExtractFileName(http.URL) + ' (' +datetimetostr(lastdate)+' )';

 r2.Expression:= '(\d\d)/(\d\d)/(\d\d\d\d)';

 txtinput.Position:=0;

 split:= TStringlist.Create;
 r.Expression:= #10;   //Zeilentrenner ist in diesem Fall nur #10, da unix-Datei
 r.Split(txtinput.DataString,Split); //zeilenweise aufsplitten

//alle Tarife löschen, die bereits mit UserLCXP beginnen
 DeleteAllFrom('UserLCXP');

 for i:= 0 to Split.count -1 do
 begin

  r.Expression:= '(.*)  (.*)  (\d)  (\d{1,2})  (\d{1,2})  (.*)  (.*)  (.*)  (\d*)  (.*)  (.*)  (.*)  (\d{2}/\d{2}/\d{4})  (\d{2}/\d{2}/\d{4})';

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
   if not ansicontainsstr(Preis, Decimalseparator) then
     preis:= preis + DecimalSeParator + '0';

   DatenSatz.Preis   := StrToFloat(Preis);

   Einwahl:= r.Replace(split.Strings[i], '$7', true);
   Einwahl:= AnsiReplaceStr(Einwahl,ThousandSeparator, DecimalSeparator);
   if not ansicontainsstr(Einwahl, Decimalseparator) then
     Einwahl:= Einwahl + DecimalSeParator + '0';

   DatenSatz.Einwahl:= StrToFloat(einwahl);

   tag:= strtoint(r.Replace(split.Strings[i], '$3', true));
   case (tag) of
    0: gilt:= '[Mo][Di][Mi][Do][Fr]';
    1: gilt:= '[Sa][So][feiertags]';
    2: gilt:= '[Sa]';
    3: gilt:= '[So]';
    4: gilt:= '[Mo][Di][Mi][Do][Fr][Sa][So][feiertags]';
   end;
   Datensatz.Tag              := gilt;
   DatenSatz.Nummer           := r.Replace(split.Strings[i], '$9', true);
   TaktToInteger(r.Replace(split.Strings[i], '$8', true), DatenSatz.takt_a, Datensatz.Takt_b);
   DatenSatz.User             := r.Replace(split.Strings[i], '$10', true);
   DatenSatz.Passwort         := r.Replace(split.Strings[i], '$11', true);
   DatenSatz.Webseite         := r.Replace(split.Strings[i], '$12', true);
   DatenSatz.eingetragen      := dateof(lastdate);
   //das Datum extrahieren und neu encodieren
   tempdate:= r.Replace(split.Strings[i], '$13', true);
   DatenSatz.validfrom        := dateof(EncodeDate(strtoint(r2.Replace(tempdate, '$3', true)),strtoint(r2.Replace(tempdate, '$1', true)),strtoint(r2.Replace(tempdate, '$2', true))));
   tempdate:= r.Replace(split.Strings[i], '$14', true);
   DatenSatz.expires          := dateof(EncodeDate(strtoint(r2.Replace(tempdate, '$3', true)),strtoint(r2.Replace(tempdate, '$1', true)),strtoint(r2.Replace(tempdate, '$2', true))));

   DatenSatz.Editor           := 'UserLCXP';
   DatenSatz.DeleteWhenExpires:= Autodel;//deleteit.checked;
   Datensatz.Mindestumsatz    := 0.0;

    //wenn Tarif innerhalb der Bedingungen, dann mitnehmen
    if((maxPreis >= DatenSatz.Preis) and ( maxEinwahl >= DatenSatz.Einwahl)) then
    begin
      //neue Länge setzen
      setlength(Hauptfenster.Tarife,length(Hauptfenster.Tarife)+1);
    //an der neuen freien Stelle hinzufügen
      Hauptfenster.Tarife[length(Hauptfenster.Tarife)-1]  := DatenSatz;
    end;
  end;  //Ende der Match-Bedingung

//    progress.position:= i;
 end;  //ende der BonogDatei

 split.Clear;
 split.Free;

 r2.free;
 r.Free;
end;

procedure TTarifThread.ParseBonGoDatei(txtinput:TStringStream);
var r                 : TRegExpr;
    i                 : integer;
    split             : TStringlist;
    Beginn, Ende, gilt: String;
    preis, einwahl    : string;
    tag               : integer;

    DatenSatz         : TTarif02;
    Tarife            : array of TTarif02;
begin
 setlength(Tarife,0);

 r:= TRegExpr.Create;
 Hauptfenster.status.simpletext:= 'Lese ' + ExtractFileName(http.URL) + ' (' +datetimetostr(lastdate)+' )';

 txtinput.Position:=0;

 //alle Tarife löschen, die bereits mit UserLCXP beginnen
 DeleteAllFrom('BonGo');

 split:= TStringlist.Create;
 r.Expression:= #10;   //Zeilentrenner ist in diesem Fall nur #10, da unix-Datei
 r.Split(txtinput.DataString,Split); //zeilenweise aufsplitten

 for i:= 0 to Split.count -1 do
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
   Datensatz.Tag              := gilt;
   DatenSatz.Nummer           := r.Replace(split.Strings[i], '$9', true);
   TaktToInteger(r.Replace(split.Strings[i], '$8', true), DatenSatz.takt_a, Datensatz.Takt_b);
   DatenSatz.User             := r.Replace(split.Strings[i], '$10', true);
   DatenSatz.Passwort         := r.Replace(split.Strings[i], '$11', true);
   DatenSatz.Webseite         := r.Replace(split.Strings[i], '$12', true);
   DatenSatz.eingetragen      := dateof(lastdate);
   DatenSatz.expires          := dateof(incDay(lastdate,2));
   DatenSatz.validfrom        := dateof(lastdate);

   DatenSatz.Editor           := 'BonGo';
   DatenSatz.DeleteWhenExpires:= Autodel;
   Datensatz.Mindestumsatz    := 0.0;
   
    //wenn Tarif innerhalb der Bedingungen, dann mitnehmen
    if((maxPreis >= DatenSatz.Preis) and ( maxEinwahl >= DatenSatz.Einwahl)) then
    begin
      //neue Länge setzen
      setlength(Hauptfenster.Tarife,length(Hauptfenster.Tarife)+1);
    //an der neuen freien Stelle hinzufügen
      Hauptfenster.Tarife[length(Hauptfenster.Tarife)-1]  := DatenSatz;
    end;
  end;  //Ende der Match-Bedingung

//    progress.position:= i;
 end;  //ende der BonogDatei

 split.Clear;
 split.Free;

 r.Free;
end;

end.
