UNIT Files;


INTERFACE
uses Windows , SysUtils, Registry, Classes, shellapi, zlib;

function DelDir(Dir : String) : Boolean;
function InstallExt(Extension, ExtDescription, FileDescription,
OpenWith, ParamString: string; IconIndex: Integer = 0): Boolean;
function UnInstallExt(Extension: String): Boolean;
function GetFileVersion(Path: string): string;
function daten_zaehlen(Filename:string):integer;
procedure Filecopy(sourcefilename, targetfilename: string);
function FileExists(FileName: string): Boolean;
procedure datei_erzeugen(FileName:string);
procedure ini_anhaengen(zeile: string);
procedure verzeichnis_erzeugen(FolderName: string);
function DeleteFileToRecycleBin(const AFile: string): boolean;
procedure Compress(InputFileName, OutputFileName: string);
procedure Decompress(InputFileName, OutputFileName: string);

IMPLEMENTATION

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

function InstallExt(Extension, ExtDescription, FileDescription,
OpenWith, ParamString: string; IconIndex: Integer = 0): Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  if Extension <> '' then
  begin
    if Extension[1] <> '.' then
      Extension := '.' + Extension;

    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CLASSES_ROOT;
      if Reg.OpenKey(Extension, True) then
      begin
       Reg.WriteString('', ExtDescription);
       if Reg.OpenKey('\' + ExtDescription, True) then
       begin
         Reg.WriteString('', FileDescription);
         if Reg.OpenKey('DefaultIcon', True) then
         begin
           Reg.WriteString('', Format('%s,%d', [OpenWith, IconIndex]));
           if Reg.OpenKey('\' + ExtDescription + '\Shell\Open\Command', True) then
           begin
             Reg.WriteString('', Format('"%s" "%s"', [OpenWith, ParamString]));
             Result:=True;
           end;
         end;
       end;
     end;
  finally
    Reg.Free;
  end;
  end;
end;

function UnInstallExt(Extension: String): Boolean;
var
  Reg: TRegistry;
  Description: String;
begin
  Result := False;
  if Extension <> '' then
    begin
    if Extension[1] <> '.' then
      Extension := '.' + Extension;
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CLASSES_ROOT;
      if Reg.KeyExists(Extension) then
        begin
        Reg.OpenKey(Extension, false);
        Description:=Reg.ReadString('');
        Reg.CloseKey;
        if Reg.KeyExists('\'+Description) then
          Result:=Reg.DeleteKey(Extension) and Reg.DeleteKey('\' + Description);
        end;
    finally
      Reg.Free;
    end;
  end;
end;



function GetFileVersion(Path: string): string;
var
  lpVerInfo: pointer;
  rVerValue: PVSFixedFileInfo;
  dwInfoSize: cardinal;
  dwValueSize: cardinal;
  dwDummy: cardinal;
  lpstrPath: pchar;

begin
  if Trim(Path) = EmptyStr
  then lpstrPath := pchar(ParamStr(0))
  else lpstrPath := pchar(Path);

  dwInfoSize := GetFileVersionInfoSize(lpstrPath, dwDummy);

  if dwInfoSize = 0
  then begin
    Result := 'No version specification';
    Exit;
  end;

  GetMem(lpVerInfo, dwInfoSize);
  GetFileVersionInfo(lpstrPath, 0, dwInfoSize, lpVerInfo);
  VerQueryValue(lpVerInfo, '\', pointer(rVerValue), dwValueSize);

  with rVerValue^ do
  begin
    Result := IntTostr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntTostr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntTostr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntTostr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(lpVerInfo, dwInfoSize);

end; {function GetFileVersion() ...}

function daten_zaehlen(Filename:string):integer;
var F: textfile;
    hilf: integer;
    zeile:string;
begin
     assignfile(F,FileName);
     reset(F);
     hilf:= 0;
     Repeat begin
      readln(F,zeile);
      If zeile[1]='[' then hilf:= hilf+1;
      end;
     until eof(F)=true;
closefile(F);
daten_zaehlen:=hilf;
end;

procedure Filecopy(sourcefilename, targetfilename: string);
Var
   S,T: TFileStream;
   f: file;
 Begin
   if not fileexists(targetfilename) then
   begin
   assignfile(f, targetfilename);
   rewrite(f);
   closefile(f);
   end;
   S:=TFileStream.Create( sourcefilename, fmOpenRead );
   try
     T:=TFileStream.Create( targetfilename, fmOpenWrite );
     try
        T.CopyFrom(S, S.Size ) ;
     finally
        T.Free;
     end;
   finally
      S.Free;
   end;
  End;

function FileExists(FileName: String): Boolean;
{ Boolean function that returns True if the file exists;otherwise,
   it returns False. Closes the file if it exists. }
var
  F: textfile;
begin
  {$I-}
  Assignfile(F, FileName);
  Reset(F);
  closefile(F);
  {$I+}
  FileExists := (IOResult = 0) and (FileName <> '');
end;  { FileExists }

procedure datei_erzeugen(FileName:string);
var F: textfile;
begin
  assignfile(F, FileName);
  Rewrite(F);
  closefile(F);
end;

procedure ini_anhaengen(zeile: string);
var hilf: textfile;

begin
if fileexists('lcr.$$$') then
begin
assignfile(hilf,'lcr.$$$');
append(hilf);
writeln(hilf,zeile);
closefile(hilf);
end else
begin
datei_erzeugen('lcr.$$$');
assignfile(hilf,'lcr.$$$');
append(hilf);
writeln(hilf,zeile);
closefile(hilf);
end;
end;

procedure verzeichnis_erzeugen(FolderName: string);
begin
  {$I-}
  MkDir(FolderName);
  if IOResult <> 0 then begin end {verzeichnis besteht schon}
    else
 
end;

function DeleteFileToRecycleBin(const AFile: string): boolean;
var
  Operation: TSHFileOpStruct;
begin
  with Operation do
  begin
//    Wnd := Application.Handle;
    wFunc := FO_DELETE;
    pFrom := PChar(AFile +#0);
    pTo := Nil;
    { in den Papierkorb verschieben / keine
      Sicherheitsabfrage }
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
  end;
  Result := SHFileOperation(Operation) = 0;
end;

procedure Compress(InputFileName, OutputFileName: string);
var InputStream, OutputStream: TFileStream;
  CompressionStream: ZLib.TCompressionStream;
begin
  InputStream:=TFileStream.Create(InputFileName, fmOpenRead);
  try
    OutputStream:=TFileStream.Create(OutputFileName, fmCreate);
    try
      CompressionStream:=TCompressionStream.Create(clMax, OutputStream);
      try
        CompressionStream.CopyFrom(InputStream, InputStream.Size);
      finally
        CompressionStream.Free;
      end;
    finally
      OutputStream.Free;
    end;
  finally
    InputStream.Free;
  end;
end;

procedure Decompress(InputFileName, OutputFileName: string);
var InputStream, OutputStream: TFileStream;
  DeCompressionStream: ZLib.TDeCompressionStream;
  Buf: array[0..4095] of Byte;
  Count: Integer;
begin
  InputStream:=TFileStream.Create(InputFileName, fmOpenRead);
  try
    OutputStream:=TFileStream.Create(OutputFileName, fmCreate);
    try
      DecompressionStream := TDecompressionStream.Create(InputStream);
      try
        while true do
        begin
          Count := DecompressionStream.Read(Buf[0], SizeOf(Buf));
          if Count = 0 then
            break
          else
            OutputStream.Write(Buf[0], Count);
        end;
      finally
        DecompressionStream.Free;
      end;
    finally
      OutputStream.Free;
    end;
  finally
    InputStream.Free;
  end;
end;



BEGIN
END. 
