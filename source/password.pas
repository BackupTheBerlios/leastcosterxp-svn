unit password;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TGetThread = class(TThread)
   protected
    procedure Execute; override;
   public
    procedure MyTerminate(sender: TObject);
  end;

  TPWForm = class(TForm)
    PWEdit: TEdit;
    savePwd: TCheckBox;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    passlabel: TLabel;
    UsernameEdit: TLabeledEdit;
    Memo: TMemo;
    Label1: TLabel;
    noNews: TCheckBox;
    closeBtn: TBitBtn;
    Memo1: TMemo;
    procedure closeBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

  private
    { Private-Deklarationen }
    ready: boolean;
  public
    { Public-Deklarationen }
    action: String;
  end;

const
  Code = 'some code for encoding';

var
  PWForm: TPWForm;
  Download: TGetThread;

implementation
uses unit1, addons, httpprot, Tarifmanager, DateUtils, StrUtils, tarifverw;

{$R *.dfm}

procedure httppost(URL,Data: string);
var Http: THttpCli;
    Adresse: string;
begin
//  Adresse:= 'http://darkempire.da.funpic.de/php/Tarife/LCXP_add.php';
  Adresse:= '';
  Http := THttpCli.Create(nil);
//  http.OnDocData := Form1.DocData;
  with Http do
  begin
    Name := 'Http';
    LocalAddr := Adresse;
    ProxyPort := '80';
    Agent := 'Mozilla/4.0 (compatible; ICS)';
    Accept := 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*';
    NoCache := true;
    ContentTypePost := 'application/x-www-form-urlencoded';
    MultiThreaded := False;
    RequestVer := '1.0';
    FollowRelocation := True;
    LocationChangeMaxCount := 5;
    BandwidthLimit := 10000;
    BandwidthSampling := 1000;
    Options := [];
  end;

  Http.SendStream := TMemoryStream.Create;
  Http.SendStream.Write(Data[1], Length(Data));
  Http.SendStream.Seek(0, 0);
  Http.RcvdStream := TStringStream.Create('');
  Http.URL := URL;
  Http.Post;
  PWForm.Memo1.text:= (http.rcvdstream as TStringStream).DataString;
  if Ansicontainstext((http.rcvdstream as TStringStream).DataString, 'Login failed') then
  begin
//    PWForm.Memo1.Lines.Append('Login failed');
    PWForm.ready:= false;
  end
  else
  if Ansicontainstext((http.rcvdstream as TStringStream).DataString, 'ready') then
  BEGIN
//    PWForm.Memo1.Lines.Append('ready...');
    PWForm.ready:= true;
  end;
  http.RcvdStream.Free;
  http.RcvdStream:= nil;
  http.Free;
end;


procedure TGetThread.MyTerminate(sender: TObject);
begin
  if PWForm.ready then
  begin
    PWForm.close;
    if (PWForm.action <> 'delete') then
      TaVerwaltung.Button1.Click;
//    else
//    if (PWForm.action = 'delete') then
//    with TaVerwaltung do
//      LoescheTarif(OldProv + ' ' + OldTarif, oldNumber, DatetoStr(oldFrom), DatetoStr(OldUntil));
  end;
end;

procedure TGetThread.Execute;
var  Data : string;
     i    : integer;
begin
      Data:= 'uid='+PWForm.UsernameEdit.text+'&';
         Data:= Data + 'pwd='+encrypt(PWForm.PWEdit.text, code)+'&';
         Data:= Data + 'oldProv='+TaVerwaltung.oldProv+'&';
         Data:= Data + 'Bemerkungen='+PWForm.Memo.Text+'&';
         Data:= Data + 'oldTarif='+TaVerwaltung.oldTarif+'&';
         Data:= Data + 'oldNumber='+TaVerwaltung.oldNumber+'&';
         Data:= Data + 'oldUser='+TaVerwaltung.oldUser+'&';
         Data:= Data + 'oldPass='+TaVerwaltung.oldPass+'&';
         Data:= Data + 'oldfromd='+inttostr(dayof(TaVerwaltung.oldFrom))+'&';
         Data:= Data + 'oldfromm='+inttostr(monthof(TaVerwaltung.oldFrom))+'&';
         Data:= Data + 'oldfromy='+inttostr(yearof(TaVerwaltung.oldFrom))+'&';
         Data:= Data + 'oldbisd='+inttostr(dayof(TaVerwaltung.oldUntil))+'&';
         Data:= Data + 'oldbism='+inttostr(monthof(TaVerwaltung.oldUntil))+'&';
         Data:= Data + 'oldbisy='+inttostr(yearof(TaVerwaltung.oldUntil))+'&';
         Data:= Data + 'inprovider='+TaVerwaltung.TaProvider.Text+'&';
         Data:= Data + 'intarif='+TaVerwaltung.TaName.text+'&';
         Data:= Data + 'intag='+inttostr(TaVerwaltung.TaTag.Itemindex)+'&';
         Data:= Data + 'intakt='+TaVerwaltung.TaTakt_a.Text+'/'+TaVerwaltung.TaTakt_b.text+'&';
         Data:= Data + 'inuser='+TaVerwaltung.TaUser.Text+'&';
         Data:= Data + 'inpasswort='+TaVerwaltung.TaPass.Text+'&';
         Data:= Data + 'innummer='+TaVerwaltung.TaNumber.Text+'&';
         Data:= Data + 'inurl='+TaVerwaltung.TaWebsite.Text+'&';
         Data:= Data + 'infromd='+inttostr(dayof(TaVerwaltung.TaStarts.DateTime))+'&';
         Data:= Data + 'infromm='+inttostr(monthof(TaVerwaltung.TaStarts.DateTime))+'&';
         Data:= Data + 'infromy='+inttostr(yearof(TaVerwaltung.TaStarts.DateTime))+'&';
         Data:= Data + 'inbisd='+inttostr(dayof(TaVerwaltung.Taexpires.DateTime))+'&';
         Data:= Data + 'inbism='+inttostr(monthof(TaVerwaltung.Taexpires.DateTime))+'&';
         Data:= Data + 'inbisy='+inttostr(yearof(TaVerwaltung.Taexpires.DateTime))+'&';

         for i:= 0 to 23 do
         begin
          Data:= Data + 'inanfang' + inttostr(i)+'='+TaVerwaltung.EditArray[i][0].text+'&';
          Data:= Data + 'inende'   + inttostr(i)+'='+TaVerwaltung.EditArray[i][1].text+'&';
          Data:= Data + 'inpreis'  + inttostr(i)+'='+TaVerwaltung.EditArray[i][2].text+'&';
          Data:= Data + 'ineinwahl'+ inttostr(i)+'='+TaVerwaltung.EditArray[i][3].text+'&';
         end;

         If PWForm.action = 'delete' then //Nur löschen der Daten
          Data:= Data + 'action=delete&';

         if PWForm.noNews.Checked then //kein Newsletter
           Data:= Data + 'WillEnd=1&'
           else
           Data:= Data + 'WillEnd=0&';

         Data:= Data + 'Submit=Submit';
        try
         httppost('http://darkempire.da.funpic.de/php/TarifDB/LCXP_add.php', Data);
        except
        end; 
end;

procedure TPWForm.BitBtn1Click(Sender: TObject);
begin
     settings.writeBool('Tariflisten', 'SaveData', savePWD.Checked);

     if savePWD.Checked then
      begin
        settings.writeString('Tariflisten', 'Username', UsernameEdit.Text);
        if length(PWedit.text) > 1 then
         settings.writeString('Tariflisten', 'Password', encrypt(PWedit.text, CODE));
      end
      else
      begin
        settings.DeleteKey('Tariflisten', 'Username');
        settings.DeleteKey('Tariflisten', 'Password');
      end;

   Download:=TGetThread.Create(true);
   Download.Priority:=tpLower;
   Download.FreeOnTerminate:=true;
   Download.OnTerminate:= Download.MyTerminate;
   Download.Resume;

end;


procedure TPWForm.FormShow(Sender: TObject);
begin
  Memo.Clear;
  Memo1.Clear;
  savePWD.Checked:= settings.readBool('Tariflisten', 'SaveData', false);
  if savePWD.checked
    then
    begin
     UsernameEdit.Text:= settings.ReadString('tariflisten','Username','');
     PWEdit.Text:= decrypt(settings.ReadString('tariflisten','Password',''), CODE);
    end;
end;


procedure TPWForm.closeBtnClick(Sender: TObject);
begin
PWForm.close;
end;

end.
