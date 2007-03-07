unit SocketUtils;

interface
uses scktcomp;

procedure StartSocket;
procedure StopSocket;
Procedure SocketMessage(Sender: TObject; Socket: TCustomWinSocket);

implementation

uses main;



end.
