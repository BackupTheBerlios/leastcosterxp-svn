unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TCallIn = class(TForm)
    info2: TLabel;
    info3: TLabel;
    Bevel1: TBevel;
    Date: TLabel;
    BitBtn1: TBitBtn;
    topbox: TCheckBox;
    Panel: TPanel;
    Bright: TButton;
    Bleft: TButton;
    Calltype: TLabel;
    info4: TLabel;
    duration: TLabel;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure BleftClick(Sender: TObject);
    procedure BrightClick(Sender: TObject);
    procedure topboxClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure showCall(p: integer);
  private
    { Private-Deklarationen }
     procedure CreateParams(var Params : TCreateParams); override;
     procedure WMNCHitTest(var M: TWMNCHitTest);
      message wm_NCHitTest;
   var CallID : integer;
  public
    Call: string;

    { Public-Deklarationen }
  end;

var
  CallIn: TCallIn;

implementation
uses tools, main, Strutils, shellapi;
{$R *.dfm}

//den Desktop zum Mainform machen, damt das Fenster nicht mit LCXP weggeblendet wird
procedure TCallIn.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
  Params.Caption:='CallInfo';
end;

procedure TCallIn.WMNCHitTest (var M: TWMNCHitTest);
begin
  inherited;
  if M.Result = htClient then 
    M.Result := htCaption;
end;

procedure TCallIn.showCall(p: integer);
begin
      if p >= length(ActiveCalls) then p:=0;
      if length(ActiveCalls)=0 then exit;
      
      callID:= p;
      CallType.caption:= ActiveCalls[p].typ;
      info2.caption   := ActiveCalls[p].name;
      info3.caption   := ActiveCalls[p].MSN;
      info4.caption   := ActiveCalls[p].ConnID;
      date.caption    := ActiveCalls[p].date;

      if ActiveCalls[p].typ = 'outgoing call' then
         info3.caption   := ActiveCalls[p].Nebenstelle+'@'+ActiveCalls[p].MSN;

      duration.caption:= '';
      if ActiveCalls[p].start > 0 then
       duration.caption:= Format('%d',[round(gettickcount/1000 - ActiveCalls[p].start/1000)]);
end;

procedure SetFormPosition;
var h              : HWnd;
    Taskbar        : TRect;
    Twidth, THeight: integer;
begin
H:= FindWindow('Shell_TrayWnd', nil);
if H<>0 then
begin
      GetWindowRect(H, Taskbar);
      TWidth := Taskbar.right - Taskbar.Left;
      THeight:= Taskbar.Bottom - Taskbar.Top;

      if TWidth > THeight then
      begin
        if Taskbar.Bottom = Screen.Height then
        begin
         Callin.top  := Taskbar.Top  - Callin.Height;
         CallIn.Left := Screen.Width - CallIn.Width;
        end
        else
        if Taskbar.Top = 0 then
        begin
         Callin.top  := Taskbar.Bottom +1;
         CallIn.Left := Screen.Width - CallIn.Width;
        end;
      end //Taskbar ist rechts oder links)
      else
      begin
       if taskbar.left = 0 then
       begin
        Callin.top := Screen.height - Callin.Height;
        callin.Left:= TWidth + 1;
       end
       else
       if Taskbar.right = screen.width then
       begin
        Callin.top := Screen.height - Callin.Height;
        callin.Left:= Taskbar.left - Callin.width;
       end;
      end;
end;
end;

procedure TCallIn.BitBtn1Click(Sender: TObject);
begin
CallIn.close;
end;

procedure TCallIn.topboxClick(Sender: TObject);
begin
  AlwaysOnTop(Callin.Handle, callin.Left,callin.top, callin.width, callin.height, topbox.Checked);
end;

procedure TCallIn.BrightClick(Sender: TObject);
begin
 if CallID+1 < length(ActiveCalls) then ShowCall(CallID+1)
 else
 if CallID+1 >= length(ActiveCalls) then ShowCall(0)
end;

procedure TCallIn.BleftClick(Sender: TObject);
begin
 if CallID-1 > -1 then ShowCall(CallID-1)
 else
 if CallID-1 = -1 then ShowCall(length(ActiveCalls))
end;

procedure TCallIn.TimerTimer(Sender: TObject);
begin
CallIn.close;
end;

procedure TCallIn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 sett.Writeinteger('Call','left',CallIn.Left);
 sett.Writeinteger('Call','top' ,CallIn.top);
CallIn.Release;
CallIn:= nil;
end;

procedure TCallIn.FormCreate(Sender: TObject);
var reverseAdress  : string;
begin

CallIn.Left:= sett.Readinteger('Call','left',-1);
CallIn.top := sett.Readinteger('Call','top',-1);
if (CallIn.left = -1) or (CallIn.top = -1) then SetFormPosition;
AlwaysOnTop(Callin.Handle,callin.Left,callin.top, callin.width, callin.height, true);

//AlwaysOnTop(Callin.Handle,callin.Left,callin.top, callin.width, callin.height, topbox.Checked);

 if sett.ReadBool('FritzBox','CloseTimer',false) then
 begin
  timer.Interval:= sett.ReadInteger('FritzBox','CloseTime',15) * 1000;
  timer.Enabled:= true;
 end;

  reverseAdress := sett.ReadString('FritzBox','reverse', '');
   if reverseAdress <> '' then
    if (Call <> '') and (Call = info2.caption) then
     begin
      reverseAdress:= AnsiReplaceStr(reverseAdress, '%NUMBER%',CALL);
      Shellexecute( handle, nil, Pchar(reverseadress), nil, nil, SW_SHOWMaximized);
     end;
end;


end.
