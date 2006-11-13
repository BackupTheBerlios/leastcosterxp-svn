unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, zlib, files, inifiles, ZipMstr,
  ComCtrls;

type
  Twndlist = class(TForm)
    Panel1: TPanel;
    Zip: TZipMaster;
    ok: TBitBtn;
    ListBox: TListBox;
    Caption: TLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    NotImported_Label: TLabel;
    Memo1: TMemo;
    Panel2: TPanel;
    NotImported_OverWrite: TBitBtn;
    sclose: TBitBtn;
    Panel3: TPanel;
    keine: TCheckBox;
    alle: TCheckBox;
    email: TCheckBox;
    Progress: TProgressBar;
    Progress2: TProgressBar;
    Newimport: TBitBtn;
    procedure ClearImport;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure alleClick(Sender: TObject);
    procedure SaveToSingleFile(filename: string; count: integer);
    procedure keineClick(Sender: TObject);
    procedure batchexport;
    procedure import(filename:string);
    procedure batchimport;
    procedure okClick(Sender: TObject);
    procedure getLCX(FileName: String);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NotImported_OverWriteClick(Sender: TObject);
    procedure SetCursor_Wait;
    procedure SetCursor_Default;
    procedure NewimportClick(Sender: TObject);
    procedure WriteDataToHD;
  private
    { Private declarations }
    ImportLCX: boolean;
    LCXFile: String;
    NotImported, NotImportedFiles, AllFiles, AllNames, NewDate: TStringList;
  public
    { Public declarations }
    basename: string;
  end;

var
  wndlist: Twndlist;

implementation

uses Unit1, tarifverw, StringRoutine, Strutils, DateUtils, Tarifmanager;

{$R *.dfm}

procedure Twndlist.ClearImport;
var i: integer;
begin

if assigned(NotImported) then NotImported.Free;
if assigned(NotImportedFiles) then NotimportedFiles.Free;
if assigned(NewDate) then NewDate.Free;


if allFiles.count > 0 then
begin
 progress.visible:= true;
 progress.refresh;
 progress.min:= 0;
 progress.max:= AllFiles.count + 1;

 for i:= 0 to Allfiles.Count-1 do
 begin
  DeleteFile(basename+'_'+inttostr(i+1)+'.csv');
  progress.Position:= i;
 end;
 //contents.lcx löschen
 deletefile(extractfilepath(paramstr(0)) + 'temp\contents.lcx');
 progress.Position:= progress.Position +1;
 removedir(Extractfilepath(paramstr(0)) + 'temp');
 progress.Position:= progress.Position +1;
end;
 if assigned(AllFiles) then Allfiles.Free;
 if assigned(AllNames) then  AllNames.free;
 AllFiles:= nil;
 AllNames:= nil;
 progress.visible:= false;
 newimport.Visible:= true;
end;

procedure Twndlist.FormClose(Sender: TObject; var Action: TCloseAction);
begin
listbox.Items.clear;
SetCursor_wait;
hauptfenster.enabled:= true;

//Dateien löschen
if assigned(AllFiles) and assigned(AllNames) then ClearImport;

//if ok.Caption = '&Import' then
if caption.caption='Import' then
begin
//tarifverw.LadeTarife;
hauptfenster.AktualisierenClick(self);
end;

if assigned(TaVerwaltung) and TaVerwaltung.visible then
begin
TaVerwaltung.FormCreate(self);
TaVerwaltung.enabled:= true;
hauptfenster.enabled:= not TaVerwaltung.visible;
end;

SetCursor_Default;
hauptfenster.startwithimport:= false;
wndlist.Release;
wndlist:= nil;

end;

procedure Twndlist.SaveToSingleFile(filename: string; count: integer);
var zeilen: TStringlist;
    i: integer;
    einezeile: string;
begin
setCursor_wait;

zeilen:= TStringlist.Create;
  //Tarifnamen hinzufügen
  zeilen.append(listbox.Items.Strings[count]);
  //Header setzen
  zeilen.append('Gültigkeit'+#9+'Beginn'+#9+'Ende'+#9+'Preis'+#9+'Einwahl'+#9+'Takt'+#9+'Nummer'+#9+'User'+#9+'Passwort'+#9+'Webseite'+#9+'gültig ab'+#9+'gültig bis'+#9+'eingetragen');

//  jeden Tarif hinzufügen
    progress2.min:= 0;
    progress2.Max:=length(hauptfenster.tarife)-1;

    for i:=0 to length(hauptfenster.tarife)-1 do
    begin
    if listbox.Items.Strings[count] = Hauptfenster.tarife[i].tarif then
      begin
        einezeile:= Hauptfenster.Tarife[i].Tag + #9 +
                    Hauptfenster.Tarife[i].Beginn + #9 +
                    Hauptfenster.Tarife[i].Ende + #9 +
                    Hauptfenster.Tarife[i].Preis + #9 +
                    Hauptfenster.Tarife[i].Einwahl + #9 +
                    Hauptfenster.Tarife[i].Takt + #9 +
                    Hauptfenster.Tarife[i].Nummer + #9 +
                    Hauptfenster.Tarife[i].User + #9 +
                    Hauptfenster.Tarife[i].Passwort + #9 +
                    Hauptfenster.Tarife[i].Webseite + #9 +
                    Hauptfenster.Tarife[i].validfrom + #9 +
                    Hauptfenster.Tarife[i].expires + #9 +
                    Hauptfenster.Tarife[i].eingetragen;
       zeilen.append(einezeile);
      end;
      progress2.Position:= i;
    end;

  //speichern in der Datei
  Zeilen.SaveToFile(filename);

SetCursor_Default;
end;

procedure Twndlist.alleClick(Sender: TObject);
begin
if alle.Checked then
begin
keine.Checked:= false;
listbox.SelectAll;
end;
end;

procedure Twndlist.batchexport;
var zeilen: TStringlist;
    i, count, tarifnumber, k: integer;
    nameoffile, basename: string;
    mailtext: string;
    neu: string;
begin

count := 0;
tarifnumber:= 1;
if hauptfenster.german then
begin
savedialog.Title:= 'Tarif - Export';
savedialog.filter:= 'LeastCosterXP Tarifpaket (*.lcz)|*.lcz;*.LCZ';
if listbox.SelCount = 1 then savedialog.filter:= savedialog.filter + '|LeastCosterXP Tarifdatei (*.lcx)|*.lcx;*.LCX';
end;
savedialog.Options:= [ofHideReadOnly,ofCreatePrompt,ofEnableSizing, ofOverwritePrompt];

if savedialog.execute then
begin
wndlist.Refresh;

if savedialog.FilterIndex = 2 then
begin
//Datensatz finden
for k:= 0 to listbox.Count-1 do if listbox.Selected[k] then break;
SaveToSingleFile(savedialog.filename, k);
end
else
begin
if Fileexists(savedialog.filename) then deletefile(savedialog.filename);

basename:= savedialog.FileName;
delete(basename, length(basename)-3,4);
zip.ZipFileName:= basename + '.lcz';
//Basisnamen filtern
nameoffile:= savedialog.FileName;
delete(nameoffile,length(nameoffile)-3,4);

progress.min:= 0;
progress.max:= listbox.items.count;

Repeat
  // index des Tarifes setzen und falls nicht ausgewählt Tarif überspringen
  if not Listbox.Selected[count] then begin  count:= count+1; continue; end;

  SaveToSingleFile(NameofFile+'_'+inttostr(tarifnumber)+'.csv', count);
  zip.FSpecArgs.Add(NameofFile+'_'+inttostr(tarifnumber)+'.csv');
  count:= count+1;
  tarifnumber:= tarifnumber+1;
  progress.position:= count;
until count=listbox.Items.Count;

//Logfile anlegen (enthält alle Dateinamen)
  zeilen:= TStringlist.Create;
  zeilen.append(extractfilename(basename));
  for i:= 0 to listbox.Items.Count-1 do
  begin
  if not listbox.Selected[i] then continue;
  zeilen.Append(listbox.items.Strings[i]);
  end;
  zeilen.SaveToFile('contents.lcx');
  zip.FSpecArgs.Add('contents.lcx');

  zeilen.free;

zip.AddOptions:= zip.AddOptions + [AddMove];
zip.Add;

end;

//eMail schreiben
mailtext:= #13#10+ '~~~~~~~~~~~~~~~~~~~~~~~'+#13#10 + datetimetostr(now) +#13#10;
if hauptfenster.german then mailtext:= mailtext +'Enthaltene Tarife :'+#13#10;


for i:= 0 to listbox.Count-1 do
if listbox.Selected[i] then
mailtext:= mailtext + listbox.Items.Strings[i] +#13#10;
wndlist.Visible:= false;

if hauptfenster.german then neu:= 'neue Tarife ';

if ((savedialog.FilterIndex = 2) and email.checked) then
begin
hauptfenster.sendmail(neu + datetimetostr(now),mailtext,'','','','',savedialog.FileName,extractfilename(savedialog.filename),true);
end
else
if ((savedialog.FilterIndex = 1) and email.checked) then
hauptfenster.sendmail(neu + datetimetostr(now),mailtext,'','','','',zip.ZipFileName,extractfilename(zip.ZipFileName),true);
end;
wndlist.Close;
end;

function tarifisvalid(name, DTag, DBeginn,DEnde,DStart, DExpires:string): boolean;
var i: integer;
    ergebnis: boolean;
    mo,di,mi,don,fr,sa,so,feiertag: string;
    temptime, temptimeend,  Dtemptime, Dtemptimeend: TDateTime;
    vglstring: string;
    anfang, ende: TTime;
    expdate, startdate: TDate;
begin

//negativ initialisieren
mo:= '[error]';
di:= '[error]';
mi:= '[error]';
don:='[error]';
fr:= '[error]';
sa:= '[error]';
so:= '[error]';
feiertag:= '[error]';

//wenn der tag enthalten ist, dann setzen
if ansicontainstext(Dtag,'[Mo]') then mo:= '[Mo]';
if ansicontainstext(Dtag,'[Di]') then di:= '[Di]';
if ansicontainstext(Dtag,'[Mi]') then mi:= '[Mi]';
if ansicontainstext(Dtag,'[Do]') then don:= '[Do]';
if ansicontainstext(Dtag,'[Fr]') then fr:= '[Fr]';
if ansicontainstext(Dtag,'[Sa]') then sa:= '[Sa]';
if ansicontainstext(Dtag,'[So]') then so:= '[So]';
if ansicontainstext(Dtag,'[feiertags]') then feiertag:= '[feiertags]';

   ergebnis:= true;


try
   Dtemptime   := EncodeDate(1970,01,01) + strtotime(Dbeginn);
   Dtemptimeend:= EncodeDate(1970,01,01) + strtotime(DEnde);

   if length(hauptfenster.tarife) > 0 then
   for i:= 0 to length(hauptfenster.tarife)-1 do
   //namen finden
   if hauptfenster.tarife[i].Tarif = name then
   begin
    expdate:=    strtodate(hauptfenster.tarife[i].expires);
    startdate:=  strtodate(hauptfenster.tarife[i].validfrom);
    vglstring:=  hauptfenster.tarife[i].tag;
    anfang:=     strtotime(hauptfenster.tarife[i].Beginn);
    ende:=       strtotime(hauptfenster.tarife[i].Ende);
    temptime   := EncodeDate(1970,01,01) + anfang;
    temptimeend:= EncodeDate(1970,01,01) + ende;

    if ( //wenn der Tag enthalten ist
       ( vglstring = Dtag))
        or (ansicontainstext(vglstring,mo)) or (ansicontainstext(vglstring,di))
        or (ansicontainstext(vglstring,mi)) or (ansicontainstext(vglstring,don))
        or (ansicontainstext(vglstring,fr)) or (ansicontainstext(vglstring,sa))
        or (ansicontainstext(vglstring,so)) or (ansicontainstext(vglstring,feiertag)
        )
    then
     begin
     //tagesüberschneidung abfangen
      if (temptimeend < temptime) then temptimeend:= EncodeDate(1970,1,2) {strtodate('02.01.1970')} + ende;

     //Dbeginn liegt im Intervall
      if ( ((temptime <= Dtemptime) and (temptimeend > (Dtemptime)) )
     //DEnde liegt im Intervall
      or   ((temptimeend >= (Dtemptimeend)) and (temptime < (Dtemptimeend)))
     //Intervall liegt zwischen TaStart.time und TaEnd.time
     //oder Intervall ist gleich
      or  ((temptime >= Dtemptime) and (temptimeend <= Dtemptimeend)) )
      then
      begin    // wenn Überschneidung gefunden
      if ((strtodate(DStart) <= expdate)   //wenn neuer beginn und altes Ende sich überschneiden
      and (startdate < strtodate(DStart) ))//wenn der neue Tarif später beginnt
       then
        begin //neues expireDate
         hauptfenster.tarife[i].expires:= datetostr(incDay(Strtodate(DStart),-1));

         //aufnehmen, wenn nicht schon gemacht
         if wndlist.NewDate.indexof(name) = -1 then  wndlist.newdate.append(name);
         //löschen, wenn nicht schon gelöscht
         if wndlist.allnames.IndexOf(name) > -1 then wndlist.allnames.Delete(wndlist.allnames.IndexOf(name));

         ergebnis:= true;
         end
       else
       if (startdate >= strtodate(DStart) )//wenn der neue Tarif neuer ist
       then begin ergebnis:= false; break; end;
      end;
     end;
   end;

   tarifisvalid:= ergebnis;
except
   ergebnis:= false;
   tarifisvalid:= ergebnis;
   end;
end;

procedure TWndList.import(filename:string);
var tarifname, DTag, DBeginn, DEnde,
    DEinwahl, DPreis, DUser, DPasswort,
    DWebseite, DStart, DExpires,
    Deingetragen, DTakt, DNummer: string;
    zeilen: TStringlist;
    j: integer;
    ident, identadd: string;
    rand, pos: integer;
    hinweis: boolean;
begin

hinweis:= false;
if not fileexists(filename) then exit;

 zeilen:= TStringList.Create;

 //zeilen sind die Zeilen eines Tarifsatzes
 try
 zeilen.LoadFromFile(filename);
 except //wenn lesefehler, dann überspringen
 zeilen.Free;
 exit;
 end;

tarifname:= zeilen.Strings[0];

if zeilen.count > 2 then       //Die Tabelle enthält ab zeile 3 Daten
begin

progress2.min:= 2;
progress2.max:= zeilen.count -1;

   for j:=2 to zeilen.count-1 do
   begin
   rand:= random(100000);
   identadd:='_'+datetimetostr(now)+'_'+inttostr(rand);
   ident:= tarifname+identadd;

   DTag         := GetWordofAnsiString(zeilen.Strings[j],1,char(#9));
   DBeginn      := GetWordofAnsiString(zeilen.Strings[j],2,char(#9));
   DEnde        := GetWordofAnsiString(zeilen.Strings[j],3,char(#9));
   DPreis       := GetWordofAnsiString(zeilen.Strings[j],4,char(#9));
   DEinwahl     := GetWordofAnsiString(zeilen.Strings[j],5,char(#9));
   DTakt        := GetWordofAnsiString(zeilen.Strings[j],6,char(#9));
   DNummer      := GetWordofAnsiString(zeilen.Strings[j],7,char(#9));
   DUser        := GetWordofAnsiString(zeilen.Strings[j],8,char(#9));
   DPasswort    := GetWordofAnsiString(zeilen.Strings[j],9,char(#9));
   DWebseite    := GetWordofAnsiString(zeilen.Strings[j],10,char(#9));
   DStart       := GetWordofAnsiString(zeilen.Strings[j],11,char(#9));
   DExpires     := GetWordofAnsiString(zeilen.Strings[j],12,char(#9));
   Deingetragen := GetWordofAnsiString(zeilen.Strings[j],13,char(#9));

   if tarifisvalid(tarifname, DTag,DBeginn,DEnde,DStart,DExpires) then   //Tarif existiert noch nicht
   begin
     pos:= length(hauptfenster.tarife);
     setlength(hauptfenster.tarife, pos+1);
     hauptfenster.tarife[pos].Tarif       := Tarifname;
     hauptfenster.tarife[pos].Tag         := DTag;
     hauptfenster.tarife[pos].Beginn      := DBeginn;
     hauptfenster.tarife[pos].Ende        := DEnde;
     hauptfenster.tarife[pos].Einwahl     := DEinwahl;
     hauptfenster.tarife[pos].Preis       := DPreis;
     hauptfenster.tarife[pos].Takt        := DTakt;
     hauptfenster.tarife[pos].Nummer      := DNummer;
     hauptfenster.tarife[pos].User        := DUser;
     hauptfenster.tarife[pos].Passwort    := DPasswort;
     hauptfenster.tarife[pos].Webseite    := DWebseite;
     hauptfenster.tarife[pos].validfrom   := DStart;
     hauptfenster.tarife[pos].expires     := DExpires;
     hauptfenster.tarife[pos].eingetragen := DEingetragen;
   end
   else hinweis:= true;

   progress2.Position:= j;

   end;
end;
zeilen.free;

if hinweis then
begin
     if notimported.IndexOf(tarifname) = -1 then
          begin
          NotImported.Append(tarifname);

         if AllNames.IndexOf(tarifname)> -1 then
                             AllNames.Delete(AllNames.IndexOf(tarifname));


          NotImportedFiles.append(Filename);
          end;
end;
end;


procedure Twndlist.batchimport;
var i: integer;
begin
if listbox.count > 0 then
begin

for i:= listbox.Count-1 downto 0 do
     if not listbox.Selected[i] then
      allnames.Delete(i);

progress.min:= 0;
progress.max:= listbox.Count-1;
for i:= 0 to listbox.Count-1 do
begin
     if listbox.Selected[i] then import(basename+'_'+inttostr(i+1)+'.csv');
     progress.Position:= i;
end;
end;
end;

procedure Twndlist.keineClick(Sender: TObject);
var i: integer;
begin
if keine.Checked then
begin
alle.checked:= false;

for i:=0 to listbox.Count-1 do
listbox.Selected[i]:= false;
end;
end;

procedure Twndlist.okClick(Sender: TObject);
var i: integer;
begin
if listbox.SelCount > 0 then
begin
listbox.enabled:= false;
ok.Enabled:= false;
sclose.enabled:= false;
SetCursor_wait;

progress.visible:= true;
progress2.visible:= true;
progress.refresh;
progress2.refresh;

if Caption.Caption='Export' then batchexport
else
if (Caption.Caption='Import') and not ImportLCX then batchimport
else
if (Caption.Caption='Import') and ImportLCX then
begin
     if not listbox.Selected[0] then
      allnames.Delete(0)
     else
     import(LCXFile);
     LCXFile:= '';
     importlcx:= false;
end;

//Zusammenfassung anzeigen
if (Caption.Caption='Import') then
begin
 progress.visible:= false;
 progress2.visible:= false;

 //Items anzeigen, die nicht erfolgreich waren
 listbox.Items.Clear;
 if notimported.count > 0 then
 begin
     for i:= 0 to NotImported.Count -1 do
      listbox.Items.Append(notImported.Strings[i]);
      memo1.height:= 90;
      panel2.height:= 36;
      wndlist.height:= wndlist.height + memo1.height;

      if hauptfenster.german then
      memo1.Text:= 'Die angezeigten Tarife wurden nur teilweise oder gar nicht importiert, da es Überschneidungen zu bestehenden Tarifen gibt.'
                   +'Sie können jetzt die alten Tarife löschen und die neuen importieren, indem sie oben die betreffenden Tarife markieren und auf den Button "Weiter" klicken.';
      Memo1.Visible:= true;
      ok.Visible:= false;
      NotImported_label.Visible:= true;
      NotImported_Overwrite.Visible:= true;
      listbox.height:= listbox.height-Notimported_label.height;
      listbox.top:= listbox.top + Notimported_label.Height;
      alleclick(self);
end
else
begin
 progress.visible:= false;
 progress2.visible:= false;
 NotImported_Label.Visible:= true;

 //fertig >>> alles auf die Platte schreiben
 WriteDataToHD;

 if hauptfenster.german then
  NotImported_Label.caption:= 'Zusammenfassung';
 listbox.items.Clear;

 if AllNames.Count > 0 then
 begin
  listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
 if hauptfenster.german then
  listbox.Items.Append('|  neu aufgenommene Tarife  |');
  listbox.Items.Append('|___________________________|');
  listbox.Items.Append('');
  for i:= 0 to AllNames.Count-1 do
       listbox.Items.Append(AllNames.Strings[i]);
 end;

 if NewDate.Count > 0 then
    begin
     listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
 if hauptfenster.german then
     listbox.Items.Append('     neu datierte Tarife     ');
     listbox.Items.Append('|___________________________|');
     listbox.Items.Append('');
      for i:= 0 to NewDate.Count-1 do
       listbox.Items.Append(NewDate.Strings[i]);
    end;

 NotImported_Overwrite.Visible:=false;
 Memo1.visible:= false;
 alle.Visible:= false;
 keine.Visible:= false;
 wndlist.height:= Caption.height + listbox.Height + panel3.Height + panel2.Height +40 ;
 ClearImport;
end;
SetCursor_Default;
end;


sclose.enabled:= true;
listbox.enabled:= true;

end;

//Nur beim Export gleich schließen
if caption.caption = 'Export' then
ok.enabled:= true;

end;

procedure FillListBox;
var temp: string;
    i: integer;
begin
with wndlist do
begin
     ListBox.Clear;

     for i:= 0 to length(hauptfenster.tarife)-1 do
     begin
          temp:= hauptfenster.tarife[i].tarif;
               if (listbox.Items.IndexOf(temp)=-1) then Listbox.Items.Append(temp);
               end;
     end;
end;

procedure Twndlist.FormCreate(Sender: TObject);
begin
//if not hauptfenster.german then lang.SetLangStrings_import;

zip.DLLDirectory:= Extractfilepath(paramstr(0));
ImportLCX:= false;
end;

procedure twndlist.getLCX(FileName: String);
var tarifname: string;
    imp: textfile;
begin
assignfile(imp,FileName);
reset(imp);
readln(imp,tarifname);
closefile(imp);
listbox.Items.Append(tarifname);

AllNames.Append(tarifname);
AllFiles.Append(FileName);

ImportLCX:= true;
LCXFile:= Filename;
end;

procedure Twndlist.FormShow(Sender: TObject);
var filename: string;
    i: integer;
begin
hauptfenster.enabled:= false;

if caption.caption='Export' then
begin
     listbox.Sorted:= true; //beim Exportieren sortieren
     FillListBox;
     email.Visible:= true;
//     email.Checked:= true;

     panel3.height:= panel3.height + 10 + email.height;

     wndlist.height:= Caption.height + listbox.Height + panel3.Height + panel2.Height + 20;
end
else  //Import
begin
     wndlist.height:= Caption.height + listbox.Height + panel3.Height + panel2.Height +20 ;

     NotImported:= TStringList.Create;
     NotImportedFiles:= TStringList.Create;
     AllFiles:= TStringlist.Create;
     AllNames:= TStringlist.Create;
     NewDate:= TStringlist.Create;


     email.Visible:= false;
     email.Checked:= false;

     if hauptfenster.german then
        opendialog.filter:= 'LeastCosterXP Tarifpaket (*.lcz)|*.lcz;*.LCZ|LeastCosterXP Tarifdatei (*.lcx)|*.lcx;*.LCX|';

     if not hauptfenster.startwithimport then
     begin
     if opendialog.execute then
       begin
          if (lowercase(ExtractFileExt(opendialog.filename))='.lcx') then
            getLCX(opendialog.FileName)
           else
           begin
            verzeichnis_erzeugen(Extractfilepath(paramstr(0))+'temp');
            filename:= extractfilename(opendialog.FileName);
            delete(filename, length(filename)-3,4);

            with zip do
            begin
            ZipFilename := opendialog.filename;
            ExtrBaseDir := Extractfilepath(paramstr(0))+'temp';
            Extract;
            end;

            ListBox.Items.LoadFromFile(Extractfilepath(paramstr(0))+'temp\contents.lcx');
            basename:= Extractfilepath(paramstr(0))+'temp\'+wndlist.ListBox.Items.Strings[0];
            ListBox.Items.Delete(0);
            for i:= 0 to listbox.Count - 1 do
            begin
             AllNames.Append(listbox.items.Strings[i]);
             AllFiles.Append(basename +'_'+ inttostr(i) + '.csv');
            end;
            end;

            ok.Visible:= true;
            ok.Enabled:= true;
            notimported_label.Visible:= false;
            alle.Visible:= true;
            keine.Visible:= true;
       end else begin ClearImport; newimport.Visible:= true; ok.Visible:= false; exit; end;// ende von opendialog
      end
  else //Start with import
      begin
         if (lowercase(extractFileExt(hauptfenster.importfilename)) = '.lcz')
         then
         begin
          verzeichnis_erzeugen(Extractfilepath(paramstr(0))+'temp');
          filename:= extractfilename(hauptfenster.importfilename);
          delete(filename, length(filename)-3,4);
          with zip do
          begin
          ZipFilename := hauptfenster.importfilename;
          ExtrBaseDir := Extractfilepath(paramstr(0))+'temp';
          Extract;
          end;

          hauptfenster.startwithimport:= false;
          hauptfenster.importfilename:= '';
          ListBox.Items.LoadFromFile(Extractfilepath(paramstr(0))+'temp\contents.lcx');
          basename:= Extractfilepath(paramstr(0))+'temp\'+wndlist.ListBox.Items.Strings[0];
          ListBox.Items.Delete(0);

          if listbox.Items.Count > 0 then
            for i:=0 to listbox.items.Count -1 do
            begin
             AllNames.Append(listbox.items.Strings[i]);
             AllFiles.Append(basename +'_'+ inttostr(i) + '.csv');
            end;
          end
         else
         if (lowercase(extractFileExt(hauptfenster.importfilename)) = '.lcx')
         then
          getlcx(hauptfenster.importfilename);
  end;


end;
//alle selektieren
alle.Checked:= true;
alleclick(self);
keine.checked:= false;

end;

procedure TWndlist.WriteDataToHD;
var text: textfile;
    fName: string;
    rand, i: integer;
    identadd: String;
begin
fName:= ExtractfilePath(paramstr(0)) + 'Tarife.ini';

assignfile(text,fName);
rewrite(text);

progress.min:= 0;
progress.max:= length(hauptfenster.tarife)-1;
progress.visible:= true;

for i:= 0 to length(hauptfenster.tarife)-1 do
begin

 rand:= random(100000);
 identadd:='_'+datetimetostr(now)+'_'+inttostr(rand);

 writeln(text,'['+hauptfenster.tarife[i].Tarif + identadd+']');
 writeln(text,'Tarif='+hauptfenster.tarife[i].Tarif);
 writeln(text,'Beginn='+hauptfenster.tarife[i].Beginn);
 writeln(text,'Ende='+hauptfenster.tarife[i].Ende);
 writeln(text,'Nummer='+hauptfenster.tarife[i].Nummer);
 writeln(text,'Preis='+hauptfenster.tarife[i].Preis);
 writeln(text,'Einwahl='+hauptfenster.tarife[i].Einwahl);
 writeln(text,'Takt='+hauptfenster.tarife[i].Takt);
 writeln(text,'User='+hauptfenster.tarife[i].User);
 writeln(text,'Passwort=',hauptfenster.tarife[i].Passwort);
 writeln(text,'Webseite=',hauptfenster.tarife[i].Webseite);
 writeln(text,'Tag=',hauptfenster.tarife[i].tag);
 writeln(text,'eingetragen=',hauptfenster.tarife[i].eingetragen);
 writeln(text,'expires=',hauptfenster.tarife[i].expires);
 if hauptfenster.tarife[i].DeleteWhenExpires then
  writeln(text,'DeleteWhenExpires=1');
 writeln(text,'start=',hauptfenster.tarife[i].validfrom);

 //neuen Tarif zu Scores hinzufügen - wenn noch nicht drin
 if IndexofScores(hauptfenster.tarife[i].Tarif) = -1 then
 begin
  setlength(hauptfenster.Scores, length(hauptfenster.Scores)+1);
  hauptfenster.Scores[length(hauptfenster.Scores)-1].Name:=hauptfenster.tarife[i].Tarif; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].erfolgreich:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].gesamt:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].State:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].Color:='none'; //neues in den Score aufnehmen
 end;

progress.position:= i;
end;
closefile(text);
progress.visible:= false;
end;


procedure Twndlist.NotImported_OverWriteClick(Sender: TObject);
var i,j, k: integer;

begin
SetCursor_wait;
Notimported_Overwrite.Refresh;
//Schritt 1: aus der liste alle löschen, die wirklich nicht importiert werden sollen
if ((listbox.Count > 0)  and (listbox.SelCount > 0)) then
begin
     progress.visible:= true;
     progress.refresh;

     progress.min:= 0;
     progress.max:= listbox.items.count + 2* listbox.SelCount;
     progress.position:= 0;

    for i:= listbox.items.Count -1 downto 0 do
    begin
     if not listbox.Selected[i] then
     begin
         NotImported.Delete(i);
         NotImportedFiles.Delete(i);
     end;
     progress.position:=progress.position + 1;
    end;

     //Schritt 2 : löschen der alten Tarife mit dem Namen
     if notImported.count > 0 then
     for i:= 0 to NotImported.Count-1 do //alle selektierten durchgehen
     begin

        if length(hauptfenster.tarife) > 0 then
          for k:= 0 to length(hauptfenster.tarife) -1 do //alle Tariffenster durchgehen
               if (hauptfenster.tarife[i].Tarif = NotImported.Strings[i]) then
                  begin
                    with Hauptfenster do //Datensatz löschen
                        for j:= length(Tarife)-1 downto 0 do
                        if Tarife[j].Tarif = NotImported.Strings[i] then
                           begin
                           tarife[j] := Tarife[length(tarife) -1]; //letzten Datensatz an stelle
                           setlength(tarife, length(tarife)-1); //um eine Stelle kürzen
                           end;
                   end;

      progress.Position:= progress.Position +1;
      end;

     progress2.visible:= true;
     progress2.Refresh;

      //Schritt 3 : Importieren der Tarife
      if notimported.count > 0 then
      for i:= 0 to NotImported.Count-1 do
      begin
           import(NotImportedFiles.Strings[i]);
           progress.Position:= progress.Position +1;
      end;

end else NotImported.Clear;

      progress.visible:= false;
      progress2.visible:= false;

      progress.refresh;
      progress2.refresh;
      listbox.refresh;


//fertig >>> alles auf die Platte schreiben
WriteDataToHD;


if hauptfenster.german then
      NotImported_Label.caption:= 'Zusammenfassung';

      listbox.items.Clear;

if ((AllNames.Count = 0) and (notimported.count = 0) and (newdate.Count =0)) then
   if hauptfenster.german then
   listbox.items.Append('Keine Änderungen.');

if AllNames.Count > 0 then
begin
 listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
 if hauptfenster.german then
 listbox.Items.Append('      neu aufgenommene Tarife   ');

 listbox.Items.Append('|___________________________|');
 listbox.Items.Append('');
 for i:= AllNames.Count-1  downto 0 do
      listbox.Items.Append(AllNames.Strings[i]);
end;

if NewDate.Count > 0 then
   begin
    listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
    if hauptfenster.german then
    listbox.Items.Append('        neu datierte Tarife     ');
    listbox.Items.Append('|___________________________|');
    listbox.Items.Append('');
     for i:= 0 to NewDate.Count-1 do
      listbox.Items.Append(NewDate.Strings[i]);
   end;


if NotImported.Count > 0 then
   begin
    listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
   if hauptfenster.german then
    listbox.Items.Append('       überschriebene Tarife    ');
    listbox.Items.Append('|___________________________|');
    listbox.Items.Append('');
     for i:= 0 to NotImported.Count-1 do
      listbox.Items.Append(NotImported.Strings[i]);
   end;


NotImported_Overwrite.Visible:=false;
Memo1.visible:= false;
alle.Visible:= false;
keine.Visible:= false;
wndlist.height:= Caption.height + listbox.Height + panel3.Height + panel2.Height +40 ;

SetCursor_Default;

ClearImport;

end;

procedure TwndList.SetCursor_Wait;
var h: THandle;
begin
  wndlist.Enabled:= false;
  h:=LoadImage(0,PChar(ExtractFilepath(paramstr(0)) +'wait.ani'),IMAGE_CURSOR,0,0,LR_DEFAULTSIZE or LR_LOADFROMFILE);
  if h=0 then Screen.Cursor:= CrHourglass
  else begin
    Screen.Cursors[1]:=h;
    Screen.Cursor:= 1;
  end;
end;

procedure TWndlist.SetCursor_Default;
begin
Screen.Cursor:= crDefault;
wndlist.enabled:= true;
end;


procedure Twndlist.NewimportClick(Sender: TObject);
begin
formshow(self);
newimport.visible:= false;
end;

end.
