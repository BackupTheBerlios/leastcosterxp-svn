unit tarifverw;

interface
uses grids,controls, GridEvents, floating, files, unit1;

procedure TaktToInteger(takt: string; var tleft, tright: integer);

procedure watchoutforcheaperprice(checktime: TDateTime);
function IndexOfScores(tarif: string): integer;
function ToggleSuspendScores(tarif: string): integer;
function GetState(tarif: string): integer;
procedure ResetSuspendScores(tarif: string);

procedure LadeTarife;
procedure Loadlist;
procedure LoadListaddline(var rows:integer;i: integer; var Einwahl,Preis: real; timeofdisplay: TDatetime; thisdauer: integer);
function CheckOnlineset: boolean;

function isFeiertag(date: TDate): string;
procedure LoescheTarif(tarif: string);
procedure LoescheAbgelaufeneTarife;
//procedure SaveTrafficData(Tarif: string; Dauer: Integer; download, upload: longint);
procedure SaveTrafficData(Data: OnlineWerte);
procedure Kontingente_Laden;
procedure ResetExpireDate(Tarif: String;Datum: TDate);

function computecosts(Kanalbuendelung: boolean): boolean;

procedure WriteTarifeToHD;
procedure LoadAutoDialTimes;
procedure SaveAutoDialTimes;

implementation

uses inifiles, classes, sysutils, Strutils,Dateutils, forms, unit7, windows, dialogs, inilang, messagestrings, Protokolle;

procedure watchoutforcheaperprice(checktime: TDateTime);
var price_now: real;
    price_then: real;
    thisprice_then, thiseinwahl_then: string;
    i: integer;
    thisprice_when: string;
begin

with hauptfenster do
  begin

  //Fenster freigeben, wenn es schon existiert
  If Assigned(PriceWarning) then begin Pricewarning.close.click; exit; end;

  thisprice_then   := misc(M149,'M149');
  thiseinwahl_then := misc(M149,'M149');
  thisprice_when:= liste.cells[2,1];

  if not (liste.cells[1,1] ='') then
  begin
   if (onlineset.preis <> -1.0) then price_now:= onlineset.Preis
                            else price_now:= -1.0;

   price_then:= strtofloat(liste.cells[4,1]);    //der billigste Preis zum Vergleich

   for i:= 1 to liste.RowCount-1 do
   begin //neuen preis des Tarifs suchen
    if (liste.cells[1,i] = onlineset.Tarif)
    then
     begin
      thisprice_then     := liste.cells[4,i];
      thisprice_when     := liste.cells[2,i];
      thiseinwahl_then   := liste.cells[5,i];
      break;
     end;
   end;

   if ( (price_then <> price_now) or (thisprice_then = misc(M149,'M149'))) then
   begin
     Application.CreateForm(TPriceWarning, PriceWarning);

     PriceWarning.info2.Caption:= Format(misc(M255,'M255'),[onlineset.Tarif ,onlineset.Preis ,onlineset.Einwahl]);
     PriceWarning.info3.Caption:= Format(misc(M256,'M256'),[timetoStr(onlineset.vbegin) ,timeToStr(onlineset.vend)]);

     PriceWarning.info4.visible:= (thisprice_when <> timetoStr(onlineset.vbegin)); //ausbelnnden wenn die gleiche zeit wie Anfang
     PriceWarning.info4.Caption:= Format(misc(M257,'M257'),[thisprice_when, thisprice_then]);
     if thisprice_then <> misc(M149,'M149') then  PriceWarning.info4.caption:= PriceWarning.info4.caption + ' '+misc(M12,'M12')+'/min .';

     PriceWarning.neu1.Caption:= Format(misc(M258,'M258'),[liste.cells[2,1] ,liste.cells[3,1]]);
     PriceWarning.neu2.Caption:= Format(misc(M259,'M259'),[UpperCase(liste.cells[1,1]),liste.cells[4,1],liste.cells[5,1]]);
     PriceWarning.neu3.Caption:= misc(M260,'M260');
     Pricewarning.trennen2.Caption:= Format(misc(M261,'M261'),[TimeToStr(onlineset.vend)]);

     Pricewarning.Timer1.enabled:= true;
     Pricewarning.Show;
     SetWindowPos(pricewarning.handle,hwnd_topmost,pricewarning.left,pricewarning.Top,pricewarning.Width,pricewarning.Height,{swp_noactivate+swp_nomove+}swp_nosize);
   end;

   if (price_then > price_now) then
   begin
     onlineset.wechsel:= dateof(checktime) + onlineset.vend;
     if thisprice_then <> misc(M149,'M149') then
        begin
             onlineset.wechselpreis   := strtofloat(thisprice_then);
             onlineset.wechseleinwahl := strtofloat(thiseinwahl_then);
             onlineset.vbegin         := StrToTime(liste.cells[2,i]);
             onlineset.vend           := StrToTime(liste.cells[3,i]);
             onlineset.tag            := liste.cells[17,i];
        end
        else begin onlineset.wechselpreis := -1.; onlineset.wechseleinwahl:= 0; end;
    end
   else
   if (price_then < price_now) then
   begin
     if onlineset.vend <> onlineset.vbegin then //nur wenn nicht ganztags
     onlineset.wechsel:= dateof(checktime) + onlineset.vend;
     if thisprice_then <> misc(M149,'M149') then
        begin
             onlineset.wechselpreis   := strtofloat(thisprice_then);
             onlineset.wechseleinwahl := strtofloat(thiseinwahl_then);
             onlineset.vbegin         := StrToTime(liste.cells[2,i]);
             onlineset.vend           := StrToTime(liste.cells[3,i]);
             onlineset.tag            := liste.cells[17,i];
        end
       else begin onlineset.wechselpreis := -1.; onlineset.wechseleinwahl:=0; end;
   end
   else
   if (thisprice_then = misc(M149,'M149')) then
   begin
     onlineset.tag  := liste.cells[17,i];
     if onlineset.vend <> onlineset.vbegin then //nur wenn nicht ganztags
      onlineset.wechsel:= dateof(checktime) + onlineset.vend;
   end;
 end
  else //erste Zeile ist leer
  begin
     Application.CreateForm(TPriceWarning, PriceWarning);

     PriceWarning.info2.Caption:= Format(misc(M255,'M255'),[onlineset.Tarif ,onlineset.Preis ,onlineset.Einwahl]);
     PriceWarning.info3.Caption:= Format(misc(M256,'M256'),[timetoStr(onlineset.vbegin) ,timeToStr(onlineset.vend)]);
     PriceWarning.info4.Caption:=  Format(misc(M257,'M257'),[timeToStr(onlineset.vend), thisprice_then]);
     if thisprice_then <> misc(M149,'M149') then  PriceWarning.info4.caption:= PriceWarning.info4.caption + ' '+misc(M12,'M12')+'/min .';

     PriceWarning.neu1.Caption:= misc(M262,'262');
     PriceWarning.neu2.Caption:= Format(misc(M263,'M263'),[TimeToStr(onlineset.endzeit)]);
     PriceWarning.neu3.Caption:= misc(M264,'M264');

     Pricewarning.trennen2.Caption:= Format(misc(M261,'M261'),[TimeToStr(onlineset.vend)]);
     Pricewarning.Timer1.enabled:= true;
     Pricewarning.Show;
     Pricewarning.bringtofront;
   end;
end;
end;

function InScores(Test: string): boolean;
var k: integer;
begin
Result:= false;
if length(Hauptfenster.Scores) > 0 then
 for k:= 0 to length(hauptfenster.Scores)-1 do
  if Test = hauptfenster.Scores[k].Name then
   begin Result:= true; break; end;
end;

procedure GetScores(tarif: string; var alle:integer; var erfolgreich: integer; var state: integer; var ScoreIndex: integer);
var i: integer;
begin
for i:= 0 to length(hauptfenster.Scores) -1 do
 if hauptfenster.Scores[i].Name =  Tarif then
 begin
  alle        := hauptfenster.Scores[i].gesamt;
  erfolgreich := hauptfenster.Scores[i].erfolgreich;
  state       := hauptfenster.Scores[i].state;
  ScoreIndex  := i;
  break;
 end;
end;

function IndexOfScores(tarif: string): integer;
var i: integer;
begin
result:= -1;
for i:= 0 to length(hauptfenster.Scores)-1 do
if hauptfenster.Scores[i].Name = Tarif then
 begin
  Result:= i;
  break;
 end;
end;

function ToggleSuspendScores(tarif: string): integer;
var index: integer;
begin
index:=IndexOfScores(tarif);
case Hauptfenster.Scores[index].state of
0: Hauptfenster.Scores[Index].state:= 1;
1: Hauptfenster.Scores[Index].state:= 0;
end;
Result:= Hauptfenster.Scores[Index].state;
end;

function GetState(tarif: string): integer;
begin
Result:= Hauptfenster.Scores[IndexOfScores(tarif)].state;
end;

procedure ResetSuspendScores(tarif: string);
begin
 Hauptfenster.Scores[IndexOfScores(tarif)].gesamt:= 0;
 Hauptfenster.Scores[IndexOfScores(tarif)].erfolgreich:= 0;
end;

procedure extractDate(line: string;var d,m,y: integer);
var temp: string;
begin
//Tag rausholen
temp:= line;
delete(temp,3, length(line));
d:= strtoint(temp);

//Monat rausholen
temp:= line;
delete(temp,1, 3);//tag mit Punkt löschen
delete(temp,3, length(line));
m:= strtoint(temp);

//Jahr rausholen
temp:= line;
delete(temp,1, 6);//alles vor dem Jahr löschen
y:= strtoint(temp);
end;

procedure TaktToInteger(takt: string; var tleft, tright: integer);
var taktstring: string;
begin
//takt_a
  taktstring:= takt;
  Delete(taktstring,pos('/', taktstring),length(taktstring) - pos('/', taktstring) +1);
  try
    tleft:= strtoint(taktstring);
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

procedure Ladetarife;
var sections            : TStringlist;
    i, k                : integer;
    DeleteWhenExpireDate: boolean;
    expDate             : TDate;
    lengthS             : integer;
    zeilen              : TStringlist;
    zeile               : string;
    count               : integer;
    UpdateFile          : boolean;
    dd,mm,yy            : integer;
    temptakt            : string[5];
    Stream              : TFileStream;
    header              : TTarifHeader;
    Datensatz           : TTarif;
begin
 UpdateFile:= false;
 //Rücksetzen des Arrays
 setlength(hauptfenster.tarife,0);

if fileexists(extractfilepath(paramstr(0))+'Tarife.ini') then
begin
 Zeilen:= TStringList.Create;
 zeilen.LoadFromFile(extractfilepath(paramstr(0))+'Tarife.ini');

 count := 0;
 For i:= 0 to zeilen.count-1 do
 begin

  zeile:= zeilen.strings[i];
  dd:=0;
  mm:=0;
  yy:=0;

   if ((zeile='') or (zeile =' ') or ( (zeile[1]='/') and (zeile[2]='/') )) then
   begin
   end
   else
   //neue Section
   if (   (zeile[1]= '[') and (zeile[length(zeile)] =']')  ) then
   begin

      count:= count+1;
      setlength(hauptfenster.tarife, count);

      if ansicontainstext(zeile,'[BonGo') then
        hauptfenster.tarife[count-1].Editor:= 'BonGo'
      else
        hauptfenster.tarife[count-1].Editor:= '';

      with hauptfenster.tarife[count-1] do
       begin
        Tarif         := '';
        Beginn        := EncodeTime(0,0,0,0);
        Ende          := EncodeTime(0,0,0,0);;
        Nummer        := '0';
        Preis         := 0.0;
        Einwahl       := 0.0;
        takt_a        := 60;
        takt_b        := 60;
        User          := '';
        Passwort      := '';
        Webseite      := '';
        Tag           := '';
        eingetragen   := EncodeDate(1970,02,02);
        validfrom     := EncodeDate(1970,02,02);
        expires       := EncodeDate(1970,02,02);
        DeleteWhenExpires:= false;
        Mindestumsatz := 0.0;
      end;
   end
   else
   if ansicontainsstr(zeile,'Tarif=') then
   begin
    delete(zeile,1,6);
    hauptfenster.tarife[count-1].Tarif:= Zeile;//trim(zeile);
   end
   else
   if ansicontainsstr(zeile,'Beginn=') then
   begin
    delete(zeile,1,7);
    hauptfenster.tarife[count-1].Beginn:= StrTotime(zeile);//trim(zeile);
   end
      else
   if ansicontainsstr(zeile,'Ende=') then
   begin
    delete(zeile,1,5);
    hauptfenster.tarife[count-1].Ende:= StrTotime(trim(zeile));
   end
      else
   if ansicontainsstr(zeile,'Nummer=') then
   begin
    delete(zeile,1,7);
    hauptfenster.tarife[count-1].Nummer:= trim(zeile);
   end
   else
   if ansicontainsstr(zeile,'Preis=') then
   begin
    delete(zeile,1,6);
    hauptfenster.tarife[count-1].Preis:= strtofloat(trim(zeile));
   end
   else
   if ansicontainsstr(zeile,'Einwahl=') then
   begin
    delete(zeile,1,8);
    hauptfenster.tarife[count-1].Einwahl:= strtofloat(trim(zeile));
   end
   else
   if ansicontainsstr(zeile,'Takt=') then
   begin
    delete(zeile,1,5);
    TaktToInteger(trim(zeile),hauptfenster.tarife[count-1].Takt_a,hauptfenster.tarife[count-1].Takt_b);
   end
   else
   if ansicontainsstr(zeile,'User=') then
   begin
    delete(zeile,1,5);
    hauptfenster.tarife[count-1].User:= trim(zeile);
   end
      else
   if ansicontainsstr(zeile,'Passwort=') then
   begin
    delete(zeile,1,9);
    hauptfenster.tarife[count-1].Passwort:= trim(zeile);
   end
   else
   if ansicontainsstr(zeile,'Webseite=') then
   begin
    delete(zeile,1,9);
    hauptfenster.tarife[count-1].Webseite:= trim(zeile);;
   end
   else
   if ansicontainsstr(zeile,'Tag=') then
   begin
    delete(zeile,1,4);
    hauptfenster.tarife[count-1].Tag:= trim(zeile);;
   end
   else
   if ansicontainsstr(zeile,'eingetragen=') then
   begin
    delete(zeile,1,12);
    zeile:= trim(zeile);
    ExtractDate(zeile, dd,mm,yy);
    hauptfenster.tarife[count-1].eingetragen:= EncodeDate(yy,mm,dd);
   end
   else
   if ansicontainsstr(zeile,'start=') then
   begin
    delete(zeile,1,6);
    zeile:= trim(zeile);
    ExtractDate(zeile, dd,mm,yy);
    hauptfenster.tarife[count-1].validfrom:=  EncodeDate(yy,mm,dd);
   end
   else
   if ansicontainsstr(zeile,'expires=') then
   begin
    delete(zeile,1,8);
    zeile:= trim(zeile);
    ExtractDate(zeile, dd,mm,yy);
    hauptfenster.tarife[count-1].expires:= EncodeDate(yy,mm,dd);
   end
   else
   if ansicontainsstr(zeile,'DeleteWhenExpires=') then
   begin
    if zeile='DeleteWhenExpires=0' then hauptfenster.tarife[count-1].DeleteWhenExpires:= false
    else hauptfenster.tarife[count-1].DeleteWhenExpires:= true;
   end;
   zeile:= '';
 end;
zeilen.free;
//nach dem Einlesen löschen
DeleteFile(PChar(extractfilepath(paramstr(0))+'Tarife.ini'));
//lcx-Datei schreiben
WriteTarifeToHD;
end
else //lcx nur laden, wenn keine Tarife.ini vorhanden war
if FileExists(extractfilepath(paramstr(0))+'Tarife.lcx') then
begin
  DeCompress(extractfilepath(paramstr(0))+'Tarife.lcx',extractfilepath(paramstr(0))+'Tarife.$$$');

  Stream := TFileStream.Create(extractfilepath(paramstr(0))+'Tarife.$$$' , fmOpenRead ) ;
  count:= 0;
  header.Version:= 0;
  Header.programm:= '';

  Stream.Read(header,sizeof(header));

  if header.programm <> 'LeastCosterXP' then
  begin
    Stream.Position:= 0;
    try
     while Stream.Position < Stream.Size do
      begin
         count:= count+1;
         setlength(hauptfenster.tarife, count);
         Stream.Read( Hauptfenster.tarife[count-1].Tarif , SizeOf( Hauptfenster.tarife[count-1].Tarif ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].Tag , SizeOf( Hauptfenster.tarife[count-1].Tag ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].Nummer , SizeOf( Hauptfenster.tarife[count-1].Nummer ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].User , SizeOf( Hauptfenster.tarife[count-1].User ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].Passwort , SizeOf( Hauptfenster.tarife[count-1].Passwort ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].Editor, SizeOf( Hauptfenster.tarife[count-1].Editor ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].Webseite , SizeOf( Hauptfenster.tarife[count-1].Webseite ) ) ;
         Stream.Read( temptakt , sizeof(temptakt) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].Preis , SizeOf( Hauptfenster.tarife[count-1].Preis ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].Einwahl , SizeOf( Hauptfenster.tarife[count-1].einwahl ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].Beginn , SizeOf( Hauptfenster.tarife[count-1].Beginn ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].ende , SizeOf( Hauptfenster.tarife[count-1].Ende ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].eingetragen , SizeOf( Hauptfenster.tarife[count-1].eingetragen ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].validfrom , SizeOf( Hauptfenster.tarife[count-1].validfrom ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].expires , SizeOf( Hauptfenster.tarife[count-1].expires ) ) ;
         Stream.Read( Hauptfenster.tarife[count-1].DeleteWhenExpires , SizeOf( Hauptfenster.tarife[count-1].DeleteWhenexpires ) ) ;
         TaktToInteger(temptakt,Hauptfenster.tarife[count-1].takt_a,Hauptfenster.tarife[count-1].takt_b);
         Hauptfenster.Tarife[count-1].mindestumsatz:= 0.0;
        Stream.Position:= count * sizeof(Datensatz);
      end;
    finally
      Stream.Free ;
    end ;

   WriteTarifeToHD; //lcx-Datei in neuem Format auf die Platte schreiben schreiben

   end
  else //wenn im Header programm=LeastCosterXP steht : DateiVersion vom Typ TTarif02 mit header
  if header.version = 2 then
  begin
   Stream.Position:= sizeof(header);
    try
     while Stream.Position < Stream.Size do
      begin
         count:= count+1;
         setlength(hauptfenster.tarife, count);
         stream.Read(hauptfenster.tarife[count-1],sizeof(hauptfenster.tarife[count-1]));
      end;
     finally
      Stream.free;
     end;
  end;

  DeleteFile(PChar(extractfilepath(paramstr(0))+'Tarife.$$$'));
end;

//abgelaufene Tarife löschen
for i:= (length(hauptfenster.tarife) -1) downto 0  do
begin
 expDate             := hauptfenster.tarife[i].expires;
 DeleteWhenExpireDate:= hauptfenster.tarife[i].DeleteWhenExpires;

 if (DeleteWhenExpireDate and (expDate < Dateof(now))) then
 begin
   hauptfenster.tarife[i]:=  hauptfenster.tarife[length(hauptfenster.tarife)-1];
   setlength(hauptfenster.tarife,length(hauptfenster.tarife)-1);
   UpdateFile:= true; //File muss neu auf de Platte geschrieben werden
 end
end;

if UpdateFile then WriteTarifeToHD;

//ungültige Kontingente löschen
sections:= TStringlist.create;
SettingsKontingente.ReadSections(sections);
for k:= 0 to sections.count-1 do
for i:= 0 to length(hauptfenster.tarife) -1 do
begin
 if sections.strings[k] = hauptfenster.tarife[i].tarif then break
 else
 begin
  if (i = length(hauptfenster.tarife) -1) then
   if sections.strings[k] <> hauptfenster.tarife[i].tarif then SettingsKontingente.EraseSection(sections.strings[k]);
 end;
end;
sections.free;

//ungültige Traffic - Zähler löschen
sections:= TStringlist.create;
SettingsTraffic.ReadSections(sections);
for k:= 0 to sections.count-1 do
for i:= 0 to length(hauptfenster.tarife) -1 do
begin
 if sections.strings[k] = hauptfenster.tarife[i].tarif then break
 else
 begin
  if (i = length(hauptfenster.tarife) -1) then
   if sections.strings[k] <> hauptfenster.tarife[i].tarif then SettingsTraffic.EraseSection(sections.strings[k]);
 end;
end;


sections.free;

//Scores einlesen
setlength(Hauptfenster.Scores, 0);
lengthS:= 0;
with Hauptfenster do
 for i:= 0 to length(tarife)-1 do
 begin
  if not InScores(tarife[i].Tarif) then
  begin
   inc(lengthS);
   setlength(Scores, lengthS);
   Scores[lengthS-1].Name       := tarife[i].Tarif;
   Scores[lengthS-1].gesamt     := SettingsScores.ReadInteger(Scores[lengthS-1].Name,'DialedAll',0);
   Scores[lengthS-1].erfolgreich:= SettingsScores.ReadInteger(Scores[lengthS-1].Name,'Dialed',0);
   Scores[lengthS-1].state      := SettingsScores.ReadInteger(Scores[lengthS-1].Name,'State',0);
   Scores[lengthS-1].Color      := SettingsScores.ReadString(Scores[lengthS-1].Name,'Color','none');
  end;
 end;

end;

Procedure ClearList;
begin
  with hauptfenster.liste do
  begin
    rows[1].Clear;
    rowcount:= 2;

    Cells[1,0] := misc(M140,'M140');
    Cells[2,0] := misc(M165,'M165');
    Cells[3,0] := misc(M166,'M166');
    Cells[4,0] := misc(M167,'M167');
    Cells[5,0] := misc(M168,'M168');
    Cells[6,0] := misc(M169,'M169');
    Cells[7,0] := misc(M50,'M50');
    Cells[8,0] := misc(M170,'M170');
    Cells[9,0] := misc(M171,'M171');
    Cells[10,0]:= misc(M172,'M172');
    Cells[11,0]:= misc(M173,'M173');
    Cells[12,0]:= misc(M174,'M174');
    Cells[13,0]:= misc(M175,'M175');
    Cells[14,0]:= misc(M176,'M176');
    Cells[15,0]:= misc(M266,'M266');
    Cells[16,0]:= misc(M267,'M267');
    Cells[17,0]:= misc(M265,'M265');
    Cells[18,0]:= misc(M268,'M268');
  end;
end;

procedure LoadList;
var daystring, tomorrowstring: string;
    today, tomorrow: word;
    i, rows: integer;
    preis, einwahl: real;
    feiercheck: string;
    gueltig: boolean;
    tarifzeit: TDateTime;
    setdauer, lookforward: integer;
    TarifBeginn, TarifEnde: TDateTime;
begin

  lookforward:= hauptfenster.lookforward;
  ClearList; //Tarifliste löschen

  rows:=0;

  if not isonline then
  begin
    tarifzeit:= now;
    setdauer:= hauptfenster.surfdauer.position;
  end
  else
  begin
    tarifzeit:= incminute(now,lookforward);
    setdauer:= 1;
  end;

  if hauptfenster.beliebig_check.Checked then tarifzeit:= Dateof(hauptfenster.beliebig_date.DateTime) + timeof(hauptfenster.beliebig_time.Datetime);

  today:=dayoftheweek(Dateof(tarifzeit));
  tomorrow:=dayoftheweek(Dateof(incday(tarifzeit,1)));

  case today of
    1: daystring:= '[Mo]';
    2: daystring:= '[Di]';
    3: daystring:= '[Mi]';
    4: daystring:= '[Do]';
    5: daystring:= '[Fr]';
    6: daystring:= '[Sa]';
    7: daystring:= '[So]';
  end;

  case tomorrow of
    1: tomorrowstring:= '[Mo]';
    2: tomorrowstring:= '[Di]';
    3: tomorrowstring:= '[Mi]';
    4: tomorrowstring:= '[Do]';
    5: tomorrowstring:= '[Fr]';
    6: tomorrowstring:= '[Sa]';
    7: tomorrowstring:= '[So]';
  end;

  //heute feiertag ?
  feiercheck:= isFeiertag(Dateof(tarifzeit));
  if feiercheck<>'' then
  begin
    daystring:= '[feiertags]';
    hauptfenster.DateLabel.Caption:= '['+feiercheck + '] ' + datetimetostr(tarifzeit);
  end
  else
  hauptfenster.datelabel.Caption:= Daystring + ' ' + datetimetostr(tarifzeit);

  hauptfenster.DateLabel.refresh;
  hauptfenster.timeofliste:= tarifzeit;

  feiercheck:='';
  //morgen feiertag ?
  feiercheck:= isFeiertag(Dateof(incday(tarifzeit,1)));
  if feiercheck<>'' then tomorrowstring:= '[feiertags]';

  for i:= 0 to length(hauptfenster.tarife)-1 do
  begin
    gueltig:= false;

    Tarifbeginn := dateof(tarifzeit) + timeof(hauptfenster.tarife[i].Beginn);
    Tarifende   := dateof(tarifzeit) + timeof(hauptfenster.tarife[i].Ende);

   //Bedingungen, damit der Tarif angezeigt wird
   //a) Anfang der Gültigkeit
     if hauptfenster.tarife[i].validfrom > dateof(tarifzeit) then continue;
   //b) Einwahlgebühr ?
     if ((hauptfenster.tarife[i].Einwahl > 0.0) and (not hauptfenster.ConnectionCostVisible)) then continue;

     //wenn der Tag gültig ist
     if ansicontainsstr(hauptfenster.tarife[i].tag,daystring) then
     begin
        //wenn datumsgrenze überchritten wird
        if (dateof(tarifzeit)<>dateof(incminute(tarifzeit,setdauer))) then
        begin
             //wenn Tarif ganztägig
              if ( TarifEnde = TarifBeginn )
                and (ansicontainsstr(hauptfenster.tarife[i].Tag,tomorrowstring))
                  then gueltig:= true;

            //wenn Tarif die Datumsgrenze überschreitet
              if  ( TarifBeginn < tarifzeit ) then
                if ( ansicontainsstr(hauptfenster.tarife[i].tag,tomorrowstring) ) then
                  if  ( TarifBeginn > TarifEnde ) then
                    if  ( dateof(incday(tarifzeit,1)) + timeof(hauptfenster.tarife[i].Ende)) >(incminute(tarifzeit,setdauer))
                      then gueltig:= true;

        end
         else //wenn am selben Tag | Datumsgrenze wird nicht überschritten
         begin
           //Tarifende ist am selben tag   | ende >= beginn
            if ( TarifEnde >= TarifBeginn) then
                begin
                  if( ( (TarifBeginn < tarifzeit)
                    and (incminute(tarifzeit,setdauer) < TarifEnde ))
                   //oder wenn ganztags
                     or ( TarifBeginn = TarifEnde ) )
                      then gueltig:= true;
                end
               else //das ende des Tarifs ist an anderem Tag als Beginn| wenn ende < beginn
               begin
                    if ( (TarifBeginn  <= tarifzeit)
                      or (TarifEnde > (incminute(tarifzeit,setdauer) ) ))
                        then gueltig:= true;
               end;
         end;
     end; //Ende von if ansicontains(tarif, daystring) ...

    //hinzufügen
    if gueltig then loadlistaddline(rows,i,Einwahl,Preis, tarifzeit, setdauer);
    end;  //Ende der For-Schleife

if not hauptfenster.beliebig_check.checked then
 Sort(hauptfenster.liste,hauptfenster.tarifprogress,7,1,hauptfenster.liste.RowCount, true, false);

//Markierung der Tabelle
setlength(hauptfenster.Selected, hauptfenster.Liste.RowCount);
for i:= 1 to length(hauptfenster.selected)-1 do hauptfenster.Selected[i]:= false;

//erstes Element auswählen
hauptfenster.liste.Row:=1;
hauptfenster.listeclick(nil);

//Wechselmeldung
if not hauptfenster.NoChangeWarning.checked then
   if (isonline and (not hauptfenster.warnung_gezeigt)) then
   if hauptfenster.selfdial and not hauptfenster.beliebig_check.checked then
   if (minuteof(now) = (59-lookforward+1)) then watchoutforcheaperprice(tarifzeit);
end;


procedure LoadListaddline(var rows:integer;i: integer; var Einwahl,Preis: real; timeofdisplay: TDatetime; thisdauer: integer);
var k, FreiSekunden, index           : integer;
    Dials, DialAll, state, ScoreIndex: integer;
    tarif                            : string;
    score, score2                    : real;
    AutoBlacklist, AutoBlacklistScore: integer;
    UseAutoBlacklist                 : Boolean;
    mindest                          : real;
    kosten_mind                      : real;
begin
 UseAutoBlacklist   := settings.ReadBool('AutoBlacklist','active',false);
 AutoBlackList      := settings.Readinteger('AutoBlacklist','Value',10);
 AutoBlackListScore := settings.Readinteger('AutoBlacklist','Score',50);

with hauptfenster do
begin
  rows := rows+1;

  liste.Cells[1,rows]  := tarife[i].Tarif;
  liste.Cells[2,rows]  := TimeToStr(tarife[i].Beginn);
  liste.Cells[3,rows]  := TimeToStr(tarife[i].Ende);
  liste.Cells[4,rows]  := Format('%.2f',[tarife[i].Preis]);
  liste.Cells[5,rows]  := Format('%.2f',[tarife[i].Einwahl]);
  liste.Cells[6,rows]  := Format('%d/%d',[tarife[i].Takt_a,tarife[i].Takt_b]);

  liste.Cells[8,rows]  := tarife[i].Nummer;
  liste.Cells[9,rows]  := tarife[i].User;
  liste.Cells[10,rows] := tarife[i].Passwort;
  liste.Cells[11,rows] := tarife[i].Webseite;
  liste.Cells[12,rows] := DateToStr(tarife[i].validfrom);
  liste.Cells[13,rows] := DateToStr(tarife[i].expires);
  liste.Cells[14,rows] := DateToStr(tarife[i].eingetragen);

  tarif                := tarife[i].Tarif;
  getScores(tarif, DialAll, Dials, state, ScoreIndex);
  liste.cells[15,rows] := inttostr(DialAll);{gesamversuche}
  liste.cells[16,rows] := inttostr(Dials); {erfolgreiche}
  liste.Cells[17, rows]:= tarife[i].Tag;
  liste.Cells[18, rows]:= Format('%.2f',[tarife[i].Mindestumsatz]);

  if (DialAll> 0) then score := 1.- dials/DialAll
                  else score := 1.;

  if (Dials > 0) then Score2:= 1./Dials else Score2:= 1.;

//AutoBlackliste
  if useAutoBlackList then
    if ((DialAll - Dials > AutoBlacklist) and (Score*100 > AutoBlacklistScore)) then hauptfenster.Scores[ScoreIndex].state:= 1;

//Scores eintragen
  liste.Cells[0, rows] :=  Format('%.4f',[score+ Score2]);

  index:= -1;
  if length(Kontingente) > 0 then
              for k:= 0 to (length(Kontingente)-1) do
                if kontingente[k].Tarif = tarif then
                 begin index:= k; break; end;

  if index > -1 then Freisekunden:= kontingente[index].FreiSekunden
   else FreiSekunden := 0;

  if Freisekunden < 0 then Freisekunden:= 0;

  //wenn nicht abgelaufen
  if strtodate(liste.cells[13,rows]) >= dateof(timeofdisplay) then
           begin
            if not (liste.cells[4,rows]= '') then
            try
             preis:= strtofloat(liste.Cells[4,Rows]);
             Einwahl:= strtofloat(liste.Cells[5,Rows]);
             Mindest:= strtofloat(liste.Cells[18,Rows]);

             kosten_mind:= thisdauer * preis;
             if Mindest > kosten_mind then kosten_mind:= mindest; //Mindestumsätze berücksichtigen

             //Blacklist
             if state = 1 then liste.Cells[7,rows]:= 'Blacklist'
             else
             //es gibt nocht FreiKB
             if ((length(kontingente) > 0) and (index > -1) and (kontingente[index].FreikB > 0)) then liste.cells[7,rows]:= Format('%.4f',[1/100 *(Einwahl + kosten_mind)])
             else
             //normale Kosten berechnen
             if Freisekunden <= 0 then
                    liste.Cells[7,rows] := Format('%.4f',[1/100 *(Einwahl+ + kosten_mind)])
                   else // Freisekunden reichen dicke
                    if ((thisdauer*60) < Freisekunden) then liste.cells[7,rows]:= Format('%.4f',[0.])// Format('%.4f (%.4f)',[0., score+ Score2])
                     else //Freisekunden reichen nur teilweise und Volumen reicht nicht
                      if (thisdauer*60) >= Freisekunden then liste.Cells[7,rows] :=Format('%.4f',[1/100 *((Einwahl + thisdauer * preis)- (Freisekunden/60 * preis) )])
            except
             preis:= 0;
             einwahl:= 0;
            end;
            end //wen ablaufdatum erreicht
            else
            begin
             //Blacklist vor Ablauf markieren
             if state = 1 then liste.Cells[7,rows]:= 'Blacklist'
             else //abglaufen
              liste.Cells[7,rows]:= misc(M98,'M98');
            end;
            if rows>1 then liste.RowCount:= liste.rowcount+1;
end;
end;


function CheckOnlineset: boolean;
var i: integer;
begin
result:= false;
with hauptfenster do
for i:= 0 to length(tarife)-1 do
begin
 if ( //nur true, wenn ergebnis positiv
    (onlineset.Tarif = tarife[i].Tarif)
  and
    (onlineset.vbegin = tarife[i].Beginn)
  and
    (onlineset.vend = tarife[i].Ende)
  and
    (onlineset.Rufnummer = tarife[i].Nummer)
  and
    (onlineset.Preis = tarife[i].Preis)
  and
    (onlineset.Einwahl = tarife[i].Einwahl)
    )
  then begin result:= true; exit; end;
end;

end;

//liefert den Feiertag oder einen leeren String zurück
function isFeiertag(date: TDate): string;
var i: integer;
    temp: string;
begin
  temp:= '';

  if length(holidaylist) >0 then
  for i:= 0 to length(holidaylist)-1 do
    if date = holidaylist[i].date then
    begin
     temp:= holidaylist[i].name;
     break;
    end;

  Result:= temp;
end;

procedure LoescheTarif(tarif: string);
var i: integer;
    Deletelist: TStringlist;
begin
DeleteList:= TStringList.Create;

for i := hauptfenster.liste.RowCount-1 downto 1   do
     if (hauptfenster.Selected[i]) then begin Deletelist.Add(hauptfenster.Liste.Cells[1,i]);  end;

// in der Datenbank löschen
with Hauptfenster do
for i:= length(Tarife)-1 downto 0 do
if (Deletelist.IndexOf(Tarife[i].Tarif) > -1) then
begin
  tarife[i] := Tarife[length(tarife) -1]; //letzten Datensatz an stelle
  setlength(tarife, length(tarife)-1); //um eine Stelle kürzen
end;

WriteTarifeToHD;

hauptfenster.aktualisierenclick(nil);
end;


procedure LoescheAbgelaufeneTarife;
var  vgldate: TDate;
    i: integer;
begin
//in der Datenbank löschen
for i:= length(hauptfenster.tarife)-1 downto 0 do
begin
 vgldate:= hauptfenster.tarife[i].expires;
 if vgldate < dateof(now) then
  begin
   hauptfenster.tarife[i] := hauptfenster.Tarife[length(hauptfenster.tarife) -1]; //letzten Datensatz an stelle
   setlength(hauptfenster.tarife, length(hauptfenster.tarife)-1); //um eine Stelle kürzen
  end;
end;

WriteTarifeToHD;
end;

procedure SaveTrafficData(Data: OnlineWerte);
var bisher_gesurft, bisher_takt: Longint;
    bisher_down, bisher_up: double;
begin
 if Data.tarif ='' then exit; //keine Daten ?!?

 bisher_gesurft:= SettingsTraffic.ReadInteger(Data.Tarif,'Surfdauer',0);
 bisher_takt:= SettingsTraffic.ReadInteger(Data.Tarif,'Surfdauer_Takt',0);
 bisher_up:= SettingsTraffic.ReadFloat(Data.Tarif,'Upload',0);
 bisher_down:= SettingsTraffic.ReadFloat(Data.Tarif,'Download',0);

 //start des Zählers setzen
 if bisher_gesurft = 0 then SettingsTraffic.WriteDateTime(Data.Tarif,'seit', now);

 SettingsTraffic.WriteInteger(Data.Tarif,'Surfdauer',Data.gesamtdauer + bisher_gesurft); //in sekunden
 SettingsTraffic.WriteInteger(Data.Tarif,'Surfdauer_Takt',Data.dauer_takt + bisher_takt); //in sekunden
 SettingsTraffic.WriteFloat(Data.Tarif,'Download', Data.download/1024 + bisher_down);     //in kB
 SettingsTraffic.WriteFloat(Data.Tarif,'Upload', Data.upload/1024 + bisher_up);           //in kB

 //csv und html logs updaten sowie die Tagesstatistik
  Protokolle.CreateAllLogs;
  Protokolle.WebAuswertungErstellen;
end;

procedure Kontingente_Laden;
var Date: TDate;
    kontis: TStringlist;
    i: integer;
begin
with Hauptfenster do begin
   setlength(kontingente,0);
 //Kontingente
   kontis:= TStringList.Create;
   SettingsKontingente.ReadSections(kontis);
   setlength(kontingente, kontis.count);
   if kontis.count > 0 then
   for i:= 0 to kontis.count -1 do
   begin
    kontingente[i].freisekunden:= 0;
    kontingente[i].Tarif:= kontis.strings[i];
    kontingente[i].FreiSekunden := 60*60 * SettingsKontingente.ReadInteger(kontis.strings[i],'Freistunden',0) + 60* SettingsKontingente.ReadInteger(kontis.strings[i],'Freiminuten',0);
    kontingente[i].NextReset    := SettingsKontingente.ReadDate(kontis.strings[i],'NextReset',Dateof(now));
    kontingente[i].ResetTag     := SettingsKontingente.ReadInteger(kontis.strings[i],'Tag',1);
    kontingente[i].FreikB       := SettingsKontingente.ReadFloat(kontis.strings[i],'Freivolumen',0);
    kontingente[i].MB_both      := SettingsKontingente.ReadBool(kontis.strings[i],'FreivolumenBoth',true);


    kontingente[i].LastReset   := dateof(SettingsTraffic.ReadDateTime(kontis.strings[i],'seit',incmonth(now,-1) ) );
    //wenn Reset gemacht werden muss
    if (Dateof(now) >= kontingente[i].Nextreset) then
    begin
     if ((kontingente[i].FreiSekunden <> 0) or (kontingente[i].FreikB <> 0 )) then  SettingsTraffic.EraseSection(kontis.strings[i]);
      tag:= kontingente[i].ResetTag;
      date:= incmonth(dateof(now),1);
      Repeat
      if IsValidDate(yearof(date),monthof(date),tag)
       then date:= encodeDate(yearof(date),monthof(date),tag)
       else
       begin
        tag:= tag-1;
        if IsValidDate(yearof(date),monthof(date),tag)
          then date:= encodeDate(yearof(date),monthof(date),tag)
       end;
      until IsValidDate(yearof(date),monthof(date),tag);
      SettingsKontingente.WriteDate(kontis.strings[i],'NextReset',date);
    end
    else //wenn alte Daten noch gültig (nächster Reste liegt in der Zukunft
    begin
         kontingente[i].FreiSekunden:= kontingente[i].FreiSekunden -  SettingsTraffic.ReadInteger(kontis.strings[i],'Surfdauer_takt',0);
         kontingente[i].FreikB:= kontingente[i].FreikB -  SettingsTraffic.ReadFloat(kontis.strings[i],'Download',0);
         if kontingente[i].MB_both then kontingente[i].FreikB:= kontingente[i].FreikB -  SettingsTraffic.ReadFloat(kontis.strings[i],'Upload',0);
         if kontingente[i].freisekunden < 0 then kontingente[i].freisekunden:= 0;
    end;
   end;
   kontis.free;
 end;
end;

procedure ResetExpireDate(Tarif: String;Datum: TDate);
var i: integer;
    changelist: TStringlist;
begin
 changelist:= TStringlist.Create;

 for i:= 1 to length(hauptfenster.selected) -1 do
  if hauptfenster.selected[i] then changelist.Add(hauptfenster.Liste.Cells[1,i]);

 //im speicher ändern
 with hauptfenster do
 for i:= 0 to length(hauptfenster.tarife) -1 do
 if  (changelist.IndexOf(Tarife[i].Tarif) <> -1) then
 begin
  Tarife[i].expires:= Datum;
  if Datum > Dateof(now) then
   Tarife[i].validfrom:= Dateof(now); //gültig ab ist dann heute
 end;

 changelist.free;
 WriteTarifeToHD;
 hauptfenster.aktualisierenclick(nil);
end;

procedure Tarifwechseln;
begin
     onlineset.preis:= onlineset.wechselpreis;
     onlineset.einwahl:= onlineset.wechseleinwahl;
     onlineset.einwahl2:= onlineset.wechseleinwahl;
     onlineset.wechselpreis:= 0;
     onlineset.wechseleinwahl:= 0;
     onlineset.wechsel:= incday(onlineset.wechsel, 10*365); //10 Jahre in die Zukunft setzen, damit das nciht gleich wieder ausgelöst wird
     if assigned(floatingW) then
     begin
      if (onlineset.vbegin=onlineset.vend) then hauptfenster.edtime.text:=misc(M111,'M111')
       else hauptfenster.edtime.text:= TimeToStr(onlineset.vbegin) +'-'+TimeToStr(onlineset.vend);
      floatingW.valid.caption:= hauptfenster.edtime.text;
      floatingW.preis.caption:= Format('%.2f '+misc(M12,'M12')+'/min',[onlineset.preis]);
     end;

end;

function computecosts(Kanalbuendelung: boolean): boolean;
begin

 if (onlineset.wechsel <= now) then //Tariffenster wechselt
  Tarifwechseln;

 //wenn der preis unbekannt ist, dann negativ, dann aber Fehler melden
 if (onlineset.preis < 0) then
 begin
      result:= false;
      exit;
 end
 else result:= true;

 //getaktete Surfdauer berechnen
 if ((hauptfenster.takt1.Tag > (dauer mod taktlaenge)) //dann hat neuer Takt begonnen
     or (taktlaenge = 1                    ))
     then onlineset.dauer_takt:= onlineset.dauer_takt +  taktlaenge;

if Kanalbuendelung then
 if ( (hauptfenster.takt2.Tag > (dauer2 mod taktlaenge)) //dann hat neuer Takt begonnen (2. Kanal)
     or (taktlaenge = 1                    ))
     then onlineset.dauer_takt:= onlineset.dauer_takt +  taktlaenge;

//wenn noch Volumenkontingente vorhanden, dann abbrechen .. keine Kosten berechnen
 if ((length(kontingente) > 0) and (kontingente[kontingentindex].freikb > 0) and (kontingentindex > -1))
 then begin result:= true; exit; end;

 //aktuelle Freisekundenanzahl ermitteln -> wichtig: nachdem auf Volumenkontingente geprüft wurde
 if ((length(kontingente) > 0) and (kontingentindex > -1) and (kontingente[kontingentindex].Freisekunden > 0)) then
 begin
   if ((hauptfenster.takt1.Tag > (dauer mod taktlaenge)) //dann hat neuer Takt begonnen
     or (taktlaenge = 1                    ))  then
       kontingente[kontingentindex].Freisekunden:= kontingente[kontingentindex].Freisekunden - taktlaenge;

   if Kanalbuendelung then
    if ( (hauptfenster.takt2.Tag > (dauer2 mod taktlaenge)) //dann hat neuer Takt begonnen (2. Kanal)
     or (taktlaenge = 1                    ))  then
       kontingente[kontingentindex].Freisekunden:= kontingente[kontingentindex].Freisekunden - taktlaenge;

    //diese Funktion beenden, wenn keine Kosten berechnet werden müssen
    if (kontingente[kontingentindex].Freisekunden > 0) then
    begin
      result:= true;
      hauptfenster.Takt1.Tag := dauer mod Taktlaenge; //alten Wert merken damit Taktberechnung funtioniert !!!
      hauptfenster.Takt2.Tag := dauer2 mod Taktlaenge;
      exit;
    end
    else kontingente[kontingentindex].Freisekunden:= 0;
 end;

 if ((hauptfenster.takt1.Tag > (dauer mod taktlaenge)) //dann hat neuer Takt begonnen
   or (taktlaenge = 1                   )) then
   begin

     if (onlineset.mindestumsatz > 0.0) then
      begin
       onlineset.kosten_mindest:= onlineset.kosten_mindest + onlineset.Preis/60/100 * taktlaenge;
       if (onlineset.kosten_mindest > onlineset.mindestumsatz)
           then onlineset.kosten:= onlineset.kosten + onlineset.Preis/60/100 * taktlaenge;
      end
      else
       onlineset.kosten:= onlineset.kosten + onlineset.Preis/60/100 * taktlaenge;

   end;
     //alten Wert merken
   hauptfenster.Takt1.Tag:= dauer mod Taktlaenge;

 if Kanalbuendelung then
 if ( (hauptfenster.takt2.Tag > (dauer2 mod taktlaenge)) //dann hat neuer Takt begonnen (2. Kanal)
     or (taktlaenge = 1                    ))  then
     begin
       if (onlineset.mindestumsatz > 0.0) then
       begin
        onlineset.kosten_mindest:= onlineset.kosten_mindest + onlineset.Preis/60/100 * taktlaenge;
        if (onlineset.kosten_mindest > onlineset.mindestumsatz)
            then onlineset.kosten:= onlineset.kosten + onlineset.Preis/60/100 * taktlaenge;
       end
       else
       onlineset.kosten:= onlineset.kosten + onlineset.Preis/60/100 * taktlaenge;
     end;
     //alten Wert merken
   hauptfenster.Takt2.Tag:= dauer2 mod Taktlaenge;

end;

procedure WriteTarifeToHD;
var fName,cName: string;
    i: integer;
    header: TTarifHeader;
    stream: TFileStream;
begin

  header.programm:= 'LeastCosterXP';
  header.datum:= now;
  header.Version:= 2;

  fName:= ExtractfilePath(paramstr(0)) + 'Tarife.$$$';
  cName:= ExtractfilePath(paramstr(0)) + 'Tarife.lcx';

  Stream := TFileStream.Create(fname , fmCreate) ;

  Stream.write(header, sizeof(header));
  for i:= 0 to length(hauptfenster.tarife)-1 do
    Stream.write(Hauptfenster.tarife[i], sizeof(hauptfenster.tarife[i]));
  Stream.free;

  Compress(fName, cName);
  DeleteFile(PChar(fName));

end;

Procedure LoadAutoDialTimes;
var f: file of TAutoDial;
    n: string;
    d: TAutoDial;
    count: integer;
begin
n:= extractfilepath(paramstr(0))+'AutoDial.dat';
if FileExists(n) then
begin
  assignfile(f,n);
  reset(f);
  count:= 0;
  while not EOF(f) do
  begin
    read(f, d);
    count:= count+1;
    setlength(Hauptfenster.AutoDialTimes, count);
    Hauptfenster.AutoDialTimes[count-1]:= d;
  end;
  closefile(f);
end;
end;

procedure SaveAutoDialTimes;
var n: string;
    i: integer;
    f: file of TAutoDial;
begin
  N:= ExtractfilePath(paramstr(0)) + 'AutoDial.dat';

  assignfile(f,n);
  rewrite(f);

  for i:= 0 to length(Hauptfenster.AutodialTimes)-1 do
   write(f,hauptfenster.AutoDialTimes[i]);

  closefile(f);
end;

end.
