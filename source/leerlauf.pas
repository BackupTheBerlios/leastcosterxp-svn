unit leerlauf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, AppEvnts,SRGrad;

type
  Tdisconnect_leerlauf = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Stop: TBitBtn;
    Timer1: TTimer;
    Panel1: TPanel;
    label3: TLabel;
    ApplicationEvents1: TApplicationEvents;
    Trennen: TBitBtn;
    Label4: TLabel;
    ConnectTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TrennenClick(Sender: TObject);
    procedure ConnectTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
   useTimer: boolean;
   useConnectTimeOut: boolean;
   //im Tag wird der Modus gepseichert
   //0: Standardzustand (not selceted) wird beim Starten und Beenden gesetzt
   //1: Autodisconnect
   //2: AutoEinwahl

   grad : TSRGradient;
    { Public declarations }
  end;

var
  disconnect_leerlauf: Tdisconnect_leerlauf;

implementation

uses Unit1, inilang, messagestrings;

{$R *.dfm}

procedure DisconnectAndClose;
begin
 disconnect_leerlauf.timer1.Enabled:= false;
 hauptfenster.disconnect;
 disconnect_leerlauf.Close;
end;

procedure Tdisconnect_leerlauf.FormCreate(Sender: TObject);
begin

CL:=loadIni('lang\'+settings.readstring('LeastCoster','language',''));
 if CL<>nil then fillProps([disconnect_leerlauf],CL);

grad := TSRGradient.Create(self);
grad.parent:= disconnect_leerlauf;
grad.Align:= alClient;
grad.Direction:= gdUpLeft;
grad.EndColor:= $00DBAF95;
grad.StartColor:= clBtnFace;
grad.Style:= gsPyramid;
grad.SendToBack;//nach hinten schieben

usetimer:= false;
useConnectTimeOut:= false;
hauptfenster.Enabled:= false;
disconnect_leerlauf.tag:= 0;
disconnect_leerlauf.bringtofront;
end;

procedure Tdisconnect_leerlauf.Timer1Timer(Sender: TObject);
begin
if not isonline then disconnect_leerlauf.Close;

if usetimer then
begin
 timer1.tag:= timer1.tag-1;
 label2.Caption := inttostr(timer1.tag) + ' '+misc(M93,'M93');
end;

if timer1.tag = 0 then DisconnectAndClose;
end;

procedure Tdisconnect_leerlauf.StopClick(Sender: TObject);
begin
if useConnectTimeOut then hauptfenster.AutoDialled.ledon:= false;

//wenn Autotrennen aktiviert ist, dann merken, dass Stopp gedrückt wurde sonst nicht
case disconnect_leerlauf.tag of
//Auto-trennen
1: hauptfenster.DisconnectStopped:= true;
//AuoEinwahl
2: begin
    hauptfenster.Status.SimpleText:= misc(M211,'M211')+' ('+ datetimetostr(now)+')';
    Hauptfenster.AutoDialStatus.LEDOn:= false;
    Hauptfenster.AutoDial.Enabled:= false;
   end;
end;
disconnect_leerlauf.Close;
end;

procedure Tdisconnect_leerlauf.ApplicationEvents1Deactivate(Sender: TObject);
begin
disconnect_leerlauf.bringtofront;
end;

procedure Tdisconnect_leerlauf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
hauptfenster.Enabled:= true;
disconnect_leerlauf.tag:= 0;

if assigned(grad) then grad.free;

disconnect_leerlauf.release;
disconnect_leerlauf:= nil;
end;

procedure Tdisconnect_leerlauf.FormShow(Sender: TObject);
begin
if not useConnectTimeout then
begin
 if usetimer then timer1.Enabled:= true else
 begin
      label2.Enabled:= false;
      label3.Enabled:= false;
      label4.Enabled:= false;
 end;
end
else Connecttimer.enabled:= true;
end;

procedure Tdisconnect_leerlauf.TrennenClick(Sender: TObject);
begin
  DisconnectAndClose;
end;

procedure Tdisconnect_leerlauf.ConnectTimerTimer(Sender: TObject);
begin
if useConnectTimeOut then
begin
 ConnectTimer.tag:= ConnectTimer.tag-1;
 label2.Caption := inttostr(ConnectTimer.tag) + ' '+misc(M93,'M93');
end;

if ConnectTimer.tag= 0 then
 begin
      ConnectTimer.Enabled:= false;
      // Wählen
      Hauptfenster.Autodialer;
      disconnect_leerlauf.Close;
 end;
end;


end.
