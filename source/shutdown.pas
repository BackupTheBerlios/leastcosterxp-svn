unit shutdown;

interface

uses
  Windows;

type
  TShutdownWindowsType = (swtShutdown, swtShutdownPowerOff, swtRestart, swtLogoff);

function ShutdownWindows (aType: TShutdownWindowsType): Boolean;
function IsWinNT: boolean;
procedure CheckSystemPowerState;
procedure SetStandBy(SetStandBy: boolean);

{...}

implementation
var
  IsHibernate: boolean = false;
  IsStandBy: boolean = false;

function ShutdownWindows (aType: TShutdownWindowsType): Boolean;
const
  cSE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
  cFlagValue: Array [TShutdownWindowsType] Of UINT = (
      EWX_SHUTDOWN, EWX_SHUTDOWN or EWX_POWEROFF, EWX_REBOOT, EWX_LOGOFF
    );

var
  OSVersionInfo: TOSVersionInfo;
  hToken: THandle;
  hProcess: THandle;
  TokenPriv: TTokenPrivileges;
  ReturnLength: DWORD;

begin
  Result := False;

  // Die Windowsversion holen
  OSVersionInfo.dwOSVersionInfoSize := SizeOf (OSVersionInfo);
  if not GetVersionEx (OSVersionInfo) then
    Exit;

  // Prüfen ob Windows NT
  if OSVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT then
    begin
      hProcess := GetCurrentProcess;
      if not OpenProcessToken (hProcess, TOKEN_ADJUST_PRIVILEGES, hToken) then
        Exit;

      if not LookupPrivilegeValue (nil, cSE_SHUTDOWN_NAME, TokenPriv.Privileges[0].Luid) then
        Exit;

      TokenPriv.PrivilegeCount := 1;
      TokenPriv.Privileges [0].Attributes := SE_PRIVILEGE_ENABLED;

      if not AdjustTokenPrivileges (
          hToken, False, TokenPriv, 0,
          PTokenPrivileges (nil)^, ReturnLength
        )
      then
        Exit;

      CloseHandle (hToken);
    end;

  ShutdownWindows := ExitWindowsEx (cFlagValue [aType], $FFFFFFFF);
end;

function IsWinNT: boolean;
var
  OSVersion: TOSVersionInfo;
begin
  Result := false;
  OSVersion.dwOSVersionInfoSize := sizeof(TOSVersionInfo);
  if GetVersionEx(OSVersion) then
    Result := (OSVersion.dwPlatformId = VER_PLATFORM_WIN32_NT);
end;

procedure CheckSystemPowerState;
type
  TIsCheckFkt = function: boolean; stdcall;
var
  hDll: THandle;
  IsCheckFkt: TIsCheckFkt;
begin
  hDll := LoadLibrary('PowrProf.dll');
  if hDll <> 0 then
  begin
    @IsCheckFkt := GetProcAddress(hDll, 'IsPwrHibernateAllowed');
    if assigned(IsCheckFkt) then
      IsHibernate := IsCheckFkt;
    @IsCheckFkt := GetProcAddress(hDll, 'IsPwrSuspendAllowed');
    if assigned(IsCheckFkt) then
      IsStandBy := IsCheckFkt;
  end;
end;


// Setstandby(False) -> Hibernate
// Setstandby(true) -> StandBy
procedure SetStandBy(SetStandBy: boolean);
var
  TokenPriv: TTokenPrivileges;
  TokenHandle: THandle;
  CurrentProc: THandle;
  Len: Cardinal;
begin
  CheckSystemPowerState;

  // WinNT, 2000, XP need the SE_SHUTDOWN_NAME privilege
  if IsWinNT then
  begin
    // determine the actual Process
    CurrentProc := GetCurrentProcess;

    // get process token for privileges
    if OpenProcessToken(CurrentProc, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
                        TokenHandle) then
    begin
      // returns the system-id of the privilege
      if LookupPrivilegeValue(nil, 'SeShutdownPrivilege',
                              TokenPriv.Privileges[0].LUID) then
      begin
        TokenPriv.PrivilegeCount := 1;
        TokenPriv.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

        // here y try to get the privilege
        if AdjustTokenPrivileges(TokenHandle, False, TokenPriv, 0, nil, Len) then
        begin
          if (SetStandBy = false) and IsHibernate then
            // and then y can got to StandBy or Hibernate
            // (first parameter = True => StandBy, False => Hibernate)
            SetSystemPowerState(SetStandBy, False);
          if SetStandBy and IsStandBy then
            // and then y can got to StandBy or Hibernate
            // (first parameter = True => StandBy, False => Hibernate)
            SetSystemPowerState(SetStandBy, False);
        end;
      end;
    end;
  end
  else
    if IsStandBy then
      // Win95/98/Me dont need Privileges and dont support hibernating
      SetSystemPowerState(False, False);
end;


end.
