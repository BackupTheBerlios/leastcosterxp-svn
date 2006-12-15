unit StringRoutine;

interface
Function GetWordOfAnsiString(Text : string; WordPos : Word; Delimiter: char): string;
procedure ShortenLogFiles(LogFile: string; DaysToSave: integer);

implementation

uses Classes, SysUtils, Controls, DateUtils, RegExpr;

Function GetWordOfAnsiString(Text : string; WordPos : Word; Delimiter: char): string;
var count,i,j: integer;
    output: string;
begin
count:= 0;
output:= '';
i:=0;
//finde String durch abzählen der Delimiter
if wordpos >1 then
for i:= 1 to Length(Text)-1 do
begin
 if Text[i] = Delimiter then Inc(count);
 if count = WordPos - 1 then break;
end;

//kopiere Zeichen für zeichen bis zum nächsten Delimiter oder bis zum Ende
for j:= i+1 to Length(Text) do
begin
 if Text[j] = Delimiter then break;
 output:= output + Text[j];
end;

Result:= output;
end;

procedure ShortenLogFiles(LogFile: string; DaysToSave: integer);
var zeilen: TStringlist;
    timestamp: string;
    DateOfTimeStamp: TDate;
    i: integer;
begin
 if fileexists(LogFile) then
 begin
  zeilen:= TStringList.create;
  zeilen.LoadFromFile(LogFile);
  for i:= zeilen.Count-1 downto 0 do
  begin
   timestamp:= trim(GetWordOfAnsiString(zeilen.Strings[i],1,#9));
   try
    DateOfTimeStamp:= Dateof(StrtoDateTime(timestamp));
    if (daysbetween(dateof(now), DateofTimeStamp) > DaysToSave) then
     zeilen.Delete(i);
   except
    continue;
   end;
  end;
  zeilen.SaveToFile(LogFile);
  zeilen.free;
 end;
end;

end.
 