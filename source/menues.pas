unit menues;

interface
  procedure TarifStatusClick(sender: TObject; row: integer);
  procedure MainMenueClick(sender: TObject);
  procedure TrayMenueClick(sender: TObject);

implementation
uses unit1, tarifverw,Graphics, DateUtils, SysUtils, unit6,
     forms, CoolTrayIcon, Tarifmanager, shellapi,
     Windows, unit3, floating, addons, dialogs, files,
     unit2, unit9, strUtils, shutdown, Protokolle, html, inilang, messagestrings;

procedure TarifStatusClick(sender: TObject; row: integer);
var datum: TDateTime;
    i, k: integer;
    found: boolean;
begin
with hauptfenster do
    if sender = TS1 then
      begin
       for i:= 1 to length(hauptfenster.Selected)-1 do
        if hauptfenster.selected[i] then ToggleSuspendScores(liste.cells[1,i]);
        AktualisierenClick(sender);
      end
    else
    if Sender = TS2_1 then
     ResetExpireDate(liste.cells[1,row],liste.cells[8,row],liste.cells[12,row],liste.cells[13,row], Dateof(yesterday))
    else
    if Sender = TS2_2 then
     ResetExpireDate(liste.cells[1,row],liste.cells[8,row],liste.cells[12,row],liste.cells[13,row], Dateof(now))
    else
    if Sender = TS2_3 then
     ResetExpireDate(liste.cells[1,row],liste.cells[8,row],liste.cells[12,row],liste.cells[13,row], Dateof(tomorrow))
    else
    if Sender = TS2_4 then
     ResetExpireDate(liste.cells[1,row],liste.cells[8,row],liste.cells[12,row],liste.cells[13,row], Dateof(incday(now,7)))
    else
    if Sender = TS2_5 then
     begin
        tag:= 32;
        repeat
         tag:= tag-1;
        until tryencodedate(yearof(now), monthof(now),tag, datum) = true;
        ResetExpireDate(liste.cells[1,row],liste.cells[8,row],liste.cells[12,row],liste.cells[13,row], Dateof(datum));
     end
    else
    if sender = TS3_1 then //neue Farben hinzufügen
      begin
       if ColorDialog.execute then
        for k:= 1 to length(selected)-1 do
          if selected[k] then
          begin
          found:= false;
          for i:= 0 to length(Scores)-1 do
            if (Scores[i].Name = liste.cells[1, k]) then begin found:= true; break; end;

          if not found then
          begin
          i:= length(Scores);
          setlength(Scores,length(Scores)+1);
          Scores[i].Name:= liste.cells[1, row];
          Scores[i].gesamt     := 0;
          Scores[i].erfolgreich:= 0;
          Scores[i].state      := 0;
          Scores[i].Color      := ColorToString(ColorDialog.color);
          end
          else
            Scores[i].Color := ColorToString(ColorDialog.color);
            liste.Repaint;
         end;
      end
    else
    if sender = TS3_2 then
      begin
       for k:= 1 to length(selected)-1 do
         if selected[k] then
           if length(Scores) > 0 then
            for i:= length(Scores) -1 downto 0 do
               if (liste.cells[1, k] = Scores[i].Name) then Scores[i].Color:= 'none';
       liste.Repaint;
      end
    else
    if sender = TS3_3_1 then //Einwahl-Farbe
    begin
     ColorDialog.Color:= StringToColor(settings.ReadString('Basics','Color_E', ColortoString(RGB(250,250,200))));
     if ColorDialog.execute then
       settings.WriteString('Basics','Color_E', ColorToString(ColorDialog.Color));
     liste.repaint;
    end
    else

   if sender = TS3_3_2 then //Einwahl-Farbe
    begin
     ColorDialog.Color:= StringToColor(settings.ReadString('Basics','Color_K', ColortoString(RGB(230,230,250))));
     if ColorDialog.execute then
        settings.WriteString('Basics','Color_K', ColortoString(ColorDialog.Color));
     liste.repaint;
    end
    else

    if sender = TS3_3_3 then //Blacklist-Farbe
    begin
     ColorDialog.Color:= StringToColor(settings.ReadString('Basics','Color_K', ColortoString(RGB(255,220,200))));
     if ColorDialog.execute then
      settings.WriteString('Basics','Color_K', ColortoString(ColorDialog.Color));

     liste.repaint;
    end
    else
    if sender = TS3_3_4 then //abgelaufen-Farbe
    begin
     ColorDialog.Color:= StringToColor(settings.ReadString('Basics','Color_A', ColortoString(RGB(255,220,220))));
     if ColorDialog.execute then
        settings.WriteString('Basics','Color_A', ColortoString(ColorDialog.Color));
     liste.repaint;
    end
    else

    if sender = TS3_3_5 then //Normal-Farbe
    begin
     ColorDialog.Color:= StringToColor(settings.ReadString('Basics','Color_N', ColortoString(RGB(200,230,220))));
     if ColorDialog.execute then
        settings.WriteString('Basics','Color_N', ColortoString(ColorDialog.Color));
     liste.Repaint;
    end
    else

    if sender = TS4 then
      begin
      for i:= 1 to length(hauptfenster.Selected)-1 do
       if hauptfenster.selected[i] then ResetSuspendScores(liste.cells[1,i]);
        AktualisierenClick(sender);
      end
    else
    if sender = TS5 then
    begin
      LoescheTarif(liste.cells[1, row],liste.cells[8,row],liste.cells[12,row],liste.cells[13,row]);
    end
    else
    if sender = TS6_1 then//keine Einwahl
    begin
      TS6_1.checked:= not TS6_1.Checked;
      connectionCostVisible:=not TS6_1.Checked;
      AktualisierenClick(sender);
    end
    else
    if sender = TS6_2 then//keine Farben benutzen
    begin
      TS6_2.checked:= not TS6_2.Checked;
      usecolors:= not TS6_2.Checked;
      AktualisierenClick(sender);
    end;
end;

procedure MainMenueClick(sender: TObject);
var lcx: boolean;
begin
with hauptfenster do
  if sender = MM1_1 then
  begin
    if ( ( not assigned(wndlist)) and (not TarifeDisabled)) then
       begin
         Application.CreateForm(Twndlist, wndlist);
         wndlist.ok.Caption:= misc(M192,'M192');
         wndlist.Caption.Caption:= misc(M192,'M192');
         wndlist.show;
       end;
  end
  else
  if sender = MM1_2 then
  begin
    if not assigned(wndlist) then
     begin
      Application.CreateForm(Twndlist, wndlist);
      wndlist.ok.Caption:= misc(M193,'M193');
      wndlist.Caption.Caption:= misc(M193,'M193');
      wndlist.show;
   end;
  end
  else
  if sender = MM1_5_1 then
  begin
    if not assigned(htmlwindow) then
    Application.CreateForm(Thtmlwindow, htmlwindow);

    htmlwindow.startedfrommainform:= true;
    hauptfenster.enabled:=false;
    htmlwindow.show;
  end
  else
  if sender = MM1_7 then
  begin
    LoescheAbgelaufeneTarife;
    AktualisierenClick(sender);
  end
  else
  if sender = MM1_9 then
  begin
   tray.hidemainform;
   if not noballoon then tray.ShowBalloonHint(misc(M01,'M01'), misc(M02,'M02'), bitInfo, 10);  end
  else
  if sender = MM1_10 then
  begin
    autoclose:= true;
    closeallowed:= true;
    hauptfenster.close;
  end
  else
  if sender = MM2_1 then //Tarifmanager
  begin
    if ( (not assigned(Taverwaltung)) and (not TarifeDisabled)) then
    begin
    Application.CreateForm(TTaVerwaltung, TaVerwaltung);
    TaVerwaltung.Show;
    end;
  end
  else
  if sender = MM2_2_1 then //Monatsstatistik
  begin
//   Protokolle.CreateAllLogs;      //passiert nach jedem abspeichern
//   Protokolle.WebAuswertungErstellen;
   ShellExecute(0,'open',Pchar(extractfilepath(paramstr(0))+'www\log\index.htm'),Pchar ('') ,nil,SW_SHOWNORMAL);
  end
  else
  if sender = MM2_2_2 then //EVN
  begin
    if not assigned(auswert) then
    begin
     Application.CreateForm(Tauswert, auswert);
     auswert.show;
    end;
  end
  else
  if sender = MM2_3_1 then //OnlineInfo
  begin

    if selfdial and (not Assigned(floatingW)) then
    begin
     Application.CreateForm(TfloatingW, floatingW);
     floatingW.tarif.caption:= onlineset.Tarif;
     if settings.ReadBool('OnlineInfo', 'AutoWidth', true) then floatingW.setwidth;
     floatingW.valid.caption:= TimeToStr(onlineset.vbegin) + '-'+ TimeToStr(onlineset.vend);
     floatingW.preis.caption:= Format('%.2f c/min',[onlineset.preis]);
     floatingW.Show;
    end;
  end
  else
  if sender = MM2_3_2 then //Atomzeitupdate
  begin
    sntptimer.Enabled:= false;
    sntptimerTimer(sender);
  end
  else
  if sender = MM2_3_3 then //RSS
  begin
   if not rssrunning then
   begin
     rsstimer.enabled:= false;
     rsstimertimer(sender);
   end;
  end
  else
  if sender = MM2_3_4 then //Updates
  begin
   if not isexerunning('update.exe') then  ShellExecute(0,'open',Pchar(extractfilepath(paramstr(0))+'update.exe'),Pchar ('') ,nil,SW_SHOWNORMAL);
  end
  else
  if sender = MM2_4_1 then //Onlineprogs starten
  begin
   progcount:= 0;
   loadprogs;
  end
  else
  if sender = MM2_4_2 then //Offlineprogs starten
  begin
   progcountoff:=0;
   loadprogsoff;
  end
  else
  if sender = MM2_5 then //Newsletter
  begin
    ShellExecute(Application.Handle, 'open',
    PChar('https://lists.berlios.de/mailman/listinfo/leastcosterxp-news'), nil, nil, sw_ShowNormal);
  end
  else
  if sender = MM2_7_1 then
  begin

   lcx:= false;
   try //Dateiendung lcz und lcx installieren
    if InstallExt('.lcx', 'LeastCosterXP Xport', misc(M194,'M194'), ParamStr(0), '%1',0)
     then lcx:= true;

    if lcx then
    Showmessage('*.lcx '+misc(M212,'M212'));

   except end;
  end
  else
  if sender = MM2_7_2 then
  begin
    lcx:= false;
    if UnInstallExt('.lcx') then lcx:= true;

    if lcx then
    Showmessage('*.lcx '+misc(M213,'M213'));

  end
   else
   if sender = MM3_1 then //Einstellungen
   begin
    timer_an.enabled:= false;
    timer_aus.enabled:= false;

    if not assigned(LCXPSettings) then Application.CreateForm(TLCXPSettings, LCXPSettings);
   end
   else
   if sender = MM5_1 then
   begin
    if not assigned(info) then
     begin
       Application.CreateForm(TInfo, Info);
       info.show;
     end;
   end
   else
   if sender = MM5_2 then //Hilfe
    ShellExecute(Application.Handle, 'open',PChar('http://www.dsl-fuer-assamstadt.de/lcxp'), nil, nil, sw_ShowNormal)
   else
   if sender = MM7_1 then //standby
   begin
    if isonline then fastDisconnectOnExit;
    shutdown.SetStandby(true);
   end
   else
   if sender = MM7_2 then //Hibernate
   begin
     if isonline then fastDisconnectOnExit;
      shutdown.SetStandby(false);
   end
   else
   if sender = MM7_4 then
   begin
    if isonline then fastDisconnectOnExit;
      shutdown.ShutdownWindows(swtlogoff);
   end
   else
   if sender = MM7_5 then
   begin
    if isonline then fastDisconnectOnExit;
      shutdown.ShutdownWindows(swtshutdownpoweroff);
   end
   else
   if sender = MM7_6 then
   begin
     if isonline then fastDisconnectOnExit;
      shutdown.ShutdownWindows(swtrestart);
   end;
end;

  procedure TrayMenueClick(sender: TObject);
  begin
  with hauptfenster do
   if sender = PM12 then MainMenueClick(MM1_10)
   else
   if sender = PM13_1 then MainMenueClick(MM7_1)
   else
   if sender = PM13_2 then MainMenueClick(MM7_2)
   else
   if sender = PM13_3 then MainMenueClick(MM7_4)
   else
   if sender = PM13_4 then MainMenueClick(MM7_5)
   else
   if sender = PM13_5 then MainMenueClick(MM7_6);
  end;

end.
