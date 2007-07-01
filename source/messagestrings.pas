unit messagestrings;

interface
const
	cr=#13#10;
//unit1
  M01='Hinweis';
  M02='Der LeastCoster ist nun im Tray minimiert.' + cr + 'Doppelklick zum maximieren.';

  M03='Wenn Sie LeastCosterXP jetzt beenden, wird die aktuelle Verbindung getrennt ! Schließen ?';
  M04='Wenn Sie LeastCosterXP jetzt beenden, wird die aktuelle Verbindung nicht protokolliert ! Schließen ?';
  M05='Beim Beenden stehen die WebInterface-Funktionen nicht mehr zur Verfügung ! Schließen ?';

  M06='Automatisches Trennen';
  M07='Rufnummer';
  M08='Verbindung';

  M09='Ende des Freikontingents';

  M12='ct';
  M13='€';

  M17='Große Zeitdifferenz nach Atomzeitupdate';
  M18='Der gewählte Tarif ist noch gültig.';
  M19='Trennen ist nicht nötig.';
  M20='Der gewählte Tarif ist im Moment NICHT gültig.';
  M21='Trennen wird empfohlen!';

  M24='&Wählen';
  M25='Autoeinwahl gescheitert.';
  M26='Verbindung beendet.';

  M27='Übersicht aller aktiven Verbindungen';
  M28='Verbindungen';
  M29='Ihre Verbindung: ';
  M30='Verbindung Nr.';
  M31='Name';
  M32='Modemtyp';
  M33='Modemname';
  M34='Multilinkgeräte';
  M35='Download';
  M36='Upload';

  M37='Verbindung getrennt, weil Windows beendet wird.';
  M38='Bitte die Einstellungen überprüfen !';
  M39='Dies scheint der erste Start vom LeastCosterXP zu sein. Bitte nehmen Sie zunächst alle Einstellungen vor.';

  M40='Verbindung getrennt und LeastCosterXP beendet.';
  M41='Starte Programm';
  M42='läuft bereits.';
  M43='existiert nicht.';

  M44='Kein RAS installiert !';

  M45='Das automatische Atomzeitupdate ist deaktiviert.';
  M46='RSSFeeds sind deaktiviert.';
  M47='Programm bereit.';

  M48='Onlinezeit';
  M49='Dauer';
  M50='Kosten';

  M51='Einwahl erfolglos.';
  M52='Wählen abgebrochen.';

  M53='a&bbrechen';
  M54='Die Verbindung';
  M55='wird getrennt.';
  M56='Prüfe Anfrage ...';
  M57='Keine Einwahl solange ''Zeige beliebige Zeit'' aktiviert ist !';
  M58='Die Tarifliste ist älter als 60s. Sie wird aktualisiert.' + cr + 'Bitte danach erneut versuchen';
  M59='Kein Eintrag in der Tarifliste aktiv.';
  M60='Dieser Tarif ist am ';
  M61='abgelaufen.';
  M62='Ein unbekannter Fehler trat auf. Bitte die Liste aktualisieren und neu versuchen zu wählen.';
  M63='Tarife der Blacklist werden nicht gewählt.';
  M64='Es wurde kein gültiges Modem eingtragen !';
  M65='Wähle ... ';
  M67='Anwahlversuch (LeastCosterXP)';

  M68='Tarif wurde verändert !';
  M69='Onlinesession vorbereitet';

  M70='Empfänger nicht eindeutig.';
  M71='Datei zum Anhängen nicht gefunden';
  M72='Datei zum Anhängen konnte nicht geöffnet werden.';
  M73='Empfängertyp nicht MAPI_TO, MAPI_CC oder MAPI_BCC.';
  M74='Unbekannter Fehler.';
  M75='Nicht genug Speicher.';
  M76='Benutzerlogin (z.B. bei Outlook) fehlgeschlagen.';
  M77='Text zu groß.';
  M78='Benutzer hat Senden abgebrochen oder MAPI nicht installiert.';

  M79='Die Verbindung wurde soeben getrennt.';
  M80='Verbindung getrennt (automatisch ausgelöst)';

  M81='Online/Connected';
  M82='&Trennen !';
  M83='Verbunden mit';
  M84='Letzte Onlinesession dauerte';
  M85='Verbindung getrennt';
  M86='ist ein ungültiger Paramter.';
  M87='kein RSS-Update (nicht online)';

  M88='Ihre Verbindung ist im Leerlauf.';
  M89='aktiv';
  M90='inaktiv';

  M91='Automatisches Verbinden';
  M92='gewählt.';
  M93='Sekunden';

  M94='Die aktuelle IP-Adresse Ihres Computers lautet';
  M95='Diese eMail wurde automatisch versandt und ist ein'
       + ' Service bereitgestellt von LeastCosterXP ( http://www.leastcosterxp.de )'
       + cr+cr
       + 'Keine Haftung für unerwünschtes Spamming. Sollten Sie diese eMail bekommen,'
       +' ohne zu wissen warum, so wenden Sie sich direkt an den Absender.';
  M96='Ihr LeastCosterXP WebInterface';

  M97='Es wurden Dateien heruntergeladen, die jetzt ausgetauscht werden. Soll sich LeastCosterXP jetzt neu starten ?' +cr+cr
      +'Bitte warten Sie ab, bis LeastCosterXP von selbst neu startet!';

  M98='abgelaufen';
  M99='Die Kosten können nicht berechnet werden. Der aktuelle Preis ist unbekannt !';

  M100='Durchschnittliche Kosten/min';
  M101='aus Blacklist entfernen';
  M102='zur Blacklist hinzufügen';

  M103='Atomzeit-Update gestartet';
  M104='Starte Atomzeit-Update mit';
  M105='alte Zeit';
  M106='neue Zeit';
  M107='Zeitdifferenz in s';
  M108='Server';
  M109='Erfolgreiches Atomzeit-Update';
  M110='Fehler beim Verbinden mit';

  M111='ganztags';
  M112='ungültig seit';
  M113='noch frei';

  M114='Die Automatische Einwahl ist aktiviert.';
  M115='Die Automatische Einwahl ist deaktiviert.';

//unit2
  M116= 'ist ein ungültiger Eintrag.';
  M117= 'Titelleiste von';
  M118= '<neuer User>';
  M119= 'OK';

  M120= 'Die Titelzeile von';
  M121= 'ist nicht eingetragen. Bitte korrigieren !!';

  M122= 'Noch kein Atomzeit-Update seit dem Start.';
  M123= 'Noch kein Rss-Feed Update seit dem Start.';

  M124= 'Die beiden Passwortfelder stimmen nicht überein !';
  M125= 'falsches Passwort !';
  M126= 'Titel nicht gefunden. Bitte Versuch wiederholen.';
  M127= 'Fehler beim Löschen von';
  M128= '&speichern';
  M129= '&hinzufügen';

  M130= 'aktiviert';
  M131= 'aktivieren';
  M132= 'deaktiviert';
  M133= 'deaktivieren';
  M134= 'Löschen Sie nun das folgende Verzeichnis:';

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

  M144= 'Sortiere Datensätze ... ';
  M145= 'Lade Datensätze ... ';
  M146= 'Fehler: Endzeit liegt vor der Startzeit.';
  M147= 'Fehler: Startzeitpunkt liegt in der Zukunft.';
  M148= 'Keine Datensätze gefunden ... ';
  M149= 'unbekannt';
  M150= 'Speichere Kommentare ... ';
  M151= 'Export des Einzelverbindungsnachweises';
  M152= 'Einzelverbindungsübersicht';
  M153= 'Gesamtdauer';
  M154= 'Teilsumme';
  M155= 'Gesamtsumme';

//unit4
  M156= 'Windows beenden geblockt !';
//TarifManger
  M157= 'Hinweis: Es wurde keine Webseite angegeben.';
  M158= 'Hinweis: Startzeit gleich Endzeit: ''Ganztags'' wurde aktiviert.';
  M159= 'Eintragen abgebrochen: Bitte rote Markierungen beachten !';
  M160= 'Tarifüberschneidung, bitte Daten korrigieren.';

  M161= 'ja';
  M162= 'nein';
  M163= '&Tarif hinzufügen';

  M164= 'Gültigkeit';
  M165= 'Beginn';
  M166= 'Ende';
  M167= 'Preis';
  M168= 'Einwahl';
  M169= 'Takt';
  M170= 'Nummer';
  M171= 'User';
  M172= 'Passwort';
  M173= 'Webseite';
  M174= 'gültig ab';
  M175= 'gültig bis';
  M176= 'eingetragen';
  M177= 'Löschen bei Ablauf';
  M178= 'Tarif-Editor';

  M179= 'Dieser Tarif befindet sich auf der Whitelist. Klick zum Umschalten';
  M180= 'Dieser Tarif befindet sich auf der Blacklist. Klick zum Umschalten';

  M181= 'Eintrag &löschen';
  M182= 'Der Tarif wird verwaltet von';

  M183= 'Achtung : Mehrfachauswahl.' + cr +
                      'Beim Ändern werden die Daten für alle markierten Datensätze übernommen. Ausnahme sind die Felder "Beginn" und "Ende".';
  M184= 'Einträge &löschen';
  M185= 'Eintrag &löschen';

  M186= 'Nächster Reset';
  M187= 'Mit dem Zurücksetzen der Zähler werden bestehende Kontingente wieder aktiviert. '
        +cr+'Wirklich zurücksetzen ?';
  M188= 'Achtung: Zähler-Reset !';
  M189= 'Achtung: Beim Umbenennen werden Kontingente und Zähler nicht übernommen.';
  M190= '''Alles löschen'' nicht möglich im Online-Modus.';
  M191= 'Wollen Sie die Tarifdatenbank, Kontingente und Zähler wirklich löschen ?';

//unit6
  M192= 'Import';
  M193= 'Export';
  M194= 'LeastCosterXP Tarifpaket';
  M195= 'Enthaltene Tarife';
  M196= 'neue Tarife';

  M197= 'Die angezeigten Tarife wurden nur teilweise oder gar nicht importiert, da es Überschneidungen zu bestehenden Tarifen gibt.'
         +'Sie können jetzt die alten Tarife löschen und die neuen importieren, indem sie oben die betreffenden Tarife markieren und auf den Button "Weiter" klicken.';
  M198= 'Zusammenfassung';
  M199= 'neu aufgenommene Tarife';
  M200= 'neu datierte Tarife';
  M201= 'Keine Änderungen.';
  M202= 'überschriebene Tarife';

//auswertung.pas
  M203= 'Legende';
  M204= 'mind.';
  M205= '€/Tag';
  M206= 'weniger als';
  M207= 'durchschnittl. Kosten pro Minute';

//Export
  M208= 'Übersicht der verfügbaren Tabellen';
  M209= 'existiert bereits. Überschreiben ?';
  M210= 'wurde nicht in den Papierkorb verschoben.';
//leerlauf
  M211= 'Auto-Einwahl deaktiviert';
//menues
  M212= 'konnte erfolgreich registriert werden.';
  M213= 'konnte erfolgreich gelöscht werden.';

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
  M222= 'Keine Tarife verfügbar (Surfzeit verkleinern ?)';
  M223= 'Verbindung wählen';
  M224= 'Aktualisieren';
  M225= 'Nachrichten lesen';
  M226= 'Anhang';
  M227= 'von';
  M228= 'Nachrichten schreiben';
  M229= 'markierte Nachrichten löschen';
  M230= 'Absenden';
  M231= 'Empfänger';
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
  M255= '%s für %1.2f ct/min (Einwahl : %f ct).';
  M256= 'Dieser gilt von %s Uhr bis %s Uhr.';
  M257= 'Der Preis ab %s Uhr ist %s';
  M258= 'Von %s Uhr - %s Uhr steht Ihnen der Tarif';
  M259= '%s für %s ct/min (Einwahl %s ct)';
  M260= 'zur Verfügung !';
  M261= 'Um %s trennen';

  M262= 'Es ist kein Tarif bekannt, der nach';
  M263= '%s Uhr';
  M264= 'gilt !';

  M265= 'Tag';
  M266= 'Score (alle)';
  M267= 'Score (ok)';

  M268= 'Mindestumsatz';
  M269= 'ist kein gültiges Datumsformat.';

  M270= 'Feiertag';
  M271= 'Datum';
  M272= 'Originalsprache wird nach Neustart eingestellt.';

  Help00= 'Hinweise:' +cr
              +' werden beim Zeigen auf ein Objekt angezeigt.';
  Help01= 'Autostart:' +cr
                  + 'LeastCoster XP startet mit Windows. Wenn der Webserver nach dem Einschalten der Rechners zur Verfügung stehen soll, dann unbedingt aktivieren !';
  Help02= 'minimiert:' +cr
          + 'LeastCosterXP startet nur in der Tray-Leiste (kleines graues Symbol, das bei Onlineverbindung gelb wird). Ein Klick darauf maximiert LeastCosterXP.';
  Help03= 'Klick auf [X]:' +cr
          + 'Ist diese Option aktiviert, so wird LeastCosterXP nicht geschlossen wenn [x] gedrückt wird. Beenden ist dann nur über das Menü möglich.';
  Help04= 'zeige Uhrzeit' +cr
          + '...über der Tariftabelle kann die uhrzeit eingeblendet werden.';
  Help05= 'keine BalloonTips' +cr
          +'BalloonTips sind diese kleinen gelben Fensterchen, die hin und wieder neben der Windows-Uhr erscheinen. Möchten Sie, dass der LeastCosterXP nicht auf diesem Wege mit Ihnen kommuniziert, so können Sie diese Hinweise hier ausschalten.';
  Help06= 'Log-Dateien' +cr
              + 'Datensätze die älter als xx Tage sind werden automatisch aus den Log-Dateien entfernt.'
              +  'So wird vermieden, dass die Log-Dateien immer länger werden.';
  Help07= 'Logfile anzeigen' +cr
              +'Die Änderungen der Uhrzeit werden in der Datei "Atomzeit.txt" protokolliert.'+ cr
              +'Ein Klick auf diesen Button öffnet das Logfile.';
  Help08= 'Einwahl-Log anzeigen' +cr
              +'Einwahlen werden in der Datei "www\log\log.txt" protokolliert.'+ cr
              +'Ein Klick auf diesen Button öffnet das Logfile.';
  Help09= 'Einfärbung der Balkendiagramme' +chr(13)+chr(10)+
              'Die Balkendiagramme werden blau, gelb und rot eingefärbt. Hier einzutragen sind die vorrausichtlichen Monatskosten.' +cr+
              'Dier Wert wird intern durch die Anzahl der Tage geteilt. Eine Einfärbung findet dann statt wenn der jeweilige Anteil an einem Tag überschritten wurde.' +cr+
              'Standardwerte: gelb: 10 | rot 15';
  Help19= 'benutze Einstellungen der DFÜ-Verbindung' + cr
            +'Die Modem-Einstellungen der DFÜ-Verbindung blieben unangetastet. Nur in Ausnahmefällen nötig. Die DFÜ-Verbindung LeastCosterXP MUSS dann korrekt eingerichtet sein.'
            + cr + 'Empfehlung: daektiviert lassen, solange es keine Probleme gibt.';
  Help20= 'Modem' +cr+
            'Welches Modem wird verwendet um ins Internet zu gehen ?';
  Help21= 'Multilink' +cr
              +'... auch Kanalbündelung genannt. Es kann ein zweites Modem angegeben werden um dieses zu realisieren. Nicht unter Windows 9x. Ist dieser Haken gesetzt, so wird die Verbindung beim nächsten Mal mit beidem Modems aufgebaut.'+cr
              +'Ist diese Option gesetzt ist das Zuschalten des 2. Kanales möglich.';
  Help22= 'Modem-Vorwahlstring' +cr
              +'Manchmal ist es notwendig eine Nummer vorzuwählen, um z.B. eine Telefonanlage zu passieren.' + cr
              +'z.B.: "0,"';
  Help23= 'Netzwerk- und DFÜ-Verbindungen' +cr
              + '... öffnet das Fenster Netzwerk- und DFÜ-Verbindungen.'+cr
              + '(nur Win2k/WinXP)';
  Help24= 'Anzeige im Voraus' +cr
              +'Im Online-Modus wird die Tariftabelle für die kommenden Minuten angezeigt. Hier wird angezeigt, wie lange im Voraus die Tabelle berechnet wird.'
              +cr
              +'Achtung: Auch die Warnung, wenn ein Tarif teurer wird, endet oder ein billigerer Tarif zur Verfügung steht, richtet sich anch dieser Zeit.';
  Help25= 'Verstecken nach dem Online- Wechsel' +cr
              +'Das Hauptfenster wird nach dem Onlinewechsel minimiert und im Tray versteckt.';
  Help26= 'Öffne die Webseite des Anbieters' +cr
              +'Beim Verbinden wird der Browser mit der Anbieterwebseite geöffnet. So kann sofort nach der Einwahl die Gültigkeit des Tarifes überprüft werden.';
  Help27= 'Programmstart' +cr+
              ' ... wechselt der Rechner in den OFFLINE- oder ONLINE-Zustand können Programme gestartet werden';
  Help28= 'löschen' +cr
          +'...löscht den gewählten Eintrag.';
  Help29= 'Programm wieder beenden' +cr+
              ' Ein Programm, das bei ONLINE-Verbindungen gestartet wird, kann beendet werden.'
              +cr +
              'Achtung: Das Programm wird dann einfach "abgeschossen". Es kann zu Datenverlust kommen.';
  Help30= 'Programm'+cr
          + '... geben Sie hier das Programm an.';
  Help31= 'Parameter' +cr+
              ' Manche Programme können Kommandozeilenparameter verarbeiten, um spezielle Funktionen auszuführen. Diese Parameter sind der Hilfe des jeweiligen Programms zu entnehmen.';
  Help32= 'Timeout' +cr+
              ' ... gibt die Zeit in Millisekunden an, die vor dem Start des Programms gewartet werden soll.';
  Help33= 'mindeste Basiszeit' +cr
              +' ... nur wenn die eingestellte Surfdauer den Mindestwert in Minuten überschreitet, dann wird das Programm gestartet. ';
  Help34= 'alle xx Tage' +cr
              +' ... das Programm wird nur jeden x-ten Tag nach dem letzten Aufruf ausgeführt';
  Help35= 'hinzufügen' +cr
              +' ... speichert den Eintrag.';
  Help36= 'löschen' +cr
              +' ... löscht den Eintrag.';
  Help37= 'Sound' +cr
              +'Beim Verbinden und Trennen kann je ein Sound abgespielt werden. Dieser muss im Wave- Format (*.wav) vorliegen.';
  Help38= 'Programmupdates' +cr
              +'... Überprüfung auf Updates (empfohlen)';
  Help39= 'Backups anlegen' +cr
              +'Die aktualisierten Dateien werden im Ordner BackUp abgelegt, damit eine Änderung wieder rückgängig gemacht werden kann.';
  Help40= 'Nur die letzte Änderung sichern' +cr
              +'Vor einem Update wird der BackUp-Ordner gelöscht, so dass nur die letzte Änderung gespeichert wird (spart Speicherplatz).';
  Help41= 'Zeige BackUp-Ordner' +cr
              +'... öffnet den Ordner "BackUp"';
  Help42= 'OnlineInfo' +cr
              +'Das Infofenster wird angezeigt, sobald sie eine Verbindung mit LeastCosterXP herstellen.';
  Help43= 'Tarifnamen vollständig' +cr
              +'Je nach Länge des Tarifnamens passt sich das OnlineInfo selbst in der Breite an.';
  Help44= 'OnlineInfo' +cr
              +'Geben Sie hier das gewünschte Hintergrundbild an.';
  Help45= 'OnlineInfo' +cr
              +'Geben Sie hier die gewünschte Schriftart an.';
  Help46= 'Textfarbe' +cr
              +'Welche Farbe soll der Text haben ? ';
  Help47= 'Hintergrundfarbe' +cr
              +'Welche Farbe soll der Hintergrund haben ? ';
  Help48= 'Textfarbe' +cr
              +'Welche Farbe sollen Zeit und Preis haben ? ';
  Help49= 'Atomzeit:' +cr
              +'Damit es nicht zu unnötigen Tarifüberschreitungen kommt, muss die Uhrzeit des Computers immer genau sein. Mit dem Atomzeit-Update wird die Uhrzeit bei Online-Verbindung mit einem Time-Server abgeglichen.'
              +cr
              +'Achtung: andere Atomzeit-Update Programme und die Windows-Funktion müssen deaktiviert sein.';
  Help50= 'Atomzeit-Server: Sortierung' +cr
           +'... verschiebt den ausgewählten Server nach oben in der Prioritätenliste.';
  Help51= 'Atomzeit-Server: Sortierung' +cr
           +'... verschiebt den ausgewählten Server nach unten in der Prioritätenliste.';
  Help52= 'Atomzeit-Server' +cr
            + 'Server, die das SNTP-Protokoll unterstützen, können hier eingetragen werden.'
            + 'Der LeastCoster XP versucht die Liste in angegebener Reihenfolge abzuarbeiten, wenn ein Server nicht antwortet.';
  Help53= 'Wiederholung' +cr
            + 'Solange der Computer online ist, kann die Uhrzeit wiederholt abgeglichen werden. Geben Sie hier das Intervall in Minuten an.';
  Help54= 'eMail-Benachrichtigung' +cr
              + 'Sie können sich per eMail benachrichtigen lassen, wenn der Computer eine Verbindung herstellt. So haben Sie immer Zugriff auf Dienste des Computers wenn Sie unterwegs sind.'
              + ' Voraussetzung ist ein eingerichtetes eMail-Programm (welches unter Umständen eine Warnmeldung beim Versenden gibt > bitte deaktivieren).';
  Help55= 'eMail-Benachrichtigung : Name' +cr
              +'Bitte tragen Sie Ihren Namen ein, wie er in der eMail erscheinen soll.'
              + cr
              +'Ist das Feld leer findet KEIN Versand statt.';
  Help56= 'eMail-Benachrichtigung : Adresse' +cr
              + 'Bitte tragen Sie Ihre eMail-Adresse hier ein.'
              + cr
              + 'Eine Überprüfung der Adresse findet nicht statt. Für Spamming übernimmt der Autor keine Haftung.';
  Help57= '... setzt als Windows Standard Verbindung ''Keine Verbindung'' (WinXP)';
  Help58= '... öffnet die Netzwerkverbindungen. (WinXP)';
  Help59= 'IP-Adresse' +cr
              +'Listet alle dem Computer zugewiesenen IP-Adressen auf.'
              +'Sofern der Rechner Offline ist und er KEINE Netzwerkverbindungen besitzt muss hier der Wert 127.0.0.1 erscheinen ...'
              +'Einstellung hat keine Relevanz - nur zur Info ... ';

 Help60= 'Automatisches Trennen' +cr
              +'Diese Einstellungen werden bei Online-Wechsel automatisch gesetzt und können dann aber individuell für die Verbindung angepasst werden.';
 Help61= 'Trennen zum Ende des Tarifes' +cr
              +'Das automatisches Trennen wird zur Uhrzeit des Tarifendes programmiert.';
 Help62= 'Trennen zum Ende von Kontingenten' +cr
              +'60s bevor ein Kontingent aufgebraucht ist, wird ein Hinweis angezeigt und die Verbindung nach 30s getrennt. Bei Volumenkontingenten wird getrennt sobald weniger als 512kB übrig sind.';
 Help63= '... mit Nachfrage' +cr
              +'Wenn gewünscht erscheint ein Hinweisfenster vor dem Trennen der Verbindung.';
 Help64= 'Warten bis zum Trennen' +cr
              +'... das Hinweisfenster wartet xx Sekunden und trennt nach Ablauf dieser Zeit, wenn nicht zuvor auf ''Stop'' gedrückt wurde.';
 Help65= 'Nur nach Bestätigung' +cr
              +'Das Hinweisfenster erscheint, aber es wird nur getrennt, wenn ''Jetzt trennen'' gedrückt wird.';
 Help66= 'Sekunden vor dem Ende trennen' +cr
              +'... bestimmt die Zeit, wie lange vor dem Ende eines Zeitfensters getrennt werden soll.';
 Help67=  'Trennen bei Leerlauf und Leerlaufzeit' +cr
              + 'Werden keine Daten über die aktuelle Verbindung empfangen oder gesendet, so ist die Verbindung im Leerlauf und verursacht unnötig Kosten. Nach einer zulässigen Leerlaufzeit von xx Minuten können solche Verbindungen getrennt werden.';
 Help68= 'Sound bei Leerlauf' +cr
              + 'Welcher Sound soll abgespielt werden ? (muss im *.wav-Format angegeben werden)';
 Help69= 'Leerlaufschwelle' +cr
              + 'Die Verbindung wird als im Leerlauf betrachtet, wenn die Summe aus gesendeten und empfangenen Bytes kleiner als diese Leerlaufschwelle ist.'
              + ' Je kleiner dieser Wert ist, desto empfindlicher ist die Leerlauferkennung auf Datenbewegungen. Ist dieser Wert zu groß gewählt, so wird nahezu jede Verbindung gemeldet.' +cr
              + 'Empfehlung: 500 bytes/Sekunde';
 Help70= 'Ausschalten' +cr
              + 'Nach dem automatischen Trennen kann der Computer im jeweiligen Modus ausgeschaltet werden.' +cr
              + 'Auch dies ist die Standardeinstellung, die bei jedem Online-Wechsel aktiviert wird.';
 Help71= 'Auto-Verbinden bei Programmstart' +cr
              +'Beim Programmstart wird sofort begonnen zu wählen. Schlägt die Verbindung fehl, wird nach Ablauf des Einwahl-Intervalls ein neuer Einwahlversuch gestartet.';
 Help72= 'Wiedereinwahl' +cr
              +'Wird die Verbindung getrennt, so kann eine automatische Wiedereinwahl mit dem billigsten Tarif veranlasst werden. Dies wird versucht, bis der Rechner online ist oder durch drücken der ''stop''-Taste abgebrochen.';
 Help73= 'Sekunden zwischen zwei Einwahlversuchen' +cr
              +'Ist ein Einwahlversuch nicht erfolgreich, so wird ein neuer Versuch nach xx Sekunden gestartet.';
 Help74= '... Einwahlgebühr berücksichtigen' +cr
              + 'Nur wenn dieser Haken gesetzt ist, dann wird auch ein Tarif mit Einwahlgebühr gewählt, ansonsten wird gesucht bis ein Tarif ohne EWG gefunden ist.';
 Help75= 'Basiszeit bei Auto-Einwahl' +cr
              + 'Da der Computer automatisch entscheiden muss, welches der für ihn billgste Tarif ist, muss er die gewünschte Basiszeit selbst setzen. Dieser Wert wird hier angegeben.';
 Help76= 'zeitgesteuert online' +cr
              + 'Sie können Zeiten angeben, zu denen der Computer versuchen soll online zu sein. Während dieser Zeit wird automatisch versucht zu wählen sobald der COmputer offline ist.';
 Help77= 'Zeitübersicht' +cr
              + 'Zu Zeiten, die in dieser Übersicht angegeben sind werden automatisch Verbindungen aufgebaut.';
 Help78= 'Auto Blacklist' +cr
              + 'Die Blacklist enthält alle Tarife, die nicht gewählt werden dürfen. Tarife werden automatisch auf die Blacklist gesetzt sobal eine Mindestanzahl an Einwahlenversuchen erfolgte UND ein gewisser Prozentsatz davon fehlgeschlagen ist.';
 Help79= 'WebInterface' +cr
              + 'Das WebInterface stellt Basisfunktionen für ein (lokales) Netzwerk zur Verfügung. So können Sie die Einwahl und das Trennen über einen entfernten Rechner steuern.';
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
              +'Hier werden die User eingtragen, die das WebInterface nutzen dürfen. Um das WebInterface zu Nutzen, muss mindestens ein User eingetragen sein.';
 Help85= 'User' +cr
              +'Geben Sie hier den Namen an, mit dem sich ein User beim WebInterface einloggen soll.';
 Help86=  'altes Passwort' +cr
              +'Wenn Sie einen neuen Benutzer hinzufügen, dann können sie dieses Feld leer lassen. Zum Ändern und Löschen, aber muss Ihnen das Benutzerpasswort bekannt sein.';
 Help87= 'neues Passwort' +cr
              +'Tragen Sie hier das Passwort ein. Möchten Sie ihr Passwort ändern, dann muss zusätzlich das zuvor gültige Passwrot angegeben werden (siehe ''altes Passwort'').';
 Help88= 'Passwortbestätigung' +cr
              +'Bitte geben Sie hier ihr Passwort ein zweites Mal ein. Dies ist eine Sicherheitsabfrage, um zu vermeiden, dass Sie sich beim ersten mal vertippt haben';
 Help89= 'RSS Feeds' +cr
              +'RSS Feeds halten sie über neueste Nachrichten oder Veränderungen auf Webseiten/ in Foren auf dem laufenden. Sie werden direkt beim Verbinden aktualisiert und stehen Ihnen über das Hauptmenü zur Verfügung.';
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

