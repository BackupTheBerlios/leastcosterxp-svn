unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls, dateutils, shellapi, Strutils,
  Buttons, ExtCtrls, inifiles, Gauges;

type
  TMoveSG = class(TCustomGrid); // reveals protected MoveRow procedure
  Tauswert = class(TForm)
    Datepick1: TDateTimePicker;
    DatePick2: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    ok: TBitBtn;
    FormatBox: TComboBox;
    Ausgabeformat: TLabel;
    Exportiere: TBitBtn;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Caption: TLabel;
    SaveDialog1: TSaveDialog;
    Sortbox: TComboBox;
    Sortierung: TLabel;
    TimePick1: TDateTimePicker;
    TimePick2: TDateTimePicker;
    errormsg: TLabel;
    ProgressPanel: TPanel;
    Progress1: TProgressBar;
    Progress2: TProgressBar;
    Panel2: TPanel;
    Grid: TStringGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    FilterName: TEdit;
    Filter: TCheckBox;
    sizer: TPanel;
    deletelist: TPanel;
    procedure GridColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sizerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sizerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure deletelistMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure deletelistMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FilterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ReSetProgress;
    procedure GridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure TimePick1Change(Sender: TObject);
    procedure TimePick2Change(Sender: TObject);
    procedure SortboxCloseUp(Sender: TObject);
    procedure okClick(Sender: TObject);
    procedure Datepick1Change(Sender: TObject);
    procedure ExportiereClick(Sender: TObject);
    procedure exportcsv;
    procedure BitBtn2Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Datepick1DropDown(Sender: TObject);

   procedure SortGrid(Grid : TStringGrid; SortCol,start,ende:integer);
   procedure Sortby2Col(Grid : TStringGrid; SortCol:integer; col2: integer);
   procedure readin;
   procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
   procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
   procedure GridDblClick(Sender: TObject);
   procedure SaveComments;

  private
    { Private declarations }
    posleft: integer;
    postop : integer;
    nomove: boolean;
    sort_descending: boolean;
    liste_clicked, liste_rand: boolean;
    col_Nr, col_Datum, col_Uhrzeit,
      col_Dauer, col_Kosten, col_Tarif,
      col_getrennt, col_Rufnr, col_notiz: integer;
    start_date, end_date: TDateTime;
    last_x: integer;  
  public
    { Public declarations }
  end;

var
  auswert: Tauswert;
  Column, Row: Longint;
  lastsorted: integer;
  ascending : boolean;
  sortedbytarif, sortedbyrufnummer: boolean;

implementation

uses Unit1, gridEvents, inilang, messagestrings;

{$R *.dfm}


procedure SetGridSize;
var i: integer;
begin
auswert.panel2.height:= auswert.height - auswert.panel2.top - 10;

for i:= 0 to auswert.grid.ColCount -1 do
auswert.grid.ColWidths[i]:= round(auswert.Grid.Width/auswert.grid.colcount);

auswert.progresspanel.Left:= round(auswert.Grid.width/2 - auswert.progresspanel.Width/2);

end;

procedure SetCursor_Wait;
var h: THandle;
begin
  h:=LoadImage(0,PChar(ExtractFilepath(paramstr(0)) +'wait.ani'),IMAGE_CURSOR,0,0,LR_DEFAULTSIZE or LR_LOADFROMFILE);
  if h=0 then Screen.Cursor:= CrHourglass
  else begin
    Screen.Cursors[1]:=h;
    Screen.Cursor:= 1;
  end;
 with auswert do
 begin
  Exportiere.enabled:= false;
  bitbtn1.enabled:= false;
  sortbox.enabled:= false;
  FormatBox.enabled:= false;
  deletelist.enabled:= false;
  Datepick1.enabled:= false;
  Datepick2.enabled:= false;
  Timepick1.enabled:= false;
  Timepick2.enabled:= false;
 end;
end;

procedure SetCursor_Default;
begin
screen.Cursor:= crDefault;
with auswert do
begin
  Exportiere.enabled:= true;
  bitbtn1.enabled:= true;
  sortbox.enabled:= true;
  FormatBox.enabled:= true;
  deletelist.enabled:= true;
  Datepick1.enabled:= true;
  Datepick2.enabled:= true;
  Timepick1.enabled:= true;
  Timepick2.enabled:= true;
end;
end;


procedure Tauswert.FormClose(Sender: TObject; var Action: TCloseAction);
var i: integer;
begin

 deletelistmouseup(sender, mbleft,[ssleft],0,0);

 exportiere.Enabled:= false;

 settings.WriteInteger('EVN','colcount',grid.Colcount);
 for i:= 0 to grid.ColCount-1 do
   begin
     settings.WriteInteger('EVN','col'+inttostr(i),grid.ColWidths[i]);
     settings.Writestring('EVN','pos'+inttostr(i),grid.cells[i,0]);
   end;
 settings.Writeinteger('EVN','Sortierung',sortbox.ItemIndex);
 settings.writeinteger('EVN','Export',Formatbox.ItemIndex);
 hauptfenster.enabled:= true;
 auswert.Release;
 auswert:= nil;
end;

procedure Tauswert.readin;
var line, temp: string;
    zeichen: string[1];
    i, row, tab, pretabcount: integer;
    checkdate: tdatetime;
    checkmonth: string;
    Data: TStringlist;
    datalines: integer;
begin
row:= 0;
lastsorted:= -1;

//grid leeren
grid.RowCount:=2;
grid.Rows[1].Clear;

checkdate:= datepick1.DateTime; //Anfangsdatum setzen
repeat
//Dateinamen identifizieren
if monthof(checkdate) > 9 then checkmonth:= inttostr(monthof(checkdate))
else checkmonth:= '0'+inttostr(monthof(checkdate));

if fileexists(extractfilepath(paramstr(0))+'log\'+inttostr(yearof(checkdate))+'_'+checkmonth+'.csv') then
begin
  data:= TStringlist.Create;
  Data.LoadFromFile(extractfilepath(paramstr(0))+'log\'+inttostr(yearof(checkdate))+'_'+checkmonth+'.csv');

  For Datalines:=0 to Data.Count-1 do
  begin
   tab:= 0;
   pretabcount:=0;
   line:= Data.Strings[Datalines];

   row:= row+1;
   if row+1 > grid.rowcount then grid.RowCount:= grid.RowCount+1;
   temp:= line;

  //Zeile in Stringgrid eintragen
   for i:= 1 to length(line) do //zeile scannen
   begin
    zeichen:= line[i];

    delete(temp,1,pretabcount); //temp vorn abschneiden
    if zeichen = chr(9) then
    begin
      tab:= tab+1;
      delete(temp,i-pretabcount,length(temp)-(i-pretabcount)+1); //hinten abschneiden
      //erste Spalte numerieren
      if tab = 1 then grid.Cells[tab-1,row]:= inttostr(row)
       //alle anderen mit inhalt füllen
       else grid.Cells[tab-1,row]:= temp;

       pretabcount:= i; //merken der letzten tabstelle

      temp:='';
    end;  //ende der if chr(9)
    // die letzte Spalte muss manuell eingetragen werdne, da am Ende kein tab mehr kommt
    if i = length(line) then
       grid.Cells[tab,row]:= temp;


    temp:= line; //nächste Spalte
   end; // ende der for-schleife > weiter zur nächsten zeile

 //wenn Daten ausserhalb des Bereichs dann wieder löschen
    if  ( Dateof(Strtodate(grid.cells[1,row]))+ Timeof(strtotime(grid.cells[2,row])) < datepick1.DateTime )
       or ( Dateof(Strtodate( grid.cells[1,row]))+ TimeOf(strtotime(grid.cells[2,row])) > datepick2.DateTime)
       then
        begin
          row:= row-1;
          if (grid.rowcount > 2) then grid.RowCount:= grid.RowCount-1
          else
          if (grid.rowcount = 2) then grid.rows[1].clear;
        end;
   end; //Data durchgehen

  Data.free;

end; // von "if filexists"
checkdate:= incmonth(dateof(checkdate),1);
until (checkdate > incmonth(datepick2.DateTime,1));


//Überschriften setzen
grid.cells[0,0]:= misc(M135,'M135');
grid.cells[1,0]:= misc(M136,'M136');
grid.cells[2,0]:= misc(M137,'M137');
grid.cells[3,0]:= misc(M138,'M138');
grid.cells[4,0]:= misc(M139,'M139');
grid.cells[5,0]:= misc(M140,'M140');
grid.cells[6,0]:= misc(M141,'M141');
grid.cells[7,0]:= misc(M142,'M142');
grid.cells[8,0]:= misc(M143,'M143');

//Spalten
GridColumnMoved(self, 0,1);

end;

procedure Tauswert.Sortgrid(Grid : TStringGrid; SortCol, start, ende:integer);
var
   i,j : integer;
   dummy1, dummy2: real;
   code1, code2: integer;
   tickcount: Cardinal;
begin
 if (sortcol > -1) //wenn Maus ausserhalb der Zelle war
 then
 begin
  //GaugePanel.Visible:= true;
  progress1.min:= start;
  progress1.max:= ende;
  tickcount:= GetTickCount;

  with Grid do
  //erste Zeile nicht mitsortieren
  for i := start{-1 } to ende - 2 do  {because last row has no next row}
  for j:= i+1 to ende-1 do
  begin
   if (cells[sortcol,0] =  misc(M135,'M135')) or (cells[sortcol,0] =  misc(M142,'M142')) or (cells[sortcol,0] =  misc(M139,'M139')) then //numerisch sortieren
   begin
      if grid.Cells[Sortcol,j]='' then grid.Cells[Sortcol,j]:='-10';
      if grid.Cells[Sortcol,i]='' then grid.Cells[Sortcol,i]:='-10';

      grid.Cells[Sortcol,j]:= ansireplacestr(grid.Cells[Sortcol,j],',','.');
      grid.Cells[Sortcol,i]:= ansireplacestr(grid.Cells[Sortcol,i],',','.');

      val(grid.Cells[Sortcol,j], dummy1,code1);
      val(grid.Cells[Sortcol,i], dummy2,code2);
      if code1 <> 0 then dummy1:= 999999999;
      if code2 <> 0 then dummy2:= 999999999;
      if not sort_descending then
      begin
       if dummy1 < dummy2 then ExchangeRows(grid, i, j);
      end
      else
       if dummy1 > dummy2 then ExchangeRows(grid, i, j);

      grid.Cells[Sortcol,j]:= ansireplacestr(grid.Cells[Sortcol,j],'.',',');
      grid.Cells[Sortcol,i]:= ansireplacestr(grid.Cells[Sortcol,i],'.',',');

     if grid.Cells[Sortcol,j]='-10' then grid.Cells[Sortcol,j]:='';
     if grid.Cells[Sortcol,i]='-10' then grid.Cells[Sortcol,i]:='';

   end else //alphbetisch sortieren
   begin
  if not sort_descending then
      begin
        if AnsiCompareText(Cells[SortCol, i], Cells[SortCol,j]) > 0
           then ExchangeRows(grid, i, j);
       end
  else
      if AnsiCompareText(Cells[SortCol, i], Cells[SortCol,j]) < 0
           then ExchangeRows(grid, i, j);

    end;
  progress1.position:= i+2;
  if gettickcount - tickcount > 50 then progressPanel.Visible:= true; 
  end; //end der innere For-Schleife

  lastsorted:= Sortcol;
 end;
 progresspanel.Visible:= false;
end;

procedure Tauswert.Sortby2Col(Grid : TStringGrid; SortCol:integer; col2: integer);
var
   i,j : integer;
   start, ende: integer;
   dat, vgldat: TDate;
   tickcount: cardinal;
begin
 tickcount:= gettickcount;

 if grid.cells[sortcol,0]= misc(M140,'M140') then sortedbytarif:= true else sortedbytarif:= false;
 if grid.cells[sortcol,0]= misc(M142,'M142') then sortedbyrufnummer:= true else sortedbyrufnummer:= false;

 if sortcol > -1 then //wenn Maus ausserhalb der Zelle war
 begin

  progress2.min:=  grid.FixedRows;
  progress2.max:=  grid.RowCount - 2;

  with Grid do
  //erste Zeile nicht mitsortieren
  for i := FixedRows{-1 } to RowCount - 2 do  {because last row has no next row}
  for j:= i+1 to rowcount-1 do
  begin
   if cells[sortcol,0] =  misc(M135,'M135') then //numerisch sortieren
   begin
   end else
   //ascending
   if not (grid.cells[sortcol,0]= misc(M136,'M136')) then
   begin
    if not sort_descending then
    begin
     if AnsiCompareText(Cells[SortCol, i], Cells[SortCol,j]) > 0
      then ExchangeRows(grid, i, j);
    end
    else
    if AnsiCompareText(Cells[SortCol, i], Cells[SortCol,j]) < 0
      then ExchangeRows(grid, i, j);
    end
    else //wenn nach Datum zu sortieren
    begin
    dat:= strtodate(Cells[SortCol, i]);
    vgldat:= strtodate(Cells[SortCol,j]);
    if not sort_descending then
    begin
     if dat > vgldat then ExchangeRows(grid, i, j);
    end
    else
     if dat < vgldat then ExchangeRows(grid, i, j);
    end;
    progress2.position:= i;
    if gettickcount - tickcount > 50 then progresspanel.Visible:= true;
  end;
  lastsorted:= Sortcol;

//zweiter Durchgang um nach Spalte col2 zu sortieren
 start:= 1;

 progress2.min:= 1;
 progress2.Max:= grid.rowcount-2;

 for i:= 1 to grid.RowCount-2 do
   if AnsiCompareText(grid.Cells[SortCol, i], grid.Cells[SortCol,i+1]) <> 0
    then begin
         ende:= i+1;
         if ende-start > 0 then sortgrid(grid,col2,start,ende);
         start:= ende;
         progress2.Position:= i;
         if gettickcount - tickcount > 50 then progresspanel.Visible:= true;
         end;
  //letzter Block muss sortiert werden, ENDE ist ja bekannt
 if i = grid.RowCount-1 then sortgrid(grid,col2,start,grid.rowcount);
end;
 progresspanel.Visible:= false;
end;

procedure Tauswert.ReSetProgress;
begin
  progress1.min:= 0;
  progress2.min:= 0;
  progress1.max:= 100;
  progress2.max:= 100;
  progress1.Position:= 0;
  progress2.Position:= 0;
  progress1.Top:= 27;
  progress2.visible:= true;
  ProgressPanel.Visible:= false;
end;

procedure Tauswert.GridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: integer;
    timecol, nrcol, tarifcol: integer;
begin
if not liste_clicked then exit;
liste_clicked:= false;

grid.repaint;
//wenn nur ein Datensatz geladen, dann keine Sortierung notwendig
if grid.rowcount < 3 then exit;

for i:=grid.leftcol to grid.ColCount -1 do
if (grid.ColWidths[i] > grid.width) then grid.ColWidths[i]:= grid.Width-30;

for i:=0  to grid.ColCount -1 do
 begin
  if ansicontainstext(grid.Cells[i,0],misc(M137,'M137')) then timecol:=i;
  if (grid.Cells[i,0]= misc(M135,'M135')) then nrcol:=i;
  if (grid.Cells[i,0]= misc(M140,'M140')) then tarifcol:=i;
 end;

if column = -1 then exit;

sortedbytarif:= false;
sortedbyrufnummer:= false;

with grid do
  if (y<=rowheights[0]) and (abs(x-last_x) < 5) then //wenn erste Zeile geklickt
  begin

  SetCursor_Wait;
  errormsg.caption:= misc(M144,'M144');
  errormsg.Refresh;
  grid.Enabled:= false;
  grid.Font.Color:= clSilver;
  grid.selection:= TGridRect(Rect(-1,-1,-1,-1));
  grid.DefaultDrawing:= false;
//  ProgressPanel.visible:= true;
//  grid.refresh;
//  progresspanel.refresh;

  if grid.Cells[column,0]= misc(M136,'M136') then  sortbox.itemindex:= 0
  else
  if grid.Cells[column,0]= misc(M137,'M137') then  sortbox.itemindex:= 1
  else
  if grid.Cells[column,0]= misc(M138,'M138') then  sortbox.itemindex:= 2
  else
  if grid.Cells[column,0]= misc(M139,'M139') then  sortbox.itemindex:= 3
  else
  if grid.Cells[column,0]= misc(M140,'M140') then  sortbox.itemindex:= 4
  else
  if grid.Cells[column,0]= misc(M142,'M142') then  sortbox.itemindex:= 5
  else
  if grid.Cells[column,0]= misc(M135,'M135') then  sortbox.itemindex:= 6;

  if grid.Tag = column then sort_descending:= not sort_descending else sort_descending:= false;
  grid.Tag:= column;
  grid.Repaint;

  if column <> -1 then
   if ((grid.Cells[column,0]= misc(M142,'M142')) or (grid.Cells[column,0]=misc(M140,'M140')))
    then sortby2Col(grid,column,nrcol)
   else
   if ansicontainstext(grid.Cells[column,0],misc(M136,'M136'))
    then Sortby2Col(Grid,column,timecol)
   else
   begin
    progress2.Visible:= false;
    progress1.top:= 16;
    sortgrid(grid,column, 1,grid.rowcount);
   end;
   filterclick(self);
   end;

if not filter.checked then filtername.Text:= grid.cells[tarifcol,row];

SetCursor_Default;
errormsg.caption:= '';
grid.Enabled:= true;
grid.Font.Color:= clWindowText;
Resetprogress;
grid.DefaultDrawing:= true;
grid.Refresh;
end;


procedure Tauswert.FormCreate(Sender: TObject);
begin
 CL:=loadIni('lang\'+settings.readstring('LeastCoster','language',''));
 if CL<>nil then fillProps([auswert],CL);

 hauptfenster.Enabled:= false;
 nomove:= false;
 auswert.Top:= hauptfenster.Top;
 auswert.left:= round((screen.width - auswert.width)/2);
 auswert.height:= 145;

 sortedbytarif:= false;
 sortedbyrufnummer:= false;

 datepick2.Date:= dateof(now);
 timepick2.Time:= EncodeTime(23,59,59,0);//strtotime('23:59:59');
 datepick2.Time:= timepick2.Time;

 datepick1.Date:= encodedate(yearof(now), monthof(now),1);//strtodate('01.'+inttostr(monthof(now))+'.'+inttostr(yearof(now)));
 timepick1.time:= EncodeTime(0,0,0,0);//strtotime('00:00:00');
 datepick1.Time:= timepick1.Time;

 sortbox.itemindex  :=    settings.ReadInteger('EVN','Sortierung',0);
 Formatbox.itemindex:=    settings.ReadInteger('EVN','Export',0);
end;

procedure Tauswert.TimePick1Change(Sender: TObject);
begin
datepick1.Time:= TimePick1.Time;
deletelistmouseup(sender, mbleft,[ssleft],0,0);
ok.Enabled:= true;
end;

procedure Tauswert.TimePick2Change(Sender: TObject);
begin
DatePick2.Time:= TimePick2.Time;
ok.Enabled:= true;
end;

procedure Tauswert.SortboxCloseUp(Sender: TObject);
var i,timecol, nrcol: integer;
    vgl: string;
begin

if ((auswert.Height < 200) or (grid.RowCount < 3)) then exit;

SetCursor_Wait;
errormsg.caption:= misc(M144,'M144');
errormsg.Refresh;
grid.Enabled:= false;
grid.Font.Color:= clSilver;
grid.selection:= TGridRect(Rect(-1,-1,-1,-1));
//ProgressPanel.visible:= true;
//grid.refresh;
//progresspanel.refresh;

for i:=0  to grid.ColCount -1 do
begin
  if ansicontainstext(grid.Cells[i,0],misc(M137,'M137')) then timecol:=i;
  if (grid.Cells[i,0]= misc(M135,'M135')) then nrcol:=i;
end;

case(sortbox.ItemIndex) of
  0: begin vgl:= misc(M136,'M136'); end;
  1: begin vgl:= misc(M137,'M137'); progress2.Visible:= false; progress1.Top:= 16; end;
  2: begin vgl:= misc(M138,'M138'); progress2.Visible:= false; progress1.Top:= 16; end;
  3: begin vgl:= misc(M139,'M139'); progress2.Visible:= false; progress1.Top:= 16; end;
  4: vgl:= misc(M140,'M140');
  5: vgl:= misc(M142,'M142');
  6: begin vgl:= misc(M135,'M135'); progress2.Visible:= false; progress1.Top:= 16; end;
end;

if ((vgl=misc(M142,'M142')) or (vgl=misc(M140,'M140'))) then
   begin
     for i:= 0 to grid.ColCount-1 do
       begin
          if grid.Cells[i,0]= vgl then
             begin
               grid.Tag:= i;
               sort_descending:= false;
               sortby2Col(grid,i,nrcol);
               if vgl=misc(M140,'M140') then sortedbytarif:= true;
                SetCursor_Default;
                filterclick(self);
                errormsg.caption:= '';
                grid.Enabled:= true;
                grid.Font.Color:= clWindowText;
                Resetprogress;
                grid.refresh;
                exit;
             end;
       end;
   end
   else
   if (vgl=misc(M136,'M136')) then
   begin
     for i:= 0 to grid.ColCount-1 do
       begin
          if grid.Cells[i,0]= vgl then
             begin
               grid.Tag:= i;
               sort_descending:= false;
               sortby2Col(grid,i,timecol);
               SetCursor_Default;
               filterclick(self);
               errormsg.caption:= '';
               grid.Enabled:= true;
               grid.Font.Color:= clWindowText;
               Resetprogress;
               grid.refresh;
               exit;
             end;
       end;
   end
   else //wenn vgl <> 'Tarif' o. 'Rufnr'
   for i:= 0 to grid.ColCount-1 do
   begin
   if grid.Cells[i,0]= vgl then
   begin
    grid.Tag:= i;
    sort_descending:= false;
    sortgrid(grid,i, 1,grid.rowcount);
    sortedbytarif:= false;
    SetCursor_Default;
    filterclick(self);
    errormsg.caption:= '';
    grid.Enabled:= true;
    grid.Font.Color:= clWindowText;
    Resetprogress;
    grid.refresh;
    exit;
   end;
   end;
end;

procedure Tauswert.okClick(Sender: TObject);
var localrow: integer;
    i,j,k: integer;
    tmp, inhalti: string;
    getcols: integer;
begin

if sortbox.ItemIndex = -1 then sortbox.ItemIndex:= 0;
if formatbox.ItemIndex = -1 then formatbox.ItemIndex:= 0;

SetCursor_Wait;
errormsg.caption:= misc(M145,'M145');
errormsg.Refresh;

ok.Enabled:= false;

if datepick2.DateTime < datepick1.DateTime then
  begin
    errormsg.caption:=misc(M146,'M146');
    SetCursor_Default;
    exit;
  end
else if datepick1.DateTime > now then
  begin
    errormsg.caption:= misc(M147,'M147');
    SetCursor_Default;
    exit;
  end;

//cleanup
grid.rowcount:= 2;
grid.Rows[1].Clear;

start_date := Datepick1.DateTime;
end_date   := Datepick2.DateTime;

//einlesen
readin;

//keine Datenätze ?
if (( grid.cells[0,1] = '' ) and ( grid.cells[1,1] = '' ) and ( grid.cells[2,1] = '' ) and ( grid.cells[3,1] = '' ))
then
begin
 errormsg.caption:= misc(M148,'M148');
 ok.enabled:= true;
 SetCursor_Default;
 exit;
end;

//spaltenbreiten setzen
if grid.ColCount > 4 then
begin
  getcols:= settings.ReadInteger('EVN','colcount',grid.Colcount);
  //Spalten Reihenfolge
  for i:= 0 to getcols-1 do
  begin
   tmp:= settings.ReadString('EVN','pos'+inttostr(i),'');
   if grid.cells[i,0] <> tmp then
   for k:= i to grid.ColCount-1 do
   if (grid.cells[k,0] = tmp) then //tauschen
       for j:= 0 to grid.rowcount -1 do
         begin
          inhalti:= grid.Cells[i,j];
          grid.cells[i,j]:= grid.cells[k,j];
          grid.cells[k,j]:= inhalti;
          inhalti:= '';
         end;
  end;
  //Spaltengröße
  for i:= 0 to grid.ColCount-1 do
    grid.ColWidths[i]:= settings.ReadInteger('EVN','col'+inttostr(i),64);

errormsg.caption:= '';
errormsg.Refresh;
end;

//Spalten
GridColumnMoved(self, 0,1);

for localrow:= 1 to grid.rowcount-1 do
begin
 if ( grid.cells[col_rufnr,localrow]='' ) then grid.cells[col_rufnr,localrow]:=misc(M149,'M149');
 if ( grid.cells[col_getrennt,localrow] ='' ) then grid.cells[col_getrennt,localrow]:=misc(M149,'M149');
end;


 auswert.Height:= 510;
 grid.visible:= true;
 panel2.Visible:= true;
 panel4.Visible:= true;
 exportiere.Enabled:=true;
 SetGridSize;

//Cursor setzen
SetCursor_Default;

//Sortieren
if sortbox.itemindex < 6 then SortboxCloseUp(Self);
{
Es wird nicht sortiert, wenn in der
Sortbox "wie im Protokoll" (6) ausgewählt
ist.
}
end;

function CountChar(text: string; tpl: char): integer;
var i: integer;
begin
Result:= 0;

for i:=1 to length(text) do
  if text[i] = tpl then inc(Result);

end;

procedure Tauswert.SaveComments;
var checkdate   : TDateTime;
    checkmonth  : string;
    Data        : TStringlist;
    i,j,k       : integer;
    test, tmp   : string;
begin
SetCursor_Wait;
errormsg.caption:= misc(M150,'M150');
errormsg.Refresh;

//Anfangsdatum setzen
checkdate:= start_date;

repeat
  //Dateinamen identifizieren
  if monthof(checkdate) > 9 then checkmonth:= inttostr(monthof(checkdate))
  else checkmonth:= '0'+inttostr(monthof(checkdate));

  if fileexists(extractfilepath(paramstr(0))+'log\'+inttostr(yearof(checkdate))+'_'+checkmonth+'.csv') then
  begin
    data:= TStringlist.Create;
    Data.LoadFromFile(extractfilepath(paramstr(0))+'log\'+inttostr(yearof(checkdate))+'_'+checkmonth+'.csv');

    For i:=0 to Data.Count-1 do
    begin

     for j:= 1 to grid.rowcount-1 do
     begin
      test:= grid.cells[col_datum,j] + #9 + grid.cells[col_uhrzeit,j] + #9 + grid.cells[col_dauer,j] + #9 +grid.cells[col_kosten,j] + #9 +grid.cells[col_Tarif,j];

      if ansicontainsstr(Data.strings[i], test) then
      begin

       case CountChar(Data.strings[i],#9) of
         5: //es fehlen rufnummer und getrennt
            begin
             Data.strings[i]:= Data.Strings[i] + #9 + grid.cells[col_getrennt,j] + #9 + grid.cells[col_Rufnr, j] + #9 + grid.cells[col_notiz,j];
            end;
         7: //es fehlt der kommentar
            begin
             Data.strings[i]:= Data.Strings[i] + #9 + grid.cells[col_notiz,j];
            end;
         8: //kommentar enthalten
            begin
              tmp:= data.strings[i];
              for k:= length(Data.strings[i]) downto 1 do
                if (data.strings[i][k] <> #9) then delete(tmp,length(tmp),1)
                else break;
              Data.strings[i]:= tmp + grid.cells[col_notiz,j];
            end;
        end; //case
      end;
     end;
    end; // ende der for-schleife > weiter zur nächsten zeile

    Data.SaveToFile(extractfilepath(paramstr(0))+'log\'+inttostr(yearof(checkdate))+'_'+checkmonth+'.csv');
    Data.free;

  end; // von "if filexists"
  checkdate:= incmonth(dateof(checkdate),1);
until (checkdate > incmonth(end_date,1));

errormsg.caption:= '';
//Cursor setzen
SetCursor_Default;
end;

procedure Tauswert.exportcsv;
var zeilen: TStringlist;
    i: integer;
begin
savedialog1.Title:= misc(M151,'M151');
savedialog1.filter:= 'Comma Seperated Value (CSV)|*.csv;*.CSV';
savedialog1.Options:= [ofHideReadOnly,ofCreatePrompt,ofEnableSizing, ofOverwritePrompt];
if savedialog1.execute then
begin
zeilen:= TStringlist.Create;
for i:= 0 to grid.rowcount-1 do
  begin
  if grid.RowHeights[i] = -1 then continue;
  grid.Rows[i].Delimiter:= #9;
  zeilen.append(grid.Rows[i].DelimitedText);
  end;

  //Endung setzen wenn nicht vorhanden oder falsch
if lowercase(ExtractFileExt(SaveDialog1.FileName)) <> '.csv' then
   savedialog1.filename:= Changefileext(SaveDialog1.FileName, '.csv');
   
zeilen.savetofile(savedialog1.filename);
zeilen.Free;
end;
end;

procedure Tauswert.Datepick1Change(Sender: TObject);
begin
 deletelistmouseup(sender, mbleft,[ssleft],0,0);
 ok.Enabled:= true;
end;

procedure Tauswert.ExportiereClick(Sender: TObject);
var f: textfile;
    row, col: integer;
    tarif, kosten, zeit, nummer, rufnummer: integer;
    vgl: string;
    gesamtkosten: real;
    gesamtzeit: Ttime;
    gesamt: Tdatetime;
    test: integer;
    idtext, idalt, geskost: string;
    count: integer;
    geszeitstring: string;
begin
vgl:= '';
count:=0;   test:=0;
kosten:=0;
zeit:=0;
nummer:=0;
tarif:=0;
rufnummer:=0;
gesamtkosten:= 0.0;
gesamtzeit:= EncodeTime(0,0,0,0);
gesamt:= EncodeDateTime(1970,01,01,0,0,0,0);

if ((grid.ColCount<6) and (grid.rowcount < 3)) then exit;

if formatbox.ItemIndex=1 then
begin
exportcsv;
exit;
end;

for col:=0 to grid.ColCount-1 do
begin
if grid.cells[col,0] = misc(M140,'M140') then tarif:= col
else if grid.cells[col,0] = misc(M139,'M139') then kosten:= col
else if grid.cells[col,0] = misc(M138,'M138') then zeit:= col
else if grid.cells[col,0] = misc(M135,'M135') then nummer:= col
else if grid.cells[col,0] = misc(M142,'M142') then rufnummer:= col;
end;

if not sortedbytarif and not sortedbyrufnummer then
begin
  assignfile(f, extractfilepath(paramstr(0)) + 'EVN.htm');
  rewrite(f);
  writeln(f, '<html><head></head><body alink="#0080ff" bgcolor="#ebedfe" link="#0000df" text="#000000" vlink="#3f00ff">');
  writeln(f, '<center><h1>'+misc(M152,'M152')+'</h1> '+chr(9) +'<h2>'+ datetimetostr(datepick1.DateTime) + ' - '+datetimetostr(datepick2.DateTime) +'</h2></center>');
  writeln(f,chr(13)+'<table border="0" width="80%" align="center" cellspacing="2">');

  for row:=0 to grid.rowcount-1 do
    begin

      if grid.RowHeights[row] = -1 then continue;

      writeln(f,'  <tr>');
      for col:=0 to grid.colcount-1 do
      begin
        if col=kosten then //die kostenspalte aufsummieren
             if row>0 then gesamtkosten:= gesamtkosten + strtofloat(grid.cells[col, row]);
        if col=zeit then //die Zeitspalte aufsummieren
             if row>0 then begin gesamtzeit:= gesamtzeit + strtotime(grid.cells[col, row]); gesamt:= gesamt + strtotime(grid.cells[col, row]); end;
//zeile schreiben
        write(f,'   <td>');
        if row=0 then write(f,'<b>');
        if col <> nummer then write(f,grid.cells[col, row]);
        if row=0 then write(f,'</b>');
        writeln(f,'</td>');
      end;
      writeln(f,'</tr>');
    end;
  //letzte Zeile schreiben
  write(f,'<tr>');

    if (daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt))<10 then
    geszeitstring:= '0'+ format('%d',[daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt)])+FormatDateTime(':nn:ss', gesamt)
   else  geszeitstring:= format('%d',[daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt)])+FormatDateTime(':nn:ss', gesamt);

  for col:=0 to grid.colcount-1 do
  begin

    if col=kosten then write(f,'<td><b>'+format('%2.4m',[gesamtkosten])+'</b></td>')
                   else  if col=zeit then write(f,'<td><b>'+geszeitstring+'</b></td>')
                                        else  write(f,'<td></td>');
  end;
  write(f,'</tr>');
  writeln(f, '</table><p align=center><font size="-1"><b><a href="http://www.leastcosterxp.de ">LeastCosterXP</a> by <a href="mailto:owner@leastcosterxp.de"> Stefan Fruhner </a></b></font></p></body></html>');
  closefile(f);
end; // Nach Tarif sortiert
if sortedbytarif or sortedbyrufnummer then
begin
  assignfile(f, extractfilepath(paramstr(0)) + 'EVN.htm');
  rewrite(f);
  writeln(f, '<html>');
  writeln(f,'<script type="text/javascript">');
  writeln(f,'function show (element, info) {');
  writeln(f,'   if (document.getElementById)');
  writeln(f,'	  if(document.getElementById(element).style.display == "none")');
  writeln(f,'	    {  document.getElementById(element).style.display = "block";');
    writeln(f,'	      document.getElementById(info).style.display = "none";}');
  writeln(f,'	  else {document.getElementById(element).style.display = "none";');
    writeln(f,'	      document.getElementById(info).style.display = "block";}');
  writeln(f,'   }');
  writeln(f,'</script>');

  writeln(f,'<style type="text/css">');
  writeln(f,'a:link { color:#0000df; text-decoration:none; }');
  writeln(f,'a:visited { color:#0000df; text-decoration:none; }');
  writeln(f,'a:hover { color:#0080ff; text-decoration:underline; }');
  writeln(f,'a:active { color:#0080ff; text-decoration:underline; }');
  writeln(f,'a:focus {  color:#0080ff; text-decoration:underline;}');
  writeln(f,'</style>');
  writeln(f,'<head></head><body alink="#0080ff" bgcolor="#ebedfe" link="#0000df" text="#000000" vlink="#0000df"><form name="formular">');
  writeln(f, '<center><h1>'+misc(M152,'M152')+'</h1> '+chr(9) +'<h2>'+ datetimetostr(datepick1.DateTime) + ' - '+datetimetostr(datepick2.DateTime) +'</h2></center>');

  for row:=1 to grid.rowcount-1 do
    begin
     if grid.RowHeights[row] = -1 then continue;
     
     if sortedbytarif then test := AnsiCompareText(vgl,grid.cells[tarif,row])
else if sortedbyrufnummer then test := AnsiCompareText(vgl,grid.cells[rufnummer,row]);
     if test <> 0 then
      begin //neuer Tabellenkopf
      count:=count+1;
      idtext:= 'id'+inttostr(count);
      idalt:= 'id'+inttostr(count-1);
        if vgl <> '' then
        begin
            //letzte Zeile schreiben
           write(f,'<tr>');

           if (daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt))<10 then
           geszeitstring:= '0'+ format('%d',[daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt)])+FormatDateTime(':nn:ss', gesamt)
           else geszeitstring:= format('%d',[daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt)])+FormatDateTime(':nn:ss', gesamt);
            for col:=0 to grid.colcount-1 do
            begin
                geskost:= floattostr(gesamtkosten);
                geskost:= ansireplacestr(geskost,',','.');
                if col=kosten then writeln(f,'<td><input type="hidden"  value="'+geskost+'" name="kost'+idalt+'"><b>'+format('%2.4m',[gesamtkosten])+'</b></td>')
                else
                 if col=zeit then writeln(f,'<td><input type="hidden"  value="'+geszeitstring+'" name="zeit'+idalt+'"><b>'+geszeitstring+'</b></td>')
                else
                if ((col <> tarif) and (col<>nummer)) then write(f,'<td></td>');
            end;
            write(f,'</tr>');
            writeln(f,'</table><hr width="90%"></div>');
            writeln(f,'<div id="kosten'+idalt+'">&nbsp;&nbsp;&nbsp;&nbsp;<b>'+misc(M139,'M139')+' '+format('%2.4m',[gesamtkosten])+' | '+misc(M153,'M153')+': '+geszeitstring+'</b></div>');
        end;
        //Kosten und Zeit rücksetzen
        gesamtzeit  := EncodeTime(0,0,0,0);
        gesamt:= EncodeDateTime(1970,01,01,0,0,0,0);
        gesamtkosten:= 0.0;

     if sortedbytarif then writeln(f,'<h3><input type="checkbox" onclick="summe();" name="check'+idtext+'"> <a href="javascript:show('''+idtext+''',''kosten'+idtext+''');"><b>'+misc(M140,'M140')+': '+grid.cells[tarif,row]+'</b></a></h3>')
     else if sortedbyrufnummer then writeln(f,'<h3><a href="javascript:show('''+idtext+''',''kosten'+idtext+''');"><b>Rufnr.: '+grid.cells[rufnummer,row]+'</b></a></h3>');
        writeln(f,chr(13)+'<div id="'+idtext+'" style="display:none"><table border="0" width="80%" align="center" cellspacing="2">');
        writeln(f,'<tr>');
        for col:=0 to grid.colcount-1
          do
          begin
           if sortedbytarif then
             begin if ((col <> tarif) and (col<>nummer)) then writeln(f,'<td><b>'+grid.cells[col, 0]+'</b></td>') end
       else begin if sortedbyrufnummer then
             begin if ((col <> rufnummer) and (col<>nummer)) then writeln(f,'<td><b>'+grid.cells[col, 0]+'</b></td>') end;
            end;
          end;
        writeln(f,'</tr>');
      end;
      writeln(f,'<tr>');
      for col:=0 to grid.colcount-1 do
      begin

        if col=kosten then //die kostenspalte aufsummieren
             if row>0 then gesamtkosten:= gesamtkosten + strtofloat(grid.cells[col, row]);
        if col=zeit then //die Zeitspalte aufsummieren
             if row>0 then begin gesamtzeit:= gesamtzeit + strtotime(grid.cells[col, row]); gesamt:= gesamt + strtotime(grid.cells[col, row]); end;

        // Die Spalte Tarif muss in dieser Sortierung nicht ausgegeben werden !
        if sortedbytarif then
          Begin if ((col <> tarif) and (col<>nummer)) then writeln(f,'   <td>'+grid.cells[col, row]+'</td>'); end
       else
          begin if sortedbyrufnummer then  begin if ((col <> rufnummer) and (col<>nummer)) then writeln(f,'   <td>'+grid.cells[col, row]+'</td>') end; end;
      end;
      writeln(f,'</tr>');
      if sortedbytarif then vgl:= grid.cells[tarif,row]
      else
      if sortedbyrufnummer then vgl:= grid.cells[rufnummer,row];
    end;

    //letzte Zeile der allerletzten tabelle schreiben
    write(f,'<tr>');

    if (daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt))<10 then
    geszeitstring:= '0'+ format('%d',[daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt)])+FormatDateTime(':nn:ss', gesamt)
    else geszeitstring:= format('%d',[daysbetween(EncodeDateTime(1970,01,01,0,0,0,0), gesamt)*24 + hourof(gesamt)])+FormatDateTime(':nn:ss', gesamt);

    for col:=0 to grid.colcount-1 do
    begin
       geskost:= floattostr(gesamtkosten);
       geskost:= ansireplacestr(geskost,',','.');
       if col=kosten then writeln(f,'<td><input type="hidden"  value="'+geskost+'" name="kost'+idtext+'"><b>'+format('%2.4m',[gesamtkosten])+'</b></td>')
       else
       if col=zeit then writeln(f,'<td><input type="hidden"  value="'+geszeitstring+'" name="zeit'+idtext+'"><b>'+geszeitstring+'</b></td>')
       else
       if sortedbytarif then begin if ((col <> tarif) and (col<>nummer)) then write(f,'<td></td>'); end
       else begin if sortedbyrufnummer then if ((col <> rufnummer) and (col<>nummer)) then write(f,'<td></td>'); end;
    end;
    write(f,'</tr>');
    write(f, '</table></div>');
    writeln(f,'<div id="kosten'+idtext+'">&nbsp;&nbsp;&nbsp;&nbsp;<b>'+misc(M139,'M139')+' '+format('%2.4m',[gesamtkosten])+' | Gesamtdauer: '+geszeitstring+'</b></div>');
    writeln(f,'<input type="hidden"  value="'+inttostr(count)+'" name="Eingabe">');
    writeln(f,'</form>');

    writeln(f,'<script type="text/javascript">');
    writeln(f,'function summe() {');
    writeln(f,'var counter = 0;');
    writeln(f,'var i = 1;');
    writeln(f,'var elmid = "kostid";');
    writeln(f,'var checker = "checkid"');
    writeln(f,'var temp = 0;');
    writeln(f,'var sum = 0;');
    writeln(f,'var partsum = 0;');
    writeln(f,'counter = parseFloat(document.formular.Eingabe.value);');
    writeln(f,'for (i =1;i<(counter+1);i++) { ');
    writeln(f,'   elmid = "kostid";');
    writeln(f,'   checker = "checkid";');
    writeln(f,'   elmid +=  i;');
    writeln(f,'   checker +=  i;');
    writeln(f,'   temp = parseFloat(document.getElementsByName(elmid)[0].value);');
    writeln(f,'   if (document.getElementsByName(checker)[0].checked == true )');
    writeln(f,      '{ partsum += temp; }');
    writeln(f,'   sum = sum+ temp;');
    writeln(f,'   }');
    writeln(f,'  partsum = Math.round(partsum * 10000) / 10000;');
    writeln(f,'  sum = Math.round(sum * 10000) / 10000;');
    writeln(f,'  document.getElementsByName(''Zusammenfassung'')[0].innerHTML = "<table border=\"0\"><tr><td><b>'+misc(M154,'M154')+':</b></td><td><b>" + partsum +" '+misc(M13,'M13')+'</b></td></tr><tr><td><b>'+misc(M155,'M155')+':</b></td><td><b>" + sum + " '+misc(M13,'M13')+'<\/b></td></tr></table>";');
    writeln(f, ' }');
    writeln(f,'</script>');
    writeln(f,'   <p name="Zusammenfassung"></p>');
    writeln(f,'<p align=center><font size="-1"><b><a href="http://www.leastcosterxp.de ">LeastCosterXP</a> by <a href="mailto:owner@leastcosterxp.de"> Stefan Fruhner </a></b></font></p></body></html>');

  closefile(f);
end;
ShellExecute(0,'open',Pchar('"'+Extractfilepath(paramstr(0))+'EVN.htm"'),Pchar('') ,nil,SW_normal);
end;

procedure Tauswert.BitBtn2Click(Sender: TObject);
begin
setCursor_Wait;
end;

procedure Tauswert.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
posleft:= x;
postop := y;
end;

procedure Tauswert.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if ((ssLeft in Shift) and not nomove) then
begin
auswert.left:= auswert.left - (posleft-x);
auswert.Top:= auswert.Top - (postop -y);
end;

if ssLeft in Shift then
if nomove then
begin
 nomove:= false;
 posleft:= x;
 postop := y;
end;
end;

procedure Tauswert.Datepick1DropDown(Sender: TObject);
begin
nomove:= true;
end;

procedure Tauswert.GridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i, widthl, widthr: integer;
begin

last_x:= x;

liste_clicked := true;
grid.MouseToCell(X,Y,Column,Row);

widthl:=0;
widthr:=0;
with grid do
begin
     for i:=leftcol to column-1 do widthl:= widthl + ColWidths[i] + 1 ;
     for i:=leftcol to column do widthr:= widthr + ColWidths[i] + 1;
end;

if ( (( (x - 6) < widthl ) and ( (x+6)>widthl) )
or   (( (x - 6) < widthr ) and ( (x+6)>widthr) ))
then liste_rand:= true else liste_rand:= false;

if not liste_rand then
 GridEvents.OnMouseDown(sender, x,column, row, widthl, widthr);
end;

procedure Tauswert.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if (ARow = 0) then // and not (gdFixed in State) then
begin
  with grid.Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := psSolid;

    MoveTo(Rect.right-1, Rect.top);
    Lineto(Rect.right-1, Rect.Bottom);
  end;
end;

//Dreieck nach unten
if ((ARow = 0) and (ACol = grid.tag)) then
begin
  with Grid.Canvas do
  begin
    Pen.Color := clNavy;
    Pen.Width := 1;
    Pen.Style := psSolid;

    if sort_descending then
    begin
        MoveTo(rect.right - 15 , Rect.top+5);
        Lineto(rect.right - 10, Rect.Bottom - 5);
        Lineto(rect.right - 5, Rect.top+5);
        Lineto(rect.right - 15, Rect.top+5);
    end
    else
    begin
        MoveTo(rect.right -15, Rect.bottom -5);
        Lineto(rect.right -10, Rect.top + 5);
        Lineto(rect.right -5, Rect.bottom -5);
        Lineto(rect.right -15, Rect.bottom-5);
   end;
        brush.color:= clHotlight;
        Floodfill(rect.right  - 10, rect.top +8 ,clNavy,fsBorder);
        brush.color:= clBlack;
  end;
end;

end;

procedure Tauswert.GridDblClick(Sender: TObject);
begin
OnDoubleClick(sender, column);
end;

procedure Tauswert.FilterClick(Sender: TObject);
var i, col: integer;
begin
SetCursor_Wait;
grid.visible:= false;
if filter.Checked then
begin
 filtername.ReadOnly:= true;
 filtername.Color:= clgraytext;
 for col:=0 to grid.ColCount-1 do
  if grid.cells[col,0] = misc(M140,'M140') then break;

 for i:= 1 to grid.RowCount-1 do
  begin
    if not ansiStartsText(Filtername.text,grid.cells[col, i]) then
      grid.RowHeights[i]:= -1
    else
      grid.RowHeights[i]:= 18;
  end;
end
else //wenn Haken entfernt wurde
begin
 for i:= 1 to grid.RowCount-1 do
  begin
    grid.RowHeights[i]:= 18;
  end;
 filtername.ReadOnly:= false;
 filtername.Color:= clWindow;
end;
grid.visible:= true;
SetCursor_Default;
end;

procedure Tauswert.deletelistMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
deletelist.BevelOuter:= bvlowered;
end;

procedure Tauswert.deletelistMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: integer;
begin

SaveComments;

deletelist.BevelOuter:= bvRaised;
if (auswert.width>602) then sizermouseup(sender,Button, shift, x,y);

auswert.AutoScroll:= false;
auswert.height:= 145;

//Grid richtig löschen
if grid.rowcount > 1 then
for i:= 1 to grid.RowCount -1 do grid.rows[i].Clear;
grid.rowcount:= 2;

grid.Visible:= false;
panel2.Visible:= false;
panel4.Visible:= false;
exportiere.enabled:= false;
auswert.AutoScroll:= true;
ok.Enabled:= true;
end;

procedure Tauswert.sizerMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
sizer.bevelinner:= bvlowered;
end;

procedure Tauswert.sizerMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
sizer.bevelinner:= bvraised;

if auswert.WindowState = wsnormal then
begin
 auswert.WindowState:= wsMaximized;
 sizer.Caption:= '<';
 sizer.BevelOuter:= bvLowered;
 sizer.color:= clbtnhighlight;

end
else
begin
 auswert.WindowState := wsnormal;
 sizer.Caption:= '>';
 sizer.BevelOuter:= bvRaised;
 sizer.color:= clbtnface;
end;
setgridsize;
end;

procedure Tauswert.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var i,notecol: integer;
begin
for i:= 0 to grid.colcount-1 do
  if grid.cells[i,0]=misc(M143,'M143') then notecol:= i;

if ((arow > 0) and (acol <> notecol)) then
  grid.options:= [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goDrawFocusSelected,goRowSizing,goColSizing,goColMoving,goTabs,goThumbTracking]
else
if ((arow > 0) and (acol = notecol)) then
  grid.options:= [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goDrawFocusSelected,goRowSizing,goColSizing,goColMoving,goTabs,goThumbTracking, goediting];


// canselect:= false;
end;

procedure Tauswert.GridColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var i: integer;
begin
for i:= 0 to grid.colcount-1 do
  begin
   if grid.Cells[i,0] = misc(M135,'M135') then col_Nr:= i
   else
   if grid.Cells[i,0] = misc(M136,'M136') then col_Datum:= i
   else
   if grid.Cells[i,0] = misc(M137,'M137') then col_Uhrzeit:= i
   else
   if grid.Cells[i,0] = misc(M138,'M138') then col_Dauer:= i
   else
   if grid.Cells[i,0] = misc(M139,'M139') then col_Kosten:= i
   else
   if grid.Cells[i,0] = misc(M140,'M140') then col_Tarif:= i
   else
   if grid.Cells[i,0] = misc(M141,'M141') then col_getrennt:= i
   else
   if grid.Cells[i,0] = misc(M142,'M142') then col_Rufnr:= i
   else
   if grid.Cells[i,0] = misc(M143,'M143') then col_notiz:= i;
  end;
end;

end.
