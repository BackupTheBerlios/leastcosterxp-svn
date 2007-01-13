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
  Buttons, CHCrypt, DateUtils, icsMD5, inilang, messagestrings;

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
    Label3: TLabel;
    ClientCountLabel: TLabel;
    Label5: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    PortEdit: TEdit;
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
    serverautostart: TCheckBox;
    GroupBox1: TGroupBox;
    memo1: TMemo;
    GroupBox2: TGroupBox;
    procedure pw2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pwMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure oldpwMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure usernameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure serverautostartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StopButtonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StartButtonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PortEditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PortEditKeyPress(Sender: TObject; var Key: Char);

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
    procedure ProcessPostedData_LeastCosterDial(ClientCnx : TMyHttpConnection);
    procedure ProcessPostedData_sendmessage(ClientCnx : TMyHttpConnection);
    procedure ProcessPostedData_deletemessage(ClientCnx : TMyHttpConnection);
    procedure filluserbox;


  public
     crypter: TCHCrypt;
 end;

var
  WebServForm: TWebServForm;
  status:string;
  servertime: string;
  Surftime: integer;

implementation

uses Unit1, CoolTrayIcon,  Unit4;

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


function Tarifliste(user: string) : string;
var tabelle: string;
    i      : integer;
begin
 Result   := '';
 tabelle  := '';

  if (Hauptfenster.Liste.cells[1,1] <> '') then
   begin
    tabelle:= '<table border=1 width=100%>'+#13#10;
      for i:=0 to Hauptfenster.Liste.rowCount-1 do
         begin

          if (i>0) then
          begin
           if (i=1) then
                tabelle:= tabelle + '<tr><td><input type="radio" name="Tarif" value="'+inttostr(i)+'" checked><font size=-1>'
           else
                tabelle:= tabelle + '<tr><td><input type="radio" name="Tarif" value="'+inttostr(i)+'"><font size=-1>';
          end
          else  tabelle:= tabelle + '<tr><td><font size=-1>';

          if (not(hauptfenster.Liste.Cells[11,i] = misc(M173,'M173')) and not(  hauptfenster.Liste.Cells[11,i]=''))
          then tabelle:= tabelle + '<a href="'+hauptfenster.Liste.Cells[11,i]+'">'+hauptfenster.Liste.Cells[1,i] + '</a></font></td>'
          else tabelle:= tabelle + hauptfenster.Liste.Cells[0,i] + '</font></td>'+#13#10;

          tabelle:= tabelle
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[2,i] + '</font></td>'+#13#10
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[3,i] + '</font></td>'+#13#10
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[4,i] + '</font></td>'+#13#10
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[5,i] + '</font></td>'+#13#10
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[6,i] + '</font></td>'+#13#10
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[7,i] + '</font></td>'+#13#10
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[8,i] + '</font></td>'+#13#10
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[12,i] + '</font></td>'+#13#10
                    + '<td><font size=-1>'+ hauptfenster.Liste.Cells[13,i] + '</font></td>'+#13#10
                    + '</tr>' + #13#10;
          end;
          tabelle:= tabelle + '</table>'+#13#10;
  end else tabelle:= '<font size+1><b>'+misc(M222,'M222')+'</b></font>+#13#10';

 Result:= '<FORM METHOD="POST" name="Dialform" ACTION="/cgi-bin/LeastCosterDial?='+user+'">' +#13#10
		     +'<p align=left><input type="submit" name="action" value="'+misc(M223,'M223')+'"><input type="submit" name="action" value="'+misc(M224,'M224')+'"><INPUT TYPE="edit" NAME="basetime" value="'+inttostr(surftime)+'" MAXLENGTH="5"></p>' +#13#10
			   +'<p align=center valign=middle>'+#13#10
         + tabelle + #13#10
         +'</p>' +#13#10
         +'</FORM>';
end;

function NachrichtenListe(user: string): string;
var sections: Tstringlist;
    options, nachrichten, anhang: string;
    i, count : integer;
    selector: boolean;
begin
with WebServForm do
begin
   options:=''; anhang:=''; selector:= false;

   sections := TStringList.Create;

   UserSettings.ReadSections(sections);

   for i:=0 to sections.Count-1 do
   if (sections.Strings[i] <>'active') and (sections.Strings[i] <> crypter.Doencrypt(user)) then
   if not selector then
   begin
        options:=options+'<option selected>'+crypter.DoDecrypt(sections.Strings[i])+'</option>';
        selector:= true;
   end
   else options:=options+'<option>'+crypter.DoDecrypt(sections.Strings[i])+'</option>';

   count:=UserSettings.ReadInteger(crypter.DoEncrypt(user),'count',0);
   nachrichten:= '<tr><td><b><a name="lesen">'+misc(M225,'M225')+'</a></b><hr></td></tr>';

   if count >0 then
   for i:= count downto 1 do
   begin

   if (crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('file'+inttostr(i)),'')) <> '') then
        anhang:= '<b>'+misc(M226,'M226')+': <a href="files\'+ crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('file'+inttostr(i)),''))+'">'+ crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('file'+inttostr(i)),''))+'</a></b> &nbsp;</b>'
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
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('zeitpunkt'+inttostr(i)),DateTimetoStr(EncodeDateTime(1970,01,01,0,0,0,0)))) + '&nbsp; '+misc(M227,'M227')+' : '+
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('sender'+inttostr(i)),''))+ '</b> &nbsp;'+
        anhang+
        '</td></tr>'+ '<tr><td>'+
        crypter.DoDecrypt(UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('nachricht'+inttostr(i)),'no message')) +
        '<br><hr></td></tr>';
   end;
  sections.Free;

  Result:=  '<p>' +#13#10+
						'	 <b><a href="#posten">'+misc(M228,'M228')+'</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#lesen">'+misc(M228,'M228')+'</a></b>' +#13#10+
					  '</p>' +#13#10+
            '<FORM METHOD="POST" ACTION="/cgi-bin/deletemessage.html?='+user+'">' +#13#10+
						'			<P>' +#13#10+
            '			<TABLE BORDER="0" width="100%" ALIGN="DEFAULT">' +#13#10
           +nachrichten+
					  '      <tr><td><input type="submit" name="delete" value="'+misc(M229,'M229')+'" ></td></tr>' +#13#10+
					  '			</TABLE>' +#13#10+
					  '			<hr><br>' +#13#10+
            '			<b><a name="posten">'+misc(M228,'M228')+'</a></b>' +#13#10+
					  '			<br>' +#13#10+
					  '			</table>' +#13#10+
					  '</FORM>' +#13#10+
            '<FORM METHOD="POST" enctype="multipart/form-data" ACTION="/cgi-bin/sendmessage.html?='+user+'">'+#13#10+
            '			<TABLE BORDER="0" width="100%" ALIGN="DEFAULT">'+#13#10+
            '						 <tr>'+#13#10+
            '						 		 <td>'+misc(M231,'M231')+':<br> <select size="3" name="to">'+options+'</select></td>'+#13#10+
            '						 </tr>'+#13#10+
            '						 <tr>'+#13#10+
            '						 		 <td><textarea cols="60" rows="10" name="text" wrap="soft"></textarea></td>'+#13#10+
            '						 </tr>'+#13#10+
            '						 <tr>'+#13#10+
            '						 		 <td><input type="file" name="datei" size="60"></input></td>'+#13#10+
            '						 </tr>'+#13#10+
            '						 <TR>'+#13#10+
            '						 		 <TD><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="'+misc(M230,'M230')+'"></TD>'+#13#10+
            '							</TR>'+#13#10+
            '			</TABLE>'+#13#10+
            '</FORM>';
end;
end;

function LogInForm: string;
begin

result:= '<FORM METHOD="POST" ACTION="/cgi-bin/LCRXP">'+#13#10+
         '						<P>'+#13#10+
				 '      			 <TABLE BORDER="0" ALIGN="DEFAULT">'+#13#10+
				 '			 				<TR>'+#13#10+
				 '								<TD>'+misc(M232,'M232')+': </TD><TD><INPUT TYPE="TEXT" NAME="User" MAXLENGTH="25"></TD>'+#13#10+
				 '							</TR>'+#13#10+
				 '						 <TR>'+#13#10+
				 '						 		<TD>'+misc(M233,'M233')+': </TD><TD><INPUT TYPE="password" NAME="Passwort" MAXLENGTH="25"></TD>'+#13#10+
				 '						 </TR>'+#13#10+
				 '						 <TR>'+#13#10+
				 '						 		<TD>&nbsp;</TD><TD><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="'+misc(M230,'M230')+'"></TD>'+#13#10+
				 '						 </TR>'+#13#10+
				 '			 </TABLE>'+#13#10+
				 '		</FORM>'+#13#10;

end;


function LoadPage(f, user: string; ClientCnx : TMyHttpConnection): string;
var List: TStringlist;
    n: string;
    i,count: integer;
begin
n:= extractFilePath(Paramstr(0)) + 'www\templates\'+f;
Result:= '';
if fileexists(n) then
begin

  List:=TStringlist.Create;
  List.LoadFromFile(n);

  for i:= 0 to list.Count-1 do
    Result:= Result + List.Strings[i] + #13#10;

  list.Free;

  Result:= AnsireplaceStr(Result,'%%DISCONNECT%%','disconnect.html?='+user+'?=disconnect');
  Result:= AnsireplaceStr(Result,'%%STATUS%%',Hauptfenster.online.Caption);
  Result:= AnsireplaceStr(Result,'%%LAST_STATUS%%', status);
  Result:= AnsireplaceStr(Result,'%%LOGINFORM%%', LogInForm);
  Result:= AnsireplaceStr(Result,'%%NOW%%', DateTimeToStr(now));

  Result:= AnsireplaceStr(Result,'%%LINK_CONNECT%%',     'basetime.html?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_DISCONNECT%%',  'disconnect.html?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_PROTOCOLS%%',   'log/index.htm?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_MESSAGES%%',    'message.html?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_LOGS%%',        'log/log.txt?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_SHUTDOWN%%',    'shutdown.html?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_DO_SHUTDOWN%%', 'shutdown1.html?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_LOGOUT%%',      'logout.html?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_USERINFO%%',    'aktiv.html?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_MENU%%',        'links.htm?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_STATUS%%',      'myip.html?='+user);
  Result:= AnsireplaceStr(Result,'%%LINK_WELCOME%%',     'unten.html?='+user);
  Result:= AnsireplaceStr(Result,'%%DISABLE_AUTODIAL%%',     'DisableAutoDial.html?=off');

  Result:= AnsireplaceStr(Result,'%%USERNAME%%',          user);
  Result:= AnsireplaceStr(Result,'%%USER_IP%%',           ClientCnx.PeerAddr);

  Result:= AnsireplaceStr(Result,'%%USERS_LOGGEDIN%%',    inttostr(UserSettings.ReadInteger('active','count',0)));
  Result:= AnsireplaceStr(Result,'%%SERVER_RUNNING_SINCE%%',   servertime);

  if ansicontainsstr(Result,'%%DIALFORM%%') then
    Result:= AnsireplaceStr(Result,'%%DIALFORM%%',   Tarifliste(user));

  if ansicontainsstr(Result, '%%MESSAGELIST%%') then
    Result:= AnsireplaceStr(Result,'%%MESSAGELIST%%',   Nachrichtenliste(user));

  Result:= AnsireplaceStr(Result,'%%USER_DIALING%%',   settings.ReadString('server','dialtimeuser','!_niemand_!'));
  Result:= AnsireplaceStr(Result,'%%USER_ALLOW_CONNECT_IN%%',   inttostr(300 - secondsbetween(settings.ReadDateTime('server','dialtime', EncodeDatetime(3000,1,1,0,0,0,0)),now)));

  count:= UserSettings.ReadInteger(Webservform.crypter.DoEncrypt(user),'count',0);

  if AnsiContainsSTR(Result,'%%IF_NEW_MESSAGE_BEGIN%%') then
  begin
    if (UserSettings.ReadString(Webservform.crypter.DoEncrypt(user),Webservform.crypter.DoEncrypt('gelesen'+inttostr(count)),'1') = '0') then
      begin //Neue Nachrichten
        Result:= AnsiReplaceStr(Result,'%%IF_NEW_MESSAGE_BEGIN%%','');
        Result:= AnsiReplaceStr(Result,'%%IF_NEW_MESSAGE_END%%'  ,'');
      end
      else //keine neuen Nachrichten
        Delete(Result, Pos('%%IF_NEW_MESSAGE_BEGIN%%',Result),Pos('%%IF_NEW_MESSAGE_END%%',Result)+22 - Pos('%%IF_NEW_MESSAGE_BEGIN%%',Result) );
  end;

  if isonline then
    Result:= AnsireplaceStr(Result,'%%ONLINETIME%%', hauptfenster.ozeit.caption)
  else
    Result:= AnsireplaceStr(Result,'%%ONLINETIME%%','');
end
else Result:= 'Template ' + f+ ' missing !';
end;

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
  if settings.ReadBool('Server','Autostart', false) then
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
//var    wsi     : TWSADATA;
begin

//       PortEdit.Text        := '85';
//       ClientCountLabel.Caption := '0';     { Initialize client count caption }
//       wsi := WinsockInfo;                  { Display version info for program and used components }
//
//{$IFNDEF DELPHI3}
//        if wsi.lpVendorInfo <> nil then     { A bug in Delphi 3 makes lpVendorInfo invalid }
//{$ENDIF}
//        StartButtonClick(Self);             { Automatically start server }

 CL:=loadIni('lang\'+settings.readstring('LeastCoster','language',''));
 if CL<>nil then fillProps([WebServForm],CL);

 //WebInterface
 Portedit.text:= settings.ReadString('Server','Port','85');
 serverautostart.checked:= settings.readbool('Server','Autostart',false);
 startbutton.Enabled:= false;
 stopbutton.enabled:= false;
 if (webservform.HttpServer1.Tag = 0 ) then startbutton.enabled:= true else stopbutton.Enabled:= true;

 ClientCountLabel.Caption := IntToStr(HttpServer1.ClientCount);
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
var i,code: integer;
begin

   Val(PortEdit.Text, I, Code);
   if Code <> 0 then exit;   { Error during conversion to integer? }

   stopbutton.Enabled:= true;
   startbutton.Enabled:=false;

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
   stopbutton.Enabled:= false;
   startbutton.Enabled:=true;
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
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+misc(M234,'M234') +#13#10;
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

    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+misc(M235,'M235') +#13#10;
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

    user:= ansireplacestr(clientcnx.FParams,'=','');

    counter:= UserSettings.ReadInteger('active','count',0);
    For i:= 1 to counter do
      ip:= ip + UserSettings.ReadString('active','ip_'+inttostr(i),'');

    if ((CompareText(ClientCnx.Path, '/login.htm') = 0) or (CompareText(ClientCnx.Path, '/') = 0)) then
                ClientCnx.AnswerString(Flags,
                    '',           { Default Status '200 OK'         }
                    '',           { Default Content-Type: text/html }
                    '',           { Default header                  }
                LoadPage('login.tpl',user,ClientCNX))
    { Trap '/surfen.html' path to dynamically generate a dynamic answer. }
    else
    if CompareText(ClientCnx.Path, '/logout.html') = 0 then
        CreateVirtualDocument_logout(Sender, ClientCnx, Flags)
    else
    {nur authentifizierte User dürfen die folgenden Seiten abrufen}
    //wenn die Ip zur userip passt
    if ansicontainstext(ip,clientcnx.PeerAddr) then
    if CompareText(ClientCnx.Path, '/unten.html') = 0 then
         ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        LoadPage('welcome.tpl',user,ClientCNX))
    else if CompareText(ClientCnx.Path, '/links.htm') = 0 then
         ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        LoadPage('menu.tpl',user,ClientCNX))
    else if CompareText(ClientCnx.Path, '/aktiv.html') = 0 then
         ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        LoadPage('userinfo.tpl',user,ClientCNX))
    else if CompareText(ClientCnx.Path, '/shutdown.html') = 0 then
        ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        LoadPage('shutdown_select.tpl',user,ClientCNX))
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
    else if CompareText(ClientCnx.Path, '/view.html') = 0 then
        CreateVirtualDocument_ViewFormData(Sender, ClientCnx, Flags)
    else if CompareText(ClientCnx.Path, '/myip.html') = 0 then
        CreateVirtualDocument_MyIP(Sender, ClientCnx, Flags)
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
      hauptfenster.tray.ShowBalloonHint(misc(M236,'M236'),misc(M237,'M237'),bitinfo, 10);
      hauptfenster.hinttimer.Enabled:= true;
    end;

    if ansicontainsstr(user,'poweroff') then
    begin
    user:= ansireplacestr(user,'poweroff','');

    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+ misc(M237,'M237') +
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;

    shutter.art:= 'poweroff';
    shutter.label4.caption:= misc(M238,'M238');
    shutter.Label3.Caption:= misc(M232,'M232')+':'+ user;
    end
    else
    if ansicontainsstr(user,'restart') then
    begin
    user:= ansireplacestr(user,'restart','');
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+misc(M239,'M239') +#9+
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;

    shutter.art:= 'restart';
    shutter.label4.caption:= misc(M240,'M240');
    shutter.Label3.Caption:= misc(M232,'M232')+':'+user;
    end
    else
    if ansicontainsstr(user,'logoff') then
    begin
    user:= ansireplacestr(user,'logoff','');
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+ misc(M241,'M241') +#9+
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;
    shutter.art:= 'logoff';
    shutter.label4.caption:= misc(M242,'M242');
    shutter.label3.caption:= misc(M232,'M232')+':'+user;
    end
    else
    if ansicontainsstr(user,'standby') then
    begin
    user:= ansireplacestr(user,'standby','');
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+misc(M243,'M243') +#9+
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;

    shutter.art:= 'standby';
    shutter.label4.caption:= misc(M244,'M244');
    shutter.Label3.Caption:= misc(M232,'M232')+':'+user;
    end
    else
    if ansicontainsstr(user,'hibernate') then
    begin
    user:= ansireplacestr(user,'hibernate','');
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+misc(M245,'M245') +#9+
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;

    shutter.art:= 'ruhezustand';
    shutter.label4.caption:= misc(M246,'M246');
    shutter.Label3.Caption:= misc(M232,'M232')+':'+user;
    end;
    shutter.show;

    ClientCnx.AnswerString(Flags,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
     LoadPage('shutdown_message.tpl',user,ClientCNX));
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
        LoadPage('AutoDial_Disabled.tpl',user, ClientCNX));
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
        LoadPage('login.tpl',user,ClientCNX));

{ Build the record to write to data file }
    HostName := ClientCnx.PeerAddr;
    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+misc(M247,'M247') +
                #9+ User + '@' + HostName  +#13#10;
    logfile_add(buf);
    status:= buf;
    allowedip:= ansireplacestr(allowedip,clientcnx.PeerAddr,'');
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

    Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+misc(M248,'M248') +
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
var user: string;
    usercount, i: integer;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');

    UserSettings.WriteString(crypter.DoEncrypt(user),crypter.DoEncrypt('lasttimeon'), crypter.DoEncrypt(datetimetostr(now)));

    usercount:= UserSettings.Readinteger('active','count',0);
    if usercount>0 then
    for i:=1 to usercount do
    begin //User ist noch aktiv
    if (UserSettings.readstring('active','user_'+inttostr(i),'nichts eingetragen  !!!') = user) then
    begin
      UserSettings.writeString('active','login_'+inttostr(i),datetimetostr(now));
      break;
    end;
    end;

    if status[1] <>' ' then status:= ' ' + status;

    ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        LoadPage('status.tpl', user,ClientCNX));
end;

//basetime.html
procedure TWebServForm.CreateVirtualDocument_basetime(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user, buf,hostname: string;
begin
    user:= ansireplacestr(clientcnx.FParams,'=','');
    HostName := ClientCnx.PeerAddr;

    if (secondsbetween(settings.ReadDateTime('server','dialtime', EncodeDatetime(3000,1,1,0,0,0,0)),now) < 300)
    and not ansicontainstext(user,settings.ReadString('server','dialtimeuser','!_niemand_!')) then
    begin
     ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        LoadPage('Connect_forbidden.tpl',user, ClientCNX));
        exit;
    end;

    if not isonline then
    begin
    user:= ansireplacestr(clientcnx.Fparams,'=','');
    user:= ansireplacestr(user,'?','');

     if not hauptfenster.AutoDialLED.LedOn then
     begin

       if not hauptfenster.noballoon then
           hauptfenster.tray.ShowBalloonHint(misc(M236,'M236'),user +' '+misc(M249,'M249'),bitinfo, 10);

       settings.Writedatetime('Server','dialtime',now);
       settings.Writestring('Server','dialtimeuser',user);

        Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+user +' '+misc(M249,'M249')+' ('+ inttostr(hauptfenster.Surfdauer.Position)+' min)' +
                  #9+ User + '@' + HostName  +#13#10;
         status:= buf;

        { Save data to a text file }
         logfile_add(buf);
        hauptfenster.webzugriff:=true;
        unit1.zeit_min:= inttostr(hauptfenster.Surfdauer.Position);

        //aktuelle zeit setzen
        hauptfenster.beliebig_check.Checked:= false;
        hauptfenster.Repaint;

        Surftime:= hauptfenster.Surfdauer.Position;
        ClientCnx.AnswerString(Flags,
             '',                            { Default Status '200 OK'            }
             '',                            { Default Content-Type: text/html    }
             'Pragma: no-cache' + #13#10 +  { No client caching please           }
             'Expires: -1'      + #13#10,   { I said: no caching !               }
             LoadPage('connect_list.tpl',user, ClientCNX));
             sleep(1000);

      end
      else //AuotDial ist aktiv
      begin
       ClientCnx.AnswerString(Flags,
           '',                            { Default Status '200 OK'            }
           '',                            { Default Content-Type: text/html    }
           'Pragma: no-cache' + #13#10 +  { No client caching please           }
           'Expires: -1'      + #13#10,   { I said: no caching !               }
          LoadPage('Connect_AutoDial_Active.tpl',user,ClientCNX));
      end;
    end
    else
      ClientCnx.AnswerString(Flags,
          '',                            { Default Status '200 OK'            }
          '',                            { Default Content-Type: text/html    }
          'Pragma: no-cache' + #13#10 +  { No client caching please           }
          'Expires: -1'      + #13#10,   { I said: no caching !               }
          LoadPage('connect_already_on.tpl',user,ClientCNX));
end;

//message.html
procedure TWebServForm.CreateVirtualDocument_postmessage(
    Sender    : TObject;
    ClientCnx : TMyHttpConnection;
    var Flags : THttpGetFlag);
var user: string;
begin
   user:= ansireplacestr(clientcnx.FParams,'=','');

   ClientCnx.AnswerString(Flags,
        '',                            { Default Status '200 OK'            }
        '',                            { Default Content-Type: text/html    }
        'Pragma: no-cache' + #13#10 +  { No client caching please           }
        'Expires: -1'      + #13#10,   { I said: no caching !               }
        LoadPage('message_form.tpl', user, ClientCNX));
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

      Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now)+#9+ misc(M85,'M85') +' ' +
                #9+ User + '@' + HostName  +#13#10;
      status:= buf;
      logfile_add(buf);

      if rascheck then hauptfenster.disconnect else hauptfenster.disconnect;
      if not hauptfenster.noballoon then hauptfenster.tray.ShowBalloonHint(misc(M236,'M236'),user +' '+misc(M250,'M250'),bitinfo, 10);

      hauptfenster.hinttimer.Enabled:= true;

      ClientCnx.AnswerString(Flags,
         '',                            { Default Status '200 OK'            }
         '',                            { Default Content-Type: text/html    }
         'Pragma: no-cache' + #13#10 +  { No client caching please           }
         'Expires: -1'      + #13#10,   { I said: no caching !               }
          LoadPage('disconnect_stat.tpl',user,ClientCNX))
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
         LoadPage('disconnect_com.tpl',user,ClientCNX))
    else //wenn offline
         ClientCnx.AnswerString(Flags,
         '',                            { Default Status '200 OK'            }
         '',                            { Default Content-Type: text/html    }
         'Pragma: no-cache' + #13#10 +  { No client caching please           }
         'Expires: -1'      + #13#10,   { I said: no caching !               }
         LoadPage('disconnect_err.tpl',user,ClientCNX));
        end;
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
      begin  {clientcnx.Answer404} end
    else
    if (CompareText(ClientCnx.Path, '/cgi-bin/LeastCosterDial') = 0)    or
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
        if CompareText(ClientCnx.Path, '/cgi-bin/LeastCosterDial') = 0 then
            ProcessPostedData_LeastCosterDial(ClientCnx)
        else
        if CompareText(ClientCnx.Path, '/cgi-bin/sendmessage.html')=0 then
            ProcessPostedData_sendmessage(ClientCnx)
        else
        if CompareText(ClientCnx.Path, '/cgi-bin/deletemessage.html')=0 then
            ProcessPostedData_deletemessage(ClientCnx)
        else ClientCnx.Answer404; { We don't accept any other request }
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
    and(GetMD5(@Buffer[1], Length(Buffer) - 1) = UserSettings.ReadString(crypter.DoEncrypt(user),crypter.DoEncrypt('pass'),'nicht gefunden !!!!')))
  then
    begin

     for i:=1 to counter do  { Session speichern }
      if (user = UserSettings.ReadString('active','user_'+inttostr(i),'nichts eingetragen !!!')) then
       begin alreadyin:= true; break; end;

     if not alreadyin then
     begin
       UserSettings.writeinteger('active','count',counter+1);
       counter:= counter+1;
       UserSettings.writeString('active','user_'+inttostr(counter),user);
       UserSettings.writeString('active','ip_'+inttostr(counter),ClientCnx.PeerAddr);
       UserSettings.writeString('active','login_'+inttostr(counter),datetimetostr(now));

       Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+ misc(M251,'M251')+' ' +#9+ User + '@' + HostName  +#13#10;
       allowedip:= clientcnx.PeerAddr + ';';
       status:= buf;
     end;

      { HTML answer.}
     ClientCnx.AnswerString(Dummy,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header }
        LoadPage('loggedin.tpl',user,ClientCNX));
    end
    else //falsches Passwort oder Username
    begin
        Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) + #9+misc(M252,'M252') +' '+
                #9+ User + '@' + HostName  +#13#10;
        status:= buf;
        ClientCnx.AnswerString(Dummy,
        '',           { Default Status '200 OK'         }
        '',           { Default Content-Type: text/html }
        '',           { Default header                  }
        LoadPage('login_error.tpl', user, ClientCNX));
    end;
       { Save data to a text file }
    if not alreadyin then logfile_add(buf);
end;

procedure TWebServForm.ProcessPostedData_LeastCosterDial(
    ClientCnx : TMyHttpConnection);
var
    user, command, Tarif, basetime : string;
    HostName  : String;
    Buf       : String;
    Dummy     : THttpGetFlag;
    tarifnr, base : integer;
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

    if command = misc(M223,'M223') then
    begin
     if ( (dateof(now) <= strtodate(hauptfenster.liste.cells[13,tarifnr])) and (secondsbetween(hauptfenster.timeofliste, now) < 60) ) then
     begin
      hauptfenster.webzugriff:=true;
       hauptfenster.DialBtnClick(nil);
       { Build the record to write to data file }
        Buf      := FormatDateTime(' DD.MM.YYYY HH:NN:SS ', Now) +#9+misc(M253,'M253') +
                  #9+ User + '@' + HostName  +#13#10;
        status:= buf;
      { Save data to a text file }
       logfile_add(buf);

      { HTML answer.}
      hauptfenster.webzugriff:=true;
      if not hauptfenster.noballoon then
        hauptfenster.tray.ShowBalloonHint(misc(M236,'M236'),user +' '+misc(M254,'M254') ,bitinfo, 10);

      ClientCnx.AnswerString(Dummy,
          '',                            { Default Status '200 OK'            }
          '',                            { Default Content-Type: text/html    }
          'Pragma: no-cache' + #13#10 +  { No client caching please           }
          'Expires: -1'      + #13#10,   { I said: no caching !               }
          LoadPage('connect_dial.tpl', user, ClientCNX));
      end
      else
        ClientCnx.AnswerString(Dummy,
          '',                            { Default Status '200 OK'            }
          '',                            { Default Content-Type: text/html    }
          'Pragma: no-cache' + #13#10 +  { No client caching please           }
          'Expires: -1'      + #13#10,   { I said: no caching !               }
          LoadPage('connect_error.tpl', user,ClientCNX));
    end
   // wenn nicht action=Verbindung wählen
    else
    if command = misc(M224,'M224') then
    begin
          hauptfenster.surfdauer.position:= base;
          SurfTime:= base;
          ClientCnx.AnswerString({Flags}Dummy,
            '',                            { Default Status '200 OK'            }
            '',                            { Default Content-Type: text/html    }
            'Pragma: no-cache' + #13#10 +  { No client caching please           }
            'Expires: -1'      + #13#10,   { I said: no caching !               }
            LoadPage('connect_list.tpl', user, ClientCNX));
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
        LoadPage('message_sent.tpl',user,ClientCNX));
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

      if (UserSettings.ValueExists(crypter.DoEncrypt(user),crypter.doencrypt('nachricht'+inttostr(i)))) then
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

    HostName := ClientCnx.PeerAddr; { client's IP address}

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

procedure TWebServForm.userboxChange(Sender: TObject);
var i: integer;
begin
 i:= userbox.ItemIndex;
 if not (userbox.items[i]= misc(M118,'M118')) then username.Text:= userbox.items[i]
  else username.Text:='';
 pw.Text:= '';
 pw2.Text:= '';
 oldpw.Text:= '';
end;

procedure TWebServForm.Button1Click(Sender: TObject);
var oldpw_buf, pw_buf: string;
begin

if username.text <> '' then
begin
  oldpw_buf:= 'Sorry no password to read:'+oldpw.text + #0;
  pw_buf:= 'Sorry no password to read:'+pw.Text + #0;

  if UserSettings.sectionexists(webservform.crypter.doencrypt(username.text)) then
  begin
  if (GetMD5(@oldpw_buf[1], Length(oldpw_buf) - 1) = UserSettings.readstring(webservform.crypter.doencrypt(username.text),webservform.crypter.doencrypt('pass'),'no password!!')) then
    if (pw.text=pw2.text) then UserSettings.writestring(webservform.crypter.DoEncrypt(username.text),webservform.crypter.doencrypt('pass'),GetMD5(@pw_buf[1], Length(pw_buf) - 1))
      else showmessage(misc(M124,'M124'))
    else showmessage(misc(M125,'M125')) //falsches PW
  end
  else if (pw.text=pw2.text) then
  begin
    UserSettings.writestring(webservform.crypter.DoEncrypt(username.text),webservform.crypter.doencrypt('pass'),GetMD5(@pw_buf[1], Length(pw_buf) - 1));
    username.Text:='';
    oldpw.Text:='';
    pw.Text:= '';
    pw2.Text:= '';
  end
  else showmessage(misc(M124,'M124'));
end;
filluserbox;

end;

procedure TWebServForm.filluserbox;
var
  counter: integer;
begin
  UserSettings.ReadSections(userbox.items);

  userbox.ItemIndex := userbox.items.IndexOf('active');
  userbox.items.Delete(userbox.itemindex);

  if userbox.Items.count >0 then for counter:=0 to userbox.Items.Count-1 do
  begin
    userbox.items[counter]:=Webservform.crypter.DoDecrypt(userbox.items[counter])
  end;
  userbox.items.Append(misc(M118,'M118'));
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

if UserSettings.sectionexists(webservform.crypter.doencrypt(username.text)) then
  begin
  oldpw_buf:= 'Sorry no password to read:'+oldpw.text + #0;
  if (GetMD5(@oldpw_buf[1], Length(oldpw_buf) - 1)) = UserSettings.readstring(webservform.crypter.doencrypt(username.text),webservform.crypter.doencrypt('pass'),'no password!!') then
    UserSettings.erasesection(webservform.crypter.DoEncrypt(username.text))
      else showmessage(misc(M125,'M125'))
  end;
end;
filluserbox;
username.Text:='';
oldpw.Text:='';
pw.Text:= '';
pw2.Text:= '';
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

procedure TWebServForm.PortEditKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9', Char(VK_BACK)]) then
  Key := #0;
end;
procedure TWebServForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 //Server Autostart
  settings.writebool('Server','Autostart',serverautostart.Checked);
  settings.writestring('Server','Port',Portedit.text);
end;

procedure TWebServForm.GroupBox2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 memo1.text:= misc(Help79,'Help79');
end;

procedure TWebServForm.PortEditMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help80,'Help80');
end;

procedure TWebServForm.StartButtonMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help81,'Help81');
end;

procedure TWebServForm.StopButtonMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help82,'Help82');
end;

procedure TWebServForm.serverautostartMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help83,'Help83');
end;

procedure TWebServForm.GroupBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  memo1.text:= misc(Help84,'Help84');
end;

procedure TWebServForm.usernameMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help85,'Help85');
end;

procedure TWebServForm.oldpwMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help86,'Help86');
end;

procedure TWebServForm.pwMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help87,'Help87');
end;

procedure TWebServForm.pw2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  memo1.text:= misc(Help88,'Help88');
end;

end.

