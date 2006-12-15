unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TInfo = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Label2: TLabel;
    copyright: TLabel;
    Edit: TRichEdit;
    Label3: TLabel;
    Image1: TImage;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Info: TInfo;

implementation
uses files, StrUtils, ShellAPi, Unit1, DateUtils;
{$R *.dfm}

procedure TInfo.FormCreate(Sender: TObject);
begin
Hauptfenster.enabled:= false;
label1.caption:= 'LeastCosterXP Version : '+GetFileVersion(Application.exename);
copyright.caption:= '©2006 ' + chr(83)+ chr(116)+ chr(101)+ chr(102)+ chr(97)+ chr(110)+ chr(32)+ chr(70)+ chr(114)+ chr(117)+ chr(104)+ chr(110)+ chr(101)+ chr(114) +'   ';


if fileexists(ExtractFilepath(paramstr(0))+ 'about.txt' ) then
 edit.Lines.LoadFromFile(ExtractFilepath(paramstr(0))+ 'about.txt')
else Edit.Lines.Append('about.txt nicht gefunden !');
end;

procedure TInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Hauptfenster.enabled:= true;

Info.Release;
Info:= nil;
end;

procedure TInfo.EditMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var link, temp: string;
    i: integer;
begin
if ansicontainstext(edit.Lines.Strings[edit.CaretPos.Y],'http://') then
begin
  temp:= edit.Lines.Strings[edit.CaretPos.Y];
  delete(temp,1,posex('http://',temp,0)-1);
  if ansicontainsstr(temp,' ') then delete(temp,posex(' ',temp,0),length(temp) - posex(' ',temp,0)+1);
  link:= temp;
  ShellExecute(Application.Handle, 'open', Pchar(link), nil, nil, sw_ShowNormal);
end
else
if ansicontainstext(edit.Lines.Strings[edit.CaretPos.Y],'@') then
begin
temp:= edit.Lines.Strings[edit.CaretPos.Y];
for i:= posex('@',temp,0) downto 0 do
 if temp[i]=' ' then break;
delete(temp, 1, i);
delete(temp, posex(' ', temp,0), length(temp) - posex(' ', temp,0) +1);
link:= 'mailto:'+temp;
ShellExecute(Application.Handle, 'open', PChar(link), nil, nil, sw_ShowNormal);
//showmessage(temp);
end;
end;

procedure TInfo.Image1Click(Sender: TObject);
begin
 settings.WriteDate('LeastCoster','Donation', incday(Dateof(now),60));
 Shellexecute( handle, nil, Pchar('https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=stefan_fruhner%40web%2ede&item_name=LeastCosterXP&no_shipping=2&no_note=1&tax=0&currency_code=EUR&lc=DE&bn=PP%2dDonationsBF&charset=UTF%2d8'), nil, nil, SW_SHOWMaximized);
end;

end.
