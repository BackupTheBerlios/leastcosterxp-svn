unit messagestrings;

interface
const
	cr=#13#10;
//unit1
  M01='Hinweis';
  M02='Der LeastCoster ist nun im Tray minimiert.' + cr + 'Doppelklick zum maximieren.';

  M03='Wenn Sie LeastCosterXP jetzt beenden, wird die aktuelle Verbindung getrennt ! Schlie�en ?';
  M04='Wenn Sie LeastCosterXP jetzt beenden, wird die aktuelle Verbindung nicht protokolliert ! Schlie�en ?';
  M05='Beim Beenden stehen die WebInterface-Funktionen nicht mehr zur Verf�gung ! Schlie�en ?';

  M06='Automatisches Trennen';
  M07='Rufnummer';
  M08='Verbindung';

  M09='Ende des Freikontingents';

  M12='ct';
  M13='�';

  M17='Gro�e Zeitdifferenz nach Atomzeitupdate';
  M18='Der gew�hlte Tarif ist noch g�ltig.';
  M19='Trennen ist nicht n�tig.';
  M20='Der gew�hlte Tarif ist im Moment NICHT g�ltig.';
  M21='Trennen wird empfohlen!';

  M24='&W�hlen';
  M25='Autoeinwahl gescheitert.';
  M26='Verbindung beendet.';

  M27='�bersicht aller aktiven Verbindungen';
  M28='Verbindungen';
  M29='Ihre Verbindung: ';
  M30='Verbindung Nr.';
  M31='Name';
  M32='Modemtyp';
  M33='Modemname';
  M34='Multilinkger�te';
  M35='Download';
  M36='Upload';

  M37='Verbindung getrennt, weil Windows beendet wird.';
  M38='Bitte die Einstellungen �berpr�fen !';
  M39='Dies scheint der erste Start vom LeastCosterXP zu sein. Bitte nehmen Sie zun�chst alle Einstellungen vor.';

  M40='Verbindung getrennt und LeastCosterXP beendet.';
  M41='Starte Programm';
  M42='l�uft bereits.';
  M43='existiert nicht.';

  M44='Kein RAS installiert !';

  M45='Das automatische Atomzeitupdate ist deaktiviert.';
  M46='RSSFeeds sind deaktiviert.';
  M47='Programm bereit.';

  M48='Onlinezeit';
  M49='Dauer';
  M50='Kosten';

  M51='Einwahl erfolglos.';
  M52='W�hlen abgebrochen.';

  M53='a&bbrechen';
  M54='Die Verbindung';
  M55='wird getrennt.';
  M56='Pr�fe Anfrage ...';
  M57='Keine Einwahl solange ''Zeige beliebige Zeit'' aktiviert ist !';
  M58='Die Tarifliste ist �lter als 60s. Sie wird aktualisiert.' + cr + 'Bitte danach erneut versuchen';
  M59='Kein Eintrag in der Tarifliste aktiv.';
  M60='Dieser Tarif ist am ';
  M61='abgelaufen.';
  M62='Ein unbekannter Fehler trat auf. Bitte die Liste aktualisieren und neu versuchen zu w�hlen.';
  M63='Tarife der Blacklist werden nicht gew�hlt.';
  M64='Es wurde kein g�ltiges Modem eingtragen !';
  M65='W�hle ... ';
  M67='Anwahlversuch (LeastCosterXP)';

  M68='Tarif wurde ver�ndert !';
  M69='Onlinesession vorbereitet';

  M70='Empf�nger nicht eindeutig.';
  M71='Datei zum Anh�ngen nicht gefunden';
  M72='Datei zum Anh�ngen konnte nicht ge�ffnet werden.';
  M73='Empf�ngertyp nicht MAPI_TO, MAPI_CC oder MAPI_BCC.';
  M74='Unbekannter Fehler.';
  M75='Nicht genug Speicher.';
  M76='Benutzerlogin (z.B. bei Outlook) fehlgeschlagen.';
  M77='Text zu gro�.';
  M78='Benutzer hat Senden abgebrochen oder MAPI nicht installiert.';

  M79='Die Verbindung wurde soeben getrennt.';
  M80='Verbindung getrennt (automatisch ausgel�st)';

  M81='Online/Connected';
  M82='&Trennen !';
  M83='Verbunden mit';
  M84='Letzte Onlinesession dauerte';
  M85='Verbindung getrennt';
  M86='ist ein ung�ltiger Paramter.';
  M87='kein RSS-Update (nicht online)';

  M88='Ihre Verbindung ist im Leerlauf.';
  M89='aktiv';
  M90='inaktiv';

  M91='Automatisches Verbinden';
  M92='gew�hlt.';
  M93='Sekunden';

  M94='Die aktuelle IP-Adresse Ihres Computers lautet';
  M95='Diese eMail wurde automatisch versandt und ist ein'
       + ' Service bereitgestellt von LeastCosterXP ( http://www.leastcosterxp.de )'
       + cr+cr
       + 'Keine Haftung f�r unerw�nschtes Spamming. Sollten Sie diese eMail bekommen,'
       +' ohne zu wissen warum, so wenden Sie sich direkt an den Absender.';
  M96='Ihr LeastCosterXP WebInterface';

  M97='Es wurden Dateien heruntergeladen, die jetzt ausgetauscht werden. Soll sich LeastCosterXP jetzt neu starten ?' +cr+cr
      +'Bitte warten Sie ab, bis LeastCosterXP von selbst neu startet!';

  M98='abgelaufen';
  M99='Die Kosten k�nnen nicht berechnet werden. Der aktuelle Preis ist unbekannt !';

  M100='Durchschnittliche Kosten/min';
  M101='aus Blacklist entfernen';
  M102='zur Blacklist hinzuf�gen';

  M103='Atomzeit-Update gestartet';
  M104='Starte Atomzeit-Update mit';
  M105='alte Zeit';
  M106='neue Zeit';
  M107='Zeitdifferenz in s';
  M108='Server';
  M109='Erfolgreiches Atomzeit-Update';
  M110='Fehler beim Verbinden mit';

  M111='ganztags';
  M112='ung�ltig seit';
  M113='noch frei';

  M114='Die Automatische Einwahl ist aktiviert.';
  M115='Die Automatische Einwahl ist deaktiviert.';

//unit2
  M116= 'ist ein ung�ltiger Eintrag.';
  M117= 'Titelleiste von';
  M118= '<neuer User>';
  M119= 'OK';

  M120= 'Die Titelzeile von';
  M121= 'ist nicht eingetragen. Bitte korrigieren !!';

  M122= 'Noch kein Atomzeit-Update seit dem Start.';
  M123= 'Noch kein Rss-Feed Update seit dem Start.';

  M124= 'Die beiden Passwortfelder stimmen nicht �berein !';
  M125= 'falsches Passwort !';
  M126= 'Titel nicht gefunden. Bitte Versuch wiederholen.';
  M127= 'Fehler beim L�schen von';
  M128= '&speichern';
  M129= '&hinzuf�gen';

  M130= 'aktiviert';
  M131= 'aktivieren';
  M132= 'deaktiviert';
  M133= 'deaktivieren';
  M134= 'L�schen Sie nun das folgende Verzeichnis:';

//unit3
  M135= 'Nr.';
  M136= 'Datum';
  M137= 'Uhrzeit';
  M138= 'Dauer';
  M139= 'Kosten';
  M140= 'Tarif';
  M141= 'getrennt um ..';
  M142= 'Rufnr.';
  M143= 'Anmerkungen';

  M144= 'Sortiere Datens�tze ... ';
  M145= 'Lade Datens�tze ... ';
  M146= 'Fehler: Endzeit liegt vor der Startzeit.';
  M147= 'Fehler: Startzeitpunkt liegt in der Zukunft.';
  M148= 'Keine Datens�tze gefunden ... ';
  M149= 'unbekannt';
  M150= 'Speichere Kommentare ... ';
  M151= 'Export des Einzelverbindungsnachweises';
  M152= 'Einzelverbindungs�bersicht';
  M153= 'Gesamtdauer';
  M154= 'Teilsumme';
  M155= 'Gesamtsumme';

//unit4
  M156= 'Windows beenden geblockt !';
//TarifManger
  M157= 'Hinweis: Es wurde keine Webseite angegeben.';
  M158= 'Hinweis: Startzeit gleich Endzeit: ''Ganztags'' wurde aktiviert.';
  M159= 'Eintragen abgebrochen: Bitte rote Markierungen beachten !';
  M160= 'Tarif�berschneidung, bitte Daten korrigieren.';

  M161= 'ja';
  M162= 'nein';
  M163= '&Tarif hinzuf�gen';

  M164= 'G�ltigkeit';
  M165= 'Beginn';
  M166= 'Ende';
  M167= 'Preis';
  M168= 'Einwahl';
  M169= 'Takt';
  M170= 'Nummer';
  M171= 'User';
  M172= 'Passwort';
  M173= 'Webseite';
  M174= 'g�ltig ab';
  M175= 'g�ltig bis';
  M176= 'eingetragen';
  M177= 'L�schen bei Ablauf';
  M178= 'Tarif-Editor';

  M179= 'Dieser Tarif befindet sich auf der Whitelist. Klick zum Umschalten';
  M180= 'Dieser Tarif befindet sich auf der Blacklist. Klick zum Umschalten';

  M181= 'Eintrag &l�schen';
  M182= 'Der Tarif wird verwaltet von';

  M183= 'Achtung : Mehrfachauswahl.' + cr +
                      'Beim �ndern werden die Daten f�r alle markierten Datens�tze �bernommen. Ausnahme sind die Felder "Beginn" und "Ende".';
  M184= 'Eintr�ge &l�schen';
  M185= 'Eintrag &l�schen';

  M186= 'N�chster Reset';
  M187= 'Mit dem Zur�cksetzen der Z�hler werden bestehende Kontingente wieder aktiviert. '
        +cr+'Wirklich zur�cksetzen ?';
  M188= 'Achtung: Z�hler-Reset !';
  M189= 'Achtung: Beim Umbenennen werden Kontingente und Z�hler nicht �bernommen.';
  M190= '''Alles l�schen'' nicht m�glich im Online-Modus.';
  M191= 'Wollen Sie die Tarifdatenbank, Kontingente und Z�hler wirklich l�schen ?';

//unit6
  M192= 'Import';
  M193= 'Export';
  M194= 'LeastCosterXP Tarifpaket';
  M195= 'Enthaltene Tarife';
  M196= 'neue Tarife';

  M197= 'Die angezeigten Tarife wurden nur teilweise oder gar nicht importiert, da es �berschneidungen zu bestehenden Tarifen gibt.'
         +'Sie k�nnen jetzt die alten Tarife l�schen und die neuen importieren, indem sie oben die betreffenden Tarife markieren und auf den Button "Weiter" klicken.';
  M198= 'Zusammenfassung';
  M199= 'neu aufgenommene Tarife';
  M200= 'neu datierte Tarife';
  M201= 'Keine �nderungen.';
  M202= '�berschriebene Tarife';

//auswertung.pas
  M203= 'Legende';
  M204= 'mind.';
  M205= '�/Tag';
  M206= 'weniger als';
  M207= 'durchschnittl. Kosten pro Minute';

//Export
  M208= '�bersicht der verf�gbaren Tabellen';
  M209= 'existiert bereits. �berschreiben ?';
  M210= 'wurde nicht in den Papierkorb verschoben.';
//leerlauf
  M211= 'Auto-Einwahl deaktiviert';
//menues
  M212= 'konnte erfolgreich registriert werden.';
  M213= 'konnte erfolgreich gel�scht werden.';

//protokolle
  M214= 'Verbindung(en) exportiert nach';
  M215= 'Dateien neu angelegt';
  M216= 'Kostenprotokolle';

//RSS
  M217= 'Starte RSS-Update';
  M218= 'RSS-Update gestartet.';
  M219= 'RSS-Update beendet.';
  M220= 'Letzte Aktualisierung der Rss-Feeds um';

//Webserv
  M222= 'Keine Tarife verf�gbar (Surfzeit verkleinern ?)';
  M223= 'Verbindung w�hlen';
  M224= 'Aktualisieren';
  M225= 'Nachrichten lesen';
  M226= 'Anhang';
  M227= 'von';
  M228= 'Nachrichten schreiben';
  M229= 'markierte Nachrichten l�schen';
  M230= 'Absenden';
  M231= 'Empf�nger';
  M232= 'User';
  M233= 'Passwort';

  M234= 'Server gestartet';
  M235= 'Server gestoppt';

  M236= 'WebInterface Hinweis';
  M237= 'Windows wird beendet';
  M238= 'Ausschalten';
  M239= 'Windows neu gestartet';
  M240= 'Neustart';
  M241= 'User abgemeldet';
  M242= 'Abmelden';
  M243= 'Windows ausschalten > Standby';
  M244= 'StandBy';
  M245= 'Windows ausschalten > Ruhezustand';
  M246= 'Ruhezustand';

  M247= 'Ausgeloggt';
  M248= 'Ausgeloggt (Logout vergessen !)';
  M249= 'versucht Einwahl.';

  M250= 'hat die Verbindung getrennt.';
  M251= 'erfolgreicher Login';
  M252= 'fehlgeschlagener Login';

  M253= 'Einwahl gestartet';
  M254= 'stellt die Verbindung mit LeastCosterXP zum Internet her.';

//tarife
  M255= '%s f�r %1.2f ct/min (Einwahl : %f ct).';
  M256= 'Dieser gilt von %s Uhr bis %s Uhr.';
  M257= 'Der Preis ab %s Uhr ist %s';
  M258= 'Von %s Uhr - %s Uhr steht Ihnen der Tarif';
  M259= '%s f�r %s ct/min (Einwahl %s ct)';
  M260= 'zur Verf�gung !';
  M261= 'Um %s trennen';

  M262= 'Es ist kein Tarif bekannt, der nach';
  M263= '%s Uhr';
  M264= 'gilt !';

  M265= 'Tag';
  M266= 'Score (alle)';
  M267= 'Score (ok)';

  M268= 'Mindestumsatz';
  M269= 'ist kein g�ltiges Datumsformat.';

  M270= 'Feiertag';
  M271= 'Datum';
  M272= 'Originalsprache wird nach Neustart eingestellt.';

  Help00= 'Hinweise:' +cr
              +' werden beim Zeigen auf ein Objekt angezeigt.';
  Help01= 'Autostart:' +cr
                  + 'LeastCoster XP startet mit Windows. Wenn der Webserver nach dem Einschalten der Rechners zur Verf�gung stehen soll, dann unbedingt aktivieren !';
  Help02= 'minimiert:' +cr
          + 'LeastCosterXP startet nur in der Tray-Leiste (kleines graues Symbol, das bei Onlineverbindung gelb wird). Ein Klick darauf maximiert LeastCosterXP.';
  Help03= 'Klick auf [X]:' +cr
          + 'Ist diese Option aktiviert, so wird LeastCosterXP nicht geschlossen wenn [x] gedr�ckt wird. Beenden ist dann nur �ber das Men� m�glich.';
  Help04= 'zeige Uhrzeit' +cr
          + '...�ber der Tariftabelle kann die uhrzeit eingeblendet werden.';
  Help05= 'keine BalloonTips' +cr
          +'BalloonTips sind diese kleinen gelben Fensterchen, die hin und wieder neben der Windows-Uhr erscheinen. M�chten Sie, dass der LeastCosterXP nicht auf diesem Wege mit Ihnen kommuniziert, so k�nnen Sie diese Hinweise hier ausschalten.';
  Help06= 'Log-Dateien' +cr
              + 'Datens�tze die �lter als xx Tage sind werden automatisch aus den Log-Dateien entfernt.'
              +  'So wird vermieden, dass die Log-Dateien immer l�nger werden.';
  Help07= 'Logfile anzeigen' +cr
              +'Die �nderungen der Uhrzeit werden in der Datei "Atomzeit.txt" protokolliert.'+ cr
              +'Ein Klick auf diesen Button �ffnet das Logfile.';
  Help08= 'Einwahl-Log anzeigen' +cr
              +'Einwahlen werden in der Datei "www\log\log.txt" protokolliert.'+ cr
              +'Ein Klick auf diesen Button �ffnet das Logfile.';
  Help09= 'Einf�rbung der Balkendiagramme' +chr(13)+chr(10)+
              'Die Balkendiagramme werden blau, gelb und rot eingef�rbt. Hier einzutragen sind die vorrausichtlichen Monatskosten.' +cr+
              'Dier Wert wird intern durch die Anzahl der Tage geteilt. Eine Einf�rbung findet dann statt wenn der jeweilige Anteil an einem Tag �berschritten wurde.' +cr+
              'Standardwerte: gelb: 10 | rot 15';
  Help19= 'benutze Einstellungen der DF�-Verbindung' + cr
            +'Die Modem-Einstellungen der DF�-Verbindung blieben unangetastet. Nur in Ausnahmef�llen n�tig. Die DF�-Verbindung LeastCosterXP MUSS dann korrekt eingerichtet sein.'
            + cr + 'Empfehlung: daektiviert lassen, solange es keine Probleme gibt.';
  Help20= 'Modem' +cr+
            'Welches Modem wird verwendet um ins Internet zu gehen ?';
  Help21= 'Multilink' +cr
              +'... auch Kanalb�ndelung genannt. Es kann ein zweites Modem angegeben werden um dieses zu realisieren. Nicht unter Windows 9x. Ist dieser Haken gesetzt, so wird die Verbindung beim n�chsten Mal mit beidem Modems aufgebaut.'+cr
              +'Ist diese Option gesetzt ist das Zuschalten des 2. Kanales m�glich.';
  Help22= 'Modem-Vorwahlstring' +cr
              +'Manchmal ist es notwendig eine Nummer vorzuw�hlen, um z.B. eine Telefonanlage zu passieren.' + cr
              +'z.B.: "0,"';
  Help23= 'Netzwerk- und DF�-Verbindungen' +cr
              + '... �ffnet das Fenster Netzwerk- und DF�-Verbindungen.'+cr
              + '(nur Win2k/WinXP)';
  Help24= 'Anzeige im Voraus' +cr
              +'Im Online-Modus wird die Tariftabelle f�r die kommenden Minuten angezeigt. Hier wird angezeigt, wie lange im Voraus die Tabelle berechnet wird.'
              +cr
              +'Achtung: Auch die Warnung, wenn ein Tarif teurer wird, endet oder ein billigerer Tarif zur Verf�gung steht, richtet sich anch dieser Zeit.';
  Help25= 'Verstecken nach dem Online- Wechsel' +cr
              +'Das Hauptfenster wird nach dem Onlinewechsel minimiert und im Tray versteckt.';
  Help26= '�ffne die Webseite des Anbieters' +cr
              +'Beim Verbinden wird der Browser mit der Anbieterwebseite ge�ffnet. So kann sofort nach der Einwahl die G�ltigkeit des Tarifes �berpr�ft werden.';
  Help27= 'Programmstart' +cr+
              ' ... wechselt der Rechner in den OFFLINE- oder ONLINE-Zustand k�nnen Programme gestartet werden';
  Help28= 'l�schen' +cr
          +'...l�scht den gew�hlten Eintrag.';
  Help29= 'Programm wieder beenden' +cr+
              ' Ein Programm, das bei ONLINE-Verbindungen gestartet wird, kann beendet werden.'
              +cr +
              'Achtung: Das Programm wird dann einfach "abgeschossen". Es kann zu Datenverlust kommen.';
  Help30= 'Programm'+cr
          + '... geben Sie hier das Programm an.';
  Help31= 'Parameter' +cr+
              ' Manche Programme k�nnen Kommandozeilenparameter verarbeiten, um spezielle Funktionen auszuf�hren. Diese Parameter sind der Hilfe des jeweiligen Programms zu entnehmen.';
  Help32= 'Timeout' +cr+
              ' ... gibt die Zeit in Millisekunden an, die vor dem Start des Programms gewartet werden soll.';
  Help33= 'mindeste Basiszeit' +cr
              +' ... nur wenn die eingestellte Surfdauer den Mindestwert in Minuten �berschreitet, dann wird das Programm gestartet. ';
  Help34= 'alle xx Tage' +cr
              +' ... das Programm wird nur jeden x-ten Tag nach dem letzten Aufruf ausgef�hrt';
  Help35= 'hinzuf�gen' +cr
              +' ... speichert den Eintrag.';
  Help36= 'l�schen' +cr
              +' ... l�scht den Eintrag.';
  Help37= 'Sound' +cr
              +'Beim Verbinden und Trennen kann je ein Sound abgespielt werden. Dieser muss im Wave- Format (*.wav) vorliegen.';
  Help38= 'Programmupdates' +cr
              +'... �berpr�fung auf Updates (empfohlen)';
  Help39= 'Backups anlegen' +cr
              +'Die aktualisierten Dateien werden im Ordner BackUp abgelegt, damit eine �nderung wieder r�ckg�ngig gemacht werden kann.';
  Help40= 'Nur die letzte �nderung sichern' +cr
              +'Vor einem Update wird der BackUp-Ordner gel�scht, so dass nur die letzte �nderung gespeichert wird (spart Speicherplatz).';
  Help41= 'Zeige BackUp-Ordner' +cr
              +'... �ffnet den Ordner "BackUp"';
  Help42= 'OnlineInfo' +cr
              +'Das Infofenster wird angezeigt, sobald sie eine Verbindung mit LeastCosterXP herstellen.';
  Help43= 'Tarifnamen vollst�ndig' +cr
              +'Je nach L�nge des Tarifnamens passt sich das OnlineInfo selbst in der Breite an.';
  Help44= 'OnlineInfo' +cr
              +'Geben Sie hier das gew�nschte Hintergrundbild an.';
  Help45= 'OnlineInfo' +cr
              +'Geben Sie hier die gew�nschte Schriftart an.';
  Help46= 'Textfarbe' +cr
              +'Welche Farbe soll der Text haben ? ';
  Help47= 'Hintergrundfarbe' +cr
              +'Welche Farbe soll der Hintergrund haben ? ';
  Help48= 'Textfarbe' +cr
              +'Welche Farbe sollen Zeit und Preis haben ? ';
  Help49= 'Atomzeit:' +cr
              +'Damit es nicht zu unn�tigen Tarif�berschreitungen kommt, muss die Uhrzeit des Computers immer genau sein. Mit dem Atomzeit-Update wird die Uhrzeit bei Online-Verbindung mit einem Time-Server abgeglichen.'
              +cr
              +'Achtung: andere Atomzeit-Update Programme und die Windows-Funktion m�ssen deaktiviert sein.';
  Help50= 'Atomzeit-Server: Sortierung' +cr
           +'... verschiebt den ausgew�hlten Server nach oben in der Priorit�tenliste.';
  Help51= 'Atomzeit-Server: Sortierung' +cr
           +'... verschiebt den ausgew�hlten Server nach unten in der Priorit�tenliste.';
  Help52= 'Atomzeit-Server' +cr
            + 'Server, die das SNTP-Protokoll unterst�tzen, k�nnen hier eingetragen werden.'
            + 'Der LeastCoster XP versucht die Liste in angegebener Reihenfolge abzuarbeiten, wenn ein Server nicht antwortet.';
  Help53= 'Wiederholung' +cr
            + 'Solange der Computer online ist, kann die Uhrzeit wiederholt abgeglichen werden. Geben Sie hier das Intervall in Minuten an.';
  Help54= 'eMail-Benachrichtigung' +cr
              + 'Sie k�nnen sich per eMail benachrichtigen lassen, wenn der Computer eine Verbindung herstellt. So haben Sie immer Zugriff auf Dienste des Computers wenn Sie unterwegs sind.'
              + ' Voraussetzung ist ein eingerichtetes eMail-Programm (welches unter Umst�nden eine Warnmeldung beim Versenden gibt > bitte deaktivieren).';
  Help55= 'eMail-Benachrichtigung : Name' +cr
              +'Bitte tragen Sie Ihren Namen ein, wie er in der eMail erscheinen soll.'
              + cr
              +'Ist das Feld leer findet KEIN Versand statt.';
  Help56= 'eMail-Benachrichtigung : Adresse' +cr
              + 'Bitte tragen Sie Ihre eMail-Adresse hier ein.'
              + cr
              + 'Eine �berpr�fung der Adresse findet nicht statt. F�r Spamming �bernimmt der Autor keine Haftung.';
  Help57= '... setzt als Windows Standard Verbindung ''Keine Verbindung'' (WinXP)';
  Help58= '... �ffnet die Netzwerkverbindungen. (WinXP)';
  Help59= 'IP-Adresse' +cr
              +'Listet alle dem Computer zugewiesenen IP-Adressen auf.'
              +'Sofern der Rechner Offline ist und er KEINE Netzwerkverbindungen besitzt muss hier der Wert 127.0.0.1 erscheinen ...'
              +'Einstellung hat keine Relevanz - nur zur Info ... ';

 Help60= 'Automatisches Trennen' +cr
              +'Diese Einstellungen werden bei Online-Wechsel automatisch gesetzt und k�nnen dann aber individuell f�r die Verbindung angepasst werden.';
 Help61= 'Trennen zum Ende des Tarifes' +cr
              +'Das automatisches Trennen wird zur Uhrzeit des Tarifendes programmiert.';
 Help62= 'Trennen zum Ende von Kontingenten' +cr
              +'60s bevor ein Kontingent aufgebraucht ist, wird ein Hinweis angezeigt und die Verbindung nach 30s getrennt. Bei Volumenkontingenten wird getrennt sobald weniger als 512kB �brig sind.';
 Help63= '... mit Nachfrage' +cr
              +'Wenn gew�nscht erscheint ein Hinweisfenster vor dem Trennen der Verbindung.';
 Help64= 'Warten bis zum Trennen' +cr
              +'... das Hinweisfenster wartet xx Sekunden und trennt nach Ablauf dieser Zeit, wenn nicht zuvor auf ''Stop'' gedr�ckt wurde.';
 Help65= 'Nur nach Best�tigung' +cr
              +'Das Hinweisfenster erscheint, aber es wird nur getrennt, wenn ''Jetzt trennen'' gedr�ckt wird.';
 Help66= 'Sekunden vor dem Ende trennen' +cr
              +'... bestimmt die Zeit, wie lange vor dem Ende eines Zeitfensters getrennt werden soll.';
 Help67=  'Trennen bei Leerlauf und Leerlaufzeit' +cr
              + 'Werden keine Daten �ber die aktuelle Verbindung empfangen oder gesendet, so ist die Verbindung im Leerlauf und verursacht unn�tig Kosten. Nach einer zul�ssigen Leerlaufzeit von xx Minuten k�nnen solche Verbindungen getrennt werden.';
 Help68= 'Sound bei Leerlauf' +cr
              + 'Welcher Sound soll abgespielt werden ? (muss im *.wav-Format angegeben werden)';
 Help69= 'Leerlaufschwelle' +cr
              + 'Die Verbindung wird als im Leerlauf betrachtet, wenn die Summe aus gesendeten und empfangenen Bytes kleiner als diese Leerlaufschwelle ist.'
              + ' Je kleiner dieser Wert ist, desto empfindlicher ist die Leerlauferkennung auf Datenbewegungen. Ist dieser Wert zu gro� gew�hlt, so wird nahezu jede Verbindung gemeldet.' +cr
              + 'Empfehlung: 500 bytes/Sekunde';
 Help70= 'Ausschalten' +cr
              + 'Nach dem automatischen Trennen kann der Computer im jeweiligen Modus ausgeschaltet werden.' +cr
              + 'Auch dies ist die Standardeinstellung, die bei jedem Online-Wechsel aktiviert wird.';
 Help71= 'Auto-Verbinden bei Programmstart' +cr
              +'Beim Programmstart wird sofort begonnen zu w�hlen. Schl�gt die Verbindung fehl, wird nach Ablauf des Einwahl-Intervalls ein neuer Einwahlversuch gestartet.';
 Help72= 'Wiedereinwahl' +cr
              +'Wird die Verbindung getrennt, so kann eine automatische Wiedereinwahl mit dem billigsten Tarif veranlasst werden. Dies wird versucht, bis der Rechner online ist oder durch dr�cken der ''stop''-Taste abgebrochen.';
 Help73= 'Sekunden zwischen zwei Einwahlversuchen' +cr
              +'Ist ein Einwahlversuch nicht erfolgreich, so wird ein neuer Versuch nach xx Sekunden gestartet.';
 Help74= '... Einwahlgeb�hr ber�cksichtigen' +cr
              + 'Nur wenn dieser Haken gesetzt ist, dann wird auch ein Tarif mit Einwahlgeb�hr gew�hlt, ansonsten wird gesucht bis ein Tarif ohne EWG gefunden ist.';
 Help75= 'Basiszeit bei Auto-Einwahl' +cr
              + 'Da der Computer automatisch entscheiden muss, welches der f�r ihn billgste Tarif ist, muss er die gew�nschte Basiszeit selbst setzen. Dieser Wert wird hier angegeben.';
 Help76= 'zeitgesteuert online' +cr
              + 'Sie k�nnen Zeiten angeben, zu denen der Computer versuchen soll online zu sein. W�hrend dieser Zeit wird automatisch versucht zu w�hlen sobald der COmputer offline ist.';
 Help77= 'Zeit�bersicht' +cr
              + 'Zu Zeiten, die in dieser �bersicht angegeben sind werden automatisch Verbindungen aufgebaut.';
 Help78= 'Auto Blacklist' +cr
              + 'Die Blacklist enth�lt alle Tarife, die nicht gew�hlt werden d�rfen. Tarife werden automatisch auf die Blacklist gesetzt sobal eine Mindestanzahl an Einwahlenversuchen erfolgte UND ein gewisser Prozentsatz davon fehlgeschlagen ist.';
 Help79= 'WebInterface' +cr
              + 'Das WebInterface stellt Basisfunktionen f�r ein (lokales) Netzwerk zur Verf�gung. So k�nnen Sie die Einwahl und das Trennen �ber einen entfernten Rechner steuern.';
 Help80= 'Port' +cr
              +'Auf welchem Port soll das WebInterface bereitgestellt werden ?' +cr
              +'Empfohlene Einstellung: 85'+cr
              +'Die Adresse des Interfaces ist dann http://{servername}:{port}, z.B. http://192.168.0.1:85 .';
 Help81= 'Start' +cr
              +'... startet das WebInterface';
 Help82= 'Stop' +cr
              +'... beendet das WebInterface';
 Help83= 'Automatischer Start' +cr
              +'... startet das WebInterface bei Programmstart.';
 Help84= 'Userverwaltung' +cr
              +'Hier werden die User eingtragen, die das WebInterface nutzen d�rfen. Um das WebInterface zu Nutzen, muss mindestens ein User eingetragen sein.';
 Help85= 'User' +cr
              +'Geben Sie hier den Namen an, mit dem sich ein User beim WebInterface einloggen soll.';
 Help86=  'altes Passwort' +cr
              +'Wenn Sie einen neuen Benutzer hinzuf�gen, dann k�nnen sie dieses Feld leer lassen. Zum �ndern und L�schen, aber muss Ihnen das Benutzerpasswort bekannt sein.';
 Help87= 'neues Passwort' +cr
              +'Tragen Sie hier das Passwort ein. M�chten Sie ihr Passwort �ndern, dann muss zus�tzlich das zuvor g�ltige Passwrot angegeben werden (siehe ''altes Passwort'').';
 Help88= 'Passwortbest�tigung' +cr
              +'Bitte geben Sie hier ihr Passwort ein zweites Mal ein. Dies ist eine Sicherheitsabfrage, um zu vermeiden, dass Sie sich beim ersten mal vertippt haben';
 Help89= 'RSS Feeds' +cr
              +'RSS Feeds halten sie �ber neueste Nachrichten oder Ver�nderungen auf Webseiten/ in Foren auf dem laufenden. Sie werden direkt beim Verbinden aktualisiert und stehen Ihnen �ber das Hauptmen� zur Verf�gung.';
 Help90= 'keine Feeds' +cr
              +'... deaktiviert die RSS-Funktionen.';
 Help91= 'Update' +cr
              +'Die eingestellten RSS-Feeds werden bei Online-Verbindungen aktualisiert und dann alle xx Minuten neu heruntergeladen.';
 Help92= 'Maximal anzeigen' +cr
              +'Es werden nur die xx neuesten Meldungen angezeigt.';
 Help93= 'alte News' +cr
              +'Ist diese Option aktiviert, werden auch News gezeigt, die nicht mehr durch den Feed verbreitet werden.';

implementation

end.

