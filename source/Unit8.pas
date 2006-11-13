unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, ValEdit, StdCtrls, Buttons;

type
  TCtrlnfo = class(TForm)
    ValueListEditor1: TValueListEditor;
    Caption: TLabel;
    Panel1: TPanel;
    Butclose: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ctrlnfo: TCtrlnfo;

implementation

uses Unit1;

{$R *.dfm}

procedure TCtrlnfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
hauptfenster.ctrlcount:=0;
Ctrlnfo.Release;
Ctrlnfo:= nil;
end;

procedure TCtrlnfo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
ctrlnfo.close;
end;

end.
