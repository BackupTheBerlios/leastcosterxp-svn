unit html;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Strutils, Files, Auswertung, Gauges,DateUtils, inifiles,
  Grids, ComCtrls, Shellapi,BrwsFldr, ExtCtrls,
  ActnList, StdActns;


type Thtmlwindow = class(TForm)
    Panel1: TPanel;
    balken: TGauge;
    ok1: TBitBtn;
    kind: TComboBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    auswahlbox: TListBox;
    Export: TLabel;
    BitBtn2: TBitBtn;
    warning: TLabel;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ok1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure auswahlboxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure kindDropDown(Sender: TObject);

  private
    { Private declarations }
    nomove: boolean;
    BrowseForFolder: TBrowseForFolder;
  public
    { Public declarations }
    startedfrommainform: boolean;
  end;

var
  htmlwindow: Thtmlwindow;
  VerzListe : TStringList;
  postop: integer;
  posleft: integer;
implementation

uses Unit1, WebServ1, Protokolle;

{$R *.dfm}
function VerzGroesse(Verzeichnis:string):longint;
var SR      : TSearchRec;
    Groesse : longint;
    temp: string[4];
    code, i: integer;
begin
  Groesse:=0;
  if Verzeichnis[length(Verzeichnis)]<>'\' then
    Verzeichnis:=Verzeichnis+'\';
  //if ansicontainsStr(Sr.Name,'.csv') then showmessage(SR.Name);
  if FindFirst(Verzeichnis+'*.*',$3F,SR)=0 then begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') then
      begin
        if (sr.Name[5]='_') then
        begin
        temp:= sr.name;
        val(temp,i, code);
        if code=0 then
        begin
        VerzListe.Add(SR.Name);
        Groesse:=Groesse+SR.Size;
        end;
        end;
        end;
    until FindNext(SR)<>0;
    FindClose(SR);
  end;
  Result:=Groesse;
end;

procedure Thtmlwindow.BitBtn1Click(Sender: TObject);
begin
htmlwindow.Close;
end;

procedure Thtmlwindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin

settings.writestring('Export','Path', BrowseForFolder.Folder);

BrowseForFolder.free;
startedfrommainform:= false;
hauptfenster.Enabled:=true;
htmlwindow.Release;
htmlwindow:= nil;
end;


Procedure Ubersicht;
Var Sichte:textfile;
Begin
assign(Sichte, ExtractFilePath(paramstr(0))+'htm\Übersicht.htm');
rewrite(Sichte);
Write   ( Sichte, '<meta name="author" content="LeastCoster 1.1">');
Write   ( Sichte, '<meta name="generator" content="LeastCoster 1.1 ">');
write   ( Sichte, '<meta http-equiv="cache-control" content="no-cache"></head>');
Write   ( Sichte, '<body alink="#0080ff" bgcolor="#ebedfe" link="#0000df" text="#000000" vlink="#3f00ff">');
Write   ( Sichte, '<p align="center"><img src="head.jpg" alt="" border="0" height="150"> </p>');
Writeln ( Sichte, '<p align=center><font size=+2>Übersicht der verfügbaren Tabellen</font></p>');
Writeln ( Sichte, '<table align="center" height="20" border=0 cellspacing="0" >');
Writeln ( Sichte, '<tr><td>');
Writeln ( Sichte, '</td></tr>');
Writeln ( Sichte, '</table>');
Write   ( Sichte, '<br><p align=center><font size="-1"><b>Statistik erstellt mit <a href="http://www.leastcosterxp.de ">LeastCosterXP</a> von <a href="mailto:owner@leastcosterxp.de"> Stefan Fruhner </a></b></font></p>');
Writeln ( Sichte, '</body></html>');
Closefile(Sichte);
End;


procedure Thtmlwindow.ok1Click(Sender: TObject);
var i, count: integer;
    new, output: string;
begin
htmlwindow.Cursor:= crHourGlass;
warning.Caption:= '';
if browseforfolder.execute then
begin
new:='';
output:= '';
count:=0;
balken.progress:= 0;
for i := 0 to (Auswahlbox.Items.Count - 1) do
    if Auswahlbox.Selected[i] then count:= count+1;

balken.enabled:=true;
balken.MaxValue:=count;

for i := 0 to (Auswahlbox.Items.Count - 1) do begin

    if Auswahlbox.Selected[i] then //html-Files auf den neuesten Stand bringen
    begin
       Protokolle.Abholung(ExtractFilePath(paramstr(0))+'log\'+Auswahlbox.Items.Strings[i]);
    //   Protokolle.monatshtml(ExtractFilePath(paramstr(0))+'log\',Auswahlbox.Items.Strings[i]);

       balken.progress:= i+1;

       //exportieren
       case(kind.ItemIndex) of
       //csv-Export
       0: begin
           new:= ExtractFilePath(paramstr(0))+'log\' + Auswahlbox.Items.Strings[i];
           output:=BrowseForFolder.Folder +'\'+ Auswahlbox.Items.Strings[i];
          end;
       //htm-Export
       1: begin
           new:= ExtractFilePath(paramstr(0))+'www\log\' + ChangeFileExt(Auswahlbox.Items.Strings[i],'.htm');
           output:=BrowseForFolder.Folder +'\'+ ChangeFileExt(Auswahlbox.Items.Strings[i],'.htm');
          end;
       end;
         if not fileexists(output) then
            Filecopy(new,output)
          else
          begin
            if MessageDlg('Die Datei ' +Auswahlbox.Items.Strings[i] + ' existiert bereits. Überschreiben ?' , mtConfirmation,
            [mbYes, mbNo], 0) = mrYes then
                      Filecopy(new,output);
            end;
   end;
  end;
balken.enabled:=false;

//bilddateien kopieren, falls html, export
if kind.itemindex=1 then
begin
if (fileexists(ExtractFilePath(paramstr(0))+'www\log\bg.jpg') and not fileexists(BrowseForFolder.Folder +'\bg.jpg')) then
 Filecopy(ExtractFilePath(paramstr(0))+'www\log\bg.jpg',BrowseForFolder.Folder +'\bg.jpg');
if (fileexists(ExtractFilePath(paramstr(0))+'www\log\bgred.jpg') and not fileexists(BrowseForFolder.Folder +'\bgred.jpg')) then
  Filecopy(ExtractFilePath(paramstr(0))+'www\log\bgred.jpg',BrowseForFolder.Folder +'\bgred.jpg');
if (fileexists(ExtractFilePath(paramstr(0))+'www\log\head.jpg') and not fileexists(BrowseForFolder.Folder +'\head.jpg')) then
   Filecopy(ExtractFilePath(paramstr(0))+'www\log\head.jpg',BrowseForFolder.Folder +'\head.jpg');
if (fileexists(ExtractFilePath(paramstr(0))+'www\log\blue.gif') and not fileexists(BrowseForFolder.Folder +'\blue.gif')) then
    Filecopy(ExtractFilePath(paramstr(0))+'www\log\blue.gif',BrowseForFolder.Folder +'\blue.gif');
if (fileexists(ExtractFilePath(paramstr(0))+'www\log\red.gif') and not fileexists(BrowseForFolder.Folder +'\red.gif')) then
     Filecopy(ExtractFilePath(paramstr(0))+'www\log\red.gif',BrowseForFolder.Folder +'\red.gif');
if (fileexists(ExtractFilePath(paramstr(0))+'www\log\yellow.gif') and not fileexists(BrowseForFolder.Folder +'\yellow.gif')) then
      Filecopy(ExtractFilePath(paramstr(0))+'www\log\yellow.gif',BrowseForFolder.Folder +'\yellow.gif');
if (fileexists(ExtractFilePath(paramstr(0))+'www\log\trans.gif') and not fileexists(BrowseForFolder.Folder +'\trans.gif')) then
       Filecopy(ExtractFilePath(paramstr(0))+'www\log\trans.gif',BrowseForFolder.Folder +'\trans.gif');
end;

end;
htmlwindow.Cursor:= crdefault;
end;

procedure Thtmlwindow.RadioButton1Click(Sender: TObject);
var i: integer;
begin
for i := 0 to (Auswahlbox.Items.Count - 1) do begin
    if Auswahlbox.Selected[i] then
    begin
       Auswahlbox.Selected[i]:=false;
    end;
  end;
end;

procedure Thtmlwindow.CheckBox1Click(Sender: TObject);
var i: integer;
begin
if checkbox1.Checked then
begin
checkbox2.Checked:= false;
balken.Progress:=0;
for i := 0 to (Auswahlbox.Items.Count - 1) do begin
    if not Auswahlbox.Selected[i] then
    begin
       Auswahlbox.Selected[i]:=true;
    end;
  end;
end;
end;

procedure Thtmlwindow.CheckBox2Click(Sender: TObject);
var i: integer;
begin
if checkbox2.Checked then
begin
checkbox1.Checked:= false;
balken.Progress:=0;
for i := 0 to (Auswahlbox.Items.Count - 1) do begin
    if Auswahlbox.Selected[i] then
    begin
       Auswahlbox.Selected[i]:=false;
    end;
  end;
end;
end;

procedure Thtmlwindow.auswahlboxClick(Sender: TObject);
begin
checkbox1.Checked:= false;
checkbox2.Checked:= false;
balken.Progress:=0;
end;

procedure Thtmlwindow.FormCreate(Sender: TObject);
begin
BrowseForFolder:= TBrowseForfolder.Create(self);
//if not hauptfenster.german then lang.SetLangStrings_export;

nomove:= false;

BrowseForFolder.Folder:= settings.readstring('Export','Path', '');


startedfrommainform:= false;
  VerzListe:=TStringList.Create;
  VerzGroesse(ExtractFilePath(paramstr(0))+'log');
  Auswahlbox.Items.Assign(VerzListe);
  VerzListe.Free;

  if auswahlbox.count >0 then
  if Auswahlbox.Selected[0] then auswahlbox.selected[0]:= true;
kind.ItemIndex:=0;
end;

procedure Thtmlwindow.Panel1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if ((ssLeft in Shift) and not nomove) then
begin
htmlwindow.Left:= htmlwindow.left - (posleft-x);
htmlwindow.Top:= htmlwindow.Top - (postop -y);
end;
if ssLeft in Shift then
if nomove then
begin
 nomove:= false;
 posleft:= x;
 postop := y;
end;
end;

procedure Thtmlwindow.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
posleft:= x;
postop := y;
end;

procedure Thtmlwindow.BitBtn2Click(Sender: TObject);
var count, i: integer;
    name: string;

begin
htmlwindow.Cursor:= crHourGlass;
count:=0;
warning.Caption:= '';
balken.progress:= 0;
for i := 0 to (Auswahlbox.Items.Count - 1) do
    if Auswahlbox.Selected[i] then count:= count+1;

balken.enabled:=true;
balken.MaxValue:=count;

for i := (Auswahlbox.Items.Count - 1) downto 0 do
    if Auswahlbox.Selected[i] then //html-Files auf den neuesten Stand bringen
    begin
     name := Auswahlbox.Items.Strings[i];
     if (DeleteFileToRecycleBin(ExtractFilePath(paramstr(0))+'log\' + name) )
     then auswahlbox.items.Delete(i);

     if (not DeleteFileToRecycleBin(ExtractFilePath(paramstr(0))+'www\log\' + ChangeFileExt(name,'.htm')))
       then warning.caption:= 'Konnte '+ ChangeFileExt(name,'.htm')+ ' nicht in den Papierkorb verschieben.';
     balken.progress:= auswahlbox.Items.count - i;
    end;
htmlwindow.Cursor:= crdefault;    
end;

procedure Thtmlwindow.BitBtn3Click(Sender: TObject);
var count, fcounter, datcount, k,i: integer;
    fname: string;
    f, tmp: textfile;
    data: array of string;
begin
htmlwindow.Cursor:= crHourGlass;
count:=0;
warning.Caption:= '';
balken.progress:= 0;
for i := 0 to (Auswahlbox.Items.Count - 1) do
    if Auswahlbox.Selected[i] then count:= count+1;

balken.enabled:=true;
balken.MaxValue:=count;

for i := (Auswahlbox.Items.Count - 1) downto 0 do
if Auswahlbox.Selected[i] then
begin
fname:= Extractfilepath(paramstr(0))+'log\'+ Auswahlbox.Items.Strings[i];
if fileexists(fname) then
begin
  fcounter:= 0;
  setlength(data,0);
  assignfile(f, fname);
  reset(f);
  while not eof(f) do
  begin
   setlength(data, fcounter+1);
   readln(f, data[fcounter]);
   //alles bis zum ersten tab löschen
   delete(data[fcounter],1,pos(chr(9),data[fcounter])-1);
   fcounter:= fcounter +1;
  end;
  closefile(f);

  assignfile(tmp,fname);
  rewrite(tmp);
  datcount:= 1;
  for k:= 0 to (length(data) -1)do
  if not ansicontainsstr(data[k],'[OlecoImport]') then begin writeln(tmp,inttostr(datcount) + data[k]); datcount:= datcount+1; end;
  closefile(tmp);
  if datcount = 1 then
    begin erase(tmp); auswahlbox.Items.Delete(i); end;
  balken.progress:= Auswahlbox.Items.Count - i;

end;
end;
htmlwindow.Cursor:= crdefault;
end;

procedure Thtmlwindow.kindDropDown(Sender: TObject);
begin
nomove:= true;
end;

end.
