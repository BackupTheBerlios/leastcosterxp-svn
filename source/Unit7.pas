unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, AppEvnts, unit1, DateUtils, StrUtils;

type
  TPriceWarning = class(TForm)
    neu1: TLabel;
    neu2: TLabel;
    close: TBitBtn;
    info2: TLabel;
    Image1: TImage;
    ApplicationEvents: TApplicationEvents;
    trennen: TBitBtn;
    trennen2: TBitBtn;
    Panel1: TPanel;
    Timer1: TTimer;
    time: TStaticText;
    info1: TLabel;
    info3: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    neu3: TLabel;
    info4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure trennenClick(Sender: TObject);
    procedure trennen2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
     procedure WMNCHitTest(var M: TWMNCHitTest); 
        message wm_NCHitTest;
  public
    { Public declarations }
  end;

var
  PriceWarning: TPriceWarning;

implementation

{$R *.dfm}

procedure TPriceWarning.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
pricewarning.Release;
pricewarning:= nil;
end;

procedure TPriceWarning.ApplicationEventsDeactivate(Sender: TObject);
begin
pricewarning.BringToFront;
end;

procedure TPricewarning.WMNCHitTest (var M: TWMNCHitTest);
begin
  inherited;
  if M.Result = htClient then
    M.Result := htCaption;
end;

procedure TPriceWarning.trennenClick(Sender: TObject);
begin
hauptfenster.disconnect;
Pricewarning.close.Click;
end;

procedure TPriceWarning.trennen2Click(Sender: TObject);
begin
//trennen auf jeden Fall aktivieren
hauptfenster.AutoDiscLED.LedOn:= true;

if hauptfenster.onlineset.vbegin <> hauptfenster.onlineset.vend then
begin
        //wenn das Ende (zeitlich) noch in der Zukunft liegt, aber heutiges Datum hat
        if (dateof(now) + timeof(hauptfenster.onlineset.vend) > now) then
                hauptfenster.trennticker.datetime:= dateof(now) + timeof(hauptfenster.onlineset.vend)
        // wen Datumsgrenze überschritten wird
           else
           if ansicontainstext(hauptfenster.onlineset.tag, Hauptfenster.Stringvonmorgen(now)) then
            hauptfenster.trennticker.datetime:= incday(Dateof(now) + timeof(hauptfenster.onlineset.vend),1)
           else
            hauptfenster.trennticker.datetime:= incday(Dateof(now) + TimeOf(EncodeTime(0,0,0,0)),1);

        hauptfenster.Autodiscled.ledon:= true;
end
else //wenn ganztags
begin
 //wenn nicht der String von morgen enthalten ist
 if not ansicontainstext(hauptfenster.onlineset.tag, hauptfenster.Stringvonmorgen(now)) then
   hauptfenster.trennticker.datetime:= dateof(tomorrow) + TimeOf(hauptfenster.onlineset.vend)
 else
 hauptfenster.Autodiscled.ledon:= false;
end;

Pricewarning.close.Click;
end;

procedure TPriceWarning.FormCreate(Sender: TObject);
begin
     hauptfenster.warnung_gezeigt:= true;
     hauptfenster.warnung_unterdruecken.enabled:= true;
end;

procedure TPriceWarning.Timer1Timer(Sender: TObject);
begin
timer1.enabled:= false;
if not isonline then close.Click;
timer1.tag:= timer1.tag-1;
time.Caption:= inttostr(timer1.tag);
if timer1.tag = 0 then
begin
 if trennen2.visible then trennen2.click else close.Click;
end;
timer1.enabled:= true;
end;

end.
