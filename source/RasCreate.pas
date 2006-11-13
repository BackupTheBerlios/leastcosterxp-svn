unit RAScreate;

interface

uses SysUtils, Rasmanager,ras,windows;

function Connectionexists: boolean;
procedure set_entry_params(var entry: TRasEntry; Rufnummer,modemname,modemtype, modemstring: String);
function CreateRasEntry: boolean;

implementation

function Connectionexists: boolean;
var i : integer;
    erg: boolean;
    checkras: Trasmanager;
begin
erg:= false;
checkras:= TrasManager.Create(nil);
try
if checkras.Count>0 then
begin
for i:= 0 to checkras.count-1 do
if checkras.Name[i] = 'LeastCosterXP' then begin erg:= true;end;
end
else erg:= false;

Connectionexists:= erg;
finally
checkras.Free;
end;
end;

procedure set_entry_params(var entry: TRasEntry; Rufnummer,modemname,modemtype, modemstring: String);
begin
with entry do
   begin

    dwfOptions := dwfOptions or RASEO_IpHeaderCompression;
    dwfOptions := dwfOptions or RASEO_RemoteDefaultGateway;
    dwfOptions := dwfOptions or RASEO_SwCompression;
    dwfOptions := dwfOptions or RASEO_ModemLights;

    StrPCopy(szLocalPhoneNumber, modemstring+Rufnummer);

    {// a little shortcut.. :)
    dwFramingProtocol := 1 shl optFraming.ItemIndex;
    if optFraming.ItemIndex = 1 then  // SLIP
      dwFrameSize := StrToInt(txtFrameSize.Text);}
    {if chkIP.Checked then
      begin
      ipaddr := string_to_ip(txtIpAddr.Text);
      ipaddrDns := string_to_ip(txtPrimaryDNS.Text);
      ipaddrDnsAlt := string_to_ip(txtSecondaryDNS.Text);
      ipaddrWins := string_to_ip(txtPrimaryWINS.Text);
      ipaddrWinsAlt := string_to_ip(txtSecondaryWINS.Text);
      end;
    StrPCopy(szScript, txtScript.Text);}

    dwfNetProtocols := dwfNetProtocols or RASNP_Ip; //TCP/Ip-Protocol
    dwFramingProtocol := RASFP_Ppp;   //PPP-Protocol
    // hier modem Einstellen
    StrPCopy(szDeviceName, modemname);
    StrPCopy(szDeviceType, modemtype);
   end;
end;

function CreateRasEntry: boolean;
var
    entry: TRasEntry;
    name: string;
begin
    name:= 'LeastCosterXP';
    FillChar(entry, SizeOf(TRasEntry), 0);
    entry.dwSize := SizeOf(TRasEntry);
    set_entry_params(entry,'0','','','');
    if RasSetEntryProperties(nil, PChar(name),
        @entry, SizeOf(TRasEntry), nil, 0) <> 0 then
    CreateRasEntry:= false else CreateRasEntry:= true;
end;

end.
