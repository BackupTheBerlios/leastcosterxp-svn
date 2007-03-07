unit tools;
interface
uses windows;

procedure AlwaysOnTop(handle : hwnd; left, top, width, height: integer; bAlwaysOnTop: Boolean);

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

end.
