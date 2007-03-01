unit gridEvents;

interface
uses controls, classes, Types, grids, Graphics, strutils, windows, SysUtils, comctrls, dialogs;

procedure GridSort(var Grid: TStringGrid;prog: TProgressbar; l,r, col: integer; SortType: shortint; inverse: boolean);
procedure GridSort2(var Grid: TStringGrid; prog: TProgressbar;l,r, col1, col2: integer;  SortType1, Sorttype2: shortint);
procedure GridSort2in1(var Grid: TStringGrid;prog: TProgressbar; l,r, col1, col2: integer;  SortType: shortint);
procedure BubbleSort(Items: array of TStringList; l,r,col: integer; prog:TProgressBar);
procedure BubbleStringSort(Items: array of TStringList; l,r,col: integer;prog: TProgressbar);
procedure BubbleDateSort(Items: array of TStringList; l,r,col: integer;var prog: TProgressbar);
procedure SortCost(a: array of TStringlist; l,r,SortCol :integer; Progress: TProgressbar);

procedure OnMouseDown(Sender: TObject; X,column, ClickedRow, widthl, widthr: Integer);
procedure OnDoubleClick(Sender: TObject; Column: integer);
procedure ColorizeRow(grid: TStringgrid; CRow: integer; R,G,B: word);

implementation

uses unit1, inilang, messagestrings, math;

// *************** Sortierverfahren ********************************************

procedure GridSort(var Grid: TStringGrid; prog: TProgressBar; l,r, col: integer; SortType: shortint; inverse: boolean);
var a: array of TStringList;
    i: integer;
    c: integer;
begin
 grid.Cursor:= crHourGlass;
 setlength(a, grid.RowCount);

 for i:= 0 to length(a)-1 do
  a[i]:= TStringList.Create;

 for i:= 0 to grid.RowCount-1 do
  a[i].Assign(grid.Rows[i]);

 if not inverse then
 begin
   Case SortType of
     0 : Bubblesort(a,l,r,col, prog);//QuickNumberSort(a,l,r,col,inverse)
     1 : BubbleStringSort(a,l,r,col, prog);
     2 : BubbleDateSort(a,l,r,col, prog);
     7 : SortCost(a,l,r,col, prog);
   end;

   for i:= 0 to grid.RowCount-1 do
    begin
     grid.Rows[i].Clear;
     grid.Rows[i].Assign(a[i]);
    end;
 end
 else //beim umdrehen der spalte
 begin
    c:= 1;
    for i:= grid.RowCount-1 downto 1 do
    begin
     grid.Rows[i].Clear;
     grid.Rows[i].Assign(a[c]);
     inc(c);
    end;

 end;
 for i:= 0 to length(a)-1 do
  a[i].Free;
 grid.Cursor:= crDefault;
end;

//zweispaltiges Sortieren
procedure GridSort2(var Grid: TStringGrid;prog: TProgressbar; l,r, col1, col2: integer;  SortType1, SortType2: shortint);
var a: array of TStringList;
    i: integer;
    start: integer;
    ende: integer;
begin

 setlength(a, grid.RowCount);
 grid.Cursor:= crHourGlass;
 for i:= 0 to length(a)-1 do
  a[i]:= TStringList.Create;

 for i:= 0 to grid.RowCount-1 do
  begin
   a[i].Assign(grid.Rows[i]);
//   a[i].Append(a[i].strings[col1] + ' ' + a[i].strings[col2]);
  end;

 Case SortType1 of
   0 : Bubblesort(a,l,r,col1, prog);//QuickNumberSort(a,l,r,col,inverse)
   1 : BubbleStringSort(a,l,r,col1, prog);
   2 : BubbleDateSort(a,l,r,col1, prog);
 end;

 //zweiter Durchgang um nach Spalte col2 zu sortieren
 start:= 1;
 for i:= 1 to length(a)-2 do
   if AnsiCompareText(a[i].strings[col1], a[i+1].strings[col1]) <> 0 then
       begin
         ende:= i;
         if ende-start > 0 then
          begin
            Case SortType2 of
              0 : Bubblesort(a,start,ende,col2, prog);//QuickNumberSort(a,l,r,col,inverse)
              1 : BubbleStringSort(a,start,ende,col2, prog);
              2 : BubbleDateSort(a,start,ende,col2, prog);
             end;
          end;
         start:= ende+1;
       end;

 for i:= 0 to grid.RowCount-1 do
 begin
  grid.Rows[i].Clear;
//  a[i].Delete(grid.colcount); //letzten Eintrag wieder löschen
  grid.Rows[i].Assign(a[i]);
 end;

 for i:= 0 to length(a)-1 do
  a[i].Free;
 grid.Cursor:= crDefault;
end;

//zweispaltiges Sortieren
procedure GridSort2in1(var Grid: TStringGrid;prog: TProgressbar; l,r, col1, col2: integer;  SortType: shortint);
var a: array of TStringList;
    i: integer;
begin
 grid.Cursor:= crHourGlass;
 setlength(a, grid.RowCount);

 for i:= 0 to length(a)-1 do
  a[i]:= TStringList.Create;

 for i:= 0 to grid.RowCount-1 do
  begin
   a[i].Assign(grid.Rows[i]);
   a[i].Append(a[i].strings[col1] + ' ' + a[i].strings[col2]);
  end;

 Case SortType of
   0 : Bubblesort(a,l,r,grid.colcount, prog);//QuickNumberSort(a,l,r,col,inverse)
   1 : BubbleStringSort(a,l,r,grid.colcount, prog);
   2 : BubbleDateSort(a,l,r,grid.colcount, prog);
 end;

 for i:= 0 to grid.RowCount-1 do
 begin
  grid.Rows[i].Clear;
  a[i].Delete(grid.colcount); //letzten Eintrag wieder löschen
  grid.Rows[i].Assign(a[i]);
 end;

 for i:= 0 to length(a)-1 do
  a[i].Free;
 grid.Cursor:= crDefault;
end;

procedure ReSetProgress(var prog: TProgressbar);
begin
   if assigned(prog) then
   begin
    prog.Min:= 0;
    prog.Max:= 100;
   end;
end;

procedure UpdateProgress(var prog: TProgressbar; i,l,r: integer; var time:cardinal);
begin
   if assigned(prog) and (gettickcount - time > 50) then
   begin
      prog.Visible:= true;
      prog.Position:= floor(i/(r-l)*100);
      time:= gettickcount;
   end;
end;

procedure BubbleSort(Items: array of TStringList; l,r,col: integer; prog:TProgressBar);
var
 i, j: integer;
 Dummy: TstringList;
 time: cardinal;
begin
 time:= gettickcount;
 dummy:= TStringlist.Create;

 ReSetProgress(prog);

 for i := l to r-1 do
  begin
   for j := i+1 to r do
      if strtofloat(Items[i].strings[col]) > strtofloat(Items[j].strings[col]) then
      begin
        Dummy.Assign(Items[i]);
        Items[i].Assign(Items[j]);
        Items[j].Assign(Dummy);
      end;
   UpdateProgress(prog, i,l,r, time);
   end; 
 if assigned(prog) then Prog.visible:= false;
 dummy.Free;
end;

procedure BubbleStringSort(Items: array of TStringList; l,r,col: integer; prog: TProgressBar);
var
 i,j  : integer;
 Dummy: TstringList;
 time : cardinal;
begin
 time:= gettickcount;
 dummy:= TStringlist.Create;

 ReSetProgress(prog);
  for i := l to r-1 do
  begin
   for j := i+1 to r do
    if lowercase(Items[i].strings[col]) > lowercase(Items[j].strings[col]) then
      begin
        Dummy.Assign(Items[i]);
        Items[i].Assign(Items[j]);
        Items[j].Assign(Dummy);
      end;
    UpdateProgress(prog, i, l,r, time);
   end;
 if assigned(prog) then prog.Visible:= false;
 dummy.Free;
end;

procedure BubbleDateSort(Items: array of TStringList; l,r,col: integer;var prog: TProgressbar);
var
 i,j  : integer;
 Dummy: TstringList;
 time : cardinal;
begin
 time:= gettickcount;
 dummy:= TStringlist.Create;
 ResetProgress(prog);
  for i := l to r-1 do
  begin
   for j := i+1 to r do
    if strtoDateTime(Items[i].strings[col]) > strtoDateTime(Items[j].strings[col]) then
     begin
       Dummy.Assign(Items[i]);
       Items[i].Assign(Items[j]);
       Items[j].Assign(Dummy);
     end;
   UpdateProgress(prog, i,l, r, time);
  end;
 if assigned(prog) then prog.Visible:= false;
 dummy.Free;
end;

procedure SortCost(a: array of TStringlist; l,r,SortCol:integer; Progress: TProgressbar);
var i,j : integer;
    dummy1, dummy2: real;
    code1, code2: integer;
    str1, str2: string;
    cost1, cost2: real;
    time: cardinal;
    Dummy: TStringlist;
begin
 time:= gettickcount;

 cost1:= 0.0;
 cost2:= 0.0;
 Dummy:= TStringlist.Create;
 ReSetProgress(Progress);

 for i := l to r - 1 do
  begin
  for j:= i+1 to r do
  begin
      str1:= ansireplacestr(a[j].strings[SortCol],',','.');
      str2:= ansireplacestr(a[i].strings[SortCol],',','.');

      if ((str1 <> 'Blacklist') and (str1 <> misc(M98,'M98'))) then val(str1, cost1,code1)
      else
      if str1 = misc(M98,'M98') then cost1:= 10000.0
      else
      if str1 = 'Blacklist' then cost1:= 20000.0;

      if ((str2 <> 'Blacklist') and (str2 <> misc(M98,'M98'))) then
         val(str2, cost2,code2)
      else
      if str2 = misc(M98,'M98') then cost2:= 10000.0
      else
      if str2 = 'Blacklist' then cost2:= 20000.0;

      if (cost1 = cost2) then //nach Score beurteilen
        begin
        if (str1 = misc(M98,'M98')) then
         begin
          if (lowercase(a[j].strings[1]) > lowercase(a[i].strings[1])) then cost1:= 15000.0 else cost2:= 15000.0;
         end
         else
         if (str1 = 'Blacklist') then
          begin
           if (lowercase(a[j].strings[1]) < lowercase(a[i].strings[1])) then cost1:= 15000.0 else cost2:= 15000.0;
          end
          else
          begin
            str1:= ansireplacestr(a[j].strings[0],',','.');
            str2:= ansireplacestr(a[i].strings[0],',','.');

            val(str1, dummy1,code1);
            val(str2, dummy2,code2);

           //wenn der score kleiner ist, dann nach oben sortieren
            if (dummy1 < dummy2) then cost2:= cost2+1. else cost1:= cost1 + 1.;
          end;
       end;

        dummy1:= cost1;
        dummy2:= cost2;

       if dummy1 < dummy2 then
        begin
         Dummy.Assign(a[i]);
         a[i].Assign(a[j]);
         a[j].Assign(Dummy);
        end;
  end;
       UpdateProgress(progress, i, l,r, time);
  end;
 Dummy.free;

 Progress.Visible:= false;
end;
{//alte Sortierprozedur, die aber in der Tabelle sortiert
procedure Sort(Grid : TStringGrid; Progress: TProgressbar; SortCol, start, ende:integer);
var i,j : integer;
    dummy1, dummy2: real;
    code1, code2: integer;
    str1, str2: string;
    cost1, cost2: real;
    time: cardinal;
begin
 time:= gettickcount;

 ReSetProgress(Progress);

 for i := start to ende - 2 do
  begin
  for j:= i+1 to ende-1 do
  begin
      str1:= ansireplacestr(grid.Cells[Sortcol,j],',','.');
      str2:= ansireplacestr(grid.Cells[Sortcol,i],',','.');

      if grid.cells[sortcol, 0] = 'Kosten' then
      begin
        if ((str1 <> 'Blacklist') and (str1 <> misc(M98,'M98'))) then
          val(str1, cost1,code1)
        else
        if str1 = misc(M98,'M98') then cost1:= 10000.0
        else
        if str1 = 'Blacklist' then cost1:= 20000.0;

        if ((str2 <> 'Blacklist') and (str2 <> misc(M98,'M98'))) then
         val(str2, cost2,code2)
        else
        if str2 = misc(M98,'M98') then cost2:= 10000.0
        else
        if str2 = 'Blacklist' then cost2:= 20000.0;

        if (cost1 = cost2) then //nach Score beurteilen
        begin
          if (str1 = misc(M98,'M98')) then
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

       if dummy1 < dummy2 then ExchangeRows(grid, i, j);
  end;
       UpdateProgress(progress, i, start,ende, stime);
  end;

 Progress.Visible:= false;
 grid.Cursor:= crDefault;
end;
}


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

//Spaltenbreite setzen
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

// *************** Sortierverfahren Ende ***************************************

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
