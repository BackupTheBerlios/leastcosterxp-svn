unit Zeitupdate;

interface
uses sysutils, classes, strUtils, CoolTrayIcon, messagestrings, SNTPSend;

type
  TZeitThread = class(TThread)
  protected
   procedure Execute; override;
  public
   procedure MyTerminate(sender: TObject);
end;

implementation
uses unit1, inilang, Dateutils;

procedure TZeitThread.MyTerminate(sender: TObject);
begin
 timeupdaterunning:= false;
end;

procedure TZeitThread.Execute;
var   log: textfile;
      SNTPTime: TSntpSend;
      error: boolean;
      oldtime: TDateTime;
begin
error:= false;
with Hauptfenster do
begin
LedTime.ColorOff:= $009D9D9D;
LedTime.Hint:= misc(M103,'M103') +' ('+ timetostr(timeof(now)) + ' )';

if not isonline or (atomserver.count = 0) then
begin //wenn offline tue nix
      MM2_3_2.Enabled:= true; //Atomzeitabgleich im Menü aktivieren
      timeupdaterunning:= false;
      exit;
end;

MM2_3_2.Enabled:= false; //Atomzeitabgleich im Menü deaktivieren

if (IPAdress = '0.0.0.0') or (IPAdress='') then
begin // wenn keine IP, dann setze eine Runde aus
      MM2_3_2.Enabled:= true; //Atomzeitabgleich im Menü aktivieren
      sntptimer.interval:= 5000;
      sntptimer.Enabled:= true;
      timeupdaterunning:= false;
      exit;
end;

//Atomzeitserver setzen
 if atomcount < atomserver.Count then
 begin

//Datei anlegen, wenn sie nicht existiert und öffnen
     assignfile(log,extractfilepath(paramstr(0))+'log\atomzeit.txt');
     if fileexists( extractfilepath(paramstr(0))+'log\atomzeit.txt') then
      append(log)
     else
     begin
      rewrite(log);
      writeln(log,misc(M105,'M105') + #9 + misc(M106,'M106') + #9 + misc(M107,'M107')+ #9 + misc(M108,'M108'));
     end;
 //zeile hinzufügen
      writeln(log,datetimetostr(now) +#9+misc(M104,'M104')+' ' + atomserver.strings[atomcount]);

   SNTPtime:= TSNTPSend.Create;
   try
     SNTPtime.TargetHost:= atomserver.strings[atomcount];
     SNTPtime.SyncTime:= true;
     SNTPtime.Timeout:= 10000;
     SNTPtime.MaxSyncDiff:= 1.7*10E308;

     atomcount:= atomcount+1;
     if atomcount = atomserver.Count then atomcount:= 0;

    oldtime:= now;
    if SNTPtime.GetSNTP = true then
     begin
      writeln(log,datetimetostr(oldtime) +chr(9)+datetimetostr(now)+ chr(9)+timetostr(now-oldtime) + chr(9) + SNTPtime.targethost);
      MM2_3_2.Enabled:= true; //Atomzeitabgleich im Menü aktivieren

      LEDTime.ColorOff:= $0000F900;
      LEDTime.ledon:= false;
      LedTime.Hint:= misc(M109,'M109')+ ' ('+ timetostr(timeof(now)) +')';
   end
   else //wenn nicht erfolgreiches update
   begin
    writeln(log,datetimetostr(now) + #9 + misc(M110,'M110')+' '+SNTPtime.targethost );
    sntptimer.interval:= 5000;
    error:= true;
   end;

  finally
    SNTPtime.Free;
    closefile(log);
   end;
  end;

 if error then
 begin
     sntptimer.Enabled:= true; //wenn nicht erfolgreich nochmal starten
//     timeupdaterunning:= false;
     exit;
 end;
//wenn erfolgreich, dann neues Interval setzen
sntptimer.interval:= settings.ReadInteger('Onlinecheck','Atominterval', 60)*60000;
//nur neu starten, wenn wiederholt werden soll
sntptimer.Enabled:= settings.ReadBool('Onlinecheck','AtomRepeat',false);
//timeupdaterunning:= false;
end;
end;

end.

