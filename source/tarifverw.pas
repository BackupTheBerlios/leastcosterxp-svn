unit tarifverw;

interface
uses grids,controls, GridEvents, floating, files;

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
procedure SaveTrafficData(Tarif: string; Dauer: Integer; download, upload: longint);
procedure Kontingente_Laden;
procedure ResetExpireDate(Tarif: String;Datum: TDate);

function computecosts(Kanalbuendelung: boolean): boolean;

procedure WriteTarifeToHD;

implementation

uses unit1, inifiles, classes, sysutils, Strutils,Dateutils, forms, unit7, windows, dialogs;

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

  if not (liste.cells[1,1] ='') then
  begin
   if (onlineset.preis <> -1.0) then price_now:= onlineset.Preis
                            else price_now:= -1.0;
   price_then:= strtofloat(liste.cells[4,1]);

   thisprice_then   := 'unbekannt';
   thiseinwahl_then := 'unbekannt';
   thisprice_when:= liste.cells[2,1];
   
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

   if (price_then > price_now) then
   begin
     Application.CreateForm(TPriceWarning, PriceWarning);
     PriceWarning.warn.Caption:= 'Jetzt wird''s teurer. Ab ' + liste.cells[2,1]+' ist der billigste Tarif '''+ UpperCase(liste.cells[1,1])+''' . Er kostet '+liste.cells[4,1]+'( +'+liste.cells[5,1]+ ') pro Minute.';
//     PriceWarning.info.Caption:= 'Sie sind online mit  ' + onlineset.Tarif +'(' + onlineset.Preis +', ' +onlineset.vbegin +'-'+onlineset.vend +')';
     PriceWarning.info.Caption:= Format('Sie sind online mit %s (%f , %s - %s) ',[onlineset.Tarif ,onlineset.Preis ,timetoStr(onlineset.vbegin) ,timeToStr(onlineset.vend)]);;

     PriceWarning.info2.Caption:= 'Der Preis ab  ' + thisprice_when + ' ist ' + thisprice_then +'.';
     Pricewarning.trennen2.Caption:= 'Um ' + TimeToStr(onlineset.vend) + ' trennen';
     Pricewarning.Timer1.enabled:= true;
     Pricewarning.Show;
     SetWindowPos(pricewarning.handle,hwnd_topmost,pricewarning.left,pricewarning.Top,pricewarning.Width,pricewarning.Height,{swp_noactivate+swp_nomove+}swp_nosize);
     onlineset.wechsel:= dateof(checktime) + onlineset.vend;
     if thisprice_then <> 'unbekannt' then
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
     Application.CreateForm(TPriceWarning, PriceWarning);
     PriceWarning.warn.Caption:= 'Ab ' + liste.cells[2,1]+' steht der Tarif '''+ UpperCase(liste.cells[1,1])+''' zur Verfügung. Er kostet '+liste.cells[4,1]+'( +'+liste.cells[5,1]+ ') pro Minute.';
//     PriceWarning.info.Caption:= 'Sie sind online mit  ' + onlineset.Tarif +'('+onlineset.Preis +', ' +onlineset.vbegin +'-'+onlineset.vEnd +')';
     PriceWarning.info.Caption:= Format('Sie sind online mit %s (%f , %s - %s) ',[onlineset.Tarif ,onlineset.Preis ,timetoStr(onlineset.vbegin) ,timeToStr(onlineset.vend)]);;
     PriceWarning.info2.Caption:= 'Der Preis ab  ' + thisprice_when  + ' ist ' + thisprice_then +'.';
     Pricewarning.trennen2.Caption:= 'Um ' + TimeToStr(onlineset.vend) + ' trennen';
     Pricewarning.Timer1.enabled:= true;
     Pricewarning.Show;
     SetWindowPos(pricewarning.handle,hwnd_topmost,pricewarning.left,pricewarning.Top,pricewarning.Width,pricewarning.Height,{swp_noactivate+swp_nomove+}swp_nosize);
     if onlineset.vend <> onlineset.vbegin then //nur wenn nicht ganztags
     onlineset.wechsel:= dateof(checktime) + onlineset.vend;
     if thisprice_then <> 'unbekannt' then
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
   if (thisprice_then = 'unbekannt') then
   begin
     Application.CreateForm(TPriceWarning, PriceWarning);
     PriceWarning.warn.Caption:= 'Ab ' + liste.cells[2,1]+' steht der Tarif '''+ UpperCase(liste.cells[1,1])+''' zur Verfügung. Er kostet '+liste.cells[4,1]+'( +'+liste.cells[5,1]+ ') pro Minute.';
//     PriceWarning.info.Caption:= 'Sie sind online mit  ' + onlineset.Tarif +'('+onlineset.Preis +', ' +onlineset.vbegin +'-'+onlineset.vEnd +')';
     PriceWarning.info.Caption:= Format('Sie sind online mit %s (%f , %s - %s) ',[onlineset.Tarif ,onlineset.Preis ,timetoStr(onlineset.vbegin) ,timeToStr(onlineset.vend)]);;
     PriceWarning.info2.Caption:= 'Der Preis ab  ' + thisprice_when  + ' ist ' + thisprice_then +'.';
     Pricewarning.trennen2.Caption:= 'Um ' + TimeToStr(onlineset.vend) + ' trennen';
     Pricewarning.Timer1.enabled:= true;
     Pricewarning.Show;
     SetWindowPos(pricewarning.handle,hwnd_topmost,pricewarning.left,pricewarning.Top,pricewarning.Width,pricewarning.Height,{swp_noactivate+swp_nomove+}swp_nosize);

     onlineset.tag  := liste.cells[17,i];

     if onlineset.vend <> onlineset.vbegin then //nur wenn nicht ganztags
     onlineset.wechsel:= dateof(checktime) + onlineset.vend;
   end;
 end
  else //erste Zeile ist leer
  begin
    Application.CreateForm(TPriceWarning, PriceWarning);
    PriceWarning.warn.Caption:= 'Es ist kein Tarif bekannt, der nach ' + TimeToStr(onlineset.endzeit)+'gilt !';
//    PriceWarning.info.Caption:= 'Sie sind online mit  ' + onlineset.Tarif +'('+onlineset.Preis +', ' +onlineset.vbegin +'-'+onlineset.vEnd +')';
    PriceWarning.info.Caption:= Format('Sie sind online mit %s (%f , %s - %s) ',[onlineset.Tarif ,onlineset.Preis ,timetoStr(onlineset.vbegin) ,timeToStr(onlineset.vend)]);;
    PriceWarning.info2.Caption:= '';
    Pricewarning.trennen2.Caption:= 'Um ' + TimeToStr(onlineset.vend) + ' trennen';
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

procedure Ladetarife;
var sections: TStringlist;
    i, k: integer;
    DeleteWhenExpireDate: boolean;
    expDate: TDate;
    lengthS: integer;
    zeilen: TStringlist;
    zeile: string;
    count: integer;
    UpdateFile: boolean;
    dd,mm,yy: integer;
    Datei: file of Ttarif;
    DatenSatz: TTarif;
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
      delete(zeile,1,1);
      delete(zeile,length(zeile),1);

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
        Takt          := '60/60';
        User          := '';
        Passwort      := '';
        Webseite      := '';
        Tag           := '';
        eingetragen   := EncodeDate(1970,02,02);
        validfrom     := EncodeDate(1970,02,02);
        expires       := EncodeDate(1970,02,02);
        DeleteWhenExpires:= false;
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
    hauptfenster.tarife[count-1].Takt:= trim(zeile);
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
  assignfile(Datei,extractfilepath(paramstr(0))+'Tarife.$$$');
  reset(datei);
  count:= 0;
  while not EOF(Datei) do
  begin
    read(Datei, DatenSatz);
    count:= count+1;
    setlength(hauptfenster.tarife, count);
    Hauptfenster.tarife[count-1]:= DatenSatz;
  end;
  closefile(datei);
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

procedure LoadList;
var daystring, tomorrowstring: string;
    today, tomorrow: word;
    i, rows: integer;
    preis, einwahl: real;
    feiercheck: string;
    check1, check2: boolean;
    tarifzeit: TDateTime;
    setdauer, lookforward: integer;
begin

lookforward:= hauptfenster.lookforward;

//with hauptfenster do
begin

hauptfenster.liste.rows[1].Clear;
hauptfenster.liste.rowcount:= 2;
if hauptfenster.german then
begin
hauptfenster.liste.Cells[1,0] := 'Tarif';
hauptfenster.liste.Cells[2,0] := 'Beginn';
hauptfenster.liste.Cells[3,0] := 'Ende';
hauptfenster.liste.Cells[4,0] := 'Preis';
hauptfenster.liste.Cells[5,0] := 'Einwahl';
hauptfenster.liste.Cells[6,0] := 'Takt';
hauptfenster.liste.Cells[7,0] := 'Kosten';
hauptfenster.liste.Cells[8,0] := 'Nummer';
hauptfenster.liste.Cells[9,0] := 'User';
hauptfenster.liste.Cells[10,0] := 'Passwort';
hauptfenster.liste.Cells[11,0] := 'Webseite';
hauptfenster.liste.Cells[12,0] := 'gilt seit';
hauptfenster.liste.Cells[13,0] := 'gilt bis';
hauptfenster.liste.Cells[14,0] := 'eingetragen';
hauptfenster.liste.Cells[15,0] := 'Score (alle)';
hauptfenster.liste.Cells[16,0] := 'Score (ok)';
hauptfenster.liste.Cells[17,0] := 'Tag';
end;
rows:=0;

if not hauptfenster.isonline then
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

for i:= 0 to length(hauptfenster.tarife)-1 {sections.Count-1} do
begin
check1:= false;
check2:= false;
//Bedingungen, damit der Tarif angezeigt wird
//a) Anfang der Gültigkeit
 if hauptfenster.tarife[i].validfrom > dateof(tarifzeit) then continue;
//b) Einwahlgebühr ?
 if ((hauptfenster.tarife[i].Einwahl <> 0.0) and (not hauptfenster.ConnectionCostVisible)) then continue;

 if ansicontainsstr(hauptfenster.tarife[i].tag,daystring) then
 begin
  //wenn datumsgrenze überchritten wird
  if (dateof(tarifzeit)<>dateof(incminute(tarifzeit,setdauer))) then
  begin
     //wenn Tarif ganztägig
    if ( ((dateof(tarifzeit) +hauptfenster.tarife[i].Ende) ) = ( dateof(tarifzeit) +hauptfenster.tarife[i].Beginn ) )
            and (ansicontainsstr(hauptfenster.tarife[i].Tag,tomorrowstring)) then check1:= true;
         //wenn Tarif die Datumsgrenze überschreitet
      if  ( ( dateof(tarifzeit) + hauptfenster.tarife[i].Beginn ) < tarifzeit ) then
       if ( ansicontainsstr(hauptfenster.tarife[i].tag,tomorrowstring) ) then
        if  (dateof(tarifzeit) +hauptfenster.tarife[i].Beginn)>(dateof(tarifzeit) + hauptfenster.tarife[i].Ende ) then
          if  ( dateof(incday(tarifzeit,1)) + hauptfenster.tarife[i].Ende ) >(incminute(tarifzeit,setdauer))
            then check2:= true;

  if check1 or check2 then
    loadlistaddline(rows,i,Einwahl,Preis, tarifzeit, setdauer);
  end
  else //wenn am selben Tag | Datumsgrenze wird nicht überschritten
  begin
   //Tarifende ist am selben tag   | ende >= beginn
   if ( (dateof(tarifzeit) +hauptfenster.tarife[i].Ende) >= (dateof(tarifzeit) +hauptfenster.tarife[i].Beginn ) )
   then
   begin
     if( ( (dateof(tarifzeit) + hauptfenster.tarife[i].Beginn < (tarifzeit))
      and (incminute(tarifzeit,setdauer) < (dateof(tarifzeit) + hauptfenster.tarife[i].Ende )))
         //oder wenn ganztags
          or ( hauptfenster.tarife[i].Beginn = hauptfenster.tarife[i].Ende ) )
          then
            loadlistaddline({ini,sections,}rows,i,Einwahl,Preis, tarifzeit, setdauer);
   end
   else //das ende des Tarifs ist an anderem Tag als Beginn| wenn ende < beginn
   begin
     if ( (dateof(tarifzeit) + hauptfenster.tarife[i].Beginn  < (tarifzeit))
     or (dateof(tarifzeit) + hauptfenster.tarife[i].Ende > (incminute(tarifzeit,setdauer) ) ))
          then loadlistaddline(rows,i,Einwahl,Preis, tarifzeit, setdauer);
    end;
  end;
 end;
end;

//nach Kosten sortieren
//Sort(liste,7,1,liste.RowCount, true, false);

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
   if (hauptfenster.isonline and (not hauptfenster.warnung_gezeigt)) then
   if hauptfenster.selfdial and not hauptfenster.beliebig_check.checked then
   if (minuteof(now) = (59-lookforward+1)) then watchoutforcheaperprice(tarifzeit);
end;
end;


procedure LoadListaddline(var rows:integer;i: integer; var Einwahl,Preis: real; timeofdisplay: TDatetime; thisdauer: integer);
var k, FreiSekunden, index: integer;
    Dials, DialAll, state, ScoreIndex: integer;
    tarif: string;
    score, score2: real;
begin
with hauptfenster do
begin
  rows := rows+1;

  liste.Cells[1,rows] := tarife[i].Tarif;
  liste.Cells[2,rows] := TimeToStr(tarife[i].Beginn);
  liste.Cells[3,rows] := TimeToStr(tarife[i].Ende);
  liste.Cells[4,rows] := Format('%.2f',[tarife[i].Preis]);
  liste.Cells[5,rows] := Format('%.2f',[tarife[i].Einwahl]);
  liste.Cells[6,rows] := tarife[i].Takt;

  liste.Cells[8,rows] := tarife[i].Nummer;
  liste.Cells[9,rows] := tarife[i].User;
  liste.Cells[10,rows] := tarife[i].Passwort;
  liste.Cells[11,rows] := tarife[i].Webseite;
  liste.Cells[12,rows] := DateToStr(tarife[i].validfrom);
  liste.Cells[13,rows] := DateToStr(tarife[i].expires);
  liste.Cells[14,rows] := DateToStr(tarife[i].eingetragen);

  tarif:= tarife[i].Tarif;
  getScores(tarif, DialAll, Dials, state, ScoreIndex);
  liste.cells[15,rows]:= inttostr(DialAll);{gesamversuche}
  liste.cells[16,rows]:= inttostr(Dials); {erfolgreiche}
  liste.Cells[17, rows]:= tarife[i].Tag;

  if (DialAll> 0) then score := 1.- dials/DialAll
                  else score := 1.;

  if (Dials > 0) then Score2:= 1./Dials else Score2:= 1.;

//AutoBlackliste
  if ((DialAll - Dials > AutoBlacklist) and (Score*100 > Hauptfenster.AutoBlacklistScore)) then hauptfenster.Scores[ScoreIndex].state:= 1;

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

             //Blacklist
             if state = 1 then liste.Cells[7,rows]:= 'Blacklist'
             else
             //es gibt nocht FreiKB
             if ((length(kontingente) > 0) and (index > -1) and (kontingente[index].FreikB > 0)) then liste.cells[7,rows]:= Format('%.4f',[1/100 *(Einwahl + thisdauer*preis)]) //Format('%.4f (%.4f)',[0., score+ Score2])//  '0,0000'
             else
             //normale Kosten berechnen
             if Freisekunden <= 0 then
                    liste.Cells[7,rows] := Format('%.4f',[1/100 *(Einwahl + thisdauer*preis)])//Format('%.4f (%.4f)',[1/100 *(Einwahl + thisdauer*preis), score+ Score2])
                   else // Freisekunden reichen dicke
                    if ((thisdauer*60) < Freisekunden) then liste.cells[7,rows]:= Format('%.4f',[0.])// Format('%.4f (%.4f)',[0., score+ Score2])
                     else //Freisekunden reichen nur teilweise und Volumen reicht nicht
                      if (thisdauer*60) >= Freisekunden then liste.Cells[7,rows] :=Format('%.4f',[1/100 *((Einwahl + thisdauer*preis)- (Freisekunden/60 * preis) )])// Format('%.4f (%.4f)',[1/100 *((Einwahl + thisdauer*preis)- (Freisekunden/60 * preis) ), score+ Score2])

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
              liste.Cells[7,rows]:= 'abgelaufen'; {Hauptfenster.Scores[ScoreIndex].state:= 2;}
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
  then begin result:= true; break; end;

end;

end;


function isFeiertag(date: TDate): string;
var i: integer;
    temp: string;
    feiertagsliste: TStringlist;
begin
with hauptfenster do
begin
temp:= '';
feiertagsliste:= TStringlist.Create;

if fileexists(extractfilepath(paramstr(0))+'feiertage.txt') then
begin
  try
    feiertagsliste.LoadFromFile(extractfilepath(paramstr(0))+'feiertage.txt');
  except
    feiertagsliste.Append('1. Weichnachtstag|25.12.2006');
  end;
end;

if feiertagsliste.count >0 then
for i:= 0 to feiertagsliste.Count-1 do
if Ansicontainstext(feiertagsliste.Strings[i],datetostr(date)) then begin temp:= feiertagsliste.Strings[i]; break; end;

if pos('|', temp)>0 then
Delete(temp,pos('|', temp), length(temp));

feiertagsliste.free;
Result:= temp;
end;
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

procedure SaveTrafficData(Tarif: string; Dauer: integer; download, upload: LongInt);
var bisher_gesurft, bisher_takt: Longint;
    bisher_down, bisher_up: double;
begin
if tarif ='' then exit; //keine Daten ?!?

bisher_gesurft:= SettingsTraffic.ReadInteger(Tarif,'Surfdauer',0);
bisher_takt:= SettingsTraffic.ReadInteger(Tarif,'Surfdauer_Takt',0);
bisher_up:= SettingsTraffic.ReadFloat(Tarif,'Upload',0);
bisher_down:= SettingsTraffic.ReadFloat(Tarif,'Download',0);

//start des Zählers setzen
if bisher_gesurft = 0 then SettingsTraffic.WriteDateTime(Tarif,'seit', now);

SettingsTraffic.WriteInteger(Tarif,'Surfdauer',dauer + bisher_gesurft); //in sekunden
SettingsTraffic.WriteInteger(Tarif,'Surfdauer_Takt',dauer_takt + bisher_takt); //in sekunden
SettingsTraffic.WriteFloat(Tarif,'Download', download/1024 + bisher_down);     //in kB
SettingsTraffic.WriteFloat(Tarif,'Upload', upload/1024 + bisher_up);           //in kB
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
//         showmessage(kontingente[i].tarif + ' ' + inttostr(kontingente[i].freisekunden));
         kontingente[i].FreiSekunden:= kontingente[i].FreiSekunden -  SettingsTraffic.ReadInteger(kontis.strings[i],'Surfdauer_takt',0);
//         showmessage(inttostr(kontingente[i].freisekunden));
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
with hauptfenster do
begin
     onlineset.preis:= onlineset.wechselpreis;
     onlineset.einwahl:= onlineset.wechseleinwahl;
     onlineset.einwahl2:= onlineset.wechseleinwahl;
     onlineset.wechselpreis:= 0;
     onlineset.wechseleinwahl:= 0;
     onlineset.wechsel:= incday(onlineset.wechsel, 10*365); //10 Jahre in die Zukunft setzen, damit das nciht gleich wieder ausgelöst wird
     if assigned(floatingW) then
     begin
      if (onlineset.vbegin=onlineset.vend) then edtime.text:='ganztags'
       else edtime.text:= TimeToStr(onlineset.vbegin) +'-'+TimeToStr(onlineset.vend);
      floatingW.valid.caption:= edtime.text;
      floatingW.preis.caption:= Format('%.2f c/min',[onlineset.preis]);
     end;
end;
end;

function computecosts(Kanalbuendelung: boolean): boolean;
begin

with hauptfenster do
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
 if ((takt1.Tag > (dauer mod taktlaenge)) //dann hat neuer Takt begonnen
     or (taktlaenge = 1                    ))  then
      dauer_takt:= dauer_takt +  taktlaenge;

if Kanalbuendelung then
 if ( (takt2.Tag > (dauer2 mod taktlaenge)) //dann hat neuer Takt begonnen (2. Kanal)
     or (taktlaenge = 1                    ))  then
      dauer_takt:= dauer_takt +  taktlaenge;

//wenn noch Volumenkontingente vorhanden, dann abbrechen .. keine Kosten berechnen
 if ((length(kontingente) > 0) and (kontingente[kontingentindex].freikb > 0) and (kontingentindex > -1))
 then begin result:= true; exit; end;

 //aktuelle Freisekundenanzahl ermitteln -> wichtig: nachdem auf Volumenkontingente geprüft wurde
 if ((length(kontingente) > 0) and (kontingentindex > -1) and (kontingente[kontingentindex].Freisekunden > 0)) then
 begin
   if ((takt1.Tag > (dauer mod taktlaenge)) //dann hat neuer Takt begonnen
     or (taktlaenge = 1                    ))  then
       kontingente[kontingentindex].Freisekunden:= kontingente[kontingentindex].Freisekunden - taktlaenge;

   if Kanalbuendelung then
    if ( (takt2.Tag > (dauer2 mod taktlaenge)) //dann hat neuer Takt begonnen (2. Kanal)
     or (taktlaenge = 1                    ))  then
       kontingente[kontingentindex].Freisekunden:= kontingente[kontingentindex].Freisekunden - taktlaenge;

    //diese Funktion beenden, wenn keine Kosten berechnet werden müssen
    if (kontingente[kontingentindex].Freisekunden > 0) then
    begin
      result:= true;
      Takt1.Tag:= dauer mod Taktlaenge; //alten Wert merken damit Taktberechnung funtioniert !!!
      Takt2.Tag:= dauer2 mod Taktlaenge;
      exit;
    end
    else kontingente[kontingentindex].Freisekunden:= 0;
 end;

 if ((takt1.Tag > (dauer mod taktlaenge)) //dann hat neuer Takt begonnen
   or (taktlaenge = 1                   )) then
     //Kosten:= bisherige Kosten + Kosten/s * taktlaenge
     onlineset.kostenbisjetzt:= onlineset.kostenbisjetzt + onlineset.Preis/60/100 * taktlaenge;
     //alten Wert merken
   Takt1.Tag:= dauer mod Taktlaenge;

 if Kanalbuendelung then
 if ( (takt2.Tag > (dauer2 mod taktlaenge)) //dann hat neuer Takt begonnen (2. Kanal)
     or (taktlaenge = 1                    ))  then
     //Kosten:= bisherige Kosten + Kosten/s * taktlaenge
     onlineset.kostenbisjetzt:= onlineset.kostenbisjetzt + onlineset.Preis/60/100 * taktlaenge;
     //alten Wert merken
   Takt2.Tag:= dauer2 mod Taktlaenge;
 end;
end;

procedure WriteTarifeToHD;
var fName,cName: string;
    i: integer;
    Datei: file of TTarif;
begin
  fName:= ExtractfilePath(paramstr(0)) + 'Tarife.$$$';
  cName:= ExtractfilePath(paramstr(0)) + 'Tarife.lcx';

  assignfile(Datei,fName);
  rewrite(Datei);

  for i:= 0 to length(hauptfenster.tarife)-1 do
   write(Datei,hauptfenster.tarife[i]);

  closefile(Datei);
  Compress(fName, cName);
  DeleteFile(PChar(fName));

end;

end.
