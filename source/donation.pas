unit donation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TDonateWindow = class(TForm)
    Image1: TImage;
    quit: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    Image2: TImage;
    procedure quitClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DonateWindow: TDonateWindow;

implementation
uses ShellAPI, Unit1, DateUtils;

{$R *.dfm}

procedure TDonateWindow.Image1Click(Sender: TObject);
begin
 settings.WriteDate('LeastCoster','Donation', incday(Dateof(now),60));
 Shellexecute( handle, nil, Pchar('https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=stefan_fruhner%40web%2ede&item_name=LeastCosterXP&no_shipping=2&no_note=1&tax=0&currency_code=EUR&lc=DE&bn=PP%2dDonationsBF&charset=UTF%2d8'), nil, nil, SW_SHOWMaximized);
end;

procedure TDonateWindow.Timer1Timer(Sender: TObject);
begin
timer1.Tag:= timer1.tag-1;

if timer1.Tag > 0 then
 quit.Caption:= inttostr(timer1.Tag)
else
if timer1.Tag = 0 then
begin
  quit.caption:= 'OK';
  quit.Enabled:= true;
end
else
if timer1.tag = -60 then
  DonateWindow.Close;
end;

procedure TDonateWindow.quitClick(Sender: TObject);
begin
 settings.WriteDate('LeastCoster','Donation', incday(Dateof(now),7));
 donatewindow.close;
end;

end.
