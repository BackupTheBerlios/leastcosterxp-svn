unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, shutdown, AppEvnts;


type
  Tshutter = class(TForm)
    Stop: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Timer2: TTimer;
    Panel1: TPanel;
    ApplicationEvents1: TApplicationEvents;
    procedure StopClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      Art, user: string;
  end;

var
  shutter: Tshutter;


implementation

uses WebServ1;

{$R *.dfm}

procedure Tshutter.StopClick(Sender: TObject);
var buf: string;
begin
timer2.Enabled:= false;
art:='';
//shutter.Visible:= false;


    Buf     := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+ 'Windows beenden geblockt !' +
                #9+ User + '@ LeastCoster XP'  +#13#10;
    webservform.logfile_add(buf);
    webserv1.status:= buf;

shutter.close;    
end;

procedure Tshutter.Timer2Timer(Sender: TObject);
begin
timer2.Enabled:= false;
timer2.Tag:= timer2.Tag-1;
label2.Caption:= inttostr(timer2.tag);

if timer2.tag =0 then
begin
 if art='poweroff' then shutdown.ShutdownWindows(swtshutdownpoweroff)
 else
 if art='logoff' then shutdown.ShutdownWindows(swtlogoff)
 else
 if art='restart' then shutdown.ShutdownWindows(swtrestart)
 else
 if art='ruhezustand' then shutdown.SetStandby(false)
 else
 if art='standby' then shutdown.SetStandby(true)
 else
 shutdown.ShutdownWindows(swtshutdownpoweroff);
end
else timer2.enabled:= true;

end;

procedure Tshutter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
shutter.Release;
shutter:= nil;
end;

procedure Tshutter.FormCreate(Sender: TObject);
begin
label2.width:= shutter.ClientWidth-20;
label2.left:= 10;
end;

procedure Tshutter.FormShow(Sender: TObject);
begin
shutter.BringToFront;
timer2.enabled:= true;
end;

procedure Tshutter.ApplicationEvents1Deactivate(Sender: TObject);
begin
shutter.BringToFront;
end;

end.
