unit tarife;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, inifiles, StdCtrls, Buttons, ValEdit, Spin, Gauges, unit1, DateUtils,
  ExtCtrls, ComCtrls;

type
  Ttarif = class(TForm)
    liste: TStringGrid;
    stelle: TSpinEdit;
    Label1: TLabel;
    tarifname: TLabel;
    fort: TGauge;
    Timer1: TTimer;
    start: TDateTimePicker;
    ende: TDateTimePicker;
    namen: TComboBox;
    Label2: TLabel;
    BitBtn1: TBitBtn;

    procedure stelleChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure namenChange(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tarif: Ttarif;

implementation

uses detect;

{$R *.dfm}


procedure zeitumrechnen(zeit_in_sec: longint; var h,m,s: word);

begin
h:= zeit_in_sec div 3600;
m:= (zeit_in_sec mod 3600) div 60;
s:= zeit_in_sec mod 60;
end;

procedure Ttarif.stelleChange(Sender: TObject);
var   ini: Tinifile;
      i, j, endzeit, fenster: integer;
      startzeit: TDateTime;
      mittel: real;
      mitte: string;
      h,m,s: word;
      h1,m1,s1: string;
begin
if sender=stelle then
begin

start.Date:= strtodate('01.01.2000');
Ende.Date:= strtodate('01.01.3000');
end;
ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'kostenpertarif.dat');
// INI-Datei erstellen (falls nicht vorhanden) und initialisieren
liste.rowcount:=2;
liste.FixedRows:=1;

fenster:=ini.ReadInteger(inttostr(stelle.value), 'fenster', 2);
tarifname.Caption:= 'Tarif: '+ini.ReadString(inttostr(stelle.value),'tarif','leer');
 with liste do
    for I := 1 to fenster do
        begin
              startzeit:=ini.ReadDateTime(inttostr(stelle.value), 'start_'+inttostr(i), EncodeDateTime(1970,01,01,0,0,0,0)) ;
//              showmessage(datetostr(dateof(startzeit)));
//              showmessage(datetostr(start.date) +'  '+datetostr(dateof(startzeit)) + '  '+datetostr(ende.date));

              if (dateof(startzeit) >=incday(start.Date,-1)) and (dateof(startzeit) <=ende.Date)
              then begin

               Rowcount:=rowcount+1;
              Cells[0,rowcount-2] := DatetimetoStr(startzeit);

              mittel:= ini.ReadFloat(inttostr(stelle.value), 'mittel_'+inttostr(i), 0) ;
              str(mittel:4:3, mitte);
              zeitumrechnen(ini.Readinteger(inttostr(stelle.value), 'dauer_'+inttostr(i), 0),h,m,s) ;
              if h<10 then h1:= '0' + inttostr(h) else h1:= inttostr(h);
                            if m<10 then m1:= '0' + inttostr(m) else m1:= inttostr(m);
                                          if s<10 then s1:= '0' + inttostr(s) else s1:= inttostr(s);
              Cells[1,rowcount-2] := mitte;
              Cells[2,rowcount-2] := h1 + ':'+m1 + ':'+s1;
              Cells[3,rowcount-2] := ini.ReadString(inttostr(stelle.value), 'xcost_'+inttostr(i), '-') ;
              Cells[4,rowcount-2] := ini.ReadString(inttostr(stelle.value), 'dow_'+inttostr(i), '-') ;
              end;
            end;

liste.Rowcount:=liste.rowcount-1;
if (liste.rowcount > 1) and (sender=stelle) then
begin
start.Date:= dateof(strtodatetime(liste.Cells[0,1]));
ende.Date:= dateof(strtodatetime(liste.Cells[0,liste.rowcount-1]));
end;
end;

procedure scannen;
var   ini, cst: Tinifile;
      i, j,  fenster, tarifpos, countcst, count,check: integer;
      temptarif, temptarifcst, xcost, last1, last2, last4, last3, xlast1, xlast2, xlast3, xlast4,xlast5: string;
      eur, eurpermin: real;
      time, stunden : integer;
      tmp,tmp2 :string;

begin

cst := TIniFile.Create(cfg[6]+'ple.cst');
ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'kostenpertarif.dat');
// INI-Datei erstellen (falls nicht vorhanden) und initialisieren
countcst := cst.ReadInteger('online', 'count', 0);
check:=1; //stunden:=1;

xlast1:= ini.ReadString('last','1','Not found.');
xlast2:= ini.ReadString('last','2','Not found.');
xlast3:= ini.ReadString('last','3','Not found.');
xlast4:= ini.ReadString('last','4','Not found.');



for i:=1 to countcst do
begin
last1:= cst.ReadString(inttostr(i),'1','Not found.');
last2:= cst.ReadString(inttostr(i),'2','Not found.');
last3:= cst.ReadString(inttostr(i),'3','Not found.');
last4:= cst.ReadString(inttostr(i),'4','Not found.');


if ((last1=xlast1) and (last2=xlast2) and (last3=xlast3) and (last4=xlast4)) then
begin
check:=ini.ReadInteger('last','count',1);
break;
end;
end;
check:= check+1;

if not countcst-check=0 then begin
tarif.fort.maxvalue:= countcst;
tarif.fort.minvalue:= check;
end;

for i:= check to countcst do
begin
  stunden:=1;
  xlast1:= cst.ReadString(inttostr(i),'1','Not found.');
  xlast2:= cst.ReadString(inttostr(i),'2','Not found.');
  xlast3:= cst.ReadString(inttostr(i),'3','Not found.');
  xlast4:= cst.ReadString(inttostr(i),'4','Not found.');
  xlast5:= cst.ReadString(inttostr(i),'5','Not found.');

   tmp:= xlast3; tmp2:=tmp;
  {xlast3 entspricht starttime}
 //  Delete(xlast3,3, length(xlast3)-2);
  {ende xlast3}

   {Startminuten ausrechnen}
   delete(tmp,1,3);
   delete(tmp,3,length(tmp)-2);
  // startmin:= strtoint(tmp);

  {sortieren und berechnen}
  eur:= cst.ReadFloat(inttostr(i),'5',0);
  time:= cst.ReadInteger(inttostr(i),'4',0);


  ini.WriteString('last', '1', xlast1);
  ini.WriteString('last', '2', xlast2);
  ini.WriteString('last', '3', tmp2);
  ini.WriteString('last', '4', xlast4);
  ini.Writeinteger('last', 'count', i);

  if ((time mod 60) > 0) then time:= (time div 60) + 1 else time:= (time div 60);
  eurpermin:= (eur/time);

  count := ini.ReadInteger('count', 'Anzahl', 0);
  tarifpos:= count+1;  temptarif:='';
  temptarifcst:= cst.ReadString(inttostr(i),'2','Not found.');
  xcost:= cst.ReadString(inttostr(i),'5','Not found.');
  for j:=1 to count do
    begin
     temptarif:= ini.ReadString(inttostr(j),'tarif','Not found.');

     if  lowercase(temptarifcst) = lowercase(temptarif) then tarifpos:= j;
    end;
 fenster := ini.ReadInteger(inttostr(tarifpos), 'fenster', 0);
 if not (tarifpos < count+1) then ini.WriteInteger('count', 'Anzahl', count+1);

 ini.WriteString(inttostr(tarifpos), 'tarif', temptarifcst);
 ini.WriteInteger(inttostr(tarifpos), 'fenster', fenster+1);
 ini.WriteString(inttostr(tarifpos), 'dow_'+inttostr(fenster+1),   inttostr(dayoftheweek(strtodate(xlast1))));
 ini.WriteString(inttostr(tarifpos), 'xcost_'+inttostr(fenster+1), xlast5);
 ini.WriteString(inttostr(tarifpos), 'dauer_'+inttostr(fenster+1), xlast4);
 ini.WriteString(inttostr(tarifpos), 'start_'+inttostr(fenster+1), xlast1+' '+xlast3);
 ini.WriteFloat(inttostr(tarifpos), 'mittel_'+inttostr(fenster+1), eurpermin);

 tarif.fort.Progress:=i;


end;
ini.Free;
cst.Free;

ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'tarife.ini');
tarif.stelle.MaxValue := ini.ReadInteger('count', 'Anzahl', 0);
tarif.stelle.Value:=2;
tarif.stelle.Value:=1;
tarif.liste.Cells[0,0] := 'Datum' ;
tarif.liste.Cells[1,0] := 'Mittelwert [Cent]' ;
tarif.liste.Cells[2,0] := 'Surfdauer' ;
tarif.liste.Cells[3,0] := 'Gesamtkosten' ;
tarif.liste.Cells[4,0] := 'Wochentag' ;
end;


procedure Ttarif.FormActivate(Sender: TObject);
begin

timer1.Enabled:= true;
end;

procedure Ttarif.BitBtn1Click(Sender: TObject);
begin
stellechange(sender);
end;


procedure Ttarif.Timer1Timer(Sender: TObject);
var   ini: Tinifile;
      i: integer;
begin
timer1.Enabled:=false;
scannen;
ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'kostenpertarif.dat');
stelle.MaxValue := ini.ReadInteger('count', 'Anzahl', 0);
stelle.Value:=2;
stelle.Value:=1;
liste.Cells[0,0] := 'Datum' ;
liste.Cells[1,0] := 'Mittelwert [Cent]' ;
liste.Cells[2,0] := 'Surfdauer' ;
liste.Cells[3,0] := 'Gesamtkosten' ;
liste.Cells[4,0] := 'Wochentag' ;

for i:=1 to stelle.maxvalue do
begin
namen.Items.Append(ini.readstring(inttostr(i),'tarif','kein Tarif'));
namen.itemindex:=0;
end;


ini.free;


fort.Enabled:=false;
fort.Visible:=false;
end;

procedure Ttarif.namenChange(Sender: TObject);
begin
stelle.Value:= namen.ItemIndex+1;
end;

end.
