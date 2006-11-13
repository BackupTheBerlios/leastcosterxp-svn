unit gridEvents;

interface
uses controls, classes, Types, grids, Graphics, strutils, windows, SysUtils, comctrls, dialogs;

procedure OnMouseDown(Sender: TObject; X,column, ClickedRow, widthl, widthr: Integer);
procedure OnDoubleClick(Sender: TObject; Column: integer);
procedure ExchangeRows(grid: TStringGrid; i,j: integer);
procedure Sort(Grid : TStringGrid;Progress: TProgressbar; SortCol, start, ende:integer; numerical, ascending: boolean);
procedure ColorizeRow(grid: TStringgrid; CRow: integer; R,G,B: word);

implementation

uses unit1;

procedure OnMouseDown(Sender: TObject; X,column, ClickedRow, widthl, widthr: Integer);
var rect: Trect;
begin
with sender as TStringGrid do
begin

if ClickedRow = 0 then
  with Canvas do
  begin
    rect.top:= 0;
    rect.bottom:= rowheights[0]+1;
    rect.left:= widthl;
    rect.right:= widthr;

    Pen.Width := 2;
    Pen.Style := psSolid;

    Pen.Color:= clBtnHighLight;
    MoveTo(Rect.left, Rect.bottom-2);
    Lineto(Rect.right-4, Rect.bottom-2);

    MoveTo(Rect.right-4, Rect.top);
    Lineto(Rect.right-4, Rect.bottom-2);

    Pen.Color:=  clBtnShadow;
    MoveTo(Rect.left, Rect.top);
    Lineto(Rect.left, Rect.Bottom-2);
    MoveTo(Rect.left, Rect.top);
    Lineto(Rect.right-2, Rect.top);
    brush.color:= clBtnFace;
    Textout(rect.left +3, Rect.top +3,cells[column, 0])
  end;
end;
end;

procedure OnDoubleClick(Sender: TObject; Column: integer);
var i: integer;
    breite: integer;
begin
with sender as TStringGrid do
if column > -1 then
  begin
     breite:= 0;
     For i:= 0 to rowcount -1 do
          if (canvas.textwidth(cells[column, i]) > breite) then breite:= canvas.textwidth(cells[column, i]);
      colwidths[column]:= breite + 5 ;
      repaint;
  end;
end;


procedure ExchangeRows(grid: TStringGrid; i,j: integer);
var  temp:tstringlist;
begin
   temp:=tstringlist.create;
   temp.assign(grid.rows[j]);
   grid.rows[j].assign(grid.rows[i]);
   grid.rows[i].assign(temp);
   temp.free;
end;

procedure Sort(Grid : TStringGrid; Progress: TProgressbar; SortCol, start, ende:integer; numerical,ascending: boolean);
var i,j : integer;
    dummy1, dummy2: real;
    code1, code2: integer;
    str1, str2: string;
    cost1, cost2: real;
    stime: cardinal;
begin
 stime:= gettickcount;

 Progress.Min:= start;
 if ((ende -2 > 0 )and (ende-2 > start)) then Progress.Max:= ende-2 else Progress.max:= start;

 grid.Cursor:= crHourGlass;
 if numerical then
  begin

  //erste Zeile nicht mitsortieren
  for i := start to ende - 2 do {because last row has no next row}
  begin
  for j:= i+1 to ende-1 do
  begin
      str1:= ansireplacestr(grid.Cells[Sortcol,j],',','.');
      str2:= ansireplacestr(grid.Cells[Sortcol,i],',','.');

      if grid.cells[sortcol, 0] = 'Kosten' then
      begin
        if ((str1 <> 'Blacklist') and (str1 <> 'abgelaufen')) then
          val(str1, cost1,code1)
        else
        if str1 = 'abgelaufen' then cost1:= 10000.0
        else
        if str1 = 'Blacklist' then cost1:= 20000.0;

        if ((str2 <> 'Blacklist') and (str2 <> 'abgelaufen')) then
         val(str2, cost2,code2)
        else
        if str2 = 'abgelaufen' then cost2:= 10000.0
        else
        if str2 = 'Blacklist' then cost2:= 20000.0;

        if (cost1 = cost2) then //nach Score beurteilen
        begin
          if (str1 = 'abgelaufen') then
          begin
           if (lowercase(grid.cells[1,j]) > lowercase(grid.cells[1,i])) then cost1:= 15000.0 else cost2:= 15000.0;
          end
          else
          if (str1 = 'Blacklist') then
          begin
           if (lowercase(grid.cells[1,j]) < lowercase(grid.cells[1,i])) then cost1:= 15000.0 else cost2:= 15000.0;
          end
          else
          begin
          str1:= ansireplacestr(grid.Cells[0,j],',','.');
          str2:= ansireplacestr(grid.Cells[0,i],',','.');

           val(str1, dummy1,code1);
           val(str2, dummy2,code2);

          //wenn der score kleiner ist, dann nach oben sortieren
           if (dummy1 < dummy2) then cost2:= cost2+1. else cost1:= cost1 + 1.;
          end;
       end;

        dummy1:= cost1;
        dummy2:= cost2;

      end
      else
      begin
        val(str1, dummy1,code1);
        val(str2, dummy2,code2);
        if code1 <> 0 then dummy1:= 999999;
        if code2 <> 0 then dummy2:= 999999;
      end;

      if ascending then
      begin
       if dummy1 > dummy2 then ExchangeRows(grid, i, j);
      end
      else
       if dummy1 < dummy2 then ExchangeRows(grid, i, j);

  end;
       if gettickcount - stime > 50 then Progress.Visible:= true;
       if Progress.Max > Progress.min then
       begin
        Progress.position:= i;
        Progress.Refresh;
       end;

  end;
  end
  else //alphabetisch
    //erste Zeile nicht mitsortieren
  for i := start to ende - 2 do  {because last row has no next row}
  begin
  for j:= i+1 to ende-1 do
   if ascending then
   begin
      if lowercase(grid.Cells[Sortcol,j]) > lowercase(grid.Cells[Sortcol,i]) then
         ExchangeRows(grid, i, j);
   end
   else

    if lowercase(grid.Cells[Sortcol,j]) < lowercase(grid.Cells[Sortcol,i]) then ExchangeRows(grid, i, j);

      Progress.position:= i;
      Progress.Refresh;
  end;

 Progress.Visible:= false;
 grid.Cursor:= crDefault;
end;





procedure ColorizeRow(grid: TStringgrid; CRow: integer; R,G,B: word);
var rect: Trect;
    i, startleft: integer;
begin

//einfärben
with grid do
   begin

     if row=crow then exit;

     Canvas.Brush.Color := RGB(R,G,B);
     startleft:= 0;
     rect.top:= Crow * (RowHeights[Crow]+1);
     rect.bottom:= rect.top + RowHeights[Crow]+1;
     for i:= leftcol to colcount-1 do
     begin
        if (colwidths[i] > -1) then
        begin
          rect.left:= startleft ;
          rect.right:= startleft + colwidths[i];
          Canvas.FillRect(Rect);
          Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[i, Crow]);
          startleft:= rect.right +1;
        end;
     end;

        //letzte 'Spalte' zeichnen
          rect.left:= startleft ;
          rect.right:= startleft + 200;
          Canvas.FillRect(Rect);
   end;
end;
end.
