unit tools;
interface
uses windows;

procedure AlwaysOnTop(handle : hwnd; left, top, width, height: integer; bAlwaysOnTop: Boolean);
function encode(text, key: String):String;
function decode(text, key: String):String;

implementation

procedure AlwaysOnTop(handle : hwnd; left, top, width, height: integer; bAlwaysOnTop: Boolean);
begin

 if bAlwaysOnTop then
   SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width,Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
 else
   SetWindowPos(Handle, HWND_NOTOPMOST,Left, Top, Width,Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

 //caption ausschalten
 SetWindowLong(Handle, GWL_STYLE, GetWindowLong(handle, GWL_STYLE) and not WS_CAPTION);
end;

function encode(text, key: String):String;
var i,keypos:integer;
begin
  keypos:=1;
  for i:=1 to length(text) do
  begin
    Result:=Result+char(byte(ord(text[i])+ord(key[keypos])));
    inc(keypos);
    if keypos > length(key) then
      keypos:=1;
  end;
end;

function decode(text, key: String):String;
var i,keypos:integer;
begin
  keypos:=1;
  for i:=1 to length(text) do
  begin
    Result:=Result+char(byte(ord(text[i])-ord(key[keypos])));
    inc(keypos);
    if keypos > length(key) then
      keypos:=1;
  end;
end;


end.
