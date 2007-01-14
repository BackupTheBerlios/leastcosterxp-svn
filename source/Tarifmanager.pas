unit Tarifmanager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, Inifiles, StrUtils, DateUtils,
  Buttons, files, Mask, ExtCtrls, Spin, ImgList, AppEvnts;

type
  TTaVerwaltung = class(TForm)
    Panel1: TPanel;
    Caption: TLabel;
    Button4: TButton;
    Butkopieren: TButton;
    ButDelExp: TButton;
    BitBtn1: TBitBtn;
    Tarifliste: TStringGrid;
    Tarifbox: TComboBox;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet1: TTabSheet;
    Konti_tarif: TStaticText;
    Freikontingente: TGroupBox;
    Konti_upvol: TSpinEdit;
    konti_up: TLabel;
    konti_down: TLabel;
    Verbrauch: TGroupBox;
    konti_change: TButton;
    konti_zaehler: TEdit;
    reset: TButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    konti_tag: TSpinEdit;
    Label24: TLabel;
    Panel2: TPanel;
    konti_voltype_both: TRadioButton;
    konti_voltype_down: TRadioButton;
    konti_zeit: TSpinEdit;
    Label25: TLabel;
    Label26: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label10: TLabel;
    TaNumber: TEdit;
    TaName: TEdit;
    TaStart: TDateTimePicker;
    ganztags: TCheckBox;
    TaEnd: TDateTimePicker;
    TaPrice: TEdit;
    TaEinwahl: TEdit;
    TaTaktbox: TComboBox;
    TaTakt_a: TEdit;
    TaUser: TEdit;
    TaPass: TMaskEdit;
    TaWebsite: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox8: TCheckBox;
    TaStarts: TDateTimePicker;
    Taexpires: TDateTimePicker;
    Button2: TButton;
    Button1: TButton;
    GroupBox3: TGroupBox;
    butBatchExport: TBitBtn;
    ButBatchImport: TBitBtn;
    nextreset: TLabel;
    radio_zeit: TRadioButton;
    Radio_Vol: TRadioButton;
    radio_NO: TRadioButton;
    Panel3: TPanel;
    errormsg: TLabel;
    GroupBox2: TGroupBox;
    DelAll: TBitBtn;
    Tadelend: TCheckBox;
    blinker: TTimer;
    Freikontis_online: TGroupBox;
    Label14: TLabel;
    konti_min: TSpinEdit;
    Label22: TLabel;
    Blacklist: TBitBtn;
    Icons: TImageList;
    Vordergrund: TCheckBox;
    applicationevents1: TApplicationEvents;
    Eingabemode: TPanel;
    tarifliste_size: TPanel;
    PBar: TProgressBar;
    Label12: TLabel;
    Label23: TLabel;
    TaMindestumsatz: TLabeledEdit;
    TaTakt_b: TEdit;
    Label27: TLabel;
    procedure TaMindestumsatzKeyPress(Sender: TObject; var Key: Char);
    procedure tarifliste_sizeClick(Sender: TObject);
    procedure EingabemodeClick(Sender: TObject);
    procedure applicationevents1Deactivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure TaPriceKeyPress(Sender: TObject; var Key: Char);
    procedure TaTakt_aKeyPress(Sender: TObject; var Key: Char);
    procedure AddItemstoTarifbox(index: integer);
    procedure AddItemstoTarifListe;
    procedure TarifboxCloseUp(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    function isDataValid(tag: string; myident: string): boolean;
    procedure DeleteSelection(item: integer);
    procedure Button4Click(Sender: TObject);
    procedure ChangeData;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ganztagsClick(Sender: TObject);
    procedure TaTaktboxChange(Sender: TObject);
    procedure TariflisteMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure butBatchExportClick(Sender: TObject);
    procedure ButBatchImportClick(Sender: TObject);
    procedure ButDelExpClick(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure newexpireDropDown(Sender: TObject);
    procedure TariflisteClick(Sender: TObject);
    procedure ButkopierenClick(Sender: TObject);
    procedure konti_changeClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure radio_zeitClick(Sender: TObject);
    procedure ChangeValue(anfang: integer; ende:integer; Bezeichner, WertalsString: string);
    procedure TaNameChange(Sender: TObject);
    procedure DelAllClick(Sender: TObject);
    procedure blinkerTimer(Sender: TObject);
    procedure TariflisteMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TariflisteDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure TariflisteDblClick(Sender: TObject);
    Procedure SetRed;
    procedure BlacklistClick(Sender: TObject);
    procedure TaNumberKeyPress(Sender: TObject; var Key: Char);
    
  private
    { Private declarations }
    column , row: integer;
    postop, posleft: integer;
    changename: string;
    nomove: boolean;
    blinkercount: integer;
    sort_descending: boolean;
    liste_clicked, liste_rand: boolean;
    last_x: integer;
  public
    { Public declarations }
  end;

var
  TaVerwaltung: TTaVerwaltung;
  myident: string;

implementation

uses Unit3, Unit1, tarifverw, auswertung, math, GridEvents, addons, inilang, messagestrings;

{$R *.dfm}

procedure EnableEdits(edit:boolean);
begin
with TaVerwaltung do
begin
 TaName.Enabled         := edit;
 TaNumber.Enabled       := edit;
 TaStart.Enabled        := edit;
 TAEnd.Enabled          := edit;
 TaPrice.Enabled        := edit;
 TaEinwahl.Enabled      := edit;
 TaTakt_a.Enabled       := edit;
 TaTakt_b.Enabled       := edit;
 TaTaktbox.Enabled      := edit;
 TaUser.Enabled         := edit;
 TaPass.Enabled         := edit;
 TaWebsite.Enabled      := edit;
 CheckBox1.Enabled      := edit;
 CheckBox2.Enabled      := edit;
 CheckBox3.Enabled      := edit;
 CheckBox4.Enabled      := edit;
 CheckBox5.Enabled      := edit;
 CheckBox6.Enabled      := edit;
 CheckBox7.Enabled      := edit;
 CheckBox8.Enabled      := edit;
 CheckBox9.Enabled      := edit;
 CheckBox10.Enabled     := edit;
 Taexpires.Enabled      := edit;
 TaStarts.Enabled       := edit;
 Tadelend.Enabled       := edit;
 button1.Enabled        := edit;
 TaMindestumsatz.Enabled:= edit;
end;
end;

procedure changenames(oldname, newname: string);
var i: integer;
    tempname: string;
begin
for i:= 0 to length(hauptfenster.tarife)-1 do
 begin
    tempname:= Hauptfenster.Tarife[i].Tarif;
    if tempname=oldname then Hauptfenster.Tarife[i].Tarif:= newname;
  end;
end;

function TarifKickedOut: boolean;
var i: integer;
begin
  Result:= true;
  for i:= 0 to length(hauptfenster.tarife)-1 do
   with TaVerwaltung do
   if hauptfenster.tarife[i].Tarif = tarifbox.items.Strings[tarifbox.itemindex] then
   begin
    Result := false;
    break;
   end;
end;

procedure TTaVerwaltung.Button1Click(Sender: TObject);
var temptag: string;
    fehlertext: string;
    error, written: boolean;
    rand: integer;
    dummy, code, i: integer;
    wert: string;
    changedvalues: TStringlist;
    myidentindex: integer;
begin
myidentindex:=0;
errormsg.caption:= '';
error:= false;
fehlertext:= '';

checkbox1.Font.color:= clWindowText;
checkbox2.Font.color:= clWindowText;
checkbox3.Font.color:= clWindowText;
checkbox4.Font.color:= clWindowText;
checkbox5.Font.color:= clWindowText;
checkbox6.Font.color:= clWindowText;
checkbox7.Font.color:= clWindowText;
label1.Font.Color:=clWindowText;
label2.Font.Color:=clWindowText;
label3.Font.Color:=clWindowText;
label4.Font.Color:=clWindowText;
label5.Font.Color:=clWindowText;
label6.Font.Color:=clWindowText;
label7.Font.Color:=clWindowText;
label8.Font.Color:=clWindowText;
label9.Font.Color:=clWindowText;
label10.Font.Color:=clWindowText;
label11.Font.Color:=clWindowText;

if (taName.text ='') then
begin
  label1.font.color:= clred;
  error:=true;
end;

if (taPrice.text ='') then
begin
  label8.font.color:= clred;
  error:=true;
end;

if (taEinwahl.text ='') then
begin
  label11.font.color:= clred;
  error:=true;
end;

if taNumber.text ='' then
begin
 label2.font.color:= clred;
 error:=true;
end;

val(Trim(TaNumber.Text), Dummy, Code);
 if Code<>0 then
 begin
  label2.font.color:= clred;
  error:=true;
 end;

if (not checkbox1.checked and not checkbox2.checked and not checkbox3.checked and not checkbox4.checked and not checkbox5.checked and not checkbox6.checked and not checkbox7.checked and not checkbox10.checked) then
begin
 checkbox1.Font.color:= clred;
 checkbox2.Font.color:= clred;
 checkbox3.Font.color:= clred;
 checkbox4.Font.color:= clred;
 checkbox5.Font.color:= clred;
 checkbox6.Font.color:= clred;
 checkbox7.Font.color:= clred;
 error:=true;
end;

if (TaWebsite.text='') then
begin
  errormsg.caption:= misc(M157,'M157');
  label7.font.color:= clgreen;
end;

if ((TaStart.time= TaEnd.time) and (not ganztags.checked)) then
begin
  errormsg.caption:= misc(M158,'M158');
  label3.font.color:= clgreen;
  label4.font.color:= clgreen;
  tastart.time:= Encodetime(0,0,0,0);
  taend.time:= Encodetime(0,0,0,0);
end;

if (TaExpires.date < TAStarts.date) then
begin
 label10.Font.color:= clred;
 error:= true;
end;

if error then
begin
  errormsg.caption:= misc(M159,'M159');
  exit;
end;

temptag:= '';

if checkbox1.checked then temptag:= temptag +'[Mo]';
if checkbox2.checked then temptag:= temptag +'[Di]';
if checkbox3.checked then temptag:= temptag +'[Mi]';
if checkbox4.checked then temptag:= temptag +'[Do]';
if checkbox5.checked then temptag:= temptag +'[Fr]';
if checkbox6.checked then temptag:= temptag +'[Sa]';
if checkbox7.checked then temptag:= temptag +'[So]';
if checkbox10.checked then temptag:= temptag +'[feiertags]';

if not isdatavalid(temptag, myident) then
    begin
      errormsg.Caption:= misc(M160,'M160');
      exit;
    end;

//################ Fehler abgearbeitet ##########################
// geänderte Werte neu setzen
if myident <> '' then myidentindex:= strtoint(myident);

changedvalues:= TStringlist.create;
if myident <> '' then //neuer Datensatz
begin
     //feststellen welche Felder verändert wurden und merken
     if (TaName.Text            <> tarifbox.Items.Strings[tarifbox.itemindex]) then changedvalues.Append('Tarif');
     if (TaNumber.Text          <> tarifliste.cells[6,tarifliste.row]) then changedvalues.Append('Nummer');
     if (Timetostr(TaStart.time)<> tarifliste.Cells[1,tarifliste.row]) then changedvalues.Append('Beginn');
     if (Timetostr(TaEnd.time)  <> tarifliste.Cells[2,tarifliste.row]) then changedvalues.Append('Ende');
     if (TaPrice.text           <> tarifliste.Cells[3,tarifliste.row]) then changedvalues.Append('Preis');
     if (TaEinwahl.text         <> tarifliste.Cells[4,tarifliste.row]) then changedvalues.Append('Einwahl');
     if (Format('%s/%s',[taTakt_a.Text,taTakt_b.Text])    <> tarifliste.cells[5,tarifliste.row]) then changedvalues.Append('Takt');
     if (taUser.text            <> tarifliste.cells[7,tarifliste.row]) then changedvalues.Append('User');
     if (taPass.text            <> tarifliste.cells[8,tarifliste.row]) then changedvalues.Append('Passwort');
     if (taWebsite.text         <> tarifliste.cells[9,tarifliste.row]) then changedvalues.Append('Webseite');
     if (taStarts.Date          <> strtodate(tarifliste.cells[10,tarifliste.row]) ) then changedvalues.Append('start');
     if (taexpires.Date         <> strtodate(tarifliste.cells[11,tarifliste.row]) ) then changedvalues.Append('expires');
     if (temptag                <> tarifliste.cells[0,tarifliste.row] ) then changedvalues.Append('Tag');
     if (TaMindestumsatz.text   <> tarifliste.cells[16,tarifliste.row] ) then changedvalues.Append('Mindestumsatz');

     if (TaDelEnd.checked and (tarifliste.cells[14,tarifliste.row] =  misc(M162,'M162'))) then changedvalues.Append('DeleteWhenExpires')
     else
     if (not TaDelEnd.checked and (tarifliste.cells[14,tarifliste.row] = misc(M161,'M161'))) then changedvalues.Append('DeleteWhenExpires');

     //werte ändern
     if ((changedvalues.count > 0)   and (myident <> ''))
       then
       for i:= 0 to changedvalues.count-1 do
       begin
       if changedvalues.strings[i] = 'Tarif' then
          wert:= TaName.Text
       else
       if changedvalues.Strings[i] = 'Beginn' then
          begin
               wert:= timetostr(TaStart.time);
               changevalue(tarifliste.Selection.TopLeft.Y, tarifliste.Selection.TopLeft.Y, changedvalues.Strings[i], wert);
               continue;
          end
       else
       if changedvalues.Strings[i] = 'Ende' then
          begin
               wert:= timetostr(TaEnd.time);
               changevalue(tarifliste.Selection.TopLeft.Y, tarifliste.Selection.TopLeft.Y, changedvalues.Strings[i], wert);
               continue;
               end
          else
          if changedvalues.Strings[i] = 'Nummer' then
               wert:= TaNumber.Text
          else
          if changedvalues.Strings[i] = 'Preis' then
          wert:= TaPrice.text
          else
          if changedvalues.Strings[i] = 'Einwahl' then
          wert:= TaEinwahl.Text
          else
          if changedvalues.Strings[i] = 'Takt' then
          wert:= Format('%d/%d',[TaTakt_a.Text,taTakt_b.Text])
          else
          if changedvalues.Strings[i] = 'User' then
          wert:= TaUser.Text
          else
          if changedvalues.Strings[i] = 'Passwort' then
          wert:= TaPass.Text
          else
          if changedvalues.Strings[i] = 'Webseite' then
          wert:= TaWebsite.Text
          else
          if changedvalues.Strings[i] = 'start' then
          wert:= datetostr(Tastarts.Date)
          else
          if changedvalues.Strings[i] = 'Mindestumsatz' then
          wert:= TaMindestumsatz.text
          else
          if changedvalues.Strings[i] = 'expires' then
          wert:= datetostr(Taexpires.Date)
          else
          if changedvalues.Strings[i] = 'Tag' then
          wert:= temptag
          else
          if changedvalues.Strings[i] = 'DeleteWhenExpires' then
          begin
             if TaDelEnd.Checked then wert:= '1' else wert:= '0';
          end;
       //setzen der Änderungen
       changevalue(tarifliste.Selection.TopLeft.Y, tarifliste.Selection.BottomRight.Y, changedvalues.Strings[i], wert);

       //"beginnt am"-Datum updaten, wenn der Tarif schon gültig ist
       if changedvalues.Strings[i] = 'expires' then
        if Tastarts.date <= dateof(Now) then
              changevalue(tarifliste.Selection.TopLeft.Y, tarifliste.Selection.BottomRight.Y, 'start', datetostr(dateof(now)));
end;
end;

//hinzufügen
if myident='' then
begin

  setlength(hauptfenster.tarife, length(hauptfenster.tarife)+1);
  with hauptfenster.tarife[length(hauptfenster.tarife)-1] do
  begin
    Tarif            := TaName.text;
    Beginn           := TaStart.time;
    Ende             := TaEnd.time;
    Nummer           := TaNumber.text;
    Preis            := StrToFloat(TaPrice.Text);
    Einwahl          := StrToFloat(TaEinwahl.Text);
    takt_a           := StrToInt(TaTakt_a.Text);
    takt_b           := StrToInt(TaTakt_b.Text);
    User             := TaUser.Text;
    Passwort         := TaPass.text;
    Webseite         := TaWebsite.text;
    Tag              := temptag;
    eingetragen      := Dateof(now);
    validfrom        := TaStarts.Date;
    expires          := TaExpires.Date;
    DeleteWhenExpires:= TaDelEnd.checked;
    Mindestumsatz    := strtofloat(TaMindestumsatz.Text);
  end;

 //neuen Tarif hinzufügen - wenn noch nicht drin
 if IndexofScores(TaName.text) = -1 then
 begin
  setlength(hauptfenster.Scores, length(hauptfenster.Scores)+1);
  hauptfenster.Scores[length(hauptfenster.Scores)-1].Name:=TaName.Text; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].erfolgreich:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].gesamt:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].State:=0; //neues in den Score aufnehmen
  hauptfenster.Scores[length(hauptfenster.Scores)-1].Color:='none'; //neues in den Score aufnehmen
 end;
end
else //ident zum ändern
hauptfenster.tarife[myidentindex].beginn:= TaStart.time;

if myident='' then
begin
 AddItemstoTarifbox(-10);
 Additemstotarifliste;
end
else
begin
//wenn name geändert wurde dann tarifbox wechseln
if changedvalues.IndexOf('Tarif') <> -1 then
begin
  //neuen Tarif hinzufügen
 setlength(hauptfenster.Scores, length(hauptfenster.Scores)+1);
  hauptfenster.Scores[length(hauptfenster.Scores)-1].Name:=TaName.Text; //neues in den Score aufnehmen
    hauptfenster.Scores[length(hauptfenster.Scores)-1].erfolgreich:=0; //neues in den Score aufnehmen
      hauptfenster.Scores[length(hauptfenster.Scores)-1].gesamt:=0; //neues in den Score aufnehmen
        hauptfenster.Scores[length(hauptfenster.Scores)-1].State:=0; //neues in den Score aufnehmen

 AddItemstoTarifbox(tarifbox.itemindex); //neu einlesen
 if TarifKickedOut then tarifbox.Items.Delete(tarifbox.itemindex); //altes Element löschen
 tarifbox.itemindex:= tarifbox.items.indexof(TaName.Text); //index des neuen Names
end;

button2.Click; //Felder löschen
button1.caption:=misc(M163,'M163');
tarifboxCloseUp(self);
changedvalues.Free;
end;

end;

procedure TTaVerwaltung.FormCreate(Sender: TObject);
var i: word;
    large: boolean;
begin
hauptfenster.enabled:= false;
sort_descending:= false;
nomove:= false;
myident:='';

CL:=loadIni('lang\'+settings.readstring('LeastCoster','language',''));
if CL<>nil then fillProps([TaVerwaltung],CL);

PageControl1.ActivePage:= TabSheet2;

tarifliste.cells[0,0]:= misc(M164,'M164');
tarifliste.cells[1,0]:= misc(M165,'M165');
tarifliste.cells[2,0]:= misc(M166,'M166');
tarifliste.cells[3,0]:= misc(M167,'M167');
tarifliste.cells[4,0]:= misc(M168,'M168');
tarifliste.cells[5,0]:= misc(M169,'M169');
tarifliste.cells[6,0]:= misc(M170,'M170');
tarifliste.cells[7,0]:= misc(M171,'M171');
tarifliste.cells[8,0]:= misc(M172,'M172');
tarifliste.cells[9,0]:= misc(M173,'M173');
tarifliste.cells[10,0]:=misc(M174,'M174');
tarifliste.cells[11,0]:=misc(M175,'M175');
tarifliste.cells[12,0]:=misc(M176,'M176');
tarifliste.cells[13,0]:='Ident';
tarifliste.cells[14,0]:=misc(M177,'M177');
tarifliste.cells[15,0]:=misc(M178,'M178');
tarifliste.cells[16,0]:=misc(M268,'M268');

for i:= 0 to tarifliste.colcount-1 do
  Tarifliste.ColWidths[i] := settings.readinteger('Tarifmanager','Col'+inttostr(i),64);

large  := settings.readbool('Tarifmanager','Tarifliste_large', false);
if large then tarifliste_sizeclick(self);


//IdentSpalte 'unsichtbar'
tarifliste.ColWidths[13]:= -1;

Taexpires.Date:= incday(dateof(now),7);
taStarts.date:= dateof(now);
tastart.ShowCheckbox:= true;
taend.ShowCheckbox:= true;

TaTaktbox.ItemIndex:=0;
tataktboxchange(nil);

TaStart.DateTime:= EncodeDateTime(1970,01,01,0,0,0,0);
TaEnd.DateTime:= EncodeDateTime(1970,01,01,0,0,0,0);

tastart.ShowCheckbox:= false;
taend.ShowCheckbox:= false;

AddItemsToTarifbox(0);
tarifboxcloseup(sender);
end;

procedure TTaVerwaltung.CheckBox8Click(Sender: TObject);
begin
  checkbox1.checked:= checkbox8.Checked;
  checkbox2.checked:= checkbox8.Checked;
  checkbox3.checked:= checkbox8.Checked;
  checkbox4.checked:= checkbox8.Checked;
  checkbox5.checked:= checkbox8.Checked;
end;

procedure TTaVerwaltung.CheckBox9Click(Sender: TObject);
begin
  checkbox6.checked:= checkbox9.checked;
  checkbox7.checked:= checkbox9.checked;
end;

procedure TTaVerwaltung.TaPriceKeyPress(Sender: TObject; var Key: Char);
begin
with sender as Tedit do
if not ansicontainstext(text,DecimalSeparator) then
begin
   if not (Key in ['0'..'9',DecimalSeparator, Char(VK_BACK)]) then
     Key := #0;            //  dann sofort löschen
end
else
   if not (Key in ['0'..'9', Char(VK_BACK)]) then
     Key := #0;            //  dann sofort löschen
end;

procedure TTaVerwaltung.TaTakt_aKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9', Char(VK_BACK)]) then
  Key := #0;
end;
//index: welcher index soll ausgewählt werden ?
procedure TTaVerwaltung.AddItemstoTarifbox(index: integer);
var i: integer;
    temp: string;
begin
for i:= 0 to length(hauptfenster.Tarife) -1  do
begin
  temp:= hauptfenster.Tarife[i].tarif;
  if (tarifbox.Items.IndexOf(temp)=-1) then Tarifbox.Items.Append(temp);
end;

tarifbox.ItemIndex:=index;

//-20 Tarifname geändert | -10 wenn neu hinzugefügt
if (index=-10) then tarifbox.itemindex:= tarifbox.items.indexof(TAName.text)
else
if (index=-20) then tarifbox.itemindex:= tarifbox.items.indexof(TaName.text);
end;

procedure TTaVerwaltung.AddItemstoTarifListe;
var i, rows, state: integer;
    btime: cardinal;
begin

Tarifliste.rows[0].Clear;
Tarifliste.Rows[1].clear;
Tarifliste.rowcount:= 2;

//Blacklist oder Whitelist ?
if Tarifbox.Items.Strings[Tarifbox.ItemIndex] <> '' then
begin
 state:=  GetState(Tarifbox.Items.Strings[Tarifbox.ItemIndex]);

 blacklist.Glyph.TransparentColor:= clNone;
 blacklist.Glyph.TransparentMode:= tmFixed;
 case state of
  0: begin Blacklist.Caption:= 'Whitelist';
           Blacklist.Hint := misc(M179,'M179');
           if fileexists(ExtractFilepath(paramstr(0)) + 'whitelist.bmp') then Blacklist.glyph.LoadFromFile(ExtractFilepath(paramstr(0)) + 'whitelist.bmp');
     end;
  1: begin Blacklist.Caption:= 'Blacklist';
           Blacklist.Hint := misc(M180,'M180');
           if fileexists(ExtractFilepath(paramstr(0)) + 'blacklist.bmp') then Blacklist.glyph.LoadFromFile(ExtractFilepath(paramstr(0)) + 'blacklist.bmp');
     end;
  end;
end;

tarifliste.cells[0,0]:= misc(M164,'M164');
tarifliste.cells[1,0]:= misc(M165,'M165');
tarifliste.cells[2,0]:= misc(M166,'M166');
tarifliste.cells[3,0]:= misc(M167,'M167');
tarifliste.cells[4,0]:= misc(M168,'M168');
tarifliste.cells[5,0]:= misc(M169,'M169');
tarifliste.cells[6,0]:= misc(M170,'M170');
tarifliste.cells[7,0]:= misc(M171,'M171');
tarifliste.cells[8,0]:= misc(M172,'M172');
tarifliste.cells[9,0]:= misc(M173,'M173');
tarifliste.cells[10,0]:=misc(M174,'M174');
tarifliste.cells[11,0]:=misc(M175,'M175');
tarifliste.cells[12,0]:=misc(M176,'M176');
tarifliste.cells[13,0]:='Ident';
tarifliste.cells[14,0]:=misc(M177,'M177');
tarifliste.cells[15,0]:=misc(M178,'M178');
tarifliste.cells[16,0]:=misc(M268,'M268');

rows:=0;
pbar.Min:= 0;
if length(hauptfenster.tarife) > 0 then pbar.max:=length(hauptfenster.tarife)-1;
btime:= gettickcount;

for i:= 0 to length(hauptfenster.tarife)-1 do
begin
  if hauptfenster.tarife[i].tarif = Tarifbox.Items.Strings[Tarifbox.ItemIndex] then
  begin
     rows := rows+1;
     Tarifliste.Cells[0,rows] := hauptfenster.tarife[i].Tag;
     Tarifliste.Cells[1,rows] := TimeToStr(hauptfenster.tarife[i].Beginn);
     Tarifliste.Cells[2,rows] := TimeToStr(hauptfenster.tarife[i].Ende);
     Tarifliste.Cells[3,rows] := Format('%.2f',[hauptfenster.tarife[i].Preis]);
     Tarifliste.Cells[4,rows] := Format('%.2f',[hauptfenster.tarife[i].Einwahl]);
     Tarifliste.Cells[5,rows] := Format('%d/%d',[hauptfenster.tarife[i].Takt_a,hauptfenster.tarife[i].Takt_b]);
     Tarifliste.Cells[6,rows] := hauptfenster.tarife[i].Nummer;
     Tarifliste.Cells[7,rows] := hauptfenster.tarife[i].User;
     Tarifliste.Cells[8,rows] := hauptfenster.tarife[i].Passwort;
     Tarifliste.Cells[9,rows] := hauptfenster.tarife[i].Webseite;
     Tarifliste.Cells[10,rows] := DateToStr(hauptfenster.tarife[i].validfrom);
     Tarifliste.Cells[11,rows] := DateToStr(hauptfenster.tarife[i].expires);
     Tarifliste.Cells[12,rows] := DateToStr(hauptfenster.tarife[i].eingetragen);
     Tarifliste.Cells[13,rows] := inttostr(i);
     if hauptfenster.tarife[i].DeleteWhenExpires then
       Tarifliste.cells[14,rows] := misc(M161,'M161') else Tarifliste.cells[14,rows] := misc(M162,'M162');
     Tarifliste.Cells[15,rows] := hauptfenster.tarife[i].Editor;
     Tarifliste.Cells[16,rows] := Format('%.2f',[hauptfenster.tarife[i].Mindestumsatz]);

     if rows>1 then Tarifliste.RowCount:= tarifliste.rowcount+1;
   end;
   if (gettickcount - btime > 50) then pbar.Visible:= true;
   if pbar.max > pbar.min then pbar.position:= i;
end;

pbar.Visible:= false;

if tarifliste.RowCount > 2 then //wenn mehr als eine Zeile vorhanden ist
  gridEvents.Sort(Tarifliste,pBar,{column}1,1,tarifliste.RowCount,false,false);
  
tarifliste.Tag:= 1;
sort_descending:= false;
end;

procedure TTaVerwaltung.TarifboxCloseUp(Sender: TObject);
var changeindex: boolean;
begin
 changeindex:= false;
 button4.Caption:= misc(M181,'M181');

 if changeindex then tarifbox.itemindex:= 0;

 AddItemstoTarifListe;
 if tarifbox.Items.Count > 0 then
  ChangeData;
end;

//alle Felder löschen
procedure TTaVerwaltung.Button2Click(Sender: TObject);
begin
EnableEdits(true);
myident             := '';
changename          := '';
errormsg.Caption    := '';
button1.caption     := misc(M163,'M163');
Taname.Text         :=  '';
TaNumber.Text       := '';
tastart.ShowCheckbox:= true;
taend.ShowCheckbox  := true;
TaStart.DateTime    := EncodeDateTime(1970,01,01,0,0,0,0);
TaEnd.DateTime      := EncodeDateTime(1970,01,01,0,0,0,0);
tastart.ShowCheckbox:= false;
taend.ShowCheckbox  := false;
TaPrice.Text        := Format('%.2f',[0.0]);
TaEinwahl.Text      := Format('%.2f',[0.0]);
taMindestumsatz.text:= Format('%.2f',[0.0]);
Tataktbox.ItemIndex := 0;
tataktboxchange(nil);
TaUSer.Text         := '';
TaPass.Text         := '';
TaWebsite.Text      := 'http://';
checkbox1.Checked   := false;
checkbox2.Checked   := false;
checkbox3.Checked   := false;
checkbox4.Checked   := false;
checkbox5.Checked   := false;
checkbox6.Checked   := false;
checkbox7.Checked   := false;
checkbox8.Checked   := false;
checkbox9.Checked   := false;
checkbox10.Checked  := false;
TaExpires.Date      := incday(now,7);
TaStarts.Date       := Dateof(now);
TaDelend.Checked    := false;
label15.caption     := '';
label16.caption     := '';
label17.caption     := '';
radio_NO.checked    := true;
radiobutton1.Checked:= true;
konti_tarif.caption := '';
konti_zaehler.text  := '';
nextreset.caption   := '';
ganztags.Checked    := false;
ganztagsclick(self);
end;

function TTaVerwaltung.isDataValid(tag: string; myident: string): boolean;
var i,id: integer;
    temptime, temptimeend: TDateTime;
    ergebnis: boolean;
    mo,di,mi,don,fr,sa,so,feiertag: string;
    vglstring: string;
    anfang, ende: TTime;
    expdate: TDate;
begin
mo:= '[error]';
di:= '[error]';
mi:= '[error]';
don:='[error]';
fr:= '[error]';
sa:= '[error]';
so:= '[error]';
feiertag:= '[error]';

if ansicontainstext(tag,'[Mo]') then mo:= '[Mo]';
if ansicontainstext(tag,'[Di]') then di:= '[Di]';
if ansicontainstext(tag,'[Mi]') then mi:= '[Mi]';
if ansicontainstext(tag,'[Do]') then don:= '[Do]';
if ansicontainstext(tag,'[Fr]') then fr:= '[Fr]';
if ansicontainstext(tag,'[Sa]') then sa:= '[Sa]';
if ansicontainstext(tag,'[So]') then so:= '[So]';
if ansicontainstext(tag,'[feiertags]') then feiertag:= '[feiertags]';

ergebnis:= true;

try
  id:= strtoint(myident);
except
  id:= -1;
end;

if (length(Hauptfenster.Tarife)> 0) then
  for i:=0 to length(Hauptfenster.Tarife)-1 do
  begin
    expdate:= Hauptfenster.Tarife[i].expires;
    //namen finden
    if ( (TaName.text = Hauptfenster.Tarife[i].Tarif )
    //und prüfen ob es derselbe Eintrag ist
    and (id <> i)
    and (TaStarts.date < expdate)
    )
    then
      begin
        vglstring:= Hauptfenster.Tarife[i].tag;
         if ( //wenn der Tag enthalten ist
          (vglstring = tag))
            or (ansicontainstext(vglstring,mo))
            or (ansicontainstext(vglstring,di))
            or (ansicontainstext(vglstring,mi))
            or (ansicontainstext(vglstring,don))
            or (ansicontainstext(vglstring,fr))
            or (ansicontainstext(vglstring,sa))
            or (ansicontainstext(vglstring,so))
            or (ansicontainstext(vglstring,feiertag)
          )
           then
           begin
            anfang      := Hauptfenster.Tarife[i].beginn;
            ende        := Hauptfenster.Tarife[i].ende;
            temptime   :=  EncodeDate(1970,01,01) + timeof(anfang);
            temptimeend:=  EncodeDate(1970,01,01) + timeof(ende);

            if (temptimeend < temptime) then temptimeend:= EncodeDate(1970,01,02) + ende;

            //TaStart.time liegt im Intervall
            if ((temptime <= (TaStart.datetime)) and (temptimeend > (TaStart.datetime)) )
              then   ergebnis:= false;

            //TaEnd.time liegt im Intervall
            if ((temptimeend >= (TaEnd.datetime)) and (temptime < (TaEnd.datetime)))
              then  ergebnis:= false;

            //Intervall liegt zwischen TaStart.time und TaEnd.time
            //oder Intervall ist gleich
            if ((temptime >= (TaStart.datetime)) and (temptimeend <= (TaEnd.datetime)))
              then ergebnis:= false;

           end;
        end;
     end;
isdatavalid:= ergebnis;
end;

procedure TTaVerwaltung.DeleteSelection(item: integer);
begin
if tarifbox.Items.Count = 0 then exit;

//in der Datenbank löschen
//letzten an die Stelle kopieren
Hauptfenster.tarife[item]:= hauptfenster.tarife[length(hauptfenster.tarife)-1];
//Länge des Arrays kürzen
setlength(hauptfenster.tarife, length(hauptfenster.tarife)-1);

end;

//Eintrag/ Einträge löschen
procedure TTaVerwaltung.Button4Click(Sender: TObject);
var name: string;
    index,i: integer;
    del: array of integer;
begin

button2.click; //eingabefelder leeren

name:= tarifbox.Items.Strings[tarifbox.itemindex];
index:= tarifbox.Items.IndexOf(name);
if index=-1 then exit;

for i:= tarifliste.Selection.TopLeft.Y to tarifliste.Selection.BottomRight.Y do
begin
 setlength(del, length(del) +1);
 del[length(del)-1] := strtoint(tarifliste.cells[13,i]);
end;

Quick_Sort(del);

for i:= length(del) -1 downto 0 do DeleteSelection(del[i]);

//<<

//wenn alles gelöscht wird, dann in der Box entfernen
if ((tarifliste.Selection.TopLeft.Y = 1) and (tarifliste.Selection.BottomRight.Y = tarifliste.rowcount-1)) then
begin
 tarifbox.Items.Delete(index);
 index:= index-1;
 if index < 0 then index:= 0;
end;

tarifliste.Rows[1].Clear;
tarifbox.itemindex:= index;
TarifboxCloseUp(sender);
end;

procedure TTaVerwaltung.changeData;
var edit: boolean;
    t1,t2: integer;
begin
button2.Click;

if tarifliste.Row < 1 then exit;
button1.Caption:= misc(M128,'M128');

Taname.text:= tarifbox.Items.Strings[tarifbox.itemindex];
myident:= tarifliste.Cells[13, tarifliste.row];  //ident-nr. merken

try
 TaStart.time:= strtotime(tarifliste.Cells[1,tarifliste.row]);
 except
 TaStart.time:= EncodeTime(0,0,0,0);
 end;
try
 TaEnd.time:= strtotime(tarifliste.Cells[2,tarifliste.row]);
 except
 TaEnd.time:= EncodeTime(0,0,0,0);
 end;
changename:= TaName.text;

if tastart.time = taend.time then
begin
ganztags.Checked:= true;
ganztagsClick(nil);
end;

TaPrice.text    := tarifliste.Cells[3,tarifliste.row];
TaEinwahl.text  := tarifliste.Cells[4,tarifliste.row];
TaktToInteger(tarifliste.cells[5,tarifliste.row],t1,t2);
TaTakt_a.text   := inttostr(t1);
TaTakt_b.text   := inttostr(t2);
if tarifliste.cells[5,tarifliste.row] = '60/60' then TaTaktbox.ItemIndex:=0 else TaTaktbox.ItemIndex:=1;
taNumber.Text   := tarifliste.cells[6,tarifliste.row];
taUser.text     := tarifliste.cells[7,tarifliste.row];
taPass.text     := tarifliste.cells[8,tarifliste.row];
taWebsite.text  := tarifliste.cells[9,tarifliste.row];
taStarts.Date   := strtodate(tarifliste.cells[10,tarifliste.row]);
taexpires.Date  := strtodate(tarifliste.cells[11,tarifliste.row]);
TaMindestumsatz.text := tarifliste.cells[16,tarifliste.row];

//changeexpires:= taexpires.date;
if ansicontainsstr(tarifliste.cells[0,tarifliste.row],'[Mo]') then checkbox1.checked:= true;
if ansicontainsstr(tarifliste.cells[0,tarifliste.row],'[Di]') then checkbox2.checked:= true;
if ansicontainsstr(tarifliste.cells[0,tarifliste.row],'[Mi]') then checkbox3.checked:= true;
if ansicontainsstr(tarifliste.cells[0,tarifliste.row],'[Do]') then checkbox4.checked:= true;
if ansicontainsstr(tarifliste.cells[0,tarifliste.row],'[Fr]') then checkbox5.checked:= true;
if ansicontainsstr(tarifliste.cells[0,tarifliste.row],'[Sa]') then checkbox6.checked:= true;
if ansicontainsstr(tarifliste.cells[0,tarifliste.row],'[So]') then checkbox7.checked:= true;
if ansicontainsstr(tarifliste.cells[0,tarifliste.row],'[feiertags]') then checkbox10.checked:= true;

if tarifliste.cells[14,tarifliste.row] = misc(M161,'M161') then TaDelEnd.checked:= true else TadelEnd.Checked:= false;

edit:= (tarifliste.cells[15,tarifliste.row] = '');
if not edit then errormsg.caption:= misc(M182,'M182')+': '+ tarifliste.cells[15,tarifliste.row];

EnableEdits(edit);

PageControl1Change(self);
end;

procedure TTaVerwaltung.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i: word;
begin

if Taverwaltung.width < 400 then Eingabemodeclick(self);

//alle Änderungen der Tarifdatenbank auf die Platte schreiben
WriteTarifeToHD;

hauptfenster.save_cfg;
//tarifverw.LadeTarife;
if not isonline then tarifverw.Kontingente_Laden;

hauptfenster.AktualisierenClick(self);
hauptfenster.enabled:= true;

//Spaltenbreiten
For i:= 0 to tarifliste.Colcount -1 do
settings.WriteInteger('Tarifmanager','Col' + inttostr(i),tarifliste.ColWidths[i]);

//breite der Tabelle
settings.writebool('Tarifmanager','Tarifliste_large', (tarifliste.width > 369));

TaVerwaltung.Release;
TaVerwaltung:= nil;

end;

procedure TTaVerwaltung.ganztagsClick(Sender: TObject);
begin
if ganztags.checked then
  begin
    tastart.Time:=  Encodetime(0,0,0,0);
    taend.Time:=  Encodetime(0,0,0,0);
    tastart.Enabled:= false;
    taend.Enabled:= false;
   end
else
  begin
    tastart.Enabled:= true;
    taend.Enabled:= true;
  end;

end;

procedure TTaVerwaltung.TaTaktboxChange(Sender: TObject);
begin
if TaTaktbox.itemindex = 0 then
  begin Tatakt_a.text:= '60'; TaTakt_b.text:= '60' end
  else
  begin Tatakt_a.text:= '1'; TaTakt_b.text:= '1' end;
end;

procedure TTaVerwaltung.TariflisteMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i: integer;
begin
if not liste_clicked then exit;
liste_clicked:= false;

//tarifliste.repaint;
if tarifliste.Selection.Bottom - tarifliste.Selection.Top > 0 then
begin
   errormsg.caption:= misc(M183,'M183');
   button4.Caption := misc(M184,'M184');
end
else //wenn nur ein Eintrag selektiert
   button4.Caption := misc(M185,'M185');

//wenn über den rand gezogen wird wieder verkleinern
for i:=0 to tarifliste.ColCount -1 do
if (tarifliste.ColWidths[i] > tarifliste.width) then tarifliste.ColWidths[i]:= tarifliste.Width-15;

//zum Sortieren wird nur Zeile 0 benötigt
if row <> 0 then exit;

//wenn in der Nullten zeile gklickt, aber rdie Maus verschoben wird
if (row <> 0) and (abs(x-last_x)>5) then exit;

if Tarifliste.Tag = column then sort_descending:= not sort_descending else sort_descending:= false;
Tarifliste.Tag:= column;
Tarifliste.repaint;

case column of
3,4,6: GridEvents.Sort(Tarifliste, pbar,column,1,tarifliste.RowCount,true,sort_descending);
else GridEvents.Sort(Tarifliste,pbar,column,1,tarifliste.RowCount,false, sort_descending);
end;

end;

procedure TTaVerwaltung.butBatchExportClick(Sender: TObject);
begin
  TaVerwaltung.enabled:= false;
  hauptfenster.MainMenueClick(Hauptfenster.MM1_2);
end;

procedure TTaVerwaltung.ButBatchImportClick(Sender: TObject);
begin
  TaVerwaltung.enabled:= false;
  hauptfenster.MainMenueClick(Hauptfenster.MM1_1);
end;

procedure TTaVerwaltung.ButDelExpClick(Sender: TObject);
begin
  LoescheAbgelaufeneTarife;
  tarifliste.Rows[1].Clear;
  tarifbox.Clear;
  AddItemsToTarifbox(0);
  tarifboxcloseup(sender);
end;

procedure TTaVerwaltung.Panel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin

if (( ssLeft in Shift ) and not nomove ) then
begin
TaVerwaltung.Left:= TaVerwaltung.left - (posleft-x);
TaVerwaltung.Top:= TaVerwaltung.Top - (postop -y);
end;

if ssLeft in Shift then
if nomove then
begin
 nomove:= false;
 posleft:= x;
 postop := y;
end;

end;

procedure TTaVerwaltung.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
posleft:= x;
postop := y;
end;

procedure TTaVerwaltung.ChangeValue(anfang: integer; ende:integer; Bezeichner, WertalsString: string);
var i, myidentindex: integer;
begin
     for i:= anfang to ende do
     begin
          myidentindex:= strtoint(TaVerwaltung.tarifliste.cells[13,i]);

          if Bezeichner = 'Tarif' then
           hauptfenster.tarife[myidentindex].Tarif:= WertAlsString
          else
          if Bezeichner = 'Beginn' then
            hauptfenster.tarife[myidentindex].Beginn:= StrToTime(wertalsString)
          else
          if Bezeichner = 'Ende' then
            hauptfenster.tarife[myidentindex].Ende:= StrToTime(wertalsstring)
          else
          if Bezeichner = 'Nummer' then
            hauptfenster.tarife[myidentindex].Nummer:= wertalsstring
          else
          if Bezeichner = 'Preis' then
            hauptfenster.tarife[myidentindex].Preis:= StrToFloat(wertalsstring)
          else
          if Bezeichner = 'Einwahl' then
            hauptfenster.tarife[myidentindex].Einwahl:= StrToFloat(wertalsstring)
          else
          if Bezeichner = 'Takt' then
           TaktToInteger(wertalsstring,hauptfenster.tarife[myidentindex].Takt_a,hauptfenster.tarife[myidentindex].Takt_b)
//           hauptfenster.tarife[myidentindex].Takt:= wertalsstring
          else
          if Bezeichner = 'User' then
            hauptfenster.tarife[myidentindex].User:= wertalsstring
          else
          if Bezeichner = 'Passwort' then
            hauptfenster.tarife[myidentindex].Passwort:= wertalsstring
          else
          if Bezeichner = 'Webseite' then
            hauptfenster.tarife[myidentindex].Webseite:= wertalsstring
          else
          if Bezeichner = 'start' then
            hauptfenster.tarife[myidentindex].validfrom:= StrToDate(wertalsstring)
          else
          if Bezeichner = 'expires' then
            hauptfenster.tarife[myidentindex].expires:= StrToDate(wertalsstring)
          else
          if Bezeichner = 'Tag' then
            hauptfenster.tarife[myidentindex].Tag:= wertalsstring
          else
          if Bezeichner = 'Mindestumsatz' then
            hauptfenster.tarife[myidentindex].Mindestumsatz:= strtofloat(wertalsstring)
          else
          if Bezeichner = 'DeleteWhenExpires' then
            hauptfenster.tarife[myidentindex].DeleteWhenExpires:= strtobool(wertalsstring);
     end;
end;


procedure TTaVerwaltung.newexpireDropDown(Sender: TObject);
begin
  nomove:= true;
end;

procedure TTaVerwaltung.TariflisteClick(Sender: TObject);
begin
  if tarifbox.items.count > 0 then
    ChangeData;
  tarifliste.repaint;
end;

procedure TTaVerwaltung.ButkopierenClick(Sender: TObject);
begin
if (tarifliste.Row < 1) or (tarifliste.cells[0,tarifliste.row]='') then exit;


button1.Caption:= misc(M163,'M163');

myident:= '';  //keine ident merken
enableedits(true);

Tarifliste.Selection := TGridRect(Rect(0,Tarifliste.row,14,Tarifliste.row));
blinker.Tag:= Tarifliste.row;
button1.enabled:= false;
button2.enabled:= false;
blinker.enabled:= true;
end;

procedure TTaVerwaltung.konti_changeClick(Sender: TObject);
var date: Tdate;
    tag: word;
begin
if tarifbox.items.count > 0 then
     begin

      if (konti_zeit.value = 0) then
       SettingsKontingente.DeleteKey(konti_tarif.caption, 'Freistunden')
      else
       SettingsKontingente.WriteInteger(konti_tarif.caption,'Freistunden',konti_zeit.Value);

      if (konti_min.value = 0) then
        SettingsKontingente.DeleteKey(konti_tarif.caption, 'Freiminuten')
      else
       SettingsKontingente.WriteInteger(konti_tarif.caption,'Freiminuten',konti_min.Value);

      if konti_upvol.value = 0 then
      begin
       SettingsKontingente.DeleteKey(konti_tarif.caption, 'Freivolumen');
       SettingsKontingente.DeleteKey(konti_tarif.caption, 'FreivolumenBoth');
      end
      else
      begin
       SettingsKontingente.WriteInteger(konti_tarif.caption,'Freivolumen',konti_upvol.Value*1024);
       SettingsKontingente.WriteBool(konti_tarif.caption,'FreivolumenBoth', konti_voltype_both.Checked);
      end;

      SettingsKontingente.WriteInteger(konti_tarif.caption,'Tag',konti_tag.Value);
      tag:= konti_tag.Value;
      date:= incmonth(dateof(now),1);

      Repeat
      if IsValidDate(yearof(date),monthof(date),tag)
       then date:= encodeDate(yearof(date),monthof(date),tag)
       else
       begin
        tag:= tag-1;
        if IsValidDate(yearof(date),monthof(date),tag)
        then date:= encodeDate(yearof(date),monthof(date),tag)
       end;
      until IsValidDate(yearof(date),monthof(date),tag);
      nextreset.caption:= misc(M186,'M186')+' : ' + datetostr(date);
      SettingsKontingente.WriteDate(konti_tarif.caption,'NextReset',date);

      if ( ((konti_upvol.value = 0) and (konti_zeit.value = 0) and (konti_min.Value=0))
            or
            radio_NO.checked
          )
      then SettingsKontingente.EraseSection(konti_tarif.caption);
 end;
end;

procedure TTaVerwaltung.PageControl1Change(Sender: TObject);
var bisher_gesurft: LongInt;
    bisher_down, bisher_up: double;
    h,m,s: word;
    hstring, mstring, sstring: string;
    factor:integer;
begin
if ((PageControl1.ActivePage = TabSheet1) and (tarifbox.items.count > 0)) then
begin

   Freikontingente.visible   := not isonline;
   Freikontis_Online.visible := isonline;

   //Kontingente
   konti_tarif.caption:= tarifbox.Items.Strings[tarifbox.itemindex];

   konti_zeit.Value := SettingsKontingente.ReadInteger(konti_tarif.caption,'Freistunden',0);
   konti_min.Value  := SettingsKontingente.ReadInteger(konti_tarif.caption,'Freiminuten',0);
   konti_upvol.Value:= floor(SettingsKontingente.ReadInteger(konti_tarif.caption,'Freivolumen',0)/1024);

   konti_voltype_both.Checked:= SettingsKontingente.ReadBool(konti_tarif.caption,'FreivolumenBoth',true);
   konti_tag.Value:= SettingsKontingente.ReadInteger(konti_tarif.caption,'Tag',1);

   if ((konti_zeit.Value = 0) and (konti_min.Value = 0) and(konti_upvol.Value = 0)) then radio_NO.checked:= true
   else
   if ((konti_zeit.Value > 0) or (konti_min.Value > 0)) then radio_zeit.checked:= true
   else
   if (konti_upvol.Value > 0) then radio_Vol.checked:= true;

   nextreset.caption:= misc(M186,'M186')+' : ' +SettingsKontingente.ReadString(konti_tarif.caption,'NextReset','kein');

   bisher_gesurft:= SettingsTraffic.ReadInteger(konti_tarif.caption,'Surfdauer',0);
   bisher_up     := SettingsTraffic.ReadFloat(konti_tarif.caption,'Upload',0.0);
   bisher_down   := SettingsTraffic.ReadFloat(konti_tarif.caption,'Download',0.0);
   konti_zaehler.Text:= SettingsTraffic.ReadString(konti_tarif.caption,'seit', '');
   zeitumrechnen(bisher_gesurft,h,m,s);

   factor:= 1;

   if radiobutton1.checked then factor:= 1024        //MB
   else
      if radiobutton2.checked then factor:= 1024*1024 //GB
      else
         if radiobutton3.checked then factor:= 1;     //kB

   if h<10 then hstring:= '0'+inttostr(h) else hstring:= inttostr(h);
   if m<10 then mstring:= '0'+inttostr(m) else mstring:= inttostr(m);
   if s<10 then sstring:= '0'+inttostr(s) else sstring:= inttostr(s);

   label15.caption:= hstring +':'+mstring+':'+sstring;
   label16.Caption:= Format('%10.3n',[bisher_down/factor/1000 *1000]);
   label17.Caption:= Format('%10.3n',[bisher_up/factor/1000 *1000]);

   label23.caption:= Format('%.0f min',[SettingsTraffic.ReadInteger(konti_tarif.caption,'Surfdauer_Takt',0)/60]);
   
   radio_zeitClick(self);
end;
end;

procedure TTaVerwaltung.RadioButton3Click(Sender: TObject);
begin
PageControl1change(self);
end;

procedure TTaVerwaltung.resetClick(Sender: TObject);
var index,i: integer;
    TarifName: string;
begin
//bestehende Kontingente suchen
   index:= -1;
   TarifName:= '';
   with hauptfenster do
     for i:= 0 to length(kontingente)-1 do
      if (kontingente[i].tarif = tarifbox.items.Strings[tarifbox.itemindex]) then
        begin index:= i; TarifName:=kontingente[i].tarif; break; end;
//fragen ob wirklich zurückzusetzen
if index > -1 then
  if (MessageBox(0, PChar(misc(M187,'M187')),PChar( misc(M188,'M188')), MB_ICONWARNING or MB_YESNO or MB_SETFOREGROUND or MB_DEFBUTTON1) in [idNo])
  then exit; //wenn nein -> raus hier !

if tarifbox.items.count > 0 then
 begin
     //Traffic-Daten löschen
     SettingsTraffic.EraseSection(tarifbox.items.Strings[tarifbox.itemindex]);

     // Frei-Kontingent wieder zurücksetzen
     // da Zähler wieder auf 0 stehen, stehen wieder die vollen Kontingente zur Verfügung
    if index > -1 then
     with hauptfenster do
      begin
        kontingente[index].FreiSekunden := 60*60 * SettingsKontingente.ReadInteger(TarifName,'Freistunden',0) + 60* SettingsKontingente.ReadInteger(TarifName,'Freiminuten',0);
        kontingente[index].ResetTag     := SettingsKontingente.ReadInteger(TarifName,'Tag',1);
        kontingente[index].FreikB       := SettingsKontingente.ReadFloat(TarifName,'Freivolumen',0);
        kontingente[index].MB_both      := SettingsKontingente.ReadBool(TarifName,'FreivolumenBoth',true);
      end;

     PageControl1Change(self);
 end;
end;

procedure TTaVerwaltung.radio_zeitClick(Sender: TObject);
begin
if radio_NO.checked then
begin
     konti_zeit.Enabled:= false;
     konti_min.Enabled:= false;
     konti_upvol.enabled:= false;
     panel2.enabled:= false;
     konti_tag.enabled:= false;
end
else
if radio_zeit.checked then
begin
     konti_zeit.Enabled:= true;
     konti_min.Enabled := true;
     konti_upvol.enabled:= false;
     panel2.enabled:= false;
     konti_tag.enabled:= true;
end
else
begin
     konti_zeit.Enabled:= false;
     konti_min.Enabled:= false;
     konti_upvol.enabled:= true;
     panel2.enabled:= true;
     konti_tag.enabled:= true;
end
end;

procedure TTaVerwaltung.TaNameChange(Sender: TObject);
begin
if myident <> '' then errormsg.caption:= misc(M189,'M189');
end;

procedure TTaVerwaltung.DelAllClick(Sender: TObject);
var FileName: String;
begin
if isonline then errormsg.caption:= misc(M190,'M190');

if not isonline then
  if MessageDlg(misc(M191,'M191'), mtConfirmation, [mbYes, mbNo], 0) = IDYes then
  begin

    //Tarife.lcx löschen
    FileName:= ExtractFilepath(paramstr(0)) + 'Tarife.lcx';
    if FileExists(FileName) then DeleteFile(FileName);

    //Tarife.ini löschen
    FileName:= ExtractFilepath(paramstr(0)) + 'Tarife.ini';
    if FileExists(FileName) then DeleteFile(FileName);

    SettingsKontingente.Clear;
    SettingsTraffic.Clear;
    SettingsScores.Clear;

    setlength(hauptfenster.tarife, 0);
    setlength(hauptfenster.Scores, 0);

    tarifbox.Items.Clear;
    button2.Click;
    tarifboxcloseup(sender);
  end;  
end;

procedure TTaVerwaltung.blinkerTimer(Sender: TObject);
begin
blinker.enabled:= false;
inc(blinkercount);

if (blinkercount mod 2 = 0) then
   Tarifliste.Selection := TGridRect(Rect(0,blinker.tag,14,blinker.tag))
else
    Tarifliste.Selection := TGridRect(Rect(-1,-1,-1,-1));

if blinkercount < 5 then blinker.enabled:= true
else
begin
     blinkercount:= 0;
     button2.enabled:= true;
     button1.enabled:= true;
end;
end;

procedure TTaVerwaltung.TariflisteMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i, widthl, widthr: integer;
begin
last_x:= x;
liste_clicked := true;
Tarifliste.MouseToCell(X,Y,Column,Row);

widthl:=0;
widthr:=0;
with Tarifliste do
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

procedure TTaVerwaltung.TariflisteDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
if arow > 0 then
with tarifliste do
//wenn nicht selektiert
if ((arow < Selection.Top) or (arow > Selection.Bottom)) then
begin
if cells[11,arow] <> '' then
  if strtodate(cells[11,arow]) < dateof(now) then
   begin
     Canvas.Brush.Color := RGB(255,220,220);
     Canvas.FillRect(Rect);
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
   end
  else
  if strtodate(cells[11,arow]) < incday(dateof(now),7) then
   begin
     Canvas.Brush.Color := RGB(255,250,200);
     Canvas.FillRect(Rect);
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
   end;
end
else //wenn selektiert
  begin
     Canvas.Brush.Color := clHighlight;
     Canvas.FillRect(Rect);
     canvas.Font.Color:= clHighlightText;
     Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[Acol, Arow]);
   end;

if (ARow = 0) then
begin
  with TarifListe.Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := psSolid;

    MoveTo(Rect.right-1, Rect.top);
    Lineto(Rect.right-1, Rect.Bottom);
  end;
end;

//Dreieck nach unten
if ((ARow = 0) and (ACol = tarifListe.tag)) then
begin
  with TarifListe.Canvas do
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

procedure TTaVerwaltung.TariflisteDblClick(Sender: TObject);
begin
OnDoubleClick(sender, column);
end;

Procedure TTaVerwaltung.SetRed;
var i: integer;
begin
if tarifliste.rowcount > 1 then
for i:= 1 to tarifliste.rowcount -1 do
  if strtodate(tarifliste.cells[11,i]) < dateof(now)
    then ColorizeRow(tarifliste,i,255,220,220);

end;

procedure TTaVerwaltung.BlacklistClick(Sender: TObject);
var state: integer;
begin
if tarifbox.Items.Strings[tarifbox.itemindex] <> '' then
begin
 state:= ToggleSuspendScores(tarifbox.Items.Strings[tarifbox.itemindex]);
 blacklist.Glyph.TransparentColor:= clNone;
 blacklist.Glyph.TransparentMode:= tmFixed;
 case state of
  0: begin Blacklist.Caption:= 'Whitelist';
           Blacklist.Hint := misc(M179,'M179');
           if fileexists(ExtractFilepath(paramstr(0)) + 'whitelist.bmp') then Blacklist.glyph.LoadFromFile(ExtractFilepath(paramstr(0)) + 'whitelist.bmp');
     end;
  1: begin Blacklist.Caption:= 'Blacklist';
           Blacklist.Hint := misc(M180,'M180');
           if fileexists(ExtractFilepath(paramstr(0)) + 'blacklist.bmp') then Blacklist.glyph.LoadFromFile(ExtractFilepath(paramstr(0)) + 'blacklist.bmp');
     end;
 end;
end;
end;

procedure TTaVerwaltung.TaNumberKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9', Char(VK_BACK)]) then
     Key := #0;            //  dann sofort löschen
end;

procedure TTaVerwaltung.applicationevents1Deactivate(Sender: TObject);
begin
if Vordergrund.Checked then
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,
             Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
else //..und zurück:
  SetWindowPos(Handle, HWND_NOTOPMOST, Left, Top, Width,
             Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

end;

procedure TTaVerwaltung.EingabemodeClick(Sender: TObject);
begin
if TaVerwaltung.width > 400 then
begin
Eingabemode.Caption:= '<';
Eingabemode.BevelOuter:= bvlowered;
eingabemode.Color:= clBTNHighlight;
pageControl1.left:= pageControl1.left - 390;
bitbtn1.left:= bitbtn1.left - 390;
Vordergrund.left:= Vordergrund.left - 390;
Vordergrund.Checked:= true;
TaVerwaltung.width:= TaVerwaltung.width - 406;
TaVerwaltung.left:=Screen.width - TaVerwaltung.width;
panel3.Visible:= false;
groupbox2.visible:= false;
groupbox3.visible:= false;
tarifliste.visible:= false;
blacklist.visible:= false;
tarifbox.Visible:= false;
butkopieren.Visible:= false;
button4.Visible:= false;
butdelexp.Visible:= false;
Tarifliste_size.Visible:= false;
hauptfenster.visible:= false;
TaVerwaltung.Refresh;
end
//wieder groß machen
else
begin
Eingabemode.Caption:= '>';
Eingabemode.BevelOuter:= bvRaised;
eingabemode.Color:= clBtnFace;
pageControl1.left:= pageControl1.left + 390;
bitbtn1.left:= bitbtn1.left + 390;
Vordergrund.left:= Vordergrund.left + 390;
Vordergrund.checked:= false;
TaVerwaltung.width:= TaVerwaltung.width + 406;
TaVerwaltung.left:=round ((Screen.width - TaVerwaltung.width)/2);
panel3.Visible:= true;
groupbox2.visible:=true;
groupbox3.visible:= true;
tarifliste.visible:= true;
blacklist.visible:= true;
tarifbox.Visible:= true;
butkopieren.Visible:= true;
button4.Visible:= true;
butdelexp.Visible:= true;
Tarifliste_size.Visible:= true;
hauptfenster.visible:= true;
TaVerwaltung.Refresh;
TaVerwaltung.BringToFront;
end;
end;

procedure TTaVerwaltung.tarifliste_sizeClick(Sender: TObject);
begin
if tarifliste.width < 370 then //vergrößern
begin
PageControl1.visible:= false;
tarifliste.Width:= tarifliste.Width + 315;
tarifliste_size.Left:= tarifliste_size.Left + 315;
Tarifliste_size.caption := '<';
tarifliste_size.BevelOuter:= bvlowered;
tarifliste_size.Color:= clBtnHighlight;
pbar.width:= pbar.width + 315;
end
else //verkleinern
begin
tarifliste.Width:= tarifliste.Width - 315;
tarifliste_size.Left:= tarifliste_size.Left - 315;
Tarifliste_size.caption := '>';
tarifliste_size.BevelOuter:= bvRaised;
tarifliste_size.Color:= clBtnFace;
PageControl1.visible:= true;
pbar.width:= pbar.width - 315;
end;
end;

procedure TTaVerwaltung.TaMindestumsatzKeyPress(Sender: TObject; var Key: Char);
begin
with sender as TLabeledEdit do
if not ansicontainstext(text,DecimalSeparator) then
begin
   if not (Key in ['0'..'9',DecimalSeparator, Char(VK_BACK)]) then
     Key := #0;            //  dann sofort löschen
end
else
   if not (Key in ['0'..'9', Char(VK_BACK)]) then
     Key := #0;            //  dann sofort löschen
end;

end.

