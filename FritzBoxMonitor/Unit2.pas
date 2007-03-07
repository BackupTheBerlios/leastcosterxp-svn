unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TCallIn = class(TForm)
    Calltype: TLabel;
    info2: TLabel;
    info3: TLabel;
    info4: TLabel;
    Bevel1: TBevel;
    Date: TLabel;
    BitBtn1: TBitBtn;
    topbox: TCheckBox;
    procedure topboxClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
     procedure CreateParams(var Params : TCreateParams); override;
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

procedure TCallIn.FormShow(Sender: TObject);
var h              : HWnd;
    Taskbar        : TRect;
    Twidth, THeight: integer;
    reverseAdress  : string;
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

//  CallIn.Left := Screen.Width - CallIn.Width;
//  CallIn.Top  := Screen.Height - CallIn.Height - 30;
  AlwaysOnTop(Callin.Handle,callin.Left,callin.top, callin.width, callin.height, true);

   reverseAdress := sett.ReadString('FritzBox','reverse', '');
   if reverseAdress <> '' then
    if (Call <> '') and (Call = info2.caption) then
     begin
      reverseAdress:= AnsiReplaceStr(reverseAdress, '%NUMBER%',CALL);
      Shellexecute( handle, nil, Pchar(reverseadress), nil, nil, SW_SHOWMaximized);
     end;
end;

procedure TCallIn.BitBtn1Click(Sender: TObject);
begin
CallIn.Hide;
end;

procedure TCallIn.topboxClick(Sender: TObject);
begin
  AlwaysOnTop(Callin.Handle, callin.Left,callin.top, callin.width, callin.height, topbox.Checked);
end;
end.
