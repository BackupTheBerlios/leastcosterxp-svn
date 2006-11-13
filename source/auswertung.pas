unit auswertung;

interface

procedure zeitumrechnen(zeit_in_sec: longint; var h,m,s: word);
procedure getdate(var y,m,d,dow:word);
Function Fnord(Zeichen:string):Real;
procedure gesamtkosten_pro_monat(filename:string; tag:shortint);
procedure init_array;
function getmax(connect,cost,time,cost_per_time:boolean):real;

function sonntage(monat, jahr: integer): integer;
procedure Connections(filename, newfilename: string);
procedure html_export(filename:string);

procedure input_date(y,m,d,dow: word);
procedure input_file(filename: string);

implementation
uses files, unit1, SysUtils, DateUtils, {unit3,} forms;

type auswert = record
      day: shortint;
      month: shortint;
      year: word;
      time: longint;
      connect: word;
      cost: real;
     end;

     gesamt_auswertung = array[0..201] of auswert;

var  geld: gesamt_auswertung;
     zaehl: integer;

const
months : array[1..12] of String[9] = ('Januar','Februar','M„rz','April','Mai','Juni',
         'Juli','August','September','Oktober','November','Dezember');

length_months : array[1..12] of shortint = (31,28,31,30,31,30,31,31,30,31,30,31);

procedure getdate(var y,m,d,dow: word);
var datestring, day, month, year: string;
code: integer;
begin
Datestring := DateToStr(Date);
day:= datestring;  month:= datestring; year:= datestring;
Delete(day, 3, 8);

Delete(month, 1, 3);
Delete(month, 3, 5);

Delete(year, 1,6);

val(day,d,code);
val(month,m,code);
val(year,y,code);
dow:= dayoftheweek(date);
if dow=7 then dow:=0;
end;

Function Fnord(Zeichen:string):Real;
Var i,lang:integer;
    code: integer;
    wert:real;
Begin
lang:=length(zeichen);
For i:=1 to lang do
IF zeichen[i]=',' Then Zeichen[i]:='.';
Val(zeichen, wert, Code);
{ Error during cnversion to integer? }
if code <> 0 then
fnord:= -999
else begin
  fnord:= wert;
  end;

End;


procedure gesamtkosten_pro_monat(filename:string; tag:shortint);
var f: text;
    textzeile:string;
    datum,jahr:string;
    funf,vier, written:Boolean;
    Kosten,Sekunden:Real;
    sekunde:longint;
    code,zaehl,temptag,i:integer;
begin
assignfile(f, FileName);
reset(f);
Sekunden:=0;
Kosten:=0;
temptag:=0;
written:=false;
datum:=filename;
repeat
      begin
       readln(f, textzeile);
       if eof(f)=true then break;
      end;
until textzeile='[1]';

zaehl:=0;  //data:=1;
Repeat
funf:=false;
vier:=false;

{Datum suchen }
if textzeile[1]='1' then
begin

Delete(textzeile,1,2);
Delete(textzeile,3,length(textzeile));
val(textzeile,temptag,code);

end;

if (temptag = tag) then
begin

     IF textzeile[1]='5' Then funf:=true;
     If textzeile[1]='4' Then begin vier:=true; zaehl:=zaehl+1; end;
     if funf or vier then Delete(textzeile,1,2);
     If funf Then Begin Kosten:=kosten+Fnord(textzeile);  End;
     IF vier Then begin Sekunden:=sekunden+Fnord(textzeile); end;
end;

readln(f, textzeile);
Until Eof(f)=true;
Closefile(f);

     sekunde:=trunc(sekunden);
     Kosten:=Kosten/100;

     jahr:= datum;
     delete(jahr,5,length(jahr));
     delete(datum,1,10);
     delete(datum,3,4);
     if (kosten > 0) then
      For i:=1 to 200 do
          begin
             if geld[i].year=0 then
                begin
                  val(datum,geld[i].month,code);
                  val(jahr,geld[i].year,code);
                  geld[i].time:= sekunde;
                  geld[i].connect:= zaehl;
                  geld[i].cost:= Kosten;
                  geld[i].day:=tag;
                  written:=true;
                end;

             if written=true then break;
          end;
end;


procedure init_array;
var i: word;
begin
for i:=1 to 200 do
              begin
              geld[i].day:=0;
              geld[i].year:=0;
              geld[i].month:=0;
              geld[i].time:=0;
              geld[i].cost:=0;
              geld[i].connect:=0;
              end;

end;


function getmax(connect,cost,time,cost_per_time:boolean):real;
var i: integer;
    max:real;
begin

max:=0;
if cost=true then
   begin
        for i:=1 to 200 do
            begin
            if (geld[i].cost>max) then max:=geld[i].cost;
            end;
   end;
if connect=true then
   begin
        for i:=1 to 200 do
            begin
            if (geld[i].connect>max) then max:=geld[i].connect;
            end;
   end;

if time=true then
   begin
        for i:=1 to 200 do
            begin
            if (geld[i].time>max) then max:=geld[i].time;
            end;
   end;

if cost_per_time=true then
   begin
        for i:=1 to 200 do
            begin
            if geld[i].time > 0 then if (geld[i].cost/(geld[i].time/60)>max) then max:=geld[i].cost/(geld[i].time/60);
            end;
   end;
getmax:=max;
end;

procedure zeitumrechnen(zeit_in_sec: longint; var h,m,s: word);

begin
h:= zeit_in_sec div 3600;
m:= (zeit_in_sec mod 3600) div 60;
s:= zeit_in_sec mod 60;

end;


{---------HTML EXPORT ------------------------------------------------------}

function sonntage(monat, jahr: integer): integer;
var  ye,mo,da,dow1: word;
     i, diffdays, startday, dayofyear, y: integer;
begin
y:=0;
getdate(ye,mo,da,dow1);
//days:= 365;
dayofyear:=0;
//diffdays:=0;
startday:=1;
//if (ye mod 4 = 0) then begin days:=days+1; end;
For i:=1 to mo-1 do
begin
     dayofyear:= dayofyear+length_months[i];
     if (i = 2) and (ye mod 4 = 0) then dayofyear:= dayofyear+1;
end;
dayofyear:= dayofyear+da;
//sonntag:= da-dow1;

For i:=1 to monat-1 do
begin
     startday:= startday+length_months[i];
     if (i = 2) and (jahr mod 4 = 0) then startday:= startday+1;
end;

if ye=jahr then diffdays:= dayofyear-startday else
   begin
        diffdays:= 365-startday;
        if (jahr mod 4 =0) then diffdays:=diffdays+1;
        if jahr+1 <= y-1 then
        for i:= jahr+1 to ye-1 do
            begin
               diffdays:= diffdays+365;
               if (i mod 4 =0) then diffdays:=diffdays+1;
            end;
        diffdays:= diffdays+dayofyear;
   end;

diffdays:= diffdays-dow1;

while diffdays>7 do diffdays:=diffdays-7;



getdate(ye,mo,da,dow1);
if ((ye=jahr) and (mo=monat)) then
begin

if ((da-dow1)>31) then da:=da+7;
Repeat if ((da-dow1)>7) then da:=da-7; until ((da-dow1)<=7);
{writeln(da-dow1,' ',dow1,' ',da); }
sonntage:=da-dow1;

end else
if 1+diffdays = 8 then sonntage:=1 else sonntage:= 1+diffdays;

end;

procedure Connections(filename, newfilename: string);
var f,htm: text;
    textzeile:string;
    h,m,s: word;
    kosten,gesamtkosten: real;
    code: integer;
    sekunden: longint;

begin

gesamtkosten:=0;
{writeln(newfilename);readln;}
assignfile(htm,newfilename);
append(htm);
writeln(htm,'<p align=center><font size=+2>Einzelverbindungen ',filename,'</font></p>');
writeln(htm,'<table align=center border=0 width=550>');
writeln(htm,'<tr><td>Datum</td><td>Tarif</td><td>Uhrzeit</td><td>Surfzeit</td><td>Kosten [Euro] </td></tr>');


assignfile(f, FileName);
reset(f);
repeat
      begin
       readln(f, textzeile);
       if eof(f)=true then break;
      end;
until textzeile='[1]';

zaehl:=0;

Repeat
begin
     If textzeile[1]='1' {Tarif} Then
                  begin
                   zaehl:= zaehl+1;
                   Delete(textzeile,1,2);    {erste 2 zeichen löschen}
                   writeln(htm,'<tr><td>',textzeile,'</td>');
                   textzeile:=' ';
                  end;

     If textzeile[1]='2' {Tarif} Then
                  begin
                   Delete(textzeile,1,2);    {erste 2 zeichen löschen}
                   writeln(htm,'<td>',textzeile,'</td>');
                   textzeile:=' ';
                  end;
     If textzeile[1]='3' {Uhrzeit} Then
                  begin
                   Delete(textzeile,1,2);
                   writeln(htm,'<td>',textzeile,'</td>');
                   textzeile:=' ';
                  end;

     If textzeile[1]='4' {zeit in s} Then
                  begin
                   Delete(textzeile,1,2);
                   val(textzeile,sekunden,code);
                   zeitumrechnen(sekunden,h,m,s);
                   write(htm,'<td>');
                   if h<10 then write(htm,'0'); write(htm,h,':');
                   if m<10 then write(htm,'0'); write(htm,m,':');
                   if s<10 then write(htm,'0'); write(htm,s);
                   writeln(htm,'</td>');
                   textzeile:=' ';

                  end;
     IF textzeile[1]='5' {kosten} Then
                  begin
                   Delete(textzeile,1,2);
                   if textzeile[length(textzeile)-3]=',' then delete(textzeile,length(textzeile)-3,1);
                   insert('.',textzeile,length(textzeile)-2);
                   val(textzeile,kosten,code);
                   writeln(htm,'<td>',kosten/100:2:2,'</td></tr>');
                   gesamtkosten:= gesamtkosten+kosten;
                   textzeile:=' ';
                 end ;
end;

readln(f, textzeile);
Until Eof(f)=true;
Closefile(f);
writeln(htm,'<tr><td></td><td></td><td></td><td></td><td><b>',gesamtkosten/100:2:2,'</b></td></tr>');
writeln(htm,'</table><br><br>');
close(htm);
end;


procedure html_export(filename:string);
var f: text;
    monat, daycount,monatslaenge: integer;
    temp,i, jahr,code: integer;
    maximum,factor: real;
    oldfilename,tempo: string;
    m,d: word;
    h,min,s: word;

begin


maximum:= getmax(false,true,false,false); {Kosten}
daycount:=0;
m:= 0;
{verzeichnis_erzeugen('htm');}
//i:=0;
oldfilename:= filename;
{monatsl„nge bestimmen}

tempo:= oldfilename;

delete(tempo,5,length(tempo));
val(tempo,jahr,code);

tempo:=oldfilename;
delete(tempo,1,10);
delete(tempo,3,length(tempo));
val(tempo,monat,code);

if ((monat=2) and (jahr mod 4 = 0)) then monatslaenge:=29
else monatslaenge:= length_months[monat];
{monatslaenge bestimmen ende}

Assignfile(f,filename);
Append(f);

write(f,'<p align="center"><b>Legende</b> <img src="red.gif" width="20" height="10">: mind. ',
maxkostenrot/monatslaenge:2:2,' EUR/Tag ');
write(f,'<img src="yellow.gif" width="20" height="10">: mind. ',maxkostengelb/monatslaenge:2:2,' EUR/Tag ');
write(f,'<img src="blue.gif" width="20" height="10">: weniger als ',maxkostengelb/monatslaenge:2:2,' EUR/Tag ');
writeln(f,'<p align=center><font size=+2>Kosten ',oldfilename,'</font></p>');
writeln(f,'<Table align="center" height="400" border=0 cellspacing="0" ><tr>');

d:= sonntage(monat,jahr);
for i:= 1 to monatslaenge do
begin

if i=d then begin writeln(f,'<td valign="bottom"  background="bgred.jpg">'); d:= d+7; end else
writeln(f,'<td valign="bottom"  background="bg.jpg">');

For temp:=monatslaenge downto 1 do
begin
if geld[temp].day=i then begin daycount:=temp; break end;
end;

if geld[daycount].day = i then begin

                            factor:= geld[daycount].cost/maximum * 400;
                            if geld[daycount].cost > (maxkostenrot/monatslaenge) then
                            writeln(f,'<img src="red.gif" width=20 height="',round(factor),
                            '" border=0 title="',geld[daycount].cost:3:2,' Euro">');

                            if ((geld[daycount].cost > (maxkostengelb/monatslaenge))
                            and (geld[daycount].cost <= (maxkostenrot/monatslaenge))) then
                            writeln(f,'<img src="yellow.gif" width=20 height="',round(factor),
                            '" border=0 title="',geld[daycount].cost:3:2,' Euro">');

                            if ((geld[daycount].cost <= (maxkostengelb/monatslaenge))) then
                            writeln(f,'<img src="blue.gif" width=20 height="',round(factor),
                            '" border=0 title="',geld[daycount].cost:3:2,' Euro">');

                            daycount:= daycount+1;
                          end
                   else  writeln(f,'<img src="blue.gif" width=20 height="1" border=0 title="0">');

writeln(f,'</td>');
end;
writeln(f,'</tr>');
writeln(f,'<tr align="center">');

For i:=1 to monatslaenge do writeln(f,'<td>',i,'</td>');
writeln(f,'</tr>');


writeln(f,'</Table>');
writeln(f,'<br><br>');


maximum:= getmax(false,false,true,false); {Time}
daycount:=0;
h:= 0; min:=0; s:=0;

writeln(f,'<p align=center><font size=+2>Verbindungsdauer ',oldfilename,'</font></p>');
writeln(f,'<Table align="center" height="400" border=0 cellspacing="0" ><tr>');

d:= sonntage(monat,jahr);
for i:= 1 to monatslaenge do
begin
if i=d then begin writeln(f,'<td valign="bottom"  background="bgred.jpg">'); d:= d+7; end else
writeln(f,'<td valign="bottom"  background="bg.jpg">');


For temp:=monatslaenge downto 1 do
begin
if geld[temp].day=i then begin daycount:=temp; break end;
end;

zeitumrechnen(geld[daycount].time,h,min,s);

if geld[daycount].day = i then begin
                            factor:= geld[daycount].time/maximum * 400;
                            if geld[daycount].cost > (maxkostenrot/monatslaenge) then
                            writeln(f,'<img src="red.gif" width=20 height="',round(factor),
                            '" border=0 title="',h ,' h ',m ,' min ',s ,' s">');

                            if ((geld[daycount].cost > (maxkostengelb/monatslaenge))
                            and (geld[daycount].cost <= (maxkostenrot/monatslaenge))) then
                            writeln(f,'<img src="yellow.gif" width=20 height="',round(factor),
                            '" border=0 title="',h ,' h ',m ,' min ',s ,' s">');

                            if ((geld[daycount].cost <= (maxkostengelb/monatslaenge))) then
                            writeln(f,'<img src="blue.gif" width=20 height="',round(factor),
                            '" border=0 title="',h ,' h ',m ,' min ',s ,' s">');

                            daycount:= daycount+1;
                          end
                   else  writeln(f,'<img src="blue.gif" width=20 height="1" border=0 title="0">');

writeln(f,'</td>');
end;
writeln(f,'</tr>');
writeln(f,'<tr align="center">');

For i:=1 to monatslaenge do writeln(f,'<td>',i,'</td>');
writeln(f,'</tr>');


writeln(f,'</Table>');
writeln(f,'<br><br>');


maximum:= getmax(true,false,false,false); {Connect}
daycount:=0;

writeln(f,'<p align=center><font size=+2>Verbindungen ',oldfilename,'</font></p>');
writeln(f,'<Table align="center" height="400" border=0 cellspacing="0" ><tr>');

d:= sonntage(monat,jahr);
for i:= 1 to monatslaenge do
begin
if i=d then begin writeln(f,'<td valign="bottom"  background="bgred.jpg">'); d:= d+7; end else
writeln(f,'<td valign="bottom"  background="bg.jpg">');


For temp:=monatslaenge downto 1 do
begin
if geld[temp].day=i then begin daycount:=temp; break end;
end;

if geld[daycount].day = i then begin

                            factor:= geld[daycount].connect/maximum * 400;
                            if geld[daycount].cost > (maxkostenrot/monatslaenge) then
                            writeln(f,'<img src="red.gif" width=20 height="',round(factor),
                            '" border=0 title="',geld[daycount].connect,' Verbindungen">');

                            if ((geld[daycount].cost > (maxkostengelb/monatslaenge))
                            and (geld[daycount].cost <= (maxkostenrot/monatslaenge))) then
                            writeln(f,'<img src="yellow.gif" width=20 height="',round(factor),
                            '" border=0 title="',geld[daycount].connect,' Verbindungen">');

                            if ((geld[daycount].cost <= (maxkostengelb/monatslaenge))) then
                            writeln(f,'<img src="blue.gif" width=20 height="',round(factor),
                            '" border=0 title="',geld[daycount].connect,' Verbindungen">');

                            daycount:= daycount+1;
                          end
                   else  writeln(f,'<img src="blue.gif" width=20 height="1" border=0 title="0">');

writeln(f,'</td>');
end;
writeln(f,'</tr>');
writeln(f,'<tr align="center">');

For i:=1 to monatslaenge do writeln(f,'<td>',i,'</td>');
writeln(f,'</tr>');


writeln(f,'</Table>');
writeln(f,'<br><br>');


maximum:= getmax(false,false,false,true); {Kosten/Time}
daycount:=0;

writeln(f,'<p align=center><font size=+2>durchschnittl. Kosten pro Minute ',oldfilename,'</font></p>');
writeln(f,'<Table align="center" height="400" border=0 cellspacing="0" ><tr>');
d:= sonntage(monat,jahr);
for i:= 1 to monatslaenge do
begin
if i=d then begin writeln(f,'<td valign="bottom"  background="bgred.jpg">'); d:= d+7; end else
writeln(f,'<td valign="bottom"  background="bg.jpg">');

For temp:=monatslaenge downto 1 do
begin
if geld[temp].day=i then begin daycount:=temp; break end;
end;

if geld[daycount].day = i then begin

                            factor:= (geld[daycount].cost/(geld[daycount].time/60)) /maximum * 400;


                            if geld[daycount].cost > (maxkostenrot/monatslaenge) then
                            writeln(f,'<img src="red.gif" width=20 height="',round(factor),
                            '" border=0 title="',factor*maximum/400:0:3,' EUR/min">');

                            if ((geld[daycount].cost > (maxkostengelb/monatslaenge))
                            and (geld[daycount].cost <= (maxkostenrot/monatslaenge))) then
                            writeln(f,'<img src="yellow.gif" width=20 height="',round(factor),
                            '" border=0 title="',factor*maximum/400:0:3,' EUR/min">');

                            if ((geld[daycount].cost <= (maxkostengelb/monatslaenge))) then
                            writeln(f,'<img src="blue.gif" width=20 height="',round(factor),
                            '" border=0 title="',factor*maximum/400:0:3,' EUR/min">');

                            daycount:= daycount+1;
                          end
                   else  writeln(f,'<img src="blue.gif" width=20 height="1" border=0 title="0">');

writeln(f,'</td>');
end;
writeln(f,'</tr>');
writeln(f,'<tr align="center">');

For i:=1 to monatslaenge do writeln(f,'<td>',i,'</td>');
writeln(f,'</tr>');
writeln(f,'</table>');
writeln(f,'<br>');

writeln(f,'<p align=center><font size="-1"><b>Statistik erstellt mit <a href="http://www.leastcosterxp.de">LeastCosterXP</a> von <a href="mailto:leastcosterxp-owner@yahoogroups.de"> Stefan Fruhner </a></b></font></p>');
writeln(f,'</body></html>');

closefile(f);
end;




procedure input_date(y,m,d,dow: word);
var a, zeile: string;
    i: integer;
 begin
                 init_array;
                 str(y,a);
                 zeile:=a;
                 insert('\',zeile, length(zeile)+1);
                 insert(a,zeile, length(zeile)+1);
                 insert('_',zeile, length(zeile)+1);
                 str(m,a);
                 if m<10 then insert('0',a, length(a));
                 insert(a,zeile, length(zeile)+1);
                 insert('.txt',zeile, length(zeile)+1);

                 if fileexists(zeile) then  
                 begin
                 for i:=1 to 31 do begin gesamtkosten_pro_monat(zeile,i); end;
                 html_export(zeile);
                 delete(zeile,length(zeile)-3,4);
                 insert('.htm',zeile, length(zeile)+1);


 end;
end;

procedure input_file(filename: string);
var zeile: string;
    i: integer;
 begin           zeile:= filename;
                 init_array;
                 if fileexists(ExtractFilePath(Application.ExeName)+zeile) then
                 begin
                 for i:=1 to 31 do begin gesamtkosten_pro_monat(ExtractFilePath(Application.ExeName)+zeile,i); end;
                 html_export(zeile);
                 delete(zeile,length(zeile)-3,4);
                 insert('.htm',zeile, length(zeile)+1);

 end;
end;

end.
