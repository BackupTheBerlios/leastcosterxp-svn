unit settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  TForm3 = class(TForm)
    BtnSave: TBitBtn;
    BtnCancel: TBitBtn;
    Page: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ULDLSelect: TComboBox;
    Limit: TEdit;
    RadioMB: TRadioButton;
    RadioGB: TRadioButton;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    PriceMB: TRadioButton;
    PriceGB: TRadioButton;
    Price: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Period: TComboBox;
    GroupBox4: TGroupBox;
    FritzBox: TTabSheet;
    Label7: TLabel;
    FBMon: TCheckBox;
    FBIP: TLabeledEdit;
    FBPort: TLabeledEdit;
    NDev: TComboBox;
    TabSheet2: TTabSheet;
    startHidden: TCheckBox;
    monout: TCheckBox;
    revpath: TLabeledEdit;
    procedure FBPortKeyPress(Sender: TObject; var Key: Char);
    procedure PriceKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);

    Procedure GetDeviceList;
    procedure NetDeviceCloseUp(Sender: TObject);
    
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }

  end;

var
  Form3: TForm3;

implementation
uses main,StrUtils,
     IpHlpApi,IpIfConst,IpRtrMib,ipFunctions,iptypes;
{$R *.dfm}

procedure TForm3.GetDeviceList;
var PAdapter, PMem: PipAdapterInfo;
    OutBufLen: ULONG;
begin
NDev.clear;
  VVGetAdaptersInfo(PAdapter, OutBufLen);
  PMem := PAdapter;
  try
    while PAdapter <> nil do
      with NDev do
      begin
        NDev.Items.Append(PAdapter.Description + ' ['+ inttostr(PAdapter.Index)+']');
        PAdapter := PAdapter.Next;
      end;
    except
   end;
end;

procedure TForm3.NetDeviceCloseUp(Sender: TObject);
var s: string;
begin
    s:= NDev.Items.Strings[NDev.itemindex];
    Delete(s,1,Pos(' [',s)+1);
    Delete(s,Pos(']',s),1);

    NDev.Tag:= strToInt(s);
    NetworkDevice:= Ndev.tag;
end;


procedure TForm3.BtnSaveClick(Sender: TObject);
var Vunit, Punit: byte;
    s           : string;
begin
 //Network device setzen
 if nDev.itemindex <> -1 then
  begin
   s:= NDev.Items.Strings[NDev.itemindex];
   Delete(s,1,Pos(' [',s)+1);
   Delete(s,Pos(']',s),1);

   NDev.Tag:= strToInt(s);
   NetworkDevice:= Ndev.tag;
  end;
 sett.WriteInteger('Traffic','Device',NDev.tag);

 if RadioMB.Checked then VUnit:= 0 else VUnit:= 1;
 if PriceMB.Checked then PUnit := 0 else PUnit:= 1;

 sett.WriteBool('program','minimized',startHidden.checked);

 sett.WriteInteger('Traffic','VolumeMode',ULDLSelect.ItemIndex);
 sett.WriteInteger('Traffic','VolumeLimit',strtoint(limit.text));
 sett.WriteInteger('Traffic','VolumeUnit',VUnit);
 sett.WriteInteger('Traffic','PeriodStart',Period.ItemIndex);
// sett.WriteInteger('Traffic','PeriodUnit',MoWeSelect.ItemIndex);
 sett.WriteFloat('Traffic','Price',StrToFloat(price.text));
 sett.WriteInteger('Traffic','PriceUnit',PUnit);

 sett.WriteBool('FritzBox','useMonitor',FBMon.Checked);
 sett.WriteBool('FritzBox','monout',monout.checked);
 sett.writestring('Fritzbox','IP',FBIP.Text);
 sett.WriteInteger('FritzBox','Port',strtoint(FBPort.text));
 sett.writeString('FritzBox','reverse', revpath.Text);

 BoxAdress:= sett.ReadString('FritzBox','IP','192.168.178.1');
 sett.UpdateFile;

 //FritzBox Listener starten
 if FBMon.Checked and not socket.Active then begin form1.stopMySocket; Form1.StartMySocket; end
 else //oder beenden falls er noch läuft
 if not FBMOn.Checked and socket.Active then Form1.StopMySocket;
 form3.Close;
end;

procedure TForm3.BtnCancelClick(Sender: TObject);
begin
 NDev.tag            := sett.ReadInteger('Traffic','Device',0);
 NDev.ItemIndex      := NDev.Tag;

 ULDLSelect.ItemIndex:= sett.ReadInteger('Traffic','VolumeMode',0);
 limit.text          := sett.ReadString('Traffic','VolumeLimit','0');

// MoWeSelect.ItemIndex:= sett.ReadInteger('Traffic','PeriodUnit',2);
 Period.ItemIndex    := sett.ReadInteger('Traffic','PeriodStart',0);
 price.text          := FloattoStr(sett.ReadFloat('Traffic','Price',0.0));

 FBMon.Checked       := sett.ReadBool('FritzBox','useMonitor', false);
 monout.checked      := sett.ReadBool('FritzBox','monout',true);
 FBIP.Text           := sett.readstring('Fritzbox','IP','192.168.178.1');
 FBPort.text         := sett.ReadString('FritzBox','Port','1012');
 revpath.text        := sett.ReadString('FritzBox','reverse', 'http://www1.dasoertliche.de/?form_name=search_inv&ph=%NUMBER%');

 RadioMB.Checked     := (sett.ReadInteger('Traffic','VolumeUnit',1) = 0);
 RadioGB.Checked     := (sett.ReadInteger('Traffic','VolumeUnit',1) = 1);

 PriceMB.Checked     := (sett.ReadInteger('Traffic','PriceUnit',1) = 0);
 PriceGB.Checked     := (sett.ReadInteger('Traffic','PriceUnit',1) = 1);

 BoxAdress:= sett.ReadString('FritzBox','IP','192.168.178.1');

 if sender=BtnCancel then form3.Close;
end;

procedure TForm3.FormCreate(Sender: TObject);
var i: integer;
    Deviceindex: integer;
begin
exit;
  DeviceIndex:= 0;
  Form3.GetDeviceList;
   for i:= 0 to NDev.Items.Count-1 do
       if AnsiContainsStr(NDev.Items.Strings[i],' ['+ inttostr(DeviceIndex)+']')
         then NDev.itemindex:= i; //letztes Device einstellen

//  NDev.OnCloseUp(self); //Device setzen
  Form3.BtnCancelClick(Self);
end;

procedure TForm3.FormShow(Sender: TObject);
var i: integer;
begin
form1.Enabled:= false;

GetDeviceList;
   for i:= 0 to NDev.Items.Count-1 do
       if AnsiContainsStr(NDev.Items.Strings[i],' ['+ inttostr(NetworkDevice)+']')
         then NDev.itemindex:= i; //letztes Device einstellen

//  NDev.OnCloseUp(self); //Device setzen
  Form3.BtnCancelClick(Self);

end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.Enabled:= true;
end;

procedure TForm3.PriceKeyPress(Sender: TObject; var Key: Char);
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

procedure TForm3.FBPortKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', Char(VK_BACK)]) then
     Key := #0;            //  dann sofort löschen
end;

end.
