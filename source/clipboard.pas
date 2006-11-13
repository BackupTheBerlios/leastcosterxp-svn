unit clipboard;

interface
procedure SendToClipBrd(text: string);
function GetfromClipBrd: string;

implementation
uses Clipbrd;

procedure SendToClipBrd(text: string);
var Clipboard: TClipboard;
begin
Clipboard:= TClipboard.Create;
Clipboard.Open;
Clipboard.Clear;
Clipboard.AsText := text;
Clipboard.Close;
Clipboard.Free;
end;

function GetfromClipBrd: string;
var Clipboard: TClipboard;
begin
Clipboard:= TClipboard.Create;
Clipboard.Open;
Result:= ClipBoard.AsText;
Clipboard.Close;
ClipBoard.Free;
end;

end.

