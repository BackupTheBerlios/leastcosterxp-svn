unit addons;

interface
uses TlHelp32,SysUtils, WinProcs, Messages, forms, WinInet, winsock, strutils, windows,
{Verknüpfung anlegen}ShlObj, ActiveX ,ComObj, shellapi;

type
    TName = array[0..100] of Char;
    PName = ^TName;
    
function GetWinVersion: string;
function KeyPressed(Key: Integer): Boolean;
procedure ShowTaskbar(Handle: THandle);
procedure HideTaskbar(Handle: THandle);
procedure ForceForegroundWindow(hwnd: THandle);

function GetLocalIPs: string;

function InternetIP(var sHostName, sIPAddr, sWSAError: string): Boolean;

function IsDSLOnline: boolean;

Procedure AskedClose(Progname: PAnsiChar);
{Programmnamen übergeben}

function KillTask(const AExeName: string): boolean;
{Aufruf mit
 if not KillTask('Project2.exe') then
    Showmessage('Prozess konnte nicht beendet werden.');}

function IsExeRunning(const AExeName: string): boolean;

function CreateLink(const AFilename, ALNKFilename, ADescription: String) : Boolean;

function DelDir(Dir : String) : Boolean;

procedure Quick_Sort(var A: array of Integer);

implementation

function GetWinVersion: string;
begin
  result:='unknown';
  case Win32Platform of
    1:// 9x-Reihe
      If Win32MajorVersion=4 Then Begin
        Case Win32MajorVersion of
            0: result:='Windows 95';
            10: result:='Windows 98';
            90: result:='Windows Me';
        end;
      end;
  2: // NT-Reihe
     Case Win32MajorVersion of
         3:IF Win32MinorVersion=51 then
              result:='Windows NT 3.51';
         4:If Win32MinorVersion=0 then
             result:='Windows NT 4';
         5:Case Win32MinorVersion of
              0: result:='Windows 2000';
              1: result:='Windows XP';
              2: result:='Windows .NET Server';
           end;
     End;
  end;
  //Win32CSDVersion enthält Informationen zu Servicepacks
  if Win32CSDVersion<>'' then
    result:=result+' '+Win32CSDVersion;
end;


function KeyPressed(Key: Integer): Boolean;
begin
  Result:=GetKeyState(Key)<0;
end;


procedure ShowTaskbar(Handle: THandle);
var
  hwndOwner: HWnd;
begin
  hwndOwner := GetWindow(Handle, GW_OWNER);
  ShowWindow(hwndOwner, SW_NORMAL);
end ;

procedure HideTaskbar(Handle: THandle);
var
  hwndOwner: HWnd;
begin
  hwndOwner := GetWindow(Handle, GW_OWNER);
  ShowWindow(hwndOwner, SW_HIDE);
end ;


procedure ForceForegroundWindow(hwnd: THandle);
  begin
   BringWindowToTop(hwnd);
   SetForegroundWindow(hwnd);
   SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
   SetActiveWindow(hwnd);
  end;

function GetLocalIPs: string;
type
  PPInAddr = ^PInAddr;
var
  wsadata  : TWSAData;
  hostinfo : PHostEnt;
  addr     : PPInAddr;
begin
  Result   := '';

  if(WSAStartUp(MAKEWORD(1,1),wsadata) = 0) then
  try
    hostinfo := gethostbyname(nil);
    if(hostinfo <> nil) then begin
      addr   := pointer(hostinfo^.h_addr_list);

      while(addr^ <> nil) do begin
        Result := Result + inet_ntoa(addr^^) + ';';{^M^J;}
        inc(addr);
      end;
    end;
  finally
     WSACleanUp;
     if not ansicontainsstr(result,'127.0.0.1;') then result:= result + '127.0.0.1;'
  end;
end;


function InternetIP(var sHostName, sIPAddr, sWSAError: string): Boolean;
var
   HEnt: pHostEnt;
   HName: PName;
   WSAData: TWSAData;
   iCnt: Integer;
begin
     Result := False;
     // Initialisiert die Verbindung zur Winsock DLL
     if WSAStartup($0101, WSAData) <> 0 then
     begin
          sWSAError := 'WSAStartup error';
          Exit;
     end;
     sHostName := '';
     sIPAddr := '';
     sWSAError := '';
     New(HName);
     // Loklen Hostnamen ermitteln
     if GetHostName(HName^, SizeOf(TName)) = 0 then
     begin
          Result := True;
          sHostName := StrPas(HName^);
          // Hostname -> IP-Adresse
          HEnt := GetHostByName(HName^);
          for iCnt := 0 to HEnt^.h_length - 1 do
              sIPAddr := sIPAddr + IntToStr(Ord(HEnt^.h_addr_list^[iCnt])) + '.';
          SetLength(sIPAddr, Length(sIPAddr) - 1);
     end
     else
     begin
          case WSAGetLastError of
               WSAEFAULT        : sWSAError := 'WSAEFault';
               WSANOTINITIALISED: sWSAError := 'WSANotInitialised';
               WSAENETDOWN      : sWSAError := 'WSAENetDown';
               WSAEINPROGRESS   : sWSAError := 'WSAEInProgress';
          end;
     end;
     Dispose(HName);
     // Verbindung zur Winsock DLL trennen
     WSACleanup;
end;


function IsDSLOnline: boolean;
begin
  IsDSLOnline:=InternetGetConnectedState(nil, 0);
end;

 
Procedure AskedClose(Progname: PAnsichar);
begin
SendMessage(FindWindow(nil,Progname),WM_CLOSE,0,0);
end;

function KillTask(const AExeName: string): boolean;
var
  p: TProcessEntry32;
  h: THandle;
begin
  Result := false;
  p.dwSize := SizeOf(p);
  h := CreateToolHelp32Snapshot(TH32CS_SnapProcess, 0);
  try
    if Process32First(h, p) then
      repeat
        if AnsiLowerCase(p.szExeFile) = AnsiLowerCase(AExeName) then
          Result := TerminateProcess(OpenProcess(Process_Terminate,
                                                 false,
                                                 p.th32ProcessID),
                                     0);
      until (not Process32Next(h, p)) or Result;
  finally
    CloseHandle(h);
  end;
end;

function IsExeRunning(const AExeName: string): boolean;
var
  h: THandle;
  p: TProcessEntry32;
begin
  Result := False;

  p.dwSize := SizeOf(p);
  h := CreateToolHelp32Snapshot(TH32CS_SnapProcess, 0);
  try
    Process32First(h, p);
    repeat
      Result := AnsiUpperCase(AExeName) = AnsiUpperCase(p.szExeFile);
    until Result or (not Process32Next(h, p));
  finally
    CloseHandle(h);
  end;
  isexerunning:= result;
end;

function CreateLink(const AFilename, ALNKFilename, ADescription: String) : Boolean;
var
  psl : IShellLink;
  ppf : IPersistFile;
  wsz : PWideChar;
begin
  result:=false;
  if SUCCEEDED(CoCreateInstance(CLSID_ShellLink, nil,
  CLSCTX_inPROC_SERVER, IID_IShellLinkA, psl)) then
  begin
    psl.SetPath(PChar(AFilename));
    psl.SetDescription(PChar(ADescription));
    psl.SetWorkingDirectory(PChar(ExtractFilePath(AFilename))) ;

    if SUCCEEDED(psl.QueryInterface(IPersistFile, ppf)) then
    begin
      GetMem(wsz, MAX_PATH*2);
      try
        MultiByteToWideChar(CP_ACP, 0, PChar(ALNKFilename), -1, wsz, MAX_PATH);
        ppf.Save(wsz, true);
        result:=true;
      finally
        FreeMem(wsz, MAX_PATH*2);
      end;
    end;
  end;
end;

function DelDir(Dir : String) : Boolean;
var
 FileOption : TSHFileOpStruct;
begin
 ZeroMemory(@FileOption,SizeOf(FileOption));
 with FileOption do
 begin
   wFunc := FO_DELETE;
   fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
   pFrom := PChar(Dir + #0);
 end;
 Result := (ShFileOperation(FileOption) = 0);
end;

procedure Quick_Sort(var A: array of Integer);

 procedure QuickSort(var A: array of Integer; iLo, iHi: Integer);
 var
   Lo, Hi, Mid, T: Integer;
 begin
   Lo := iLo;
   Hi := iHi;
   Mid := A[(Lo + Hi) div 2];
   repeat
     while A[Lo] < Mid do Inc(Lo);
     while A[Hi] > Mid do Dec(Hi);
     if Lo <= Hi then
     begin
       T := A[Lo];
       A[Lo] := A[Hi];
       A[Hi] := T;
       Inc(Lo);
       Dec(Hi);
     end;
   until Lo > Hi;
   if Hi > iLo then QuickSort(A, iLo, Hi);
   if Lo < iHi then QuickSort(A, Lo, iHi);
 end;

begin
 QuickSort(A, Low(A), High(A));
end;

end.
