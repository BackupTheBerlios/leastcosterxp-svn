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
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  CallIn: TCallIn;

implementation

{$R *.dfm}

procedure TCallIn.FormShow(Sender: TObject);
begin
  CallIn.Left := Screen.Width - CallIn.Width;
  CallIn.Top  := Screen.Height - CallIn.Height - 30;
end;

procedure TCallIn.BitBtn1Click(Sender: TObject);
begin
CallIn.Hide;
end;

end.
