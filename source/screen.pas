unit screen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, jpeg, HttpSrv, ComCtrls, addons,
  strutils;


type

  TMyHttpConnection = class(THttpConnection);

  Tscreenshot = class(TForm)
    Image1: TImage;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    TrackBar1: TTrackBar;
    shot: TBitBtn;
    BitBtn4: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure shotClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }

  public
    { Public declarations }
    surfprog: string;
  end;

var
  screenshot: Tscreenshot;
  wnd, wnd2: HWND;


implementation

uses Unit1;

{$R *.dfm}

procedure savetofile;
var  jp: TJPEGImage;  //Requires the "jpeg" unit added to "uses" clause.
begin
  jp := TJPEGImage.Create;
  jp.CompressionQuality:=50;
  jp.Compress;
  try
    with jp do
    begin
      Assign(screenshot.Image1.Picture.Bitmap);
      SaveToFile(extractfilepath(Paramstr(0))+'\www\lcr.jpg')
    end;
  finally
    jp.Free;
  end;
end;

function FindWindowEx2(hParent: HWND; ChildClassName: string; ChildNr: Word): HWND;
var
  i: Word;
  hChild: HWND;
begin
  hChild := 0;
  Result := 0;
  ChildNr := ChildNr - 1;
  for i := 0 to ChildNr do
  begin
    hChild := FindWindowEx(hParent, hChild, PChar(ChildClassName), nil);
    if hChild = 0 then
      Exit;
    Result := hChild;
  end;
end;

{---------------------1---------------------}
function GetScreenShot(x,y,xu,yu: integer): TBitmap;
var
  Desktop: HDC;

begin
  Result  := TBitmap.Create;
  Desktop := GetDC(0);
  try
    try

      Result.PixelFormat := pf32bit;
      Result.Width := xu-x;{Screen.Width}
      Result.Height := yu-y; {Screen.Height}
      BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, Desktop,x , y, SRCCOPY);
      Result.Modified := True;
    finally
      ReleaseDC(0, Desktop);
    end;
  except
    Result.Free;
    Result := nil;
  end;
end;


function GetWindowState(Wnd:HWnd):integer;
var WPlacement : PWINDOWPLACEMENT;
begin
  GetMem(WPlacement,SizeOf(TWINDOWPLACEMENT));
  WPlacement^.Length:=SizeOf(TWINDOWPLACEMENT);
  if GetWindowPlacement(Wnd,WPlacement) then
    begin
    Result:=WPlacement^.showCmd;
    end
  else
    Result:=-1;
  FreeMem(WPlacement);
end;

procedure Tscreenshot.BitBtn2Click(Sender: TObject);
 var p, t:TWindowPlacement;
     x,y, x1, y1: integer;
     wnd2: HWND;
begin

  if ( not isexerunning(hauptfenster.prog) and not isexerunning('_'+hauptfenster.prog)) then
  begin
   bitbtn1.Enabled:= false;
   bitbtn2.Enabled:= false;
   bitbtn3.Enabled:= false;
   exit;
  end;

  try
  wnd2 := FindWindow(nil,PAnsichar(settings.ReadString('Server','Titel','')));

  ForceforegroundWindow(wnd2);

  t.Length:=SizeOf(TWindowPlacement);
  GetWindowPlacement(wnd2,@t);
  x:= t.rcNormalPosition.Left;
  y:= t.rcNormalPosition.top;
  x1:= t.rcNormalPosition.right;
  y1:= t.rcNormalPosition.bottom;


  if not ansicontainstext(hauptfenster.prog,'smartsurfer') then
  begin
    wnd2 := FindWindowEx2(wnd2,'TPanel', 2);
    wnd2 := FindWindowEx2(wnd2,'TListView', 2);
  end
  else  //Smartsurfer
  begin
  wnd2 := FindWindowEx(wnd2, 0, 'SysListView32', nil);
  end;

   p.Length:=SizeOf(TWindowPlacement);
   GetWindowPlacement(wnd2,@p);
   SendMessage(Wnd2, bm_click, 0,0);
   PostMessage(Wnd2, wm_KeyDown, vk_down,0);
   PostMessage(Wnd2, wm_KeyUp, vk_down,0);
   sleep(500);
    Image1.Picture.Bitmap := GetScreenShot(x,y,x1,y1);
   savetofile;
  except
     if not hauptfenster.webzugriff then showmessage('Konnte Befehl nicht ausführen.');
  end;
end;

procedure Tscreenshot.BitBtn3Click(Sender: TObject);
 var p, t:TWindowPlacement;
     x,y, x1, y1: integer;
     wnd2: HWND;
begin

  if (not isexerunning(hauptfenster.prog) and not isexerunning('_'+hauptfenster.prog)) then
  begin
   bitbtn1.Enabled:= false;
   bitbtn2.Enabled:= false;
   bitbtn3.Enabled:= false;
   exit;
  end;

try
  wnd2 := FindWindow(nil,PAnsichar(settings.ReadString('Server','Titel','')));

  forceforegroundwindow(wnd2);
  t.Length:=SizeOf(TWindowPlacement);
  GetWindowPlacement(wnd2,@t);
  x:= t.rcNormalPosition.Left;
  y:= t.rcNormalPosition.top;
  x1:= t.rcNormalPosition.right;
  y1:= t.rcNormalPosition.bottom;

  if not ansicontainstext(hauptfenster.prog,'smartsurfer') then
  begin
   wnd2 := FindWindowEx2(wnd2,'TPanel', 2);
   wnd2 := FindWindowEx2(wnd2,'TListView', 2);
  end
  else  //Smartsurfer
  begin
  wnd2 := FindWindowEx(wnd2, 0, 'SysListView32', nil);
  end;

   p.Length:=SizeOf(TWindowPlacement);
   GetWindowPlacement(wnd2,@p);
   SendMessage(Wnd2, bm_click, 0,0);
   PostMessage(Wnd2, wm_KeyDown, vk_up,0);
   PostMessage(Wnd2, wm_KeyUp, vk_up,0);
   sleep(500);
   Image1.Picture.Bitmap := GetScreenShot(x,y,x1,y1);
   savetofile;
except
 if not hauptfenster.webzugriff then showmessage('Konnte Befehl nicht ausführen.');
end;
end;

procedure Tscreenshot.BitBtn1Click(Sender: TObject);
 var  wnd2: HWND;
begin
  if (not isexerunning(hauptfenster.prog) and not isexerunning('_'+hauptfenster.prog)) then
  begin
   bitbtn1.Enabled:= false;
   bitbtn2.Enabled:= false;
   bitbtn3.Enabled:= false;
   exit;
  end;

try
  wnd2 := FindWindow(nil,PAnsichar(settings.ReadString('Server','Titel','')));

  if not ansicontainstext(hauptfenster.prog,'smartsurfer') then
  begin
  if isexerunning(hauptfenster.prog) then //neue Beta
  begin
    wnd2 := FindWindowEx2(wnd2,'TPanel', 2);
    wnd2 := FindWindowEx2(wnd2,'TButton', 5);
  end;
  end
  else  //Smartsurfer
  begin
  wnd2 := FindWindowEx2(wnd2,'Button', 4);
  end;

  sendMessage(Wnd2, bm_click, 0,0);
except
 if not hauptfenster.webzugriff then showmessage('Konnte Befehl nicht ausführen.');
end;
end;

procedure Tscreenshot.TrackBar1Change(Sender: TObject);
begin
screenshot.alphablendvalue:= trackbar1.Position;
end;

procedure Tscreenshot.shotClick(Sender: TObject);
 var p, t:TWindowPlacement;
     x,y, x1, y1: integer;
     wnd2: HWND;
begin
  if (isexerunning('_'+hauptfenster.prog)) or (isexerunning(hauptfenster.prog))
  then
  begin askedclose(Pansichar(settings.ReadString('Server','Titel',''))); sleep(3000) end;

  if ( (not isexerunning('_'+hauptfenster.prog)) and (not isexerunning(hauptfenster.prog)))
  then
  begin hauptfenster.oleco.click; sleep(3000) end;

  try
  wnd2:= FindWindow(nil,PAnsichar(settings.ReadString('Server','Titel','')));

  ForceforegroundWindow(wnd2);

  t.Length:=SizeOf(TWindowPlacement);
  GetWindowPlacement(wnd2,@t);
  x:= t.rcNormalPosition.Left;
  y:= t.rcNormalPosition.top;
  x1:= t.rcNormalPosition.right;
  y1:= t.rcNormalPosition.bottom;

  p.Length:=SizeOf(TWindowPlacement);
  GetWindowPlacement(wnd2,@p);
  sleep(100);
  Image1.Picture.Bitmap := GetScreenShot(x,y,x1,y1);
  savetofile;

  bitbtn1.Enabled:= true;
  bitbtn2.Enabled:= true;
  bitbtn3.Enabled:= true;
  except
   if not hauptfenster.webzugriff then showmessage('Konnte Befehl nicht ausführen.');
  end;
end;

procedure Tscreenshot.FormClose(Sender: TObject; var Action: TCloseAction);
begin
askedclose(PAnsichar(settings.ReadString('Server','Titel','')));
hauptfenster.Tray.ShowMainForm;
screenshot.Release;
screenshot:= nil;
end;

end.
