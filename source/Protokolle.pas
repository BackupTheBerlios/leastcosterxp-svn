unit Protokolle;

interface

type Lieferant = record
      Tag:Tdatetime;
      Zeit:tdatetime{stamp};
      Kosten:Real;
      Verbindungen:shortint;
      End;

      Lieferung = array[1..31] of Lieferant;

procedure append_own_data;
procedure OlecoImport(sender: TObject);
Procedure Abholung(Lageradresse:string);
procedure monatshtml(path, filename: string);
procedure CreateAllLogs;

procedure WebAuswertungErstellen;


implementation
uses unit1, files, DateUtils, SysUtils, StrUtils, Dialogs, RegExpr, Classes, IniFiles;

var Lieferliste:Lieferung;

procedure append_data(ausgabepfad,filename, data:string; var count: integer);//, nof: integer);
var f: textfile;
    temp:string;
begin
if fileexists(ausgabepfad+'\'+filename+'.csv') then
begin   //anhängen
     assignfile(f,ausgabepfad+'\'+filename+'.csv');
     append(f);
     writeln(f,data);
     closefile(f);
end
else
begin //neu anlegen
     count:=1;
     //nof:= nof+1;
     Repeat Delete(data,1,1); temp:= data; until (temp[1] =chr(9));
     temp:= '1'+ data;
     assignfile(f,ausgabepfad+'\'+filename+'.csv');
     rewrite(f);
     writeln(f,temp);
     closefile(f);
end;
end;

procedure append_own_data;
var ausgabepfad, filename, savedata: string;
    linecount: integer;
    tmp_linecount: string;
    act_file: string;
    datum_copy: TDateTime;
    r: TRegExpr;
    FileList: Tstringlist;
begin
//zeilencounter des eigenen Logfiles auslesen
act_file:=''; 

//anfangsdatum in Dateinamen umwandeln
try
  datum_copy:=  hauptfenster.onlineset.datum;
except //falls das Datum nicht mehr identifiziert werden kann
  datum_copy:= now;
end;
if monthof(datum_copy) < 10 then act_file:= inttostr(yearof(datum_copy))+'_0'+inttostr(monthof(datum_copy))
else act_file:= inttostr(yearof(datum_copy))+'_'+inttostr(monthof(datum_copy));

if (fileexists(extractfilepath(paramstr(0)) + '\log\'+act_file+'.csv')) then
begin
  r:= TRegExpr.Create;
  r.Expression:= '^(\d{1,})\t.*';
  Filelist:= TStringlist.create;
  Filelist.LoadFromFile(extractfilepath(paramstr(0)) + '\log\'+act_file+'.csv');

  tmp_linecount:= R.Replace(Filelist.Strings[Filelist.count-1],'$1', true);
  linecount:=   Strtoint(tmp_linecount);
  inc(linecount);
  r.free;
  Filelist.Free;
end;

verzeichnis_erzeugen(ExtractFilePath(paramstr(0))+'log');
ausgabepfad:= ExtractFilePath(paramstr(0))+'log\';
filename:= extractfilename(act_file);

with hauptfenster.onlineset do
begin
savedata:=  inttostr(linecount)
            + #9 + Datetostr(Dateof(Datum_copy))
            + #9 + TimeToStr(Timeof(Datum_copy))
            + #9 + Dauer
            + #9 + FloatToStr(Kosten)
            + #9 + Tarif
            + #9 + TimeToStr(Endzeit)
            + #9 + Rufnummer;

if (Tarif<>'') then
   append_data(ausgabepfad,filename, savedata, linecount);//, nof);
end;

end;

procedure OlecoImport(sender: TObject);
var f: textfile;
    zeile, tarif, counter, savedata, filename, monat, ausgabepfad, temp1, temp2: string;
    temp: string[2];
    count, ccount, nof: integer;
    check1, check2: boolean;
    sec: longint;
    i: integer;
    h, m, s: word;
    hour, mins, secs: string;
    act_file: string;
    zeichen: char;
    zeilennr: string;
    dates_1, dates_2: string;
begin

dates_1:= settings.ReadString('lastdate','1','');{Datum/ Zeit}
dates_2:= settings.ReadString('lastdate','3','');

count:=0; ccount:=0; nof:= 0;
temp1:='';temp2:='';
check1:= false; check2:= false;

//zeilencounter des eigenen Logfiles auslesen
act_file:=''; zeilennr:= '';

if monthof(date) < 10 then act_file:= inttostr(yearof(date))+'_0'+inttostr(monthof(date))+'.csv'
else act_file:= inttostr(yearof(date))+'_'+inttostr(monthof(date))+'.csv';

if (fileexists(extractfilepath(paramstr(0)) + '\log\'+act_file)) then
begin
  Assignfile(f,extractfilepath(paramstr(0)) + '\log\'+act_file);
  reset(f);
    repeat
      readln(f,zeile);
    until eof(f);

  closefile(f);
  i:=1;
    repeat
      zeichen:= zeile[i];
      i:=i+1;
      zeilennr:= zeilennr + zeichen;
    until ord(zeichen)=9;
  Delete(zeilennr,length(zeilennr),1);

count:= strtoint(zeilennr);
end;

zeile:='';// i:=0;
verzeichnis_erzeugen(ExtractFilePath(ParamStr(0))+'log');
ausgabepfad:= ExtractFilePath(ParamStr(0))+'log\';

if fileexists(hauptfenster.path+'ple.cst') then
begin

  assignfile(f, hauptfenster.path+'ple.cst');
  reset(f);

  repeat
    readln(f,zeile);
  until eof(f) or AnsiContainsStr(zeile, '[1]');

  if ((length(dates_1) > 4) and (length(dates_2) > 4)) then
  begin
    repeat
      readln(f,zeile);
      temp1:= zeile;
      if (AnsiContainsStr(temp1, dates_1)) then begin
      check1:= true;
      break; end;
    until ((temp1= dates_1) or eof(f));

    repeat
      readln(f,zeile);
      temp2:= zeile;
      if (AnsiContainsStr(temp2, dates_2)) then
        begin
          check2:= true;
          break;
        end;

    until ((temp2= dates_2) or eof(f));
    if ((check1=false) or (check2=false)) then
    begin
     closefile(f);
     assignfile(f, hauptfenster.path+'ple.cst');
     reset(f);
      repeat  // ersten Datensatz finden
      readln(f,zeile);
      until eof(f) or AnsiContainsStr(zeile, '[1]');
    end;
    if ((check1) and (check2)) then
    begin
      repeat
       if not eof(f) then readln(f,zeile);
      until ( (AnsiContainsStr(zeile, '[')) or (eof(f)=true))
    end;
  end;
if not eof(f) then
begin

  savedata:='';
  repeat
    readln(f, zeile);
    temp:= zeile;
    if not (zeile ='') then begin
    case temp[1] of
      '1': begin
             count:= count + 1;
              str(count, counter);
              savedata:= savedata+ counter+chr(9);
              Delete(zeile,1,2);
              settings.writestring('lastdate','1',zeile);
              dates_1:= zeile;
              filename:= zeile; monat:=zeile;
              delete(monat,1,3); delete(monat,3,5);
              delete(filename,1,6); {erste 8 zeichen löschen}
              insert('_'+monat,filename, 5);
              savedata:= savedata+zeile + chr(9);
              tarif:='';
             end;

   '2': begin Delete(zeile,1,2); { Tarif } tarif:=zeile + ' [OlecoImport]'; end;
   '3': begin Delete(zeile,1,2); { Surfzeit Anfang } settings.writestring('lastdate','3',zeile); dates_2:= zeile; savedata:= savedata+zeile + chr(9); end;
   '4': begin {Zeit in s}
          Delete(zeile,1,2);
          sec:= strtoint(zeile);
          hauptfenster.zeitumrechnen(sec, h, m, s);

          if h< 10 then hour:= '0'+inttostr(h) else hour:= inttostr(h);
          if m< 10 then mins:= '0'+inttostr(m) else mins:= inttostr(m);
          if s< 10 then secs:= '0'+inttostr(s) else secs:= inttostr(s);

          zeile:= hour + ':'+mins+':'+secs;
          savedata:= savedata+zeile + chr(9);
        end;
   '5': begin {Kosten in Cent}
          Delete(zeile,1,2);
          For i:=1 to length(zeile) do
          begin
          if zeile[i]=',' then
            begin
              insert('000',zeile,1);
              Delete(zeile,i+3,1);
              insert(',',zeile,i+3-2);
              Delete(zeile,1,i-1);
               break;
            end;
          end;

          savedata:= savedata+zeile + chr(9);
        end;
   '6': Delete(zeile,1,2);
   '7': Delete(zeile,1,2);
   '8': begin
         Delete(zeile,1,2);
         savedata:= savedata{+zeile + chr(9)}+tarif;
         //findme
         if writeme then
          begin
            savedata:= savedata + chr(9) + timetostr(actofftime) + chr(9) + actnumber;
            actnumber:='';
            actofftime:= strtotime('00:00:00');
            //um eins erhöhen
            settings.WriteInteger('lastdate','count',settings.ReadInteger('lastdate','count',0)+1);
          end;
         append_data(ausgabepfad,filename, savedata, count);//, nof);
         ccount:=ccount+1;
         savedata:='';
         end;
  end;
 end;
until eof(f);
end;
closefile(f);

 if (sender=hauptfenster.MM1_4_1) then
       showmessage(inttostr(ccount) + ' Verbindung(en) exportiert nach '+ausgabepfad + '.'+ #13#10 +'Es wurden '+inttostr(nof) + ' Dateien neu angelegt.');

   end
else
  begin
      settings.writestring('lastdate','1','');
      settings.writestring('lastdate','3','');
      dates_1:= '';
      dates_2:= '';
  end;

//der aktuelle Stand ist erreicht ... immer mitschreiben
writeme:= true;
end;

Function sekunden(Zeit:tdatetime): longint;
var h,m,s, msec: word;
begin
  DecodeTime(Zeit, h,m,s, MSec);
  if not ((h=0) and (m=0) and (s=0)) then
  sekunden:= s + m*60 + h*3600 else sekunden:=1;
end;

//erst ausführen nachdem Abhoung gelaufen ist, da die Lieferliste dort gefüllt wird
procedure monatshtml(path, filename: string);
var   Exporteur,Importeur          :textfile;
      htmfilename,zwischenhandler  : string;
      zahler,maxconect,monatstage  :integer;
      time,cost                    :Boolean;
      maxcost,maxtimecost,adcost   :Real;
      maxtime                      :tdatetime;
      adtime                       :TdateTime{Stamp};
      fname                        :String;
      jahr, monat                  :Word;
begin
//Jahr extrahieren
fname:= filename;
Delete(fname,5,7);
jahr:= strtoint(fname);
//Monat extrahieren
fname:= filename;
Delete(fname,1,5);
delete(fname,3,4);
monat:= strtoint(fname);


maxcost:=0;
Maxtime:=0;
maxtimecost:=0;
maxconect:=0;
monatstage:=Daysinamonth(yearof(lieferliste[1].tag),monthof(lieferliste[1].tag) );
For zahler:=1 to monatstage do
 Begin
 IF maxcost  <lieferliste[zahler].Kosten       Then maxcost  :=lieferliste[zahler].Kosten      ;
 IF maxtime  <lieferliste[zahler].Zeit         Then maxtime  :=lieferliste[zahler].Zeit        ;
 IF maxconect<lieferliste[zahler].Verbindungen Then maxconect:=lieferliste[zahler].VErbindungen;
 IF (maxtimecost<(lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60))) Then maxtimecost:=((lieferliste[zahler].Kosten)/(sekunden(lieferliste[zahler].Zeit)/60));
 End;
Verzeichnis_erzeugen(ExtractFilePath(paramstr(0))+'www\log');
htmfilename:=ChangeFileExt(filename,'.htm');
Assignfile(Importeur ,ExtractFilePath(paramstr(0))+'www\log\'+htmfilename);
rewrite(Importeur);
Write(Importeur,'<meta name="author" content="LeastCoster XP">');
Write(Importeur, '<meta name="generator" content="LeastCoster XP">');
write(Importeur,'<meta http-equiv="cache-control" content="no-cache"></head>');
Write(Importeur,'<body alink="#0080ff" bgcolor="#ebedfe" link="#0000df" text="#000000" vlink="#3f00ff">');
Write(Importeur,'<p align="center"><img src="head.jpg" alt="" border="0" height="150"> </p>');
Begin
 Assignfile(Exporteur,path+filename); Reset(Exporteur);
 Writeln(Importeur,'<p align=center><font size=+2>Einzelverbindungen '+ filename+'</font></p>');
 Writeln(Importeur,'<table align=center border=0 cellspacing=3>');
 Writeln(Importeur,'<tr><td>Nr.</td><td>Datum</td><td>Uhrzeit</td><td>Dauer</td><td>Kosten [Euro]</td><td>Tarif</td><td>getrennt um ..</td><td>Rufnummer</td></tr>');
 Repeat
  Write(importeur, '<tr><td>');
  Readln(exporteur, Zwischenhandler);
  For zahler:=1 to length(Zwischenhandler) do
   Begin
   IF not((Zwischenhandler[zahler]=chr(9))) Then
    write(importeur, zwischenhandler[zahler]) Else
    Write(importeur, '</td><td>');
   End;
  Writeln(importeur, '</td></tr>');
  zwischenhandler:='';
 Until EOF(Exporteur);
Write(Importeur,'<tr><td></td><td></td><td></td><td>');

adtime:= 0;

Adcost:=0;
For zahler:=1 to 31 do
 Begin
 adtime:=adtime+lieferliste[zahler].Zeit;
 adcost:=adcost+lieferliste[zahler].Kosten;
 End;

Writeln(Importeur, inttostr(daysbetween(0, adtime))+'d ' + FormatDateTime('h"h" m"m" s"s"' ,adtime));

Write(Importeur,'</td><td>');
Write(Importeur, adcost:2:5);
Write(Importeur,'<td></td></tr>');
 Writeln(importeur, '</table>');
 Closefile(Exporteur);
End;
Writeln(Importeur,'<p align="center"><b>Legende</b><img src="red.gif" width="20" height="10">: mind.');
Write(Importeur, ((settings.ReadFloat('Kostengrenzen','rot',15.0)/monatstage)):3:2);
Writeln(Importeur, ' EUR/Tag <img src="yellow.gif" width="20" height="10">: mind. ');
Write(Importeur, (settings.ReadFloat('Kostengrenzen','gelb',10.0)/monatstage):3:2);
Writeln(Importeur, ' EUR/Tag <img src="blue.gif" width="20" height="10">: weniger als');
Write(Importeur, (settings.ReadFloat('Kostengrenzen','gelb',10.0)/monatstage):3:2);
Writeln(Importeur, ' EUR/Tag ');

       For cost:=true downto false do
         Begin
         For time:=false to true do{vertauscht}

          Begin
          IF not(cost Or      Time)Then Writeln(Importeur,'<p align=center><font size=+2>Verbindungen '+filename+'</font></p>');
          If     cost and not time then Writeln(Importeur,'<p align=center><font size=+2>Kosten '+filename+'</font></p>');
          If     cost and     time then Writeln(Importeur,'<p align=center><font size=+2>Verbindungsdauer '+filename+'</font></p>');
          If(not cost)and     time then Writeln(Importeur,'<p align=center><font size=+2>durchschnittliche Kosten pro Minute '+filename+'</font></p>');
          Writeln(Importeur, '<Table align="center" height="400" border=0 cellspacing="0" ><tr>');
          For zahler:=1 to monatstage do
          Begin
          Writeln(Importeur, ' <td valign="bottom"  background="');
          If dayofweek(Lieferliste[zahler].tag)=1 Then Write(Importeur, 'bgred.jpg') Else
          Write(Importeur, 'bg.jpg');

          //transparente Bereiche zeichnen !
          Write(Importeur, '"><img src="trans.gif" width=20 height="');

          IF not(cost Or      Time)Then Begin
                                              Write(Importeur, (400 - 400*lieferliste[zahler].Verbindungen/maxconect):3:0);
                                              Write(Importeur, '" border=0 title="');
                                              Write(Importeur, lieferliste[zahler].Verbindungen);
                                              Write(Importeur, ' Verbindung(en)');

                                              if encodedate(jahr,monat,zahler) = dateof(now) then
                                              begin
                                               settings.WriteDate('Tageskosten','Date',dateof(now));
                                               settings.WriteInteger('Tageskosten','Verbindungen',lieferliste[zahler].Verbindungen);
                                              end;

                                        End;
          If  cost and not time then Begin Write(Importeur, (400-400*lieferliste[zahler].Kosten/maxcost):3:0);
                                              Write(Importeur, '" border=0 title="');
                                              Write(Importeur, lieferliste[zahler].kosten:3:2);
                                              Write(Importeur, ' €');

                                             if encodedate(jahr,monat,zahler) = dateof(now) then
                                              begin
                                              settings.WriteFloat('Tageskosten','Kosten',lieferliste[zahler].Kosten);
                                              end;
                                        End;
          If  cost and     time then Begin Write(Importeur,  (400-400*lieferliste[zahler].Zeit/maxtime):3:0);
                                              Write(Importeur, '" border=0 title="');
                                              Write(Importeur, timetostr(lieferliste[zahler].zeit));

                                              if encodedate(jahr,monat,zahler) = dateof(now) then
                                              begin
                                              settings.WriteTime('Tageskosten','Zeit',lieferliste[zahler].zeit);
                                              end;

                                        End;



          If  (not cost)and     time  then Begin
                                             Write(Importeur,  (400-400*(lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60))/maxtimecost):3:0);
                                             Write(Importeur, '" border=0 title="');
                                             Write(Importeur, (lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60)):3:4);
                                             Write(Importeur, ' €/min');

                                             if encodedate(jahr,monat,zahler) = dateof(now) then
                                              begin
                                              settings.WriteFloat('Tageskosten','Mittelwert',(lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60)));
                                              end;

                                            End;


          // Balken zeichner
          Write(Importeur, '"><br><img src="');
          If (((settings.ReadFloat('Kostengrenzen','gelb',10.0))/monatstage)<lieferliste[zahler].kosten) Then
           If (((settings.ReadFloat('Kostengrenzen','rot',15.0))/monatstage)<lieferliste[zahler].kosten) Then
            Write(Importeur, 'red.gif') Else
            Write(Importeur, 'yellow.gif') Else
           Write(Importeur, 'blue.gif');
          Write(Importeur, '" width=20 height="');

           IF not(cost Or Time)Then Begin
            Write(Importeur, (400*lieferliste[zahler].Verbindungen/maxconect):3:0);
            Write(Importeur, '" border=0 title="');
            Write(Importeur, lieferliste[zahler].Verbindungen);
            Write(Importeur, ' Verbindung(en)');
           End;

           If cost and not time then Begin
            Write(Importeur, (400*lieferliste[zahler].Kosten/maxcost):3:0);
            Write(Importeur, '" border=0 title="');
            Write(Importeur, lieferliste[zahler].kosten:3:2);
            Write(Importeur, ' €');
           End;

           If cost and time then Begin
            Write(Importeur,  (400*lieferliste[zahler].Zeit/maxtime):3:0);
            Write(Importeur, '" border=0 title="');
            Write(Importeur, timetostr(lieferliste[zahler].zeit));
           End;

           If (not cost)and time then Begin
            Write(Importeur,  (400*(lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60))/maxtimecost):3:0);
            Write(Importeur, '" border=0 title="');
            Write(Importeur, (lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60)):3:4);
            Write(Importeur, ' €/min');
           End;
           Writeln(Importeur, '"></td>');
          End;
          Write(Importeur, '</tr><tr align="center">');

          //Spaltenbeschriftungen
          For zahler:=1 to monatstage do
           Write(Importeur, '<td>'+inttostr(zahler)+'</td>');
          Writeln(Importeur,'</tr></table>');
        End;
       End;
       Write(Importeur, '<br><p align=center><font size="-1"><b>Statistik erstellt mit <a href="http://www.leastcosterxp.de">LeastCosterXP</a> von <a href="mailto:owner@leastcosterxp.de"> Stefan Fruhner </a></b></font></p>');
       Writeln(Importeur,'</body></html>');
       Closefile(Importeur);
  end;

Procedure Abholung(Lageradresse:string);
Var Zwischenhandler:string;
    Datum   :string[10];
    Zeit,Kosten    :string[8];
    Tabs      :shortint;
    Lager     :Textfile;
    Punkt,haekchen:integer;
//    monat:string[2];
//    Jahr:string[4];
    monat, jahr: integer;
    i: integer;
Begin
 for i:=1 to 31 do begin
  lieferliste[i].tag:= EncodeDate(1970,01,01);
  lieferliste[i].zeit:=EncodeTime(00,00,00,00);
  lieferliste[i].kosten:= 0;
  lieferliste[i].verbindungen:= 0;
end;

 Assign(Lager, Lageradresse);
 Reset(Lager);

 Repeat
  Readln(Lager, Zwischenhandler);
  tabs:=0;
  Datum:='';
  Zeit:='';
  Kosten:='';
  For haekchen:=1 to length(Zwischenhandler) do
   Begin
    IF not(Zwischenhandler[haekchen]=chr(9)) Then
     Begin
      If tabs=1 Then Datum:=Datum+Zwischenhandler[haekchen];
      If tabs=3 Then Zeit:=Zeit+zwischenhandler[haekchen];
      If tabs=4 Then Kosten:=Kosten+zwischenhandler[haekchen];
     End
    Else Tabs:=tabs+1;
   End;
  Punkt:= Dayof(strtoDate(Datum));
  Monat:= monthof(strtoDate(Datum));
  Jahr := yearof(strtoDate(Datum));

  Lieferliste[Punkt].Tag:=strtoDate(Datum);
  Lieferliste[Punkt].Zeit:=Lieferliste[Punkt].Zeit+strtotime(Zeit);
  Lieferliste[Punkt].Kosten:=Lieferliste[Punkt].Kosten+strtofloat(Kosten);
  Lieferliste[Punkt].Verbindungen:=Lieferliste[Punkt].Verbindungen+1;
 Until Eof(Lager);
 For haekchen:=1 to daysinamonth(jahr, monat) do
   Lieferliste[haekchen].Tag:= Dateof(encodeDate(Jahr,monat, haekchen)); // strtodate((inttostr(haekchen))+'.'+Monat+'.'+Jahr);
 
 Closefile(Lager);

 //jetzt den Html-Export
 monatshtml(ExtractFilePath(Lageradresse),ExtractFilename(lageradresse));
End;

procedure CreateAllLogs;
var i: integer;
    Verzliste: TStringlist;
    SR      : TSearchRec;
    Verzeichnis: string;
begin
VerzListe:=TStringList.Create;
Verzeichnis:= (ExtractFilePath(paramstr(0))+'log\');

//alle Dateien suchen
if FindFirst(Verzeichnis+'*.*',faAnyFile,SR)=0 then
    repeat
      if ((SR.Name<>'.') and (SR.Name<>'..') and (sr.Name[5]='_')) then
        VerzListe.Add(SR.Name);
    until FindNext(SR)<>0;
FindClose(SR);


if Verzliste.count > 0 then
 for i := 0 to (verzliste.Count - 1) do
       Abholung(ExtractFilePath(paramstr(0))+'log\'+verzliste.Strings[i]);

VerzListe.Free;
end;

procedure WebAuswertungErstellen;
var SR      : TSearchRec;
    verzeichnis: string;
    uebersicht: textfile;
    jahr,code, checkjahr: integer;
    temp: string[4];
    i: word;
    istring: string;
    count: integer;
begin

  count:= 0;
  checkjahr:= 0 ;
  verzeichnis:= extractfilepath(paramstr(0))+'www\log\';
  assignfile(uebersicht, verzeichnis+'index.htm');
  rewrite(uebersicht);

  writeln(uebersicht,' <HTML><HEAD><TITLE>Kostenprotokolle</TITLE>');
  writeln(uebersicht,'<meta name="author" content="LeastCoster XP"><meta name="generator" content="LeastCoster XP 1.2 "><meta http-equiv="cache-control" content="no-cache">');
  writeln(uebersicht,'</HEAD><BODY alink="#0080ff" bgcolor="#ebedfe" link="#0000df" text="#000000" vlink="#3f00ff">');

  if FindFirst(Verzeichnis+'*.htm',$3F,SR)=0 then begin
    repeat
    if ( (sr.Name<> 'index.htm') and (sr.name<>'header.htm')) then
    begin
      temp:= sr.Name;
      val(temp,jahr,code);

      if checkjahr < jahr then
      begin

      writeln(uebersicht, '<table border=0><tr><th colspan=12 align="left"><h1>'+temp+'</h1></th></tr><tr>');
       for i:= 1 to 12 do
       begin
       count:= count+1;
       if i<10 then istring:='0'+inttostr(i) else istring:=inttostr(i);
       if fileexists(extractfilepath(paramstr(0))+'\log\'+temp+'_'+istring+'.csv') then writeln(uebersicht, '<td><a href="'+inttostr(jahr)+'_'+ istring +'.htm" onMouseOver="image'+inttostr(count) +'.src=''../img/month_y'+inttostr(i)+'.jpg'';" onMouseOut="image'+inttostr(count) +'.src=''../img/month'+inttostr(i)+'.jpg'';" ><img name="image'+inttostr(count) +'" src="../img/month'+inttostr(i)+'.jpg" border="0" ></a><td>')
       else
        writeln(uebersicht, '<td><img src="../img/nomonth'+inttostr(i)+'.jpg" border="0" ><td>')
       end;
      writeln(uebersicht, '</tr></table>');
       checkjahr:= jahr;
      end;

    end;
    until FindNext(SR)<>0;
    FindClose(SR);
  end;
  writeln(uebersicht, '</body></html>');
  closefile(uebersicht);
end;


end.
