unit floating;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, AppEvnts, ExtCtrls, ComCtrls, AMAdvLed, Inifiles,
  Spin,magsubs1;

type
  TfloatingW = class(TForm)
    Image1: TImage;
    changepos: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    LabelSpeedRecv: TLabel;
    LabelSpeedXmit: TLabel;
    LabelSpeedVal: TLabel;
    LabelDataXmit: TLabel;
    LabelDataRecv: TLabel;
    LEDRecv: TAMAdvLed;
    LEDXmit: TAMAdvLed;
    labelx: TLabel;
    Tarif: TLabel;
    Ozeit: TLabel;
    OCostlabel: TLabel;
    valid: TLabel;
    preis: TLabel;
    visbar: TTrackBar;
    beenden: TBitBtn;
    mini: TBitBtn;
    topbox: TCheckBox;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    fontup: TButton;
    fontdown: TButton;
    ScaleUp: TButton;
    ScaleDown: TButton;
    procedure FormShow(Sender: TObject);
    procedure ScaleDownClick(Sender: TObject);
    procedure ScaleUpClick(Sender: TObject);
    procedure fontdownClick(Sender: TObject);
    procedure fontupClick(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure topboxClick(Sender: TObject);
    procedure miniClick(Sender: TObject);
    procedure beendenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure changeposClick(Sender: TObject);
    procedure visbarChange(Sender: TObject);
    procedure setwidth;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
   scaling: integer;
       procedure WMNCHitTest(var M: TWMNCHitTest);
    message wm_NCHitTest;
       procedure CreateParams(var Params : TCreateParams); override;

  public
    { Public-Deklarationen }
      background: TPicture;
      scale: boolean;
  end;

var
  floatingW: TfloatingW;

implementation
uses unit1;

{$R *.dfm}

//den Desktop zum Mainform machen, damt das Fenster nicht mit LCXP weggeblendet wird
procedure TFLoatingw.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
  Params.Caption:='OnlineInfo';
end;

Procedure TFloatingW.Setwidth;
var width: integer;
begin

width:= floatingw.Canvas.TextWidth(tarif.Caption);

if ((width > 145) and (width < screen.width)) then //dann verbreitern ... ansonsten nix tun
begin
  floatingw.width:= floatingw.width + (width - 145);
  LabelSpeedXmit.left:= LabelSpeedXmit.left+floatingw.width-200;
  LEDXmit.left:= LEDXmit.left+floatingw.width-200;
  preis.Left:= preis.left+floatingw.width-200;
  ocostlabel.left:= ocostlabel.left+floatingw.width-200;
  visbar.width:= visbar.width+floatingw.width-200;
  floatingw.mini.left:= floatingw.mini.left+floatingw.width-200;
  beenden.left:= beenden.left+floatingw.width-200;
end;
end;

procedure TfloatingW.FormCreate(Sender: TObject);
var bgfile: string;
    textcolor, sptextcolor: Tcolor;
    alpha: integer;
    H: HWnd;
    Taskbar: TRect;
begin

if (MagRasOSVersion < OSW2K) then
begin
 Ledxmit.visible:= false;
 ledRecv.visible:= false;
 LabelSpeedxmit.visible:= false;
 LabelSpeedRecv.visible:= false;
 labelx.visible:= false;
 LabelSpeedVal.visible:= false;
 label2.visible:= false;
 LabelDataxmit.visible:= false;
 label3.visible:= false;
 labelDataRecv.visible:= false;
end;

bgfile:= settings.readstring('Onlineinfo','BGImage',  '' );

floatingw.Font.Name:= settings.ReadString('Onlineinfo','Font', 'MS Sans Serif');
ozeit.Font.name:=  floatingw.Font.Name;
ocostlabel.font.name:= floatingw.Font.Name;

topbox.checked:= settings.readbool('Onlineinfo','OnTop',true);
topboxclick(self);

floatingW.top:= settings.ReadInteger('Onlineinfo','WindowTop', 0);
floatingW.left:= settings.ReadInteger('Onlineinfo','WindowLeft', 0);

floatingw.Clientwidth  := settings.ReadInteger('Onlineinfo','WindowWidth', 200);
floatingw.Clientheight := settings.ReadInteger('Onlineinfo','WindowHeight', 180);

scaling:= settings.ReadInteger('Onlineinfo','yScaling', 0);
alpha:= settings.Readinteger('Onlineinfo','Alpha',255);

floatingW.color:= stringtocolor(settings.Readstring('Onlineinfo','BGColor', 'clBtnFace'));
textcolor:= stringtocolor(settings.Readstring('Onlineinfo','TextColor','clWindowText'));
sptextcolor:= stringtocolor(settings.Readstring('Onlineinfo','SpecialTextColor',   'clGreen'));

font.Size:= settings.Readinteger('Onlineinfo','FontSize',8);
oZeit.Font.Size := font.size + 6;//settings.Readinteger('Onlineinfo','Fonts_big',16);
oCostLabel.Font.Size := font.size+ 6;//settings.Readinteger('Onlineinfo','Fonts_big',16);

if (bgfile <> '') and fileexists(bgfile) then
begin
  background:= TPicture.Create;
  background.LoadFromFile(bgfile);
  image1.Picture:= background;
  background.free;
end;

Font.Color:= textcolor;

OCostLabel.font.Color:= sptextcolor;
ozeit.font.Color:= sptextcolor;

floatingW.refresh;
floatingW.AlphaBlendValue:= alpha;
visbar.position:= alpha;

H:= FindWindow('Shell_TrayWnd', nil);
if H<>0 then
with floatingW do
begin
      GetWindowRect(H, Taskbar);
      if ((top = 0) and (left = 0)) then changepos.Caption:= 'v'
      else
      if ((top = screen.Height - height - (taskbar.Bottom - taskbar.top)) and (left = 0)) then changepos.Caption:= '>'
      else
      if ((top = screen.Height - height - (taskbar.Bottom - taskbar.top)) and (left = screen.width - width)) then  changepos.Caption:= '^'
      else
      if ((top = 0) and (left = screen.width - width)) then changepos.Caption:= '<'
      else //wenn nicht an einer Ecke platziert finde nächste Ecke
      changepos.caption:='o';
end;

floatingW.visible:= true;

end;

procedure TfloatingW.visbarChange(Sender: TObject);
begin
floatingW.AlphaBlendValue:= visbar.Position;
end;

procedure TfloatingW.changeposClick(Sender: TObject);
var
  H: HWnd;
  Taskbar: TRect;
begin
  H:= FindWindow('Shell_TrayWnd', nil);
  if H<>0 then
  begin
  GetWindowRect(H, Taskbar);
  with floatingW do
    begin
      if ((top = 0) and (left = 0)) then begin top:= screen.Height - height - (taskbar.Bottom - taskbar.top); changepos.Caption:= '>'; end
      else
      if ((top = screen.Height - height - (taskbar.Bottom - taskbar.top)) and (left = 0)) then begin left:= screen.width - width; changepos.Caption:= '^'; end
      else
      if ((top = screen.Height - height - (taskbar.Bottom - taskbar.top)) and (left = screen.width - width)) then begin top:=0; changepos.Caption:= '<'; end
      else
      if ((top = 0) and (left = screen.width - width)) then begin left:=0; changepos.Caption:= 'v';  end
      else //wenn nicht an einer Ecke platziert finde nächste Ecke
      begin
       if ((left+width/2) < screen.width/2) then
         if ((top+height/2) < screen.Height/2) then begin top:= 0; left:= 0; end
         else begin left:= 0; top:= screen.Height - height - (taskbar.Bottom - taskbar.top); end
       else //left > screen.width
        if ((top+height/2) < screen.Height/2) then begin top:= 0; left:= screen.width - width; end
         else begin left:= screen.width - width; top:= screen.Height - height - (taskbar.Bottom - taskbar.top); end;

      if ((top = 0) and (left = 0)) then changepos.Caption:= 'v'
      else
      if ((top = screen.Height - height - (taskbar.Bottom - taskbar.top)) and (left = 0)) then changepos.Caption:= '>'
      else
      if ((top = screen.Height - height - (taskbar.Bottom - taskbar.top)) and (left = screen.width - width)) then  changepos.Caption:= '^'
      else
      if ((top = 0) and (left = screen.width - width)) then changepos.Caption:= '<'
      else //wenn nicht an einer Ecke platziert finde nächste Ecke
      changepos.caption:='o';   
      end;
    end;
   end; 
end;

procedure TfloatingW.FormClose(Sender: TObject; var Action: TCloseAction);
begin


settings.WriteInteger('Onlineinfo','WindowTop', floatingW.top);
settings.WriteInteger('Onlineinfo','WindowLeft', floatingW.left);
settings.WriteInteger('Onlineinfo','WindowWidth', floatingW.Clientwidth);
settings.WriteInteger('Onlineinfo','WindowHeight', floatingW.Clientheight);
settings.WriteInteger('Onlineinfo','FontSize', floatingW.font.size);
settings.WriteInteger('Onlineinfo','yScaling', scaling);
settings.writeinteger('Onlineinfo','Alpha',floatingW.AlphaBlendValue);
settings.writebool('Onlineinfo','OnTop',topbox.checked);


floatingW.Release;
floatingW:= nil;
end;

procedure TfloatingW.beendenClick(Sender: TObject);
begin
floatingW.Close;
end;

procedure TfloatingW.miniClick(Sender: TObject);
var h: hwnd;
    taskbar: TRect;
    oldheight: integer;
begin
oldheight:= floatingw.height;
 H:= FindWindow('Shell_TrayWnd', nil);
 if H<>0 then GetWindowRect(H, Taskbar);
with floatingW do
begin
if (clientheight > preis.Top + preis.height) then
 begin
    clientHeight:= preis.Top + preis.height;
    image1.height:= clientheight;
 end
else
begin
    clientheight:= visbar.top+visbar.height;
    image1.height:= clientheight;
end;

 if h<>0 then
 begin
 if (top = screen.Height - oldheight - (taskbar.Bottom - taskbar.top)) then
     top:= screen.Height - height - (taskbar.Bottom - taskbar.top)
 else
  if (top > screen.Height - height - (taskbar.Bottom - taskbar.top)) then
     top:= screen.Height - height - (taskbar.Bottom - taskbar.top)
 end;    
end;


end;

procedure TfloatingW.WMNCHitTest (var M: TWMNCHitTest);
begin
  inherited;
  if M.Result = htClient then
    M.Result := htCaption;
end;

procedure TfloatingW.topboxClick(Sender: TObject);
begin

if topbox.checked then
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,
             Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
else
  SetWindowPos(Handle, HWND_NOTOPMOST, Left, Top, Width,
             Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

SetWindowLong(Floatingw.Handle, GWL_STYLE, GetWindowLong(Floatingw.handle, GWL_STYLE) and not WS_CAPTION);
end;

procedure TfloatingW.FormResize(Sender: TObject);
var x: real;
begin
if (floatingw.ClientWidth  >= 200.0) then  x:= floatingw.clientwidth/ 200.0  else x:= 1.0;

mini.Left:= floatingw.clientwidth - 43;
beenden.left:= floatingw.clientwidth - 22;
visbar.left:= 0;
visbar.Width:= floatingw.ClientWidth;

fontdown.left := floatingw.clientwidth - 34;
fontup.left   := floatingw.clientwidth - 18;
Scaledown.left := floatingw.clientwidth - 51;
Scaleup.left   := floatingw.clientwidth - 68;

with floatingw do
begin
OCostlabel.left    := Ozeit.left + ozeit.width + 2;
OCostlabel.width   := (beenden.left - OCostlabel.Left) + beenden.width;

valid.left         := round(8.0 * x);
preis.left         := valid.left + valid.width + 7;
preis.width        := (beenden.left - preis.Left) + beenden.width ;
Ozeit.left         := round(8.0 * x);
tarif.left         := round(8.0 * x);
LedXmit.left       := round(104.0 * x);
ledRecv.left       := round(8.0 * x);

LabelSpeedXmit.left:= round(120.0 * x);
LabelSpeedRecv.left:= round(24.0 * x);
label3.left        := round(8.0 * x);
label2.left        := round(8.0 * x);
labelx.left        := round(8.0 * x);
changepos.left     := round(8.0 * x);
topbox.left        := changepos.Left + changepos.width + 5;
label1.left        := topbox.Left + topbox.width + 1;

LabelSpeedVal.left  := labelx.left + labelx.Width;
LabelSpeedVal.width := (beenden.left - LabelSpeedVal.Left) + beenden.width ;
LabelDataRecv.left  := labelx.left + labelx.Width;
LabelDataRecv.width := (beenden.left - LabelDataRecv.Left) + beenden.width ;
LabelDataXmit.left  := labelx.left + labelx.Width;
LabelDataXmit.width := (beenden.left - LabelDataXmit.Left) + beenden.width ;

tarif.top         := round(6.0 + scaling);

OCostlabel.top    := tarif.Top + tarif.height;
Ozeit.top         := OCostlabel.top;

valid.top         := ozeit.top + ozeit.height;
preis.top         := valid.top;

Ledxmit.top       := preis.Top+preis.height + 4;
ledRecv.top       := LEDXmit.Top;
LabelSpeedxmit.top:= LEDXmit.Top;
LabelSpeedRecv.top:= LEDXmit.Top;

labelx.top        := ledxmit.Top+ledxmit.height + 4;
LabelSpeedVal.top := labelx.top;

label2.top        := labelx.top + labelx.height+1;
LabelDataxmit.top := label2.top;

label3.top        := label2.top+label2.height +1;
labelDataRecv.top := label3.top;

if (MagRasOSVersion < OSW2K) then
label1.top        := preis.Top+preis.height + 4
else //unter win2k
label1.top        := label3.Top + label3.height+2;

changepos.top     := label1.top + 2 ;
topbox.top        := label1.top + 2;
fontdown.top      := label1.top + 2;
fontup.top        := fontdown.top;
scaledown.top     := fontdown.top;
scaleup.top       := fontdown.top;

visbar.top        := topbox.top + topbox.height;
end;


//maximale breite von Tarif festelegen
tarif.constraints.MaxWidth:= (mini.Left - tarif.left - 5);
end;

procedure TfloatingW.ApplicationEvents1Deactivate(Sender: TObject);
begin
if topbox.Checked then
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,
             Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
else //..und zurück:
  SetWindowPos(Handle, HWND_NOTOPMOST, Left, Top, Width,
             Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
//if topbox.checked then floatingw.BringToFront;
end;

procedure TfloatingW.fontupClick(Sender: TObject);
begin
if (floatingw.Font.Size < 31) then
begin
  floatingw.Font.Size:= floatingw.Font.Size+1;
  ozeit.Font.Size:= 6 + floatingw.Font.Size;
  ocostlabel.Font.Size:= 6 + floatingw.Font.Size;
  FormResize(self);

  floatingw.Constraints.MaxHeight:=screen.height;
  clientheight:= visbar.Top + visbar.height;
  floatingw.Constraints.MaxHeight:=clientheight;
  visbar.refresh;
end;
end;

procedure TfloatingW.fontdownClick(Sender: TObject);
begin
if (floatingw.Font.Size > 1) then
begin
  floatingw.Font.Size:= floatingw.Font.Size-1;
  ozeit.Font.Size:= 2 + floatingw.Font.Size;
  ocostlabel.Font.Size:= 2 + floatingw.Font.Size;
  FormResize(self);

  floatingw.Constraints.MaxHeight:=screen.height;
  clientheight:= visbar.Top + visbar.height;
  floatingw.Constraints.MaxHeight:=clientheight;
  visbar.refresh;
end;
end;

procedure TfloatingW.ScaleUpClick(Sender: TObject);
begin
  scaling:= scaling + 1;
  floatingW.FormResize(self);
  floatingw.Constraints.MaxHeight:=screen.height;
  clientheight:= visbar.Top + visbar.height;
  floatingw.Constraints.MaxHeight:=clientheight;
  visbar.refresh;
end;

procedure TfloatingW.ScaleDownClick(Sender: TObject);
begin
if (scaling > -50) then
begin
  scaling:= scaling - 1;
  floatingW.FormResize(self);
  floatingw.Constraints.MaxHeight:=screen.height;
  clientheight:= visbar.Top + visbar.height;
  floatingw.Constraints.MaxHeight:=clientheight;
  visbar.refresh;
end;
end;

procedure TfloatingW.FormShow(Sender: TObject);
begin
floatingw.Constraints.maxheight:= visbar.Top+visbar.Height;
end;

end.
