unit Protokolle;

interface
uses unit1;

type Lieferant = record
      Tag:Tdatetime;
      Zeit:tdatetime{stamp};
      Kosten:Real;
      Verbindungen:shortint;
      End;

      Lieferung = array[1..31] of Lieferant;

procedure SaveConnection(Data: OnlineWerte);
Procedure Abholung(Lageradresse:string);
procedure monatshtml(path, filename: string);
procedure CreateAllLogs;

procedure WebAuswertungErstellen;


implementation
uses files, DateUtils, SysUtils, StrUtils, Dialogs, RegExpr, Classes, IniFiles, inilang, messagestrings;

var Lieferliste:Lieferung;

procedure SaveConnection(Data: OnlineWerte);
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
linecount:= 1;
Filelist:= TStringlist.create;

//anfangsdatum in Dateinamen umwandeln
try
  datum_copy:=  data.datum;
except //falls das Datum nicht mehr identifiziert werden kann
  datum_copy:= now;
end;
if monthof(datum_copy) < 10 then act_file:= inttostr(yearof(datum_copy))+'_0'+inttostr(monthof(datum_copy))
else act_file:= inttostr(yearof(datum_copy))+'_'+inttostr(monthof(datum_copy));

if (fileexists(extractfilepath(paramstr(0)) + '\log\'+act_file+'.csv')) then
begin
  r:= TRegExpr.Create;
  r.Expression:= '^(\d{1,})\t.*';

  Filelist.LoadFromFile(extractfilepath(paramstr(0)) + '\log\'+act_file+'.csv');

  tmp_linecount:= R.Replace(Filelist.Strings[Filelist.count-1],'$1', true);
  linecount:=   Strtoint(tmp_linecount);
  inc(linecount);
  r.free;
end;

verzeichnis_erzeugen(ExtractFilePath(paramstr(0))+'log');
ausgabepfad:= ExtractFilePath(paramstr(0))+'log\';
filename:= extractfilename(act_file);

savedata:=  inttostr(linecount)
            + #9 + Datetostr(Dateof(Datum_copy))
            + #9 + TimeToStr(Timeof(Datum_copy))
            + #9 + Data.Dauer
            + #9 + Format('%1.4f',[Data.Kosten])
            + #9 + Data.Tarif
            + #9 + TimeToStr(Data.Endzeit)
            + #9 + Data.Rufnummer;

if (Data.Tarif<>'') then
begin
  FileList.Append(savedata);
  Filelist.SaveToFile(ausgabepfad + filename + '.csv');
end;
//   append_data(ausgabepfad,filename, savedata, linecount);//, nof);

Filelist.Free;
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


maxcost:=0.;
Maxtime:=0;
maxtimecost:=0.;
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
Write(Importeur,'<meta name="author" content="LeastCosterXP">');
Write(Importeur, '<meta name="generator" content="LeastCosterXP">');
write(Importeur,'<meta http-equiv="cache-control" content="no-cache"></head>');
Write(Importeur,'<body alink="#0080ff" bgcolor="#ebedfe" link="#0000df" text="#000000" vlink="#3f00ff">');
Write(Importeur,'<p align="center"><img src="head.jpg" alt="" border="0" height="150"> </p>');
Begin
 Assignfile(Exporteur,path+filename); Reset(Exporteur);
 Writeln(Importeur,'<p align=center><font size=+2>'+misc(M28,'M28')+' '+ filename+'</font></p>');
 Writeln(Importeur,'<table align=center border=0 cellspacing=3>');
 Writeln(Importeur,'<tr><td>'+misc(M135,'M135')+'</td><td>'+misc(M136,'M136')+'</td><td>'+misc(M137,'M137')+'</td><td>'+misc(M138,'M138')+'</td><td>'+misc(M139,'M139')+'</td><td>'+misc(M140,'M140')+'</td><td>'+misc(M141,'M141')+'</td><td>'+misc(M142,'M142')+'</td></tr>');
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
Writeln(Importeur,'<p align="center"><b>'+misc(M203,'M203')+'</b><img src="red.gif" width="20" height="10">: '+misc(M204,'M204') +' ');
Write(Importeur, ((settings.ReadFloat('Kostengrenzen','rot',15.0)/monatstage)):3:2);
Writeln(Importeur, ' '+misc(M205,'M205')+' <img src="yellow.gif" width="20" height="10">:'+misc(M204,'M204') +' ');
Write(Importeur, (settings.ReadFloat('Kostengrenzen','gelb',10.0)/monatstage):3:2);
Writeln(Importeur, ' '+misc(M205,'M205')+' <img src="blue.gif" width="20" height="10">: '+misc(M206,'M206') +' ');
Write(Importeur, (settings.ReadFloat('Kostengrenzen','gelb',10.0)/monatstage):3:2);
Writeln(Importeur, ' '+misc(M205,'M205')+' ');

       For cost:=true downto false do
         Begin
         For time:=false to true do{vertauscht}

          Begin
          IF not(cost Or      Time)Then Writeln(Importeur,'<p align=center><font size=+2>'+misc(M28,'M28')+' '+filename+'</font></p>');
          If     cost and not time then Writeln(Importeur,'<p align=center><font size=+2>'+misc(M139,'M139')+' '+filename+'</font></p>');
          If     cost and     time then Writeln(Importeur,'<p align=center><font size=+2>'+misc(M48,'M48')+ ' ' +filename+'</font></p>');
          If(not cost)and     time then Writeln(Importeur,'<p align=center><font size=+2>'+misc(M207,'M207')+ ' '+filename+'</font></p>');
          Writeln(Importeur, '<Table align="center" height="400" border=0 cellspacing="0" ><tr>');
          For zahler:=1 to monatstage do
          Begin
          Writeln(Importeur, ' <td valign="bottom"  background="');
          If dayofweek(Lieferliste[zahler].tag)=1 Then Write(Importeur, 'bgred.jpg') Else
          Write(Importeur, 'bg.jpg');

          //transparente Bereiche zeichnen !
          Write(Importeur, '"><img src="trans.gif" width=20 height="');

          IF not(cost Or      Time)Then Begin
                                              if maxconect > 0 then Write(Importeur, (400 - 400*lieferliste[zahler].Verbindungen/maxconect):3:0)
                                                                else Write(Importeur, '400');
                                              Write(Importeur, '" border=0 title="');
                                              Write(Importeur, lieferliste[zahler].Verbindungen);
                                              Write(Importeur, ' '+misc(M28,'M28'));

                                              if encodedate(jahr,monat,zahler) = dateof(now) then
                                              begin
                                               settings.WriteDate('Tageskosten','Date',dateof(now));
                                               settings.WriteInteger('Tageskosten','Verbindungen',lieferliste[zahler].Verbindungen);
                                              end;

                                        End;
          If  cost and not time then Begin if maxcost > 0. then Write(Importeur, (400-400*lieferliste[zahler].Kosten/maxcost):3:0)
                                                           else Write(Importeur, '400');
                                              Write(Importeur, '" border=0 title="');
                                              Write(Importeur, Format('%3.2m',[lieferliste[zahler].kosten]));

                                             if encodedate(jahr,monat,zahler) = dateof(now) then
                                              begin
                                              settings.WriteFloat('Tageskosten','Kosten',lieferliste[zahler].Kosten);
                                              end;
                                        End;
          If  cost and     time then Begin if maxtime > 0 then Write(Importeur,  (400-400*lieferliste[zahler].Zeit/maxtime):3:0)
                                                           else Write(Importeur, '400');
                                              Write(Importeur, '" border=0 title="');
                                              Write(Importeur, timetostr(lieferliste[zahler].zeit));

                                              if encodedate(jahr,monat,zahler) = dateof(now) then
                                              begin
                                              settings.WriteTime('Tageskosten','Zeit',lieferliste[zahler].zeit);
                                              end;

                                        End;

          If  (not cost)and     time  then Begin
                                             if maxtimecost > 0. then Write(Importeur,  (400-400*(lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60))/maxtimecost):3:0)
                                                                 else Write(Importeur, '400');
                                             Write(Importeur, '" border=0 title="');
                                             Write(Importeur, Format('%3.4m /min',[lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60)]));

                                             if encodedate(jahr,monat,zahler) = dateof(now) then
                                              begin
                                                try
                                                 settings.WriteFloat('Tageskosten','Mittelwert',(lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60)));
                                                except
                                                 settings.WriteFloat('Tageskosten','Mittelwert',0.0);
                                                end;
                                              end;
                                            End;


          // Balken zeichnen
          Write(Importeur, '"><br><img src="');
          If (((settings.ReadFloat('Kostengrenzen','gelb',10.0))/monatstage)<lieferliste[zahler].kosten) Then
           If (((settings.ReadFloat('Kostengrenzen','rot',15.0))/monatstage)<lieferliste[zahler].kosten) Then
            Write(Importeur, 'red.gif') Else
            Write(Importeur, 'yellow.gif') Else
           Write(Importeur, 'blue.gif');
          Write(Importeur, '" width=20 height="');

           IF not(cost Or Time)Then Begin
           if maxconect > 0 then Write(Importeur, (400*lieferliste[zahler].Verbindungen/maxconect):3:0)
                            else Write(Importeur, '0');
            Write(Importeur, '" border=0 title="');
            Write(Importeur, lieferliste[zahler].Verbindungen);
            Write(Importeur, ' '+misc(M28,'M28'));
           End;

           If cost and not time then Begin
           if maxcost > 0. then Write(Importeur, (400*lieferliste[zahler].Kosten/maxcost):3:0)
                            else Write(Importeur, '0');
            Write(Importeur, '" border=0 title="');
            Write(Importeur, Format('%3.2m',[lieferliste[zahler].kosten]));
           End;

           If cost and time then Begin
           if maxtime > 0 then Write(Importeur,  (400*lieferliste[zahler].Zeit/maxtime):3:0)
                          else Write (Importeur, '0');
            Write(Importeur, '" border=0 title="');
            Write(Importeur, timetostr(lieferliste[zahler].zeit));
           End;

           If (not cost)and time then Begin
            if maxtimecost > 0. then Write(Importeur,  (400*(lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60))/maxtimecost):3:0)
                                 else Write (Importeur, '0');
            Write(Importeur, '" border=0 title="');
            Write(Importeur, (lieferliste[zahler].Kosten/(sekunden(lieferliste[zahler].Zeit)/60)):3:4);
            Write(Importeur, ' '+misc(M13,'M13')+'/min');
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
       Write(Importeur, '<br><p align=center><font size="-1"><b><a href="http://www.leastcosterxp.de">LeastCosterXP</a> by <a href="mailto:owner@leastcosterxp.de"> Stefan Fruhner </a></b></font></p>');
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
   Lieferliste[haekchen].Tag:= Dateof(encodeDate(Jahr,monat, haekchen));

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

  writeln(uebersicht,' <HTML><HEAD><TITLE>'+misc(M216,'M216')+'</TITLE>');
  writeln(uebersicht,'<meta name="author" content="LeastCosterXP"><meta name="generator" content="LeastCosterXP"><meta http-equiv="cache-control" content="no-cache">');
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
