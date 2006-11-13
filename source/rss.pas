unit downloadrss;

interface

uses menus;

type
  TInhalt = record
    title, date, author, link, description: String;
  end;

  procedure RssNotify(Sender: TObject);

var outputauthor, outputlink, outputtitle, outputdate, outputdesc: boolean;
    start: boolean;
    count: integer;
    sections: array[0..25] of TInhalt;
  
implementation

procedure RssNotify(Sender: TObject);
begin
with sender as TMenuItem do begin end;//showmessage(inttostr(tag));
end;

end.
