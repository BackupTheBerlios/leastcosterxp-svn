unit getip;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TIPForm = class(TForm)
    GetData: TButton;
    Memo: TMemo;
    procedure GetDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IPForm: TIPForm;

implementation

uses winsock;

{$R *.DFM}

//
// Die Orginalroutine wurde mir freundlicherweise von Danny Kellett
// (DannyKellett@Hotmail.com) zur Verfügung gestellt.
//

// Benötigte Typ-Deklarationen
type
    TName = array[0..100] of Char;
    PName = ^TName;

// Diese Funktion ermittelt den Hostnamen des aktuellen Rechners und die
// IP-Adresse, die der Rechner hat, wenn er mit dem Internet verbunden ist
// (also die IP-Adresse, die dem DFÜ Dial-Up Adapter zugewiesen ist), bzw.
// wenn er nicht mit dem Internet verbunden ist die IP-Adresse einer
// installierten Netzwerkkarte
//
// VAR-Rückgabewerte:
// sHostName: Hostname
// sIPAddr  : IP-Adresse
// sWSAError: Fehlermeldung
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

procedure TIPForm.GetDataClick(Sender: TObject);
var
   shost, sip, serror : string;
begin
     Memo.Lines.Clear;
     InternetIP(shost, sip, serror);
     if sip= '192.168.0.1' then Memo.Lines.Add('Offline');
     Memo.Lines.Add('Hostname: '+shost);
     Memo.Lines.Add('IP-Adresse: '+sip);
     if serror<>'' then Memo.Lines.Add('Fehlermeldung: '+serror);
end;

end.
