unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, files, inifiles, ComCtrls;

type

  Twndlist = class(TForm)
    Panel1: TPanel;
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
    Newimport: TBitBtn;
    procedure ClearImport;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure alleClick(Sender: TObject);
    procedure keineClick(Sender: TObject);
    procedure batchexport;
    procedure batchimport;
    procedure okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NotImported_OverWriteClick(Sender: TObject);
    procedure SetCursor_Wait;
    procedure SetCursor_Default;
    procedure NewimportClick(Sender: TObject);
    procedure WriteDataToHD;
  private
    { Private declarations }
    ImportFile: string;
    NotImported, AllNames, NewDate: TStringList;
  public
    { Public declarations }
    basename: string;
  end;

var
  wndlist: Twndlist;

implementation

uses Unit1, tarifverw, StringRoutine, Strutils, DateUtils, Tarifmanager;

{$R *.dfm}

procedure Twndlist.keineClick(Sender: TObject);
var i: integer;
begin

alle.checked:= not keine.checked;
if keine.Checked then
  for i:=0 to listbox.Count-1 do
    listbox.Selected[i]:= false;

end;

procedure Twndlist.alleClick(Sender: TObject);
begin

  if alle.Checked then listbox.SelectAll;
  keine.Checked:= not alle.checked;
  
end;

procedure Twndlist.ClearImport;
begin
 if importfile <> '' then DeleteFile(ImportFile);
 if assigned(NotImported) then NotImported.Free;
 if assigned(NewDate) then NewDate.Free;
 if assigned(AllNames) then  AllNames.free;
 AllNames:= nil;
 progress.visible:= false;
 newimport.Visible:= true;
end;

procedure Twndlist.FormClose(Sender: TObject; var Action: TCloseAction);
begin
listbox.Items.clear;
SetCursor_wait;
hauptfenster.enabled:= true;

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

procedure Twndlist.batchexport;
var zeilen: TStringlist;
    i, k: integer;
    mailtext: string;
    neu: string;
    Datei: file of TTarif;
    Datensatz: TTarif;
    FName, CName: String;
begin

savedialog.Title:= 'Tarif - Export';
savedialog.filter:= 'LeastCosterXP Tarifpaket (*.lcx)|*.lcx;*.LCX';
savedialog.Options:= [ofHideReadOnly,ofCreatePrompt,ofEnableSizing, ofOverwritePrompt];

if savedialog.execute then
begin
  wndlist.Refresh;

  zeilen:= TStringList.Create;
  for k:= 0 to listbox.Count-1 do
    if listbox.Selected[k] then Zeilen.Append(ListBox.Items.Strings[k]);

  if zeilen.count > 0 then //wenn mehr als eine Zeile selektiert
  begin
    fName:= changeFileExt(SaveDialog.FileName,'.$$$');
    cName:= SaveDialog.FileName;
    AssignFile(Datei,fname);
    ReWrite(Datei);
    for i:= 0 to length(Hauptfenster.tarife) -1 do
     if (zeilen.IndexOf(Hauptfenster.tarife[i].Data.tarif) > -1) then
     begin
        Datensatz:= Hauptfenster.tarife[i].Data;
        DatenSatz.Editor:= ''; //editor jetzt vergessen
        write(Datei,Datensatz);
     end;
    CloseFile(Datei);

    Compress(fName, cName);
    DeleteFile(PChar(fName));
    
  end;  
  zeilen.free;

  if email.checked then  //eMail schreiben
  begin
  mailtext:= #13#10+ '~~~~~~~~~~~~~~~~~~~~~~~'+#13#10 + datetimetostr(now) +#13#10;
  if hauptfenster.german then mailtext:= mailtext +'Enthaltene Tarife :'+#13#10;


  for i:= 0 to listbox.Count-1 do
  if listbox.Selected[i] then
  mailtext:= mailtext + listbox.Items.Strings[i] +#13#10;
  wndlist.Visible:= false;

  neu:= 'neue Tarife ';

  hauptfenster.sendmail(neu + datetimetostr(now),mailtext,'','','','',savedialog.FileName,extractfilename(savedialog.filename),true);
  end;

  end; //vom SaveDialog

  wndlist.Close;
end;

function tarifisvalid(Tname, DTag:string;DBeginn,DEnde: TTime; DStart, DExpires:TDate): boolean;
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
   Dtemptime   := EncodeDate(1970,01,01) + Dbeginn;
   Dtemptimeend:= EncodeDate(1970,01,01) + DEnde;

   if length(hauptfenster.tarife) > 0 then
   for i:= 0 to length(hauptfenster.tarife)-1 do
   //namen finden
   if hauptfenster.tarife[i].Data.Tarif = Tname then
   begin
    expdate:=    hauptfenster.tarife[i].Data.expires;
    startdate:=  hauptfenster.tarife[i].Data.validfrom;
    vglstring:=  hauptfenster.tarife[i].Data.tag;
    anfang:=     hauptfenster.tarife[i].Data.Beginn;
    ende:=       hauptfenster.tarife[i].Data.Ende;
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
      if ((DStart <= expdate)   //wenn neuer beginn und altes Ende sich überschneiden
      and (startdate < DStart ))//wenn der neue Tarif später beginnt
       then
        begin //neues expireDate
         hauptfenster.tarife[i].Data.expires:= incDay(DStart,-1);

         //aufnehmen, wenn nicht schon gemacht
         if wndlist.NewDate.indexof(tname) = -1 then  wndlist.newdate.append(Tname);
         //löschen, wenn nicht schon gelöscht
         if wndlist.allnames.IndexOf(tname) > -1 then wndlist.allnames.Delete(wndlist.allnames.IndexOf(tname));

         ergebnis:= true;
         end
       else
       if (startdate >= DStart )//wenn der neue Tarif neuer ist
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

procedure Twndlist.batchimport;
var i,pos, count: integer;
    Datei: file of TTarif;
    DatenSatz: TTarif;
    rand: integer;
begin
 count:= 0;
if listbox.count > 0 then
  begin

    //in der Stringliste alles löschen, was nicht selektiert ist
    for i:= listbox.Count-1 downto 0 do
       if not listbox.Selected[i] then
          allnames.Delete(allnames.indexof(listbox.Items.Strings[i]));

    if not FileExists(ImportFile) then exit;

    assignfile(Datei,Importfile);
    reset(Datei);

    progress.min:=0;
    progress.max:=FileSize(datei)-1;

    while not EOF(Datei) do
    begin

     read(Datei, Datensatz);
     inc(count);
     progress.position:= count;
     if (listbox.Items.IndexOf(Datensatz.tarif) > -1) and listbox.Selected[listbox.Items.IndexOf(Datensatz.tarif)] then
       if tarifisvalid(Datensatz.tarif, Datensatz.Tag,Datensatz.Beginn,Datensatz.Ende,Datensatz.validfrom,Datensatz.Expires) then
       begin
         rand:= random(100000);
         pos:= length(hauptfenster.tarife);
         setlength(hauptfenster.tarife, pos+1);
         hauptfenster.tarife[pos].Data := Datensatz;
         hauptfenster.tarife[pos].ident:= Datensatz.tarif+'_'+datetimetostr(now)+'_'+inttostr(rand);
       end
       else  //wenn Tarif nicht geschrieben wurde
       begin
          if notimported.IndexOf(Datensatz.tarif) = -1 then
            begin
              if (NotImported.IndexOf(Datensatz.Tarif)= -1) then
                  NotImported.Append(Datensatz.Tarif);
              if AllNames.IndexOf(Datensatz.Tarif)> -1 then
                   AllNames.Delete(AllNames.IndexOf(DatenSatz.Tarif));
            end;
       end;
    end;

   Closefile(Datei);
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
  progress.refresh;

  if Caption.Caption='Export' then batchexport
  else
  if (Caption.Caption='Import') then batchimport;


//Zusammenfassung anzeigen  oder Liste der nicht importierten Tarife
if (Caption.Caption='Import') then
begin
 progress.visible:= false;

 //Items anzeigen, die nicht erfolgreich waren
 listbox.Items.Clear;
 if notimported.count > 0 then
 begin
     for i:= 0 to NotImported.Count -1 do
      listbox.Items.Append(notImported.Strings[i]);
      memo1.height:= 90;
      panel2.height:= 36;
      wndlist.height:= wndlist.height + memo1.height;

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
 NotImported_Label.Visible:= true;

 //fertig >>> alles auf die Platte schreiben
 WriteDataToHD;

 NotImported_Label.caption:= 'Zusammenfassung';
 listbox.items.Clear;
 listbox.Sorted:= false;

 if AllNames.Count > 0 then
 begin
  listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
  listbox.Items.Append('|  neu aufgenommene Tarife  |');
  listbox.Items.Append('|___________________________|');
  listbox.Items.Append('');
  AllNames.Sorted:= true;
  for i:= 0 to AllNames.Count-1 do
       listbox.Items.Append(AllNames.Strings[i]);
  AllNames.Sorted:= false;
  listbox.Items.Append('');
 end;

 if NewDate.Count > 0 then
    begin
     listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
     listbox.Items.Append('     neu datierte Tarife     ');
     listbox.Items.Append('|___________________________|');
     listbox.Items.Append('');
     NewDate.Sorted:= true;
      for i:= 0 to NewDate.Count-1 do
       listbox.Items.Append(NewDate.Strings[i]);
     NewDate.Sorted:= true;
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
          temp:= hauptfenster.tarife[i].Data.tarif;
          if (listbox.Items.IndexOf(temp)=-1) then Listbox.Items.Append(temp);
       end;
     end;
end;

procedure Twndlist.FormShow(Sender: TObject);
var DatenSatz: TTarif;
    Datei: file of TTarif;
    fname, cname: string;
begin
hauptfenster.enabled:= false;
listbox.Sorted:= true;

if caption.caption='Export' then
begin
     listbox.Sorted:= true; //beim Exportieren sortieren
     FillListBox;
     email.Visible:= true;
     panel3.height:= panel3.height + 10 + email.height;
     wndlist.height:= Caption.height + listbox.Height + panel3.Height + panel2.Height + 20;
end
else  //Import
begin
     wndlist.height:= Caption.height + listbox.Height + panel3.Height + panel2.Height +20 ;

     NotImported:= TStringList.Create;
     AllNames:= TStringlist.Create;
     NewDate:= TStringlist.Create;


     email.Visible:= false;
     email.Checked:= false;

     opendialog.filter:= 'LeastCosterXP Tarifdatei (*.lcx)|*.lcx;*.LCX|';

     if not hauptfenster.startwithimport then
     begin
     if opendialog.execute then
       begin
            fname:= OpenDialog.FileName;
            cname:= changeFileExt(fname,'.$$$');
            DeCompress(fname,cname);
            ImportFile:=cname;

            assignFile(Datei,cname);
            Reset(datei);
            While not EOF(datei) do
            begin
             read(datei,DatenSatz);
            //Jeden tarif nur 1x hinzufügen
             if (Listbox.Items.IndexOf(Datensatz.Tarif) = -1)  then
             begin
              Listbox.Items.Append(Datensatz.Tarif);
              AllNames.Append(Datensatz.Tarif);
             end;
            end;
            CloseFile(datei);

            ok.Visible:= true;
            ok.Enabled:= true;
            notimported_label.Visible:= false;
            alle.Visible:= true;
            keine.Visible:= true;
       end else begin ClearImport; newimport.Visible:= true; ok.Visible:= false; exit; end;// ende von opendialog
      end
  else //Start with import
    if (lowercase(extractFileExt(hauptfenster.importfilename)) = '.lcx') then
        begin
            fname:= hauptfenster.importfilename;
            cname:= changeFileExt(fname,'.$$$');
            DeCompress(fname,cname);
            assignFile(Datei,cname);
            ImportFile:=cname;
            Reset(datei);
            While not EOF(datei) do
            begin
             read(datei,DatenSatz);
            //Jeden tarif nur 1x hinzufügen
             if (Listbox.Items.IndexOf(Datensatz.Tarif) = -1)  then
             begin
              Listbox.Items.Append(Datensatz.Tarif);
              AllNames.Append(Datensatz.Tarif);
             end;
            end;
            CloseFile(datei);
            
            hauptfenster.startwithimport:= false;
            hauptfenster.importfilename:= '';

            ok.Visible:= true;
            ok.Enabled:= true;
            notimported_label.Visible:= false;
            alle.Visible:= true;
            keine.Visible:= true;

        end;



end;
//alle selektieren
alle.Checked:= true;
alleclick(self);
keine.checked:= false;

end;

procedure TWndlist.WriteDataToHD;
var fName,cname: string;
    i: integer;
    Datei: file of TTarif;
begin
fName:= ExtractfilePath(paramstr(0)) + 'Tarife.tmp';
cName:= ExtractfilePath(paramstr(0)) + 'Tarife.lcx';

assignfile(Datei,fName);
rewrite(Datei);

progress.min:= 0;
progress.max:= length(hauptfenster.tarife)-1;
progress.visible:= true;

for i:= 0 to length(hauptfenster.tarife)-1 do
begin
 write(Datei, Hauptfenster.tarife[i].Data); //Datensatz abspeichern

 //neuen Tarif zu Scores hinzufügen - wenn noch nicht drin
 if IndexofScores(hauptfenster.tarife[i].Data.Tarif) = -1 then
 begin
  setlength(hauptfenster.Scores, length(hauptfenster.Scores)+1);
  hauptfenster.Scores[length(hauptfenster.Scores)-1].Name:=hauptfenster.tarife[i].Data.Tarif; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].erfolgreich:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].gesamt:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].State:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].Color:='none'; //neues in den Score aufnehmen
 end;

progress.position:= i;
end;
closefile(Datei);
Compress(fName, cName);
DeleteFile(PChar(fName));
progress.visible:= false;
end;


procedure Twndlist.NotImported_OverWriteClick(Sender: TObject);
var i,j, count, rand: integer;
    Datei: File of TTarif;
    Datensatz: TTarif;
    posi: integer;
begin
count:= 0;
SetCursor_wait;
Notimported_Overwrite.Refresh;
//Schritt 1: aus der liste alle löschen, die wirklich nicht importiert werden sollen
if ((listbox.Count > 0)  and (listbox.SelCount > 0)) then
begin
     progress.visible:= true;
     progress.refresh;

     progress.min:= 0;
     progress.max:= 2* listbox.SelCount;
     progress.position:= 0;

    for i:= listbox.items.Count -1 downto 0 do
      if not listbox.Selected[i] then
      begin
       NotImported.Delete(NotImported.IndexOf(listbox.Items.strings[i]));
       progress.position:=progress.position + 1;
      end;

     //Schritt 2 : löschen der alten Tarife mit dem Namen
     if notImported.count > 0 then
       with Hauptfenster do //Datensatz löschen
          for j:= length(Tarife)-1 downto 0 do
             if NotImported.IndexOf(Tarife[j].Data.Tarif) > -1 then
                begin
                   tarife[j] := Tarife[length(tarife) -1]; //letzten Datensatz an diese stelle
                   setlength(tarife, length(tarife)-1); //um eine Stelle kürzen
                   progress.position:=progress.position + 1;
                end;

     progress.visible:= true;
     progress.Refresh;

      //Schritt 3 : Importieren der Tarife
      if notimported.count > 0 then
      begin
       assignfile(Datei,Importfile);
       reset(Datei);
       progress.min:=0;
       progress.max:=FileSize(datei)-1;

       while not EOF(Datei) do
       begin
        read(Datei, Datensatz);
        inc(count);
          //wen in der NotImported-Liste dann jetzt importieren
         if (notimported.IndexOf(Datensatz.tarif) > -1) then
         begin
           rand:= random(100000);
           posi:= length(hauptfenster.tarife);
           setlength(hauptfenster.tarife, posi+1);
           hauptfenster.tarife[posi].Data := Datensatz;
           hauptfenster.tarife[posi].ident:= Datensatz.tarif+'_'+datetimetostr(now)+'_'+inttostr(rand);
        end;
       progress.position:= count;
      end;

     Closefile(Datei);
   end;
end else NotImported.Clear;

progress.visible:= false;

progress.refresh;

listbox.refresh;

//fertig >>> alles auf die Platte schreiben
WriteDataToHD;

NotImported_Label.caption:= 'Zusammenfassung';
listbox.items.Clear;
listbox.Sorted:= false;

if ((AllNames.Count = 0) and (notimported.count = 0) and (newdate.Count =0)) then
 listbox.items.Append('Keine Änderungen.');

if AllNames.Count > 0 then
begin
 listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
 listbox.Items.Append('      neu aufgenommene Tarife   ');
 listbox.Items.Append('|___________________________|');
 listbox.Items.Append('');
 AllNames.Sorted:= true;
 for i:= AllNames.Count-1  downto 0 do
      listbox.Items.Append(AllNames.Strings[i]);
 listbox.Items.Append('');
 AllNames.Sorted:= false;
end;

if NewDate.Count > 0 then
   begin
    listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
    listbox.Items.Append('        neu datierte Tarife     ');
    listbox.Items.Append('|___________________________|');
    listbox.Items.Append('');
    Newdate.sorted:= true;
     for i:= 0 to NewDate.Count-1 do
      listbox.Items.Append(NewDate.Strings[i]);
    Newdate.sorted:= false;
   listbox.Items.Append('');
   end;


if NotImported.Count > 0 then
   begin
    listbox.Items.Append('|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|');
    listbox.Items.Append('       überschriebene Tarife    ');
    listbox.Items.Append('|___________________________|');
    listbox.Items.Append('');
    NotImported.Sorted:= true;
     for i:= 0 to NotImported.Count-1 do
      listbox.Items.Append(NotImported.Strings[i]);
    NotImported.Sorted:= false;
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
