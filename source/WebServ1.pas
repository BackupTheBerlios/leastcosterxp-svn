unit WebServ1;

{$I ICSDEFS.INC}
{$B-}                 { Enable partial boolean evaluation   }
{$T-}                 { Untyped pointers                    }
{$X+}                 { Enable extended syntax              }
{$I+}                 { Turn IO exceptions to on            }
{$IFDEF COMPILER2_UP} { Not for Delphi 1                    }
    {$H+}             { Use long strings                    }
    {$J+}             { Allow typed constant to be modified }
{$ENDIF}
{$IFDEF DELPHI6_UP}
    {$WARN SYMBOL_PLATFORM   OFF}
    {$WARN SYMBOL_LIBRARY    OFF}
    {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, Forms,dialogs,
  {$IFDEF DELPHI7_UP}
  StrUtils,
  {$ENDIF}
  IniFiles, StdCtrls, ExtCtrls, WinSock, WSocket, WSocketS, HttpSrv,
  Buttons, CHCrypt, {CHPanel,jpeg,} DateUtils, icsMD5;

const
  WebServVersion     = 109;
  NO_CACHE           = 'Pragma: no-cache' + #13#10 + 'Expires: -1' + #13#10;

type
  { This component is used for client connection instead of default one.    }
  { This enables adding any data we need to handle our application.         }
  { As this data is located in client component, each connected client has  }
  { his own private data.                                                   }
  TMyHttpConnection = class(THttpConnection)
  protected
    FPostedDataBuffer : PChar;     { Will hold dynamically allocated buffer }
    FPostedDataSize   : Integer;   { Databuffer size                        }
    FDataLen          : Integer;   { Keep track of received byte count.     }
    FDataFile         : TextFile;  { Used for datafile display              }
  public
    destructor  Destroy; override;
  end;

  { This is the main form for our application. Any data here is global for  }
  { all clients. Put private data in TMyHttpConnection class (see above).   }
  TWebServForm = class(TForm)
    HttpServer1: THttpServer;
    ToolsPanel: TPanel;
    Label3: TLabel;
    ClientCountLabel: TLabel;
    Label5: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    PortEdit: TEdit;
    Panel2: TPanel;
    username: TEdit;
    pw: TEdit;
    pw2: TEdit;
    userbox: TComboBox;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    oldpw: TEdit;
    Label4: TLabel;
    loeschen: TBitBtn;
    Timer1: TTimer;

    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HttpServer1GetDocument(Sender, Client: TObject;
      var Flags: THttpGetFlag);
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure HttpServer1ClientConnect(Sender: TObject;
      Client: TObject; Error: Word);
    procedure HttpServer1ClientDisconnect(Sender: TObject;
      Client: TObject; Error: Word);
    procedure HttpServer1ServerStarted(Sender: TObject);
    procedure HttpServer1ServerStopped(Sender: TObject);
    procedure HttpServer1HeadDocument(Sender, Client: TObject;
      var Flags: THttpGetFlag);
    procedure HttpServer1PostedData(Sender: TObject;
      Client: TObject; Error: Word);
    procedure HttpServer1PostDocument(Sender, Client: TObject;
      var Flags: THttpGetFlag);
    procedure FormDestroy(Sender: TObject);
    procedure userboxChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure loeschenClick(Sender: TObject);
    procedure logfile_add(buf: string);
    procedure Timer1Timer(Sender: TObject);

   private

    FCountRequests : Integer;

    procedure CreateVirtualDocument_index(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_links(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_aktiv(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_unten(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_shutdown(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_shutdown1(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_DisableAutoDial(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_logout(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_MyIP(Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_basetime(
                                         Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_postmessage(
                                         Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_disconnect(
                                         Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_down(
                                         Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_up(
                                         Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_dial(
                                         Sender    : TObject;
                                         ClientCnx : TMyHttpConnection;
                                         var Flags : THttpGetFlag);
    procedure CreateVirtualDocument_ViewFormData(Sender    : TObject;
                                                 ClientCnx : TMyHttpConnection;
                                                 var Flags : THttpGetFlag);
    procedure FormDataGetRow(Sender          : TObject;
                             const TableName : String;
                             Row             : Integer;
                             TagData         : TStringIndex;
                             var More        : Boolean;
                             UserData        : TObject);

    procedure ProcessPostedData_FormHandler(ClientCnx : TMyHttpConnection);
    procedure ProcessPostedData_goonline(ClientCnx : TMyHttpConnection);
    procedure ProcessPostedData_goonline2(ClientCnx : TMyHttpConnection);
    procedure ProcessPostedData_LeastCosterDial(ClientCnx : TMyHttpConnection);
    procedure ProcessPostedData_sendmessage(ClientCnx : TMyHttpConnection);
    procedure ProcessPostedData_deletemessage(ClientCnx : TMyHttpConnection);
    procedure delete(Verzeichnis: string);
    procedure filluserbox;


  public
     crypter: TCHCrypt;
 end;

var
  WebServForm: TWebServForm;
  status:string;
  servertime: string;

implementation

uses screen, Unit1,CoolTrayIcon,  Unit4;

{$R *.DFM}

const
    { IniFile layout for persistent data }
    SectionWindow      = 'WindowMain';
    KeyTop             = 'Top';
    KeyLeft            = 'Left';
    KeyWidth           = 'Width';
    KeyHeight          = 'Height';
    SectionData        = 'Config';
    KeyDocDir          = 'DocDir';
    KeyDefaultDoc      = 'DefaultDoc';
    KeyTemplateDir     = 'TemplateDir';
    KeyPort            = 'Port';
    KeyDisplayHeader   = 'DisplayHeader';
    KeyLogToFile       = 'LogToFile';
    KeyDirList         = 'AllowDirList';
    KeyOutsideRoot     = 'AllowOutsideRoot';
    KeyRedirUrl        = 'RedirURL';

var allowedip: string;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{$IFDEF VER80}
function TrimRight(Str : String) : String;
var
    i : Integer;
begin
    i := Length(Str);
    while (i > 0) and (Str[i] = ' ') do
        i := i - 1;
    Result := Copy(Str, 1, i);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TrimLeft(Str : String) : String;
var
    i : Integer;
begin
    if Str[1] <> ' ' then
        Result := Str
    else begin
        i := 1;
        while (i <= Length(Str)) and (Str[i] = ' ') do
            i := i + 1;
        Result := Copy(Str, i, Length(Str) - i + 1);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function Trim(Str : String) : String;
begin
    Result := TrimLeft(TrimRight(Str));
end;
{$ENDIF}


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{$IFNDEF DELPHI7_UP}
function DupeString(const AText: String; ACount: Integer): String;
var
    P: PChar;
    C: Integer;
begin
    C := Length(AText);
    SetLength(Result, C * ACount);
    P := Pointer(Result);
    if P = nil then
        Exit;
    while ACount > 0 do begin
        Move(Pointer(AText)^, P^, C);
        Inc(P, C);
        Dec(ACount);
    end;
end;
{$ENDIF}


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TWebServForm.FormCreate(Sender: TObject);
begin
httpserver1.tag:= 0;

  crypter := TCHCrypt.Create(Self);
  with crypter do
  begin
    Name := 'crypter';
    Base := 2;
    CryptMode := cmIniExtended;
    CryptChar := ccAll;
    Key1 := 56;
    Key2 := 84;
    Key3 := 23;
    Key4 := 40;
  end;


   //Webinterface automatisch starten
  if settings.ReadBool('Server','Autostart', false) = true then
    begin
      webservform.PortEdit.text:= settings.ReadString('Server','Port','85');
      webservform.StartButton.Click;
     end;
end;



{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TWebServForm.FormDestroy(Sender: TObject);
begin
httpserver1.Stop;
if assigned(crypter) then crypter.free;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TWebServForm.FormShow(Sender: TObject);
var

    wsi     : TWSADATA;
begin

       PortEdit.Text        := '85';

        { Initialize client count caption }
        ClientCountLabel.Caption := '0';
        { Display version info for program and used components }
        wsi := WinsockInfo;

{$IFNDEF DELPHI3}
        { A bug in Delphi 3 makes lpVendorInfo invalid }
        if wsi.lpVendorInfo <> nil then

{$ENDIF}
        { Automatically start server }
        StartButtonClick(Self);

end;


procedure TWebservform.logfile_add(buf: string);
var filename: string;
     stream: TStream;
begin
    FileName := ExtractFilePath(paramstr(0)) + '\www\log\log.txt';
    if FileExists(FileName) then
        Stream := TFileStream.Create(FileName, fmOpenWrite)
    else
        Stream := TFileStream.Create(FileName, fmCreate);
    Stream.Seek(0, soFromEnd);
    Stream.Write(Buf[1], Length(Buf));
    Stream.Destroy;

end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is called when user clicks on start button. It is also }
{ called from FormShow event handler, at program startup. It starts server. }
{ We need to pass default document, document directory and client class     }
{ to HTTP server component. Client class is very usefull because it         }
{ instruct server component to instanciate our own client class instead of  }
{ defualt client class. Using our own client class will enables you to add  }
{ any data we need to handle our application. This data is private for each }
{ client.                                                                   }
{ When server is started, we will get OnServerStarted event triggered.      }
procedure TWebServForm.StartButtonClick(Sender: TObject);
begin
    HttpServer1.DocDir      := Trim(Extractfilepath(paramstr(0))+'www\');
    HttpServer1.DefaultDoc  := Trim('index.htm');
    HttpServer1.Port        := Trim(PortEdit.Text);

    HttpServer1.ClientClass := TMyHttpConnection;
    try
        HttpServer1.Start;
    except
        on E:Exception do begin

            if HttpServer1.WSocketServer.LastError = WSAEADDRINUSE then

            else

        end;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered when user clicks on stop button. We just  }
{ stop the server. We will get OnServerStopped event triggered.             }
procedure TWebServForm.StopButtonClick(Sender: TObject);
begin
   HttpServer1.Stop;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered when HTTP server is started, that is when }
{ server socket has started listening.                                      }
procedure TWebServForm.HttpServer1ServerStarted(Sender: TObject);
var buf: string;
begin
    PortEdit.Enabled            := FALSE;
    StartButton.Enabled         := FALSE;
    StopButton.Enabled          := TRUE;
    httpserver1.Tag:= 5;

    if assigned(Hauptfenster.WebIntLabel) then
    begin
     hauptfenster.WebIntLabel.LinkedAdress:='http://localhost:'+HttpServer1.port +'/login.htm';
     hauptfenster.WebIntLabel.Visible:=true;
    end;

    allowedip:= '';
    servertime:= Datetimetostr(now);
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+'Server gestartet' +#13#10;
    status:= buf;

    { Save data to a text file }
    logfile_add(buf);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered when server has been stopped, that is     }
{ when server socket stop listening.                                        }
procedure TWebServForm.HttpServer1ServerStopped(Sender: TObject);
var buf: string;
begin
    httpserver1.Tag:= 0;

    Usersettings.erasesection('active');
    servertime:= '';

    settings.DeleteKey('server','dialtime');
    settings.DeleteKey('server','dialtimeuser');
    PortEdit.Enabled            := TRUE;
    StartButton.Enabled         := TRUE;
    StopButton.Enabled          := FALSE;

    if assigned(Hauptfenster.WebintLabel) then hauptfenster.WebIntLabel.Visible:=false;
    
    allowedip:= '';


    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+'Server gestoppt' +#13#10;
    status:= buf;

    { Save data to a text file }
    logfile_add(buf);

end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered when a new client has connected.          }
procedure TWebServForm.HttpServer1ClientConnect(
    Sender : TObject;               { HTTP server component                 }
    Client : TObject;               { Client connecting                     }
    Error  : Word);                 { Error in connection                   }
begin
    ClientCountLabel.Caption := IntToStr(HttpServer1.ClientCount);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered when a client is disconnecting, just      }
{ before client component is closed.                                        }
procedure TWebServForm.HttpServer1ClientDisconnect(
    Sender : TObject;               { HTTP server component                 }
    Client : TObject;               { Client connecting                     }
    Error  : Word);                 { Error in disconnection                }
begin
    ClientCountLabel.Caption := IntToStr(HttpServer1.ClientCount - 1);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered when HTTP server component receive a HEAD }
{ command from any client.                                                  }
{ We just count the request, display a message and let HTTP server          }
{ component handle everything.                                              }
{ We should trap every URI we handle internally...                          }
procedure TWebServForm.HttpServer1HeadDocument(
    Sender    : TObject;            { HTTP server component                 }
    Client    : TObject;            { Client connection issuing command     }
    var Flags : THttpGetFlag);      { Tells what HTTP server has to do next }
begin
    Inc(FCountRequests);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function IsDirectory(const Path : String) : Boolean;
var
    SR : TSearchRec;
begin
    if FindFirst(Path, faDirectory or faAnyFile, SR) = 0 then
        Result := ((SR.Attr and faDirectory) <> 0)
    else
        Result := FALSE;
    FindClose(SR);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered when HTTP server component receive a GET  }
{ command from any client.                                                  }
{ We count the request, display a message and trap '/time.htm' path for     }
{ special handling.                                                         }
{ There is no document time.htm on disk, we will create it on the fly. With }
{ a classic webserver we would have used a CGI or ISAPI/NSAPI to achieve    }
{ the same goal. It is much easier here since we can use Delphi code        }
{ directly to generate whatever we wants. Here for the demo we generate a   }
{ page with server data and time displayed.                                 }
procedure TWebServForm.HttpServer1GetDocument(
    Sender    : TObject;            { HTTP server component                 }
    Client    : TObject;            { Client connection issuing command     }
    var Flags : THttpGetFlag);      { Tells what HTTP server has to do next }
var
    ClientCnx  : TMyHttpConnection;
    counter,i: integer;
    ip: string;
    user: string;
begin
    { It's easyer to do the cast one time. Could use with clause... }
    ClientCnx := TMyHttpConnection(Client);
    { Count request and display a message }
    Inc(FCountRequests);
    ip:='';   user:= '';

    counter:= UserSettings.ReadInteger('active','count',0);
    For i:= 1 to counter do
    begin
    ip:= ip + UserSettings.ReadString('active','ip_'+inttostr(i),'');
    end;

    if CompareText(ClientCnx.Path, '/login.htm') = 0 then
        CreateVirtualDocument_index(Sender, ClientCnx, Flags)
    { Trap '/surfen.html' path to dynamically generate a dynamic answer. }
    else

    if CompareText(ClientCnx.Path, '/logout.html') = 0 then
        CreateVirtualDocument_logout(Sender, ClientCnx, Flags)
    else

    {nur authentifizierte User dürfen die folgenden Seiten abrufen}
    //wenn die Ip zur userip passt
    if ansicontainstext(ip,clientcnx.PeerAddr) then

    if CompareText(ClientCnx.Path, '/unten.html') = 0 then
        CreateVirtualDocument_unten(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/links.htm') = 0 then
        CreateVirtualDocument_links(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/aktiv.html') = 0 then
        CreateVirtualDocument_aktiv(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/shutdown.html') = 0 then
        CreateVirtualDocument_shutdown(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/shutdown1.html') = 0 then
        CreateVirtualDocument_shutdown1(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/DisableAutoDial.html') = 0 then
        CreateVirtualDocument_DisableAutoDial(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/basetime.html') = 0 then
        CreateVirtualDocument_basetime(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/message.html') = 0 then
        CreateVirtualDocument_postmessage(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/disconnect.html') = 0 then
        CreateVirtualDocument_disconnect(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/down.html') = 0 then
        CreateVirtualDocument_down(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/up.html') = 0 then
        CreateVirtualDocument_up(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/dial.html') = 0 then
        CreateVirtualDocument_dial(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/view.html') = 0 then
        CreateVirtualDocument_ViewFormData(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/myip.html') = 0 then
        CreateVirtualDocument_MyIP(Sender, ClientCnx, Flags)
end;

procedure TWebServForm.CreateVirtualDocument_index(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
begin
    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>'+
        '<HEAD>' +
        '<TITLE>LeastCoster XP Webserver</TITLE>'+
        '  </HEAD>'+
        '  <BODY>'+
        '   <H2>Bitte geben Sie Usernamen und Passwort ein:</H2>             '+
        '  <FORM METHOD="POST" ACTION="/cgi-bin/LCRXP">'+
        '   <P>'+
        ' <TABLE BORDER="0" ALIGN="DEFAULT">'+
        '  <TR>'+
        '   <TD>User: </TD><TD><INPUT TYPE="TEXT" NAME="User" MAXLENGTH="25"></TD>'+
        ' </TR> '+
        ' <TR>'+
        '   <TD>Passwort: </TD><TD><INPUT TYPE="password" NAME="Passwort" MAXLENGTH="25"></TD>'+
        '</TR> '+
        '<TR>'+
        ' <TD>&nbsp;</TD><TD><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Send"></TD>'+
        '</TR>'+
        '</TABLE>'+
        ' </FORM>'+
 ' </BODY>'+
'</HTML>');

end;

//Menüleiste
procedure TWebServForm.CreateVirtualDocument_links(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user: string;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');

    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>'+
        '<HEAD>'+
        '<TITLE>Linkliste</TITLE>'+
        '<meta http-equiv="cache-control" content="no-cache">'+
        '</HEAD>'+
        '<BODY bgcolor=white background="img/links.jpg?='+user+'" link=blue alink=blue vlink=blue onLoad="parent.unten.linksloaded=0;">'+
        '<a href="basetime.html?='+user+'" target="unten" onMouseOver="image.src=''img/prs1.jpg'';" onMouseOut="image.src=''img/but1.jpg'';" >' +
        '<img name="image" src="img/but1.jpg" border="0" ></a><br>'+
                '<a href="disconnect.html?='+user+'" target="unten" onMouseOver="image2.src=''img/prs2.jpg'';" onMouseOut="image2.src=''img/but2.jpg'';" >' +
        '<img name="image2" src="img/but2.jpg" border="0" ></a><br>'+
                '<a href="log/index.htm?='+user+'" target="unten" onMouseOver="image3.src=''img/prs3.jpg'';" onMouseOut="image3.src=''img/but3.jpg'';" >' +
        '<img name="image3" src="img/but3.jpg" border="0" ></a><br>'+
                '<a href="message.html?='+user+'" target="unten" onMouseOver="image4.src=''img/prs4.jpg'';" onMouseOut="image4.src=''img/but4.jpg'';" >' +
        '<img name="image4" src="img/but4.jpg" border="0" ></a><br>'+
                '<a href="log\log.txt?='+user+'" target="unten" onMouseOver="image5.src=''img/prs5.jpg'';" onMouseOut="image5.src=''img/but5.jpg'';" >' +
        '<img name="image5" src="img/but5.jpg" border="0" ></a><br>'+
                '<a href="shutdown.html?='+user+'" target="unten" onMouseOver="image6.src=''img/prs6.jpg'';" onMouseOut="image6.src=''img/but6.jpg'';" >' +
        '<img name="image6" src="img/but6.jpg" border="0" ></a><br>'+
                '<a href="logout.html?='+user+'" target="_parent" onMouseOver="image7.src=''img/prs7.jpg'';" onMouseOut="image7.src=''img/but7.jpg'';" >' +
        '<img name="image7" src="img/but7.jpg" border="0" ></a>'+

        '</BODY>'+
        '</HTML>');
end;

procedure TWebServForm.CreateVirtualDocument_aktiv(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user: string;
    counter: integer;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');

   counter:= UserSettings.readinteger('active','count',0);

    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>'+
        '<HEAD>'+
        '<META HTTP-EQUIV="Refresh" CONTENT="30; URL=aktiv.html?='+user+'">'+
        '<TITLE>aktive User</TITLE>'+
        '<meta http-equiv="cache-control" content="no-cache">'+
        '</HEAD>'+
        '<BODY bgcolor=blue background="img/links.jpg" link=blue alink=blue vlink=blue onLoad="parent.unten.linksobenloaded=0;">'+
        '<b><p align="center"><font size="-1">aktive User : '+inttostr(counter)+
        '<br>Server läuft seit '+servertime+'</p></font></b></BODY>'+
        '</HTML>');
end;


procedure TWebServForm.CreateVirtualDocument_unten(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user: string;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');


    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>'+
        '<HEAD>'+
        '<TITLE>Main</TITLE>'+
        '<meta http-equiv="cache-control" content="no-cache">'+

         '<script type="text/javascript">'+
         ' var linksobenloaded = 1;'+
         ' var linksloaded = 1;'+
         ' var obenloaded = 1;'+
         'function Load () {'+
         'if (navigator.appName!="Microsoft Internet Explorer") {stop();}'+
         'if (linksobenloaded != 0) {parent.linksunten.location.href=''../aktiv.html?='+user+'''; }'+
         'if (linksloaded != 0){ window.setTimeout("parent.links.location.href=''../links.htm?='+user+''';", 1000); }'+
         'if (obenloaded != 0) { window.setTimeout("parent.oben.location.href=''../myip.html?='+user+''';", 1000); }'+
          '}'+
        'window.setTimeout("Load()", 1000);'+
        '</script>'+


        '</HEAD>'+
        '<BODY bgcolor="#ebedfe">'+
        '<p align=center><font size=+2>Willkommen '+user+' :) </font><br><br>'+
        '<img src="img/head.jpg"></p>'+
        '</BODY>'+
        '</HTML>');
end;

procedure TWebServForm.CreateVirtualDocument_shutdown(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user: string;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');
    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>'+
        '<HEAD>'+
        '<TITLE>shutdown</TITLE>'+
        '</HEAD>'+
        '<BODY bgcolor="#ebedfe" link= blue alink=blue vlink=blue>'+
        '<p align=center><font size=+2>'+
        '<a href="shutdown1.html?='+user+'?=standby">StandBy</a><br>'+
        '<a href="shutdown1.html?='+user+'?=ruhezustand">Ruhezustand</a><br>'+
        '<a href="shutdown1.html?='+user+'?=poweroff">Windows beenden</a><br>'+
        '<a href="shutdown1.html?='+user+'?=restart">Windows neu starten</a><br>'+
        '<a href="shutdown1.html?='+user+'?=logoff">User abmelden</a><br></font><br><br>'+
        '</p>'+
        '</BODY>'+
        '</HTML>');
end;

procedure TWebServForm.CreateVirtualDocument_shutdown1(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user, hostname, buf: string;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');
    user:= ansireplacestr(user,'?','');
    HostName := ClientCnx.PeerAddr;

    if not assigned(shutter) then
    Application.CreateForm(Tshutter, shutter);

    if isonline then
    begin
      hauptfenster.disconnect;
      if not hauptfenster.noballoon then
      hauptfenster.tray.ShowBalloonHint('WebServer: Hinweis','Windows wird beendet',bitinfo, 10);
      hauptfenster.hinttimer.Enabled:= true;
    end;

    if ansicontainsstr(user,'poweroff') then
    begin
    user:= ansireplacestr(user,'poweroff','');

    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+ 'Windows ausgeschaltet' +
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;

    shutter.art:= 'poweroff';
    shutter.label4.caption:= 'Ausschalten';
    shutter.Label3.Caption:= 'von '+user;
    end
    else
    if ansicontainsstr(user,'restart') then
    begin
    user:= ansireplacestr(user,'restart','');
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Windows neu gestartet' +#9+
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;

    shutter.art:= 'restart';
    shutter.label4.caption:= 'Neustart';
    shutter.Label3.Caption:= 'von '+user;
    end
    else
    if ansicontainsstr(user,'logoff') then
    begin
    user:= ansireplacestr(user,'logoff','');
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+ 'User abgemeldet' +#9+
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;
    shutter.art:= 'logoff';
    shutter.label4.caption:= 'Abmelden';
    shutter.label3.caption:= 'von '+user;
    end
    else
    if ansicontainsstr(user,'standby') then
    begin
    user:= ansireplacestr(user,'standby','');
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Windows ausschalten > Standby' +#9+
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;

    shutter.art:= 'standby';
    shutter.label4.caption:= 'Standby';
    shutter.Label3.Caption:= 'von '+user;
    end
    else
    if ansicontainsstr(user,'ruhezustand') then
    begin
    user:= ansireplacestr(user,'ruhezustand','');
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'Windows ausschalten > Ruhezustand' +#9+
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;

    shutter.art:= 'ruhezustand';
    shutter.label4.caption:= 'Ruhezustand';
    shutter.Label3.Caption:= 'von '+user;
    end;
    shutter.show;

    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>'+
        '<HEAD>'+
        '<TITLE>shutdown</TITLE>'+
        '</HEAD>'+
        '<BODY bgcolor="#ebedfe">'+
        '<p align=center><font size=+1>'+
        'Funktion wird in 30s ausgeführt, sofern am Server nicht widersprochen wird.</font><br><br>'+
        '</p>'+
        '</BODY>'+
        '</HTML>');
end;

procedure TWebServForm.CreateVirtualDocument_DisableAutoDial(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user, hostname: string;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');
    user:= ansireplacestr(user,'?','');
    HostName := ClientCnx.PeerAddr;

    Hauptfenster.AutodialLED.LEDon:= false;

    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>'+
        '<HEAD>'+
        '<TITLE>DisableAutoDial</TITLE>'+
        '</HEAD>'+
        '<BODY bgcolor="#ebedfe">'+
        '<p align=center><font size=+1>'+
        'Auto-Einwahl deaktiviert !</font><br><br>'+
        '</p>'+
        '</BODY>'+
        '</HTML>');
end;


procedure TWebServForm.CreateVirtualDocument_logout(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);

var
    counter, i, stelle: integer;
    ip, user: string;
    val1, val2, val3: string;
    buf, hostname: string;
begin


    counter:= UserSettings.readinteger('active','count',0);
    stelle:= 0;
    if counter >1 then
    begin
      For i:=1 to counter do
        begin
          ip:= UserSettings.readstring('active','ip_'+inttostr(i),'0');
          user:= UserSettings.readstring('active','user_'+inttostr(i),'0');
          if ((ip = clientcnx.peeraddr)and (ansicontainsstr(clientcnx.FParams,user))) then begin stelle:= i; break; end;
        end;

       val1:= UserSettings.readstring('active','user_'+inttostr(counter),''); //letzten Eintrag auslesen
          val2:= UserSettings.readstring('active','ip_'+inttostr(counter),'');
             val3:= UserSettings.readstring('active','login_'+inttostr(counter),'');

      UserSettings.deletekey('active','user_'+inttostr(counter)); //letzten Eintrag löschen
          UserSettings.deletekey('active','ip_'+inttostr(counter));
              UserSettings.deletekey('active','login_'+inttostr(counter));

      if stelle < counter then // wenn nicht letzter Eintrag, dann letzten Eintrag an diese Stelle schreiben
      begin
       UserSettings.writestring('active','user_'+inttostr(stelle),val1);
           UserSettings.writestring('active','ip_'+inttostr(stelle),val2);
               UserSettings.writestring('active','login_'+inttostr(stelle),val3);
      end;

      UserSettings.writeinteger('active','count',counter-1);
     end
     else if counter=1 then UserSettings.erasesection('active');


    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>'+
        '<HEAD>' +
        '<TITLE>LeastCoster XP Webserver</TITLE>'+
        '  </HEAD>'+
        '  <BODY>'+
        '   <H2>Bitte geben Sie Usernamen und Passwort ein:</H2>             '+
        '  <FORM METHOD="POST" ACTION="/cgi-bin/LCRXP">'+
        '   <P>'+
        ' <TABLE BORDER="0" ALIGN="DEFAULT">'+
        '  <TR>'+
        '   <TD>User: </TD><TD><INPUT TYPE="TEXT" NAME="User" MAXLENGTH="25"></TD>'+
        ' </TR> '+
        ' <TR>'+
        '   <TD>Passwort: </TD><TD><INPUT TYPE="password" NAME="Passwort" MAXLENGTH="25"></TD>'+
        '</TR> '+
        '<TR>'+
        ' <TD>&nbsp;</TD><TD><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Send"></TD>'+
        '</TR>'+
        '</TABLE>'+
        ' </FORM>'+
 ' </BODY>'+
'</HTML>');

{ Build the record to write to data file }
    HostName := ClientCnx.PeerAddr;
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+'Ausgeloggt ' +
                #9+ User + '@' + HostName  +#13#10;
    status:= buf;
    allowedip:= ansireplacestr(allowedip,clientcnx.PeerAddr,'');

    { Save data to a text file }
    logfile_add(buf);

end;

procedure logout(user: string);
var counter, count, i, stelle: integer;
    tempip,ip, tempuser: string;
    val1, val2, val3: string;
    buf: string;
begin

    counter:= UserSettings.readinteger('active','count',0);
    stelle:= 0;
    if counter >1 then
    begin
      For i:=1 to counter do
        begin //user suchen
          tempip:= UserSettings.readstring('active','ip_'+inttostr(i),'nichts eingetragen !!!');
          tempuser:= UserSettings.readstring('active','user_'+inttostr(i),'nichts eingetragen !!!');
          if (tempuser = user)then begin stelle:= i; ip:= tempip; break; end;
        end;

       val1:= UserSettings.readstring('active','user_'+inttostr(counter),''); //letzten Eintrag auslesen
          val2:= UserSettings.readstring('active','ip_'+inttostr(counter),'');
             val3:= UserSettings.readstring('active','login_'+inttostr(counter),'');

      UserSettings.deletekey('active','user_'+inttostr(counter)); //letzten Eintrag löschen
          UserSettings.deletekey('active','ip_'+inttostr(counter));
              UserSettings.deletekey('active','login_'+inttostr(counter));

      if stelle < counter then // wenn nicht letzter Eintrag, dann letzten Eintrag an diese Stelle schreiben
      begin
      UserSettings.writestring('active','user_'+inttostr(stelle),val1);
          UserSettings.writestring('active','ip_'+inttostr(stelle),val2);
              UserSettings.writestring('active','login_'+inttostr(stelle),val3);
      end;

      UserSettings.writeinteger('active','count',counter-1);
     end
     else if counter=1 then
     begin
     UserSettings.erasesection('active');
     ip:= UserSettings.readstring('active','ip_1','nichts eingetragen !!!');
     end;

      //nachricht schreiben
    count:= UserSettings.ReadInteger(webservform.crypter.DoEncrypt(user),'count',0);

    UserSettings.WriteString(webservform.crypter.DoEncrypt(user),webservform.crypter.doencrypt('nachricht'+inttostr(count+1)),webservform.crypter.DoEncrypt('Sie haben vergessen sich auszuloggen !!!'));
    UserSettings.WriteString(webservform.crypter.DoEncrypt(user),webservform.crypter.doencrypt('zeitpunkt'+inttostr(count+1)),webservform.crypter.DoEncrypt(datetimetostr(now)));
    UserSettings.WriteString(webservform.crypter.DoEncrypt(user),webservform.crypter.doencrypt('sender'+inttostr(count+1)),webservform.crypter.DoEncrypt('LeastCoster XP'));
    UserSettings.WriteBool(webservform.crypter.DoEncrypt(user),webservform.crypter.doencrypt('gelesen'+inttostr(count+1)),false);
    UserSettings.WriteInteger(webservform.crypter.DoEncrypt(user),'count',count+1);

{ Build the record to write to data file }

    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+'Ausgeloggt (Logout vergessen !) ' +
                #9+ User + '@' + ip  +#13#10;
    status:= buf;
    allowedip:= ansireplacestr(allowedip,ip,'');
    { Save data to a text file }
    webservform.logfile_add(buf);

end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TWebServForm.CreateVirtualDocument_MyIP(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var nachrichten, user, trenner, onzeit: string;
    count, usercount, i: integer;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');

    UserSettings.WriteString(crypter.DoEncrypt(user),crypter.DoEncrypt('lasttimeon'), crypter.DoEncrypt(datetimetostr(now)));
    count:= UserSettings.ReadInteger(crypter.DoEncrypt(user),'count',0);

    if (UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('gelesen'+inttostr(count)),'1') = '0') then
    nachrichten:='<b><a href="message.html?='+user+'" target="unten">Sie haben ungelesene Nachrichten</a></b>';

    usercount:= UserSettings.Readinteger('active','count',0);
    if usercount>0 then

    for i:=1 to usercount do
    begin
    if (UserSettings.readstring('active','user_'+inttostr(i),'nichts eingetragen  !!!') = user) then
    begin
    UserSettings.writeString('active','login_'+inttostr(i),datetimetostr(now));
    break;
    end;
    end;

  if isonline then
    onzeit:= hauptfenster.ozeit.caption else onzeit:='';

    if status[1] <>' ' then status:= ' ' + status;

    ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
          '<meta http-equiv="cache-control" content="no-cache">'+
          '<META HTTP-EQUIV="Refresh" CONTENT="30; URL=myip.html?='+user+'">'+
          '<TITLE>Status</TITLE>' +
          '</HEAD>' + #13#10 +
          '<BODY bgcolor="#030C5A" text=E0E0E0 link="blue" vlink="blue" alink="blue" topmargin="0" leftmargin="2" onLoad="parent.unten.obenloaded=0;">' +
          '&nbsp;letzter Status:'+  status +'&nbsp'+
          '<table width=100% border="0" >'+
          '<tr>'+
          '<td>Ihre IP-Adresse:'+  ClientCnx.PeerAddr +'<br>'+
          'Datum/Uhrzeit:'+  datetimetostr(NOW) +'</td>'+
          '<td align="center"><font size=+2 color=green>'+hauptfenster.online.caption+ '&nbsp;'+onzeit+'</font><br>'+trenner+'</td>'+
          '</tr>'+
          '</table>'+
           nachrichten+
           '</BODY>' +
        '</HTML>');
end;
//basetime.html

procedure TWebServForm.CreateVirtualDocument_basetime(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user: string;
    hinweis, surfer, button: string;
begin

    user:= ansireplacestr(clientcnx.FParams,'=','');

    if (secondsbetween(settings.ReadDateTime('server','dialtime', EncodeDatetime(3000,1,1,0,0,0,0)),now) < 300)
    and not ansicontainstext(user,settings.ReadString('server','dialtimeuser','!_niemand_!')) then
    begin
     ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
            '<meta http-equiv="cache-control" content="no-cache">'+
          '</HEAD>' + #13#10 +
          '<BODY bgcolor="#ebedfe"> '+
           '<p align=center valign=middle>Zugriff gesperrt, da bereits '+settings.ReadString('server','dialtimeuser','!_niemand_!')+
           ' diese Funktion nutzt.<br>Freigabe in : '+
          inttostr(300 - secondsbetween(settings.ReadDateTime('server','dialtime', EncodeDatetime(3000,1,1,0,0,0,0)),now)) + ' s</p></BODY>' +
        '</HTML>');
        exit;
    end;

    surfer:= hauptfenster.prog;
    if not (surfer='') then button:= '<INPUT TYPE="SUBMIT" NAME="Dialer" VALUE="' +surfer+ '">' else button:='';

    if not isonline then
    begin
    user:= ansireplacestr(clientcnx.Fparams,'=','');
    user:= ansireplacestr(user,'?','');

    if not hauptfenster.AutoDialLED.LedOn then
    begin

    if not hauptfenster.noballoon then
    hauptfenster.tray.ShowBalloonHint('WebServer: Hinweis',user +' versucht Einwahl. ',bitinfo, 10);
    settings.Writedatetime('Server','dialtime',now);
    settings.Writestring('Server','dialtimeuser',user);
    ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+
          '</HEAD>' + #13#10 +
          '<BODY bgcolor="#ebedfe"> '+
           '<p align=center valign=middle>'+hinweis
          +'<FORM METHOD="POST" ACTION="/cgi-bin/goonline?='+user+'"><P><TABLE BORDER="0" ALIGN="DEFAULT"><TR><TD></TD><TD>Wie lange wollen Sie surfen ?</TD>'+
           '</TR><TR><TD>Basiszeit: </TD><TD><INPUT TYPE="edit" NAME="basetime" MAXLENGTH="5"></TD></TR> <TR> <TD>&nbsp;</TD><TD>'

          +'<INPUT TYPE="SUBMIT" NAME="Dialer" VALUE="LeastCoster">'+button+'</TD></TR></TABLE> </FORM> '+
           '</p></BODY>' +
        '</HTML>');
        end
        else //AuotDial ist aktiv
        begin
        ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+
          '</HEAD>' + #13#10 +
          '<BODY bgcolor="#ebedfe"> '+
           '<p align=center valign=middle>Die automatische Einwahl ist aktiv. Sobald ein passender Tarif zur Verfügung, steht verbindet der LeastCosterXP automatisch.'+
           '<br><a href="DisableAutoDial.html?=off">Auto-Einwahl abschalten</a><br>' +
           '</p></BODY>' +
        '</HTML>');
        end;
        end
        else
    ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+
          '</HEAD>' + #13#10 +
          '<BODY bgcolor="#ebedfe"> '+
           '<p align=center valign=middle>Sie sind bereits online !'+
           '</p></BODY>' +
        '</HTML>')
end;


//message.html
procedure TWebServForm.CreateVirtualDocument_postmessage(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user: string;
    sections: Tstringlist;
    options, nachrichten, anhang: string;
    i, count : integer;
    selector: boolean;
begin
   options:=''; anhang:=''; selector:= false;

   user:= ansireplacestr(clientcnx.FParams,'=','');

   sections := TStringList.Create;


   UserSettings.ReadSections(sections);

   for i:=0 to sections.Count-1 do
   if (sections.Strings[i] <>'active') and (sections.Strings[i] <> crypter.Doencrypt(user)) then

   if not selector then
   begin
   options:=options+'<option selected>'+crypter.DoDecrypt(sections.Strings[i])+'</option>';
   selector:= true;
   end else
   options:=options+'<option>'+crypter.DoDecrypt(sections.Strings[i])+'</option>';

   count:=UserSettings.ReadInteger(crypter.DoEncrypt(user),'count',0);
   nachrichten:= '<tr><td><b><a name="lesen">Nachrichten lesen</a></b><hr></td></tr>';

   if count >0 then
   for i:= count downto 1 do
   begin
   if (crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('file'+inttostr(i)),'')) <> '') then
   anhang:= '<b>Anhang: <a href="files\'+ crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('file'+inttostr(i)),''))+'">'+ crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('file'+inttostr(i)),''))+'</a></b> &nbsp;</b>'
   else anhang:= '';

   if (UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('gelesen'+inttostr(i)),'1')) = '0'
   then
    begin
    nachrichten:= nachrichten +'<tr><td><b>'+
        '<input type="checkbox" name="delete'+inttostr(i)+'" value="'+inttostr(i)+'">'+
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('zeitpunkt'+inttostr(i)),DateTimetoStr(EncodeDateTime(1970,01,01,0,0,0,0)))) + '&nbsp; von : '+
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('sender'+inttostr(i)),''))+'</b> &nbsp;'+
        anhang+
        '</td></tr><tr><td><b>'+
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('nachricht'+inttostr(i)),'no message')) +
        '</b><hr><br></td></tr>';
    UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.DoEncrypt('gelesen'+inttostr(i)) )


    end
    else
  nachrichten:= nachrichten + '<tr><td>'+
        '<input type="checkbox" name="delete'+inttostr(i)+'" value="'+inttostr(i)+'">'+
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('zeitpunkt'+inttostr(i)),DateTimetoStr(EncodeDateTime(1970,01,01,0,0,0,0)))) + '&nbsp; von : '+
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('sender'+inttostr(i)),''))+ '</b> &nbsp;'+
        anhang+
        '</td></tr>'+ '<tr><td>'+
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('nachricht'+inttostr(i)),'no message')) +
        '<br><hr></td></tr>';
   end;

   ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+            
          '</HEAD>' + #13#10 +
          '<BODY bgcolor="#ebedfe" link=blue alink=blue vlink=blue> '+
          '<a name=top></a><p><b><a href="#posten">Nachrichten schreiben</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#lesen">Nachrichten lesen</a></b></p>'+
           '<p align=center valign=middle> <FORM METHOD="POST" ACTION="/cgi-bin/deletemessage.html?='+user+'"><P><TABLE BORDER="0" width="100%" ALIGN="DEFAULT">'+
           nachrichten+
           '<tr><td><input type="submit" name="delete" value="markierte Nachrichten löschen" ></td></tr></table><hr><br>' +
           '<b><a name="posten">Nachrichten schreiben</a></b><br></table></form><FORM METHOD="POST" enctype="multipart/form-data" ACTION="/cgi-bin/sendmessage.html?='+user+'"><P><TABLE BORDER="0" width="100%" ALIGN="DEFAULT"><tr><td>Empfänger:<br> <select size="3" name="to">'+options+
           '</select></td></tr><tr><td><textarea cols="60" rows="10" name="text" wrap="soft"></textarea></td></tr>'+
           '<tr><td><input type="file" name="datei" size="60"></input></td></tr>'+
           '<TR> <TD><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Send"></TD></TR></TABLE> </FORM>'+
           '<a href="#top">nach oben</a> '+
           '</p></BODY>' +
        '</HTML>');
     sections.Free;
end;

//disconnect.html
procedure TWebServForm.CreateVirtualDocument_disconnect(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user: string;
    Hostname, Buf: String;
begin
    user:= ansireplacestr(clientcnx.Fparams,'=','');
    if ansicontainsstr(user,'disconnect') then
    begin
    user:= ansireplacetext(user,'?','');
    user:= ansireplacetext(user,'disconnect','');

    { Build the record to write to data file }
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now)+#9+ 'Verbindung getrennt ' +
                #9+ User + '@' + HostName  +#13#10;
    status:= buf;

    { Save data to a text file }
    logfile_add(buf);


      user:= ansireplacetext(user,'disconnect','');
      user:= ansireplacetext(user,'?','');
     if rascheck then hauptfenster.disconnect else hauptfenster.disconnect;
      if not hauptfenster.noballoon then
      hauptfenster.tray.ShowBalloonHint('WebServer: Hinweis',user +' hat die Verbindung getrennt.',bitinfo, 10);
      hauptfenster.hinttimer.Enabled:= true;
      ClientCnx.AnswerString(Flags,
         '',                            { Default Status '200 OK'            }
         '',                            { Default Content-Type: text/html    }
         'Pragma: no-cache' + #13#10 +  { No client caching please           }
         'Expires: -1'      + #13#10,   { I said: no caching !               }
         '<HTML>' +
           '<HEAD>' +
             '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+             
           '</HEAD>' + #13#10 +
           '<BODY bgcolor="#ebedfe"> '+
             '<p align=center valign=middle>Der Server ist jetzt '+Hauptfenster.online.Caption+'.</p></BODY>' +
         '</HTML>')

    end
    else
    begin
    user:= ansireplacetext(user,'disconnect','');
    user:= ansireplacetext(user,'?','');

    if isonline then
    ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+            
          '</HEAD>' + #13#10 +
          '<BODY bgcolor="#ebedfe"> '+
            '<p align=center valign=middle> <a href=disconnect.html?='+user+'?=disconnect>Verbindung jetzt trennen.</a></p></BODY>' +
        '</HTML>')
        else
         ClientCnx.AnswerString(Flags,
         '',                            { Default Status '200 OK'            }
         '',                            { Default Content-Type: text/html    }
         'Pragma: no-cache' + #13#10 +  { No client caching please           }
         'Expires: -1'      + #13#10,   { I said: no caching !               }
         '<HTML>' +
           '<HEAD>' +
             '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+             
           '</HEAD>' + #13#10 +
           '<BODY bgcolor="#ebedfe"> '+
             '<p align=center valign=middle>Es besteht keine Verbindung.</p></BODY>' +
         '</HTML>')
        end;
end;

//down.html
procedure TWebServForm.CreateVirtualDocument_down(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var time: tdatetime;
    newname: string;
    user: string;
begin

    user:= ansireplacestr(clientcnx.Fparams,'=','');

    if not assigned(screenshot) then Application.CreateForm(Tscreenshot, screenshot);

    webservform.delete(extractfilepath(paramstr(0))+'\www\');
    time:= now;
    screenshot.BitBtn2.click;
    newname:= 'www\lcr'+timetostr(time)+'.jpg';
    newname:=extractfilepath(paramstr(0))+ ansireplacestr(newname,':','');
    renamefile(extractfilepath(paramstr(0))+'www\lcr.jpg',newname);
     ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML><HEAD><TITLE>Surfen</TITLE>'+
        '<meta http-equiv="cache-control" content="no-cache">'+
        '</HEAD><BODY bgcolor="#ebedfe">'+
        '<FORM METHOD="POST" ACTION="/cgi-bin/goonline2?='+user+'">'+
        '<p align=center>'+        
        '<input type="hidden" name="bild" value="'+extractfilename(newname)+'">'+
        '<input type="submit" value="Verbindung wählen">'+
        '<input type="button" name="up" value="vorheriger Tarif" onClick="self.location.href=''../up.html''">'+
        '<input type="button" name="down" value="nächster Tarif" onClick="self.location.href=''../down.html''">'+
        '</p>'+
        '<p align=center valign=middle><img src="../'+extractfilename(newname)+'" border=0>'+
        '</form></BODY></HTML>');
end;

//up.html
procedure TWebServForm.CreateVirtualDocument_up(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var time: tdatetime;
    newname: string;
    user: string;
begin
    user:= ansireplacestr(clientcnx.Fparams,'=','');
    delete(extractfilepath(paramstr(0))+'\www\');
    time:= now;
    if not assigned(screenshot) then Application.CreateForm(Tscreenshot, screenshot);
    screenshot.BitBtn3.click;
    newname:= 'www\lcr'+timetostr(time)+'.jpg';
    newname:=extractfilepath(paramstr(0))+ ansireplacestr(newname,':','');
    renamefile(extractfilepath(paramstr(0))+'www\lcr.jpg',newname);
      ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML><HEAD><TITLE>Surfen</TITLE>'+
          '<meta http-equiv="cache-control" content="no-cache">'+
        '</HEAD><BODY bgcolor="#ebedfe">'+
        '<FORM METHOD="POST" ACTION="/cgi-bin/goonline2?='+user+'">'+
        '<p align=center>'+
        '<input type="hidden" name="bild" value="'+extractfilename(newname)+'">'+
        '<input type="submit" value="Verbindung wählen">'+
        '<input type="button" name="up" value="vorheriger Tarif" onClick="self.location.href=''../up.html''">'+
        '<input type="button" name="down" value="nächster Tarif" onClick="self.location.href=''../down.html''">'+
        '</p>'+
        '<p align=center valign=middle><img src="../'+extractfilename(newname)+'" border=0>'+
        '</form></BODY></HTML>');
end;

//dial.html
procedure TWebServForm.CreateVirtualDocument_dial(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var time: tdatetime;
    newname: string;
begin
    delete(extractfilepath(paramstr(0))+'\www\');
    time:= now;
    if not assigned(screenshot) then Application.CreateForm(Tscreenshot, screenshot);
    screenshot.BitBtn1.click;
    newname:= 'www\lcr'+timetostr(time)+'.jpg';
    newname:=extractfilepath(paramstr(0))+ ansireplacestr(newname,':','');
    renamefile(extractfilepath(paramstr(0))+'www\lcr.jpg',newname);
    ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+            
          '</HEAD>' + #13#10 +
          '<BODY  bgcolor="#ebedfe"> '+
            '<p align=center valign=middle><font size=+2>Verbindung wird hergestellt.</font></p></BODY>' +
        '</HTML>');
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ FormDataGetRow is called by AnswerPage when in find <#TABLE_ROWS> tag.    }
{ We have to read a line from the data file and call TagData.Add to seed    }
{ the HTML table with row data.                                             }
procedure TWebServForm.FormDataGetRow(
    Sender          : TObject;
    const TableName : String;
    Row             : Integer;
    TagData         : TStringIndex;
    var More        : Boolean;
    UserData        : TObject);
var
    Buf       : String;
    ClientCnx : TMyHttpConnection;
begin
    { Check if the table name. There could be several tables or table       }
    { embedded in another table in the template file                        }
    if TableName <> 'DATAFILE' then
        Exit;

    { Get reference to the connection. It has our data private.             }
    ClientCnx := Sender as TMyHttpConnection;

    { Check if we have read all the data file                               }
    More := not Eof(ClientCnx.FDataFile);
    if not More then
        Exit;

    { Read a line form data file                                            }
    ReadLn(ClientCnx.FDataFile, Buf);

    { Extract column data from the datafile line                            }
    TagData.Add('DATE', Copy(Buf, 1, 8));
    TagData.Add('TIME', Copy(Buf, 10, 6));
    TagData.Add('DATA', TextToHtmlText(Copy(Buf, 17, High(Integer))));

    { Alternate style for even or odd table lines                           }
    if (Row and 1) <> 0 then
        TagData.Add('STYLE', 'stEven')
    else
        TagData.Add('STYLE', 'stOdd');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ Build the dynamic page to show datafile. This page is based on a template }
{ with a table.                                                             }
procedure TWebServForm.CreateVirtualDocument_ViewFormData(
    Sender    : TObject;            { HTTP server component                 }
    ClientCnx : TMyHttpConnection;  { Client connection issuing command     }
    var Flags : THttpGetFlag);      { Tells what HTTP server has to do next }
begin
    { Open data file                                                        }
    AssignFile(ClientCnx.FDataFile, Extractfilepath(paramstr(0)) + 'www\log\log.txt');
    Reset(ClientCnx.FDataFile);
    try
        { Set event handler for getting datafile rows                       }
        ClientCnx.OnGetRowData := FormDataGetRow;
        ClientCnx.AnswerPage(
            Flags,
            '',
            NO_CACHE,
            'FormData.html',
            nil,
            ['NOW', DateTimeToStr(Now)]);
        { Clear event handler                                               }
        ClientCnx.OnGetRowData := nil;
    finally
        CloseFile(ClientCnx.FDataFile);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered when HTTP server component receive a POST }
{ command from any client.                                                  }
{ We count the request, display a message and trap posted data.             }
{ To check for posted data, you may construct the following HTML document:  }
{ <HTML>                                                                    }
{   <HEAD>                                                                  }
{     <TITLE>Test Form 1</TITLE>                                            }
{   </HEAD>                                                                 }
{   <BODY>                                                                  }
{     <H2>Enter your first and last name</H2>                               }
{     <FORM METHOD="POST" ACTION="/cgi-bin/FormHandler">                    }
{       <TABLE BORDER="0" ALIGN="DEFAULT" WIDTH="100%">                     }
{         <TR>                                                              }
{           <TD>First name</TD>                                             }
{           <TD><INPUT TYPE="TEXT" NAME="FirstName"                         }
{                      MAXLENGTH="25" VALUE="YourFirstName"></TD>           }
{         </TR>                                                             }
{         <TR>                                                              }
{           <TD>Last name</TD>                                              }
{           <TD><INPUT TYPE="TEXT" NAME="LastName"                          }
{                      MAXLENGTH="25" VALUE="YourLastName"></TD>            }
{         </TR>                                                             }
{       </TABLE>                                                            }
{       <P><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Button"></P>           }
{     </FORM>                                                               }
{   </BODY>                                                                 }
{ </HTML>                                                                   }
procedure TWebServForm.HttpServer1PostDocument(
    Sender    : TObject;            { HTTP server component                 }
    Client    : TObject;            { Client connection issuing command     }
    var Flags : THttpGetFlag);      { Tells what HTTP server has to do next }
var
    ClientCnx  : TMyHttpConnection;
begin
    { It's easyer to do the cast one time. Could use with clause... }
    ClientCnx := TMyHttpConnection(Client);

    { Count request and display a message }
    Inc(FCountRequests);
    { Check for request past. We only accept data for '/cgi-bin/LCRXP' }

    if (CompareText(ClientCnx.Path, '/cgi-bin/LCRXP') = 0) then begin

        { Tell HTTP server that we will accept posted data        }
        { OnPostedData event will be triggered when data comes in }
        Flags := hgAcceptData;
        { We wants to receive any data type. So we turn line mode off on   }
        { client connection.                                               }
        ClientCnx.LineMode := FALSE;
        { We need a buffer to hold posted data. We allocate as much as the }
        { size of posted data plus one byte for terminating nul char.      }
        { We should check for ContentLength = 0 and handle that case...    }
{$IFDEF VER80}
        if ClientCnx.FPostedDataSize = 0 then begin
            ClientCnx.FPostedDataSize := ClientCnx.RequestContentLength + 1;
            GetMem(ClientCnx.FPostedDataBuffer, ClientCnx.FPostedDataSize);
        end
        else begin
            ReallocMem(ClientCnx.FPostedDataBuffer, ClientCnx.FPostedDataSize,
                       ClientCnx.RequestContentLength + 1);
            ClientCnx.FPostedDataSize := ClientCnx.RequestContentLength + 1;
        end;
{$ELSE}
        ReallocMem(ClientCnx.FPostedDataBuffer,
                   ClientCnx.RequestContentLength + 1);
{$ENDIF}
        { Clear received length }
        ClientCnx.FDataLen := 0;
    end else
//check ob die ipadresse zugriffsrechte hat
    if not ansicontainstext(allowedip,clientcnx.PeerAddr) then
    begin
    clientcnx.Answer404;
    end
    else
    if (CompareText(ClientCnx.Path, '/cgi-bin/goonline') = 0)  or
    (CompareText(ClientCnx.Path, '/cgi-bin/goonline2') = 0)    or
    (CompareText(ClientCnx.Path, '/cgi-bin/LeastCosterDial') = 0)    or
    (CompareText(ClientCnx.Path, '/cgi-bin/sendmessage.html') = 0)    or
    (CompareText(ClientCnx.Path, '/cgi-bin/deletemessage.html') = 0) then begin

        { Tell HTTP server that we will accept posted data        }
        { OnPostedData event will be triggered when data comes in }
        Flags := hgAcceptData;
        { We wants to receive any data type. So we turn line mode off on   }
        { client connection.                                               }
        ClientCnx.LineMode := FALSE;
        { We need a buffer to hold posted data. We allocate as much as the }
        { size of posted data plus one byte for terminating nul char.      }
        { We should check for ContentLength = 0 and handle that case...    }
{$IFDEF VER80}
        if ClientCnx.FPostedDataSize = 0 then begin
            ClientCnx.FPostedDataSize := ClientCnx.RequestContentLength + 1;
            GetMem(ClientCnx.FPostedDataBuffer, ClientCnx.FPostedDataSize);
        end
        else begin
            ReallocMem(ClientCnx.FPostedDataBuffer, ClientCnx.FPostedDataSize,
                       ClientCnx.RequestContentLength + 1);
            ClientCnx.FPostedDataSize := ClientCnx.RequestContentLength + 1;
        end;
{$ELSE}
        ReallocMem(ClientCnx.FPostedDataBuffer,
                   ClientCnx.RequestContentLength + 1);
{$ENDIF}
        { Clear received length }
        ClientCnx.FDataLen := 0;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is triggered for each data packet posted by client     }
{ when we told HTTP server component that we will accept posted data.       }
{ We have to receive ALL data which is sent by remote client, even if there }
{ is more than what ContentLength tells us !                                }
{ If ContentLength = 0, then we should receive data until connection is     }
{ closed...                                                                 }
procedure TWebServForm.HttpServer1PostedData(
    Sender : TObject;               { HTTP server component                 }
    Client : TObject;               { Client posting data                   }
    Error  : Word);                 { Error in data receiving               }
var
    Len     : Integer;
    Remains : Integer;
    Junk    : array [0..255] of char;
    ClientCnx  : TMyHttpConnection;
begin
    { It's easyer to do the cast one time. Could use with clause... }
    ClientCnx := TMyHttpConnection(Client);

    { How much data do we have to receive ? }
    Remains := ClientCnx.RequestContentLength - ClientCnx.FDataLen;
    if Remains <= 0 then begin
        { We got all our data. Junk anything else ! }
        Len := ClientCnx.Receive(@Junk, SizeOf(Junk) - 1);
        if Len >= 0 then
            Junk[Len] := #0;
        Exit;
    end;
    { Receive as much data as we need to receive. But warning: we may       }
    { receive much less data. Data will be split into several packets we    }
    { have to assemble in our buffer.
                                           }
    Len := ClientCnx.Receive(ClientCnx.FPostedDataBuffer + ClientCnx.FDataLen, Remains);
    { Sometimes, winsock doesn't wants to givve any data... }
    if Len <= 0 then
        Exit;

    { Add received length to our count }
    Inc(ClientCnx.FDataLen, Len);
    { Add a nul terminating byte (handy to handle data as a string) }
    ClientCnx.FPostedDataBuffer[ClientCnx.FDataLen] := #0;
    { Display receive data so far }


    { When we received the whole thing, we can process it }
    if ClientCnx.FDataLen = ClientCnx.RequestContentLength then begin
        { First we must tell the component that we've got all the data }
        ClientCnx.PostedDataReceived;
        { Then we check if the request is one we handle }
        if CompareText(ClientCnx.Path, '/cgi-bin/LCRXP') = 0 then
            { We are happy to handle this one }
            ProcessPostedData_FormHandler(ClientCnx)
        else
        if CompareText(ClientCnx.Path, '/cgi-bin/goonline') = 0 then
            ProcessPostedData_goonline(ClientCnx)
        else
        if CompareText(ClientCnx.Path, '/cgi-bin/goonline2') = 0 then
            ProcessPostedData_goonline2(ClientCnx)
        else
        if CompareText(ClientCnx.Path, '/cgi-bin/LeastCosterDial') = 0 then
            ProcessPostedData_LeastCosterDial(ClientCnx)
        else
        if CompareText(ClientCnx.Path, '/cgi-bin/sendmessage.html')=0 then
            ProcessPostedData_sendmessage(ClientCnx)
        else
        if CompareText(ClientCnx.Path, '/cgi-bin/deletemessage.html')=0 then
            ProcessPostedData_deletemessage(ClientCnx)
        else
            { We don't accept any other request }
            ClientCnx.Answer404;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This will process posted data for FormHandler                             }
{ Data is saved in log.txt file                                     }
procedure TWebServForm.ProcessPostedData_FormHandler(
    ClientCnx : TMyHttpConnection);
var
    user : String;
    pass  : String;
    alreadyin: boolean;
    HostName  : String;
    Buf       : String;
    Dummy     : THttpGetFlag;
    counter, i: integer;
    buffer: string;
begin
     alreadyin:= false;
    { Extract fields from posted data. }
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'User', User);
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'Passwort',  pass);
    { Get client IP address. We could to ReverseDnsLookup to get hostname }
    HostName := ClientCnx.PeerAddr;
    { Build the record to write to data file }

    counter:= UserSettings.ReadInteger('active','count',0);

    Buffer := 'Sorry no password to read:'+pass + #0;

  if ((user<>'') and (pass<>'')
  and(GetMD5(@Buffer[1], Length(Buffer) - 1) = UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('pass'),'nicht gefunden !!!!'))) then
    begin

    { Session speichern }
     for i:=1 to counter do
     begin
     if user = UserSettings.ReadString('active','user_'+inttostr(i),'nichts eingetragen !!!')
     then begin alreadyin:= true; break; end;

     end;

     if not alreadyin then
     begin
     UserSettings.writeinteger('active','count',counter+1);
     counter:= counter+1;
     UserSettings.writeString('active','user_'+inttostr(counter),user);
     UserSettings.writeString('active','ip_'+inttostr(counter),ClientCnx.PeerAddr);
     UserSettings.writeString('active','login_'+inttostr(counter),datetimetostr(now));


     Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+ 'erfolgreicher Login ' +#9+ User + '@' + HostName  +#13#10;
     allowedip:= clientcnx.PeerAddr + ';';
     status:= buf;
     end;

      { HTML answer.}
    ClientCnx.AnswerString(Dummy,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<html><head><title>LeastCoaster XP Webserver</title>'+
        '<frameset frameborder=0 border=0 cols="200,*">'+

          '<frameset border=1 rows="100,*">'+
            '<frame name="linksunten" src="../aktiv.html?='+user+'" scrolling=no>'+
            '<frame name="links" src="../links.htm?='+user+'" scrolling=no>'+
          '</frameset>'+

          '<frameset border=1 rows="100,*">'+
          '<frame src="../myip.html?='+user+'" name="oben" scrolling=no>'+
         '<frame src="../unten.html?='+user+'" name="unten">'+
          '</frameset>'+

         '</frameset>'+
        '</head><body></body></html>');

       end
       else
        begin

        Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+'fehlgeschlagener Login '+
                #9+ User + '@' + HostName  +#13#10;
    status:= buf;
        ClientCnx.AnswerString(Dummy,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>falsche Userdaten</TITLE>' +
          '</HEAD>' + #13#10 +
          '<BODY>' +
            '<H2>Falsche Userdaten:</H2>' + #13#10 +
            '<P>' + TextToHtmlText(User) + '.' + '@' +
                    TextToHtmlText(HostName)  +'</P>' +
          '</BODY>' +
        '</HTML>');
         end;
       { Save data to a text file }
    if not alreadyin then logfile_add(buf);
end;

procedure TWebServForm.ProcessPostedData_goonline(
    ClientCnx : TMyHttpConnection);
var
    basetime, surfprog  : String;
    base, code,i: integer;
    user, newname: string;
    HostName  : String;
    Buf       : String;
    Dummy     : THttpGetFlag;
    tabelle, button, surfer: string;
begin
    user:= ansireplacestr(clientcnx.Fparams,'=','');
    user:= ansireplacestr(user,'?','');

    { Extract fields from posted data. }
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'basetime', basetime);
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'Dialer', surfprog);

    surfer:= hauptfenster.prog;
    if not (surfer='') then
    begin button:= '<INPUT TYPE="SUBMIT" NAME="Dialer" VALUE="' +surfer+ '">';
    end
    else button:='';

    { Get client IP address. We could do ReverseDnsLookup to get hostname }
    HostName := ClientCnx.PeerAddr;
    { Build the record to write to data file }
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+'Onlinesession vorbereitet ('+basetime+' mins) ' +
                #9+ User + '@' + HostName  +#13#10;
    status:= buf;

    { Here is the place to check for valid input data and produce a HTML }

    { HTML answer.}

    val(basetime, base,code);
    if (code =0) and (base < 721) then
    begin

            { Save data to a text file }
   logfile_add(buf);
   hauptfenster.webzugriff:=true;
   unit1.zeit_min:= basetime;

   //Basiszeit ins Hauptfenster übertragen
   hauptfenster.Surfdauer.Position:= base;

   //aktuelle zeit setzen
   hauptfenster.beliebig_check.Checked:= false;
   hauptfenster.Repaint;



   if not (surfprog='LeastCoster')
   then
   begin
   if not assigned(screenshot) then Application.CreateForm(Tscreenshot, screenshot);
    screenshot.shot.click;
    sleep(1000);

   newname:= 'www\lcr'+timetostr(time)+'.jpg';
   newname:=extractfilepath(paramstr(0))+ ansireplacestr(newname,':','');
   renamefile(extractfilepath(paramstr(0))+'www\lcr.jpg',newname);

   ClientCnx.AnswerString({Flags}Dummy,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML><HEAD><TITLE>Surfen</TITLE>'+
          '<meta http-equiv="cache-control" content="no-cache">'+
        '</HEAD><BODY bgcolor="#ebedfe">'+
        '<FORM METHOD="POST" ACTION="/cgi-bin/goonline2?='+user+'">'+
        '<p align=center>'+
        '<input type="hidden" name="bild" value="'+extractfilename(newname)+'">'+
        '<input type="submit" value="Verbindung wählen">'+
        '<input type="button" name="up" value="vorheriger Tarif" onClick="self.location.href=''../up.html''">'+
        '<input type="button" name="down" value="nächster Tarif" onClick="self.location.href=''../down.html''">'+
        '</p>'+
        '<p align=center valign=middle><img src="../'+extractfilename(newname)+'" border=0>'+
        '</p>'+
        '</form></BODY></HTML>');
        end
        else //das Surfprogramm soll der leastCoster sein
        begin
          Hauptfenster.AktualisierenClick(nil);
          if Hauptfenster.Liste.cells[1,1] <> '' then
          begin
          tabelle:= '<table border=1 width=100%>'+#13#10;
          for i:=0 to Hauptfenster.Liste.rowCount-1 do
          begin
          if i>0 then
          begin
           if i=1 then tabelle:= tabelle + '<tr><td><input type="radio" name="Tarif" value="'+inttostr(i)+'" checked><font size=-1>'
           else tabelle:= tabelle + '<tr><td><input type="radio" name="Tarif" value="'+inttostr(i)+'"><font size=-1>';
          end
          else  tabelle:= tabelle + '<tr><td><font size=-1>';

          if (not(hauptfenster.Liste.Cells[11,i] = 'Webseite') and not(  hauptfenster.Liste.Cells[11,i]=''))
          then tabelle:= tabelle + '<a href="'+hauptfenster.Liste.Cells[11,i]+'">'+hauptfenster.Liste.Cells[1,i] + '</a></font></td>'
          else tabelle:= tabelle + hauptfenster.Liste.Cells[1,i] + '</font></td>';
          tabelle:= tabelle
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[2,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[3,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[3,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[4,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[5,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[6,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[7,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[12,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[13,i] + '</font></td>'
                    + '</tr>' + #13#10;
          end;
          tabelle:= tabelle + '</table>';
          end else tabelle:= '<font size+1><b>Keine Tarife verfügbar (Surfzeit verkleinern ?)</b></font>';
          ClientCnx.AnswerString({Flags}Dummy,
            '',                            { Default Status '200 OK'            }
            '',                            { Default Content-Type: text/html    }
            'Pragma: no-cache' + #13#10 +  { No client caching please           }
            'Expires: -1'      + #13#10,   { I said: no caching !               }
            '<HTML><HEAD><TITLE>Surfen</TITLE>'+
            '<meta http-equiv="cache-control" content="no-cache">'+
            '<script type="text/javascript">'+
            'function keepalive() {'+
              'document.Dialform.elements[1].click();'+
            '}'+
            'window.setTimeout("keepalive()", 30000);'+
            '</script>'+
            '</HEAD>'+
            '<BODY bgcolor="#ebedfe">'+
            '<FORM METHOD="POST" name="Dialform" ACTION="/cgi-bin/LeastCosterDial?='+user+'">'+
            '<p align=left><input type="submit" name="action" value="Verbindung wählen"><input type="submit" name="action" value="Aktualisieren"><INPUT TYPE="edit" NAME="basetime" value="'+inttostr(base)+'" MAXLENGTH="5"></p>'+
            '<p align=center valign=middle>'+
             tabelle +
            '</p>'+
            '</form>'+

            '</BODY></HTML>');
            sleep(1000);
        end;
    end else
    ClientCnx.AnswerString(Dummy,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+
          '</HEAD>' + #13#10
          +'<BODY bgcolor="#ebedfe"> '
          +'<p align=center valign=middle><font color=red> Die Eingabe der Basiszeit war fehlerhaft, bitte wiederholen !</font>'
          +'<FORM METHOD="POST" ACTION="/cgi-bin/goonline?='+user+'"><P><TABLE BORDER="0" ALIGN="DEFAULT"><TR><TD></TD><TD>Wie lange wollen Sie surfen ?</TD>'
          +'</TR><TR><TD>Basiszeit: </TD><TD><INPUT TYPE="edit" NAME="basetime" MAXLENGTH="5"></TD></TR> <TR> <TD>&nbsp;</TD><TD>'
          +'<INPUT TYPE="SUBMIT" NAME="Dialer" VALUE="LeastCoster">'
          + button
          +'</TD></TR></TABLE></FORM> '
          +'</p></BODY>'
          +'</HTML>')

end;

procedure TWebServForm.ProcessPostedData_goonline2(
    ClientCnx : TMyHttpConnection);
var
    fehlergefunden: boolean;
    user, fehlerstring, bildname: string;
    HostName  : String;
    Buf       : String;
    Dummy     : THttpGetFlag;
begin
    fehlergefunden:= false;
    user:= ansireplacestr(clientcnx.Fparams,'=','');

    { Extract fields from posted data. }
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'bild',bildname);

    { Get client IP address. We could to ReverseDnsLookup to get hostname }
    HostName := ClientCnx.PeerAddr;
    { Build the record to write to data file }

    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+'Wählen mit ' + hauptfenster.prog+
                #9+ User + '@' + HostName  +#13#10;
    status:= buf;

    { Save data to a text file }
    logfile_add(buf);

    { Here is the place to check for valid input data and produce a HTML }

    { HTML answer.}
    if not fehlergefunden then
    begin
    if not assigned(screenshot) then Application.CreateForm(Tscreenshot, screenshot);
    screenshot.BitBtn1.Click;
    ClientCnx.AnswerString(Dummy,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML>' +
          '<HEAD>' +
            '<TITLE>Surfen</TITLE>' +
          '<meta http-equiv="cache-control" content="no-cache">'+            
          '</HEAD>' + #13#10 +
          '<BODY bgcolor="#ebedfe"> '+
           '<P>Die Verbindung wird hergestellt.</p></BODY>' +
        '</HTML>');
    end
    else
         ClientCnx.AnswerString(Dummy,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML><HEAD><TITLE>Surfen</TITLE>'+
          '<meta http-equiv="cache-control" content="no-cache">'+        
        '</HEAD><BODY bgcolor="#ebedfe">'+
        '<P><font color=red>'+fehlerstring+'</font></p>'+
        '<FORM METHOD="POST" ACTION="/cgi-bin/goonline2?='+user+'">'+
        '<p align=center>'+
        '<input type="hidden" name="bild" value="'+bildname+'">'+
        '<input type="submit" value="Verbindung wählen">'+
        '<input type="button" name="up" value="vorheriger Tarif" onClick="self.location.href=''../up.html''">'+
        '<input type="button" name="down" value="nächster Tarif" onClick="self.location.href=''../down.html''">'+
        '</p>'+
        '<p align=center valign=middle><img src="../'+bildname+'" border=0>'+
        '</form></BODY></HTML>');

       //Ausführung des Befehls

       if not fehlergefunden then
       begin
       hauptfenster.webzugriff:=true;
       if not assigned(screenshot) then Application.CreateForm(Tscreenshot, screenshot);
       screenshot.BitBtn1.click;
       if not hauptfenster.noballoon then
       hauptfenster.tray.ShowBalloonHint('WebServer: Hinweis',user +' startet Interneteinwahl.',bitinfo, 10);
       end;
end;

procedure TWebServForm.ProcessPostedData_LeastCosterDial(
    ClientCnx : TMyHttpConnection);
var
    user, command, Tarif, basetime, tabelle : string;
    HostName  : String;
    Buf       : String;
    Dummy     : THttpGetFlag;
    tarifnr, base, i   : integer;
begin
    user:= ansireplacestr(clientcnx.Fparams,'=','');
    HostName := ClientCnx.PeerAddr;

    //aktuelle zeit einstellen
    hauptfenster.beliebig_check.Checked:= false;

    { Extract fields from posted data. }
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'action',command);
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'Tarif',Tarif);
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'basetime',basetime);

    tarifnr:= strtoint(Tarif);

   try
    base:= strtoint(basetime);
   except
    base:= 1;
   end;

    hauptfenster.Liste.Row:= tarifnr;
    
    if command = 'Verbindung wählen' then
    begin
    if ( (dateof(now) <= strtodate(hauptfenster.liste.cells[12,tarifnr])) and (secondsbetween(hauptfenster.timeofliste, now) < 60) ) then
    begin
     hauptfenster.webzugriff:=true;
     hauptfenster.DialBtnClick(nil);
       { Build the record to write to data file }
      Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+'Wählen mit LeastCoster ' +
                  #9+ User + '@' + HostName  +#13#10;
      status:= buf;
      { Save data to a text file }
      logfile_add(buf);

      { Here is the place to check for valid input data and produce a HTML }

      { HTML answer.}
      hauptfenster.webzugriff:=true;
      if not hauptfenster.noballoon then
        hauptfenster.tray.ShowBalloonHint('WebInterface: Hinweis',user +' stellt die Verbindung mit LeastCosterXP zum Internet her.',bitinfo, 10);

      ClientCnx.AnswerString(Dummy,
          '',                            { Default Status '200 OK'            }
          '',                            { Default Content-Type: text/html    }
          'Pragma: no-cache' + #13#10 +  { No client caching please           }
          'Expires: -1'      + #13#10,   { I said: no caching !               }
          '<HTML>' +
            '<HEAD>' +
              '<TITLE>Surfen</TITLE>' +
            '<meta http-equiv="cache-control" content="no-cache">'+
            '<META http-equiv="refresh" content="60;URL=../WebStart.htm">'+
            '</HEAD>' + #13#10 +
            '<BODY bgcolor="#ebedfe"> '+
             '<P>Die Verbindung wird hergestellt. (Laden der Providerseite in 60s)</p></BODY>' +
          '</HTML>');
      end
      else
        ClientCnx.AnswerString(Dummy,
          '',                            { Default Status '200 OK'            }
          '',                            { Default Content-Type: text/html    }
          'Pragma: no-cache' + #13#10 +  { No client caching please           }
          'Expires: -1'      + #13#10,   { I said: no caching !               }
          '<HTML>' +
            '<HEAD>' +
              '<TITLE>Surfen</TITLE>' +
            '<meta http-equiv="cache-control" content="no-cache">'+
            '</HEAD>' + #13#10 +
              '<BODY bgcolor="#ebedfe"> '+
             '<P>Fehler: Entweder gilt der Tarif nicht mehr oder die Zeit zum Wählen ist abgelaufen (60s).</p><p align="center"><a href="javascript: history.back();">zurück</a></p></BODY>' +
          '</HTML>');
    end
   // wenn nicht action=Verbindung wählen
    else
    if command = 'Aktualisieren' then
    begin
    hauptfenster.surfdauer.position:= base;
    hauptfenster.AktualisierenClick(nil);
    hauptfenster.refresh;
     if Hauptfenster.Liste.cells[0,1] <> '' then
          begin
          tabelle:= '<table border=1 width=100%>'+#13#10;
          for i:=0 to Hauptfenster.Liste.rowCount-1 do
          begin
          if i>0 then
          begin
           if i=1 then tabelle:= tabelle + '<tr><td><input type="radio" name="Tarif" value="'+inttostr(i)+'" checked><font size=-1>'
           else tabelle:= tabelle + '<tr><td><input type="radio" name="Tarif" value="'+inttostr(i)+'"><font size=-1>';
          end
          else  tabelle:= tabelle + '<tr><td><font size=-1>';

          if (not(hauptfenster.Liste.Cells[10,i] = 'Webseite') and not(  hauptfenster.Liste.Cells[10,i]=''))
          then tabelle:= tabelle + '<a href="'+hauptfenster.Liste.Cells[10,i]+'">'+hauptfenster.Liste.Cells[0,i] + '</a></font></td>'
          else tabelle:= tabelle + hauptfenster.Liste.Cells[0,i] + '</font></td>';
          tabelle:= tabelle
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[1,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[2,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[2,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[3,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[4,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[5,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[6,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[11,i] + '</font></td>'
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[12,i] + '</font></td>'
                    + '</tr>' + #13#10;
          end;
          tabelle:= tabelle + '</table>';
          end else tabelle:= '<font size+1><b>Keine Tarife verfügbar (Surfzeit verkleinern ?)</b></font>';
          ClientCnx.AnswerString({Flags}Dummy,
            '',                            { Default Status '200 OK'            }
            '',                            { Default Content-Type: text/html    }
            'Pragma: no-cache' + #13#10 +  { No client caching please           }
            'Expires: -1'      + #13#10,   { I said: no caching !               }
            '<HTML><HEAD><TITLE>Surfen</TITLE>'+
            '<meta http-equiv="cache-control" content="no-cache">'+
            '<script type="text/javascript">'+
            'function keepalive() {'+
              'document.Dialform.elements[1].click();'+
            '}'+
            'window.setTimeout("keepalive()", 30000);'+
            '</script>'+
            '</HEAD><BODY bgcolor="#ebedfe">'+
            '<FORM METHOD="POST" name="Dialform" ACTION="/cgi-bin/LeastCosterDial?='+user+'">'+
            '<p align=left><input type="submit" name="action" value="Verbindung wählen"><input type="submit" name="action" value="Aktualisieren"><INPUT TYPE="edit" NAME="basetime" value="'+inttostr(base)+'" MAXLENGTH="5"></p>'+
            '<p align=center valign=middle>'+
             tabelle +
            '</p>'+
            '</form></BODY></HTML>');
            sleep(1000);
    end;
end;    

Procedure extractfile(ClientCnx : TMyHttpConnection; var filename: string);
var len,Blen: integer;
    temp, ext: string;
    inhalt: string[4];
    ende: string[20];
    myStream: TMemoryStream;
    i, count, fileex: integer;
    ok: boolean;
Begin
                    inhalt:= ''; count:= 0; fileex:= 1;
                    ok:= false;

                    //get start marker for start of file
                    Len := Pos('Content-Type:', clientcnx.FPostedDataBuffer);
                    For i:= len to length(clientcnx.FPostedDataBuffer) do
                    begin
                    count:= count+1;
                    if length(inhalt) = 4 then delete(inhalt,1,1);
                    inhalt:= inhalt+clientcnx.FPostedDataBuffer[i];
                    if inhalt = #13+#10+#13+#10 then break;
                    end;
                    len:= len+count;

                    //search the end marker in the file
                    count:=0;
                    For i:= len to length(clientcnx.FPostedDataBuffer) do
                    begin
                    count:= count+1;
                    if length(ende) = 20 then delete(ende,1,1);
                    ende:= ende+clientcnx.FPostedDataBuffer[i];
                    if ende = #13+#10+'------------------' then break;
                    end;

                    //get the length of file
                    Blen := count-20;

                    //get filename from multipart form
                    Filename := AnsiStrPos(clientcnx.FPostedDataBuffer,'filename="');

                    //switch to a string for delete functions
                    Temp := Filename;
                     //remove the 'filename="' section
                    Delete(Temp, 1, 10);
                    //remove everything after the '"'+#13+#10 so we get just the filename
                    Delete(Temp, pos('"'+#13+#10, Temp), Length(Temp));

                    if directoryexists(ExtractFilePath(ParamStr(0)) + 'www\files')= false then
                    mkdir(ExtractFilePath(ParamStr(0)) + 'www\files');

                    if temp<>'' then
                    begin

                    repeat
                    if fileexists(ExtractFilePath(ParamStr(0)) + 'www\files\'+ExtractFileName(Temp)) then
                    begin
                    ext:= extractfileext(temp);
                    delete(temp,length(temp)-3,4);
                    if ansicontainsstr(temp,inttostr(fileex-1)) then delete(temp,length(temp)-1,2);
                    temp:=temp +'_'+ inttostr(fileex)+ext;
                    fileex:= fileex+1;
                    end else ok:= true;
                    until ok= true;

                    MyStream := TMemoryStream.Create;
                    if ansicontainstext(PChar(clientcnx.FPostedDataBuffer),'Content-Typ: text/') then
                    MyStream.Write(clientcnx.Fposteddatabuffer[len],blen)
                    else
                    begin
                    blen:= 147;
                    MyStream.Write(clientcnx.Fposteddatabuffer[len],clientcnx.FRequestContentLength-blen-len);
                    end;
                    MyStream.Seek(0,0);
                    MyStream.SaveToFile(ExtractFilePath(ParamStr(0)) + 'www\files\'+ExtractFileName(Temp));
                    MyStream.Free;
                    end;
                    filename:= temp;
end;

procedure extractvalues(ClientCnx : TMyHttpConnection; var touser, text: string );
var temp: string;
begin
     // to user
     temp := AnsiStrPos(clientcnx.FPostedDataBuffer,'name="to"');
     temp:= ansireplacestr(temp,#13,'');
     temp:= ansireplacestr(temp,#10,'');

     Delete(temp,1,9);
     Delete(Temp, pos('------------', Temp), Length(Temp));
     touser:= temp;

      //message text
     temp := AnsiStrPos(clientcnx.FPostedDataBuffer,'name="text"');
     Delete(temp,1,14);
     temp:= ansireplacetext(temp,chr(13),'<br>');
     temp:= ansireplacetext(temp,chr(10),'');
     Delete(Temp, pos('------------', Temp), Length(Temp));
     text:= temp;

end;

procedure TWebServForm.ProcessPostedData_sendmessage(
    ClientCnx : TMyHttpConnection);
var
    touser, text: String;
    count: integer;
    user: string;
    HostName  : String;
    Dummy     : THttpGetFlag;
    filename: string;
begin
    user:= ansireplacestr(clientcnx.Fparams,'=','');
    user:= ansireplacestr(user,'?','');

    extractfile(clientcnx, filename);
    extractvalues(clientcnx, touser, text);

     { Get client IP address. We could do ReverseDnsLookup to get hostname }
    HostName := ClientCnx.PeerAddr;

    //nachricht schreiben
    count:= UserSettings.ReadInteger(crypter.DoEncrypt(touser),'count',0);

    UserSettings.WriteString(crypter.DoEncrypt(touser),crypter.doencrypt('nachricht'+inttostr(count+1)),crypter.DoEncrypt(text));
    UserSettings.WriteString(crypter.DoEncrypt(touser),crypter.doencrypt('zeitpunkt'+inttostr(count+1)),crypter.DoEncrypt(datetimetostr(now)));
    UserSettings.WriteString(crypter.DoEncrypt(touser),crypter.doencrypt('sender'+inttostr(count+1)),crypter.DoEncrypt(user));
    UserSettings.WriteString(crypter.DoEncrypt(touser),crypter.doencrypt('file'+inttostr(count+1)),crypter.DoEncrypt(extractfilename(filename)));
    UserSettings.WriteBool(crypter.DoEncrypt(touser),crypter.doencrypt('gelesen'+inttostr(count+1)),false);
    UserSettings.WriteInteger(crypter.DoEncrypt(touser),'count',count+1);

    { Here is the place to check for valid input data and produce a HTML }

    { HTML answer.}

        ClientCnx.AnswerString({Flags}Dummy,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        '<HTML><HEAD><TITLE>... gesendet</TITLE>'+
          '<meta http-equiv="cache-control" content="no-cache">'+
        '</HEAD><BODY bgcolor="#ebedfe">'+
        'Nachricht gesendet ... </BODY></HTML>');
end;


//deletemessage.html
procedure TWebServForm.ProcessPostedData_deletemessage(
    ClientCnx : TMyHttpConnection);
var
    count, position: integer;
    user: string;
    HostName, filename  : String;
    value       : String;
    Dummy     : THttpGetFlag;
    i: integer;
    sender:tobject;
begin
    sender:= nil;
    user:= ansireplacestr(clientcnx.Fparams,'=','');
    user:= ansireplacestr(user,'?','');

    //nachrichtenanzahl auslesen

    count:= UserSettings.ReadInteger(crypter.DoEncrypt(user),'count',0);

    { Extract fields from posted data. }
    for i:= 1 to count do
    begin
    ExtractURLEncodedValue(ClientCnx.FPostedDataBuffer, 'delete'+inttostr(i), value);
    if value='' then value:='-10';

    if strtoint(value) > 0 then
    begin
    filename:= crypter.DoDecrypt(UserSettings.Readstring(crypter.DoEncrypt(user),crypter.doencrypt('file'+value),'nichts eingetragen !!!'));
    if fileexists(Extractfilepath(paramstr(0)) + 'www\files\'+filename) then
    Deletefile(Extractfilepath(paramstr(0)) + 'www\files\'+filename);
    UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('file'+value));
    UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('nachricht'+value));
    UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('sender'+value));
    UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('zeitpunkt'+value));
    UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('gelesen'+value));
    end;
    end;
    position:=1;
    //lücken füllen
    For i:=1 to count do
    begin

    if (UserSettings.ValueExists(crypter.DoEncrypt(user),crypter.doencrypt('nachricht'+inttostr(i))))
    then
     begin
      if i > position then
        begin
           UserSettings.WriteString(crypter.DoEncrypt(user),crypter.doencrypt('file'+inttostr(position)),  UserSettings.ReadString( crypter.DoEncrypt(user), crypter.doencrypt('file'+inttostr(i)),'') );
           UserSettings.WriteString(crypter.DoEncrypt(user),crypter.doencrypt('nachricht'+inttostr(position)),  UserSettings.ReadString( crypter.DoEncrypt(user), crypter.doencrypt('nachricht'+inttostr(i)),'') );
           UserSettings.WriteString(crypter.DoEncrypt(user),crypter.doencrypt('zeitpunkt'+inttostr(position)), UserSettings.ReadString(crypter.DoEncrypt(user),crypter.doencrypt('zeitpunkt'+inttostr(i)),'') );
           UserSettings.WriteString(crypter.DoEncrypt(user),crypter.doencrypt('gelesen'+inttostr(position)), UserSettings.ReadString(crypter.DoEncrypt(user),crypter.doencrypt('gelesen'+inttostr(i)),'') );
           UserSettings.WriteString(crypter.DoEncrypt(user),crypter.doencrypt('sender'+inttostr(position)), UserSettings.ReadString(crypter.DoEncrypt(user),crypter.doencrypt('sender'+inttostr(i)),'') );

           UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('file'+inttostr(i)));
           UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('nachricht'+inttostr(i)));
           UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('sender'+inttostr(i)));
           UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('zeitpunkt'+inttostr(i)));
           UserSettings.DeleteKey(crypter.DoEncrypt(user),crypter.doencrypt('gelesen'+inttostr(i)));
           position:= position +1;
        end else position:= position+1;
     end;

    end;
    UserSettings.WriteInteger(crypter.DoEncrypt(user),'count',position-1);
    { Get client IP address. We could do ReverseDnsLookup to get hostname }
    HostName := ClientCnx.PeerAddr;

    { HTML answer.}
     CreateVirtualDocument_postmessage(Sender, ClientCnx, dummy)
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ We need to override parent class destructor because we have allocated     }
{ memory for our data buffer.                                               }
destructor TMyHttpConnection.Destroy;
begin
    if Assigned(FPostedDataBuffer) then begin
        FreeMem(FPostedDataBuffer, FPostedDataSize);
        FPostedDataBuffer := nil;
        FPostedDataSize   := 0;
    end;
    inherited Destroy;
end;

//+++++++++++++++++++++++++++++++++FileHandler++++++++++++++++++

procedure TWebServForm.delete(Verzeichnis:string);
var SR      : TSearchRec;
begin
  if Verzeichnis[length(Verzeichnis)]<>'\' then
    Verzeichnis:=Verzeichnis+'\';
  if FindFirst(Verzeichnis+'*.jpg',$3F,SR)=0 then begin
    repeat
       deletefile(verzeichnis+sr.name);
    until FindNext(SR)<>0;
    FindClose(SR);
  end;
end;


procedure TWebServForm.userboxChange(Sender: TObject);
var i: integer;
begin

 i:= userbox.ItemIndex;
 if not (userbox.items[i]= '<neuer User>') then
 begin
 username.Text:= userbox.items[i];
 pw.Text:= '';
 pw2.Text:= '';
 oldpw.Text:= '';
 end else username.Text:='';
end;

procedure TWebServForm.Button1Click(Sender: TObject);
var oldpw_buf, pw_buf: string;
begin
oldpw_buf:= 'Sorry no password to read:'+oldpw.text + #0;
pw_buf:= 'Sorry no password to read:'+pw.Text + #0;
if username.text <> '' then
begin

if UserSettings.sectionexists(crypter.doencrypt(username.text)) then
begin
if ( GetMD5(@oldpw_buf[1], Length(oldpw_buf) - 1) = UserSettings.readstring(crypter.doencrypt(username.text),crypter.DoEncrypt('pass'),'no password!!')) then
  if (pw.text=pw2.text) then UserSettings.writestring(crypter.DoEncrypt(username.text),crypter.DoEncrypt('pass'),GetMD5(@oldpw_buf[1], Length(oldpw_buf) - 1))
    else showmessage('Die beiden Passwortfelder stimmen nicht überein !')
  else showmessage('Falsches Passwort !!')
end
else if (pw.text=pw2.text) then UserSettings.writestring(crypter.DoEncrypt(username.text),crypter.doencrypt('pass'),GetMD5(@oldpw_buf[1], Length(oldpw_buf) - 1))
else showmessage('Die beiden Passwortfelder stimmen nicht überein !');

end;
filluserbox;
end;

procedure TWebServForm.filluserbox;
var
  counter: integer;
begin

  UserSettings.ReadSections(userbox.Items);


  userbox.ItemIndex := userbox.items.IndexOf('active');
  userbox.items.Delete(userbox.itemindex);

  if userbox.Items.count >0 then for counter:=0 to userbox.Items.Count-1 do
  begin
    userbox.items[counter]:=crypter.DoDecrypt(userbox.items[counter])
  end;
  userbox.items.Append('<neuer User>');
  userbox.ItemIndex := 0;
end;

procedure TWebServForm.FormActivate(Sender: TObject);
begin
  filluserbox;
  username.text:= '';
  pw.text:= '';
  pw2.Text:='';
end;

procedure TWebServForm.loeschenClick(Sender: TObject);
var oldpw_buf: string;
begin
if username.text <> '' then
begin

if UserSettings.sectionexists(crypter.doencrypt(username.text)) then
  begin
   oldpw_buf:= 'Sorry no password to read:'+oldpw.text + #0;
   if (GetMD5(@oldpw_buf[1], Length(oldpw_buf) - 1)) = UserSettings.readstring(crypter.doencrypt(username.text),crypter.DoEncrypt('pass'),'no password!!') then
     UserSettings.erasesection(crypter.DoEncrypt(username.text))
   else showmessage('Falsches Passwort !!')
  end;
end;
filluserbox;
username.Text:='';
oldpw.Text:='';
end;

procedure TWebServForm.Timer1Timer(Sender: TObject);
var tempuser: string;
    temptime: TDateTime;
    usercount, i: integer;
begin
    usercount:= UserSettings.Readinteger('active','count',0);
    if usercount>0 then
    for i:=1 to usercount do
    begin
      tempuser:= UserSettings.ReadString('active','user_'+inttostr(i),'nichts eingetragen !!!');
      temptime:= UserSettings.ReadDateTime('active','login_'+inttostr(i),yesterday);
      if secondsbetween(temptime, now)>600 then logout(tempuser);
    end;
end;

end.

