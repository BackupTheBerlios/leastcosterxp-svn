unit RSSReader;

interface
uses BMDThread,LibXmlParser, LibXmlComps, Dialogs, sysutils, classes, strUtils,
      CoolTrayIcon;

procedure StartRSSUpdate;

type
  TRSS = class (TObject)
    public

     MyThread : TBMDThread;
     XML      : TEasyXmlScanner;

     Itemlist : TStringlist;
     XMLStream: TStringStream;
     lasttag  : String;
     lasttitle: string;
     lastlink : string;
     isitem   : boolean;
     shutdown : boolean;

    //Thread - Events
     procedure ThreadExecute(Sender: TObject; Thread: TBMDExecuteThread; var Data: Pointer);
     procedure ThreadTerminate(Sender: TObject;Thread: TBMDExecuteThread; var Data: Pointer);
     procedure ThreadStart(Sender: TObject;Thread: TBMDExecuteThread; var Data: Pointer);

    //XML-Events
     procedure XmlContent(Sender: TObject; Content: String);
     procedure XmlEndTag(Sender: TObject; TagName: String);
     procedure XmlStartTag(Sender: TObject; TagName: String; Attributes: TAttrList);

     //sontige Funktionen
     procedure LoadRSSList; //lädt Rss. ins Menü
     procedure Rssnotify(Sender: TObject);

end;

  procedure ParseEasyXML(FName: string);

var count:integer;
    RSSRead: TRSS;


implementation
uses unit1, httpprot, RegExpr, windows, menus, graphics, DateUtils, shellapi;

function Download(Adress, FName: String): boolean;
var HttpCli: THttpCli;
    outfile: string;
begin
 Result:= true;

 httpCli:= ThttpCli.Create(nil);
 httpcli.URL:=  adress;
 trim(FName);
 outfile:= ExtractFilePath(paramstr(0))+'RSS\' + FName;

  try
   httpcli.RcvdStream := TFileStream.create(Outfile,fmCreate);
   httpcli.Get;
  except
      //bei Fehlern löschen
      if fileexists(outfile) then deletefile(PCHar(outfile));
      Result:= false;
  end;

  httpcli.RcvdStream.Destroy;
  HttpCli.RcvdStream := nil;
  httpcli.Free;
end;

procedure AppendItem(key: string);
var i, pos, oldi: integer;
    r: TRegExpr;
    item, link: string;
    lastlink: string;
    LMLFile: TStringlist;
    schnitt: integer;
    f: string;

begin
    r:= TRegExpr.Create;
    r.Expression:= '^\"(.*)\"  \"(.*)"';

    with hauptfenster do
    begin

     menu.Items.items[3].Add(NewItem(key,TextToShortCut(''),False,True,nil,0,'Item1'));

     pos:= menu.Items.items[3].count-1;

     f:= Extractfilepath(paramstr(0)) + 'RSS\'+key+'.lml';
     
     setlength(Hauptfenster.RSSitems[pos],0);

     //alle heruntergeladenen Items adden
    if RssRead.itemlist.count > 0 then
     for i:= 0 to RSSRead.itemlist.Count -1 do
      begin

       setlength(RSSitems[pos],length(RSSItems[pos])+1);

       item:= trim(r.replace(RSSRead.Itemlist.strings[i], '$1', true));
       link:= trim(r.replace(RSSRead.Itemlist.strings[i], '$2', true));

       menu.Items.items[3].items[pos].Add(NewItem(item,TextToShortCut(''),False,True,RssRead.RssNotify,0,'Item1'));
       menu.Items.items[3].items[pos].items[i].Tag:= i;

       Rssitems[pos][i].title:= item;
       Rssitems[pos][i].link:= link;
       if (i > Hauptfenster.Rss_max) then
        begin
         RSSREad.Itemlist.SaveToFile(F);
         r.free;
         exit;
        end;
      end;

    if (FileExists(F) and hauptfenster.rss_old) then
    begin

      lastlink:= '"'+item+'"' + '  "'+link+'"'; //das letzte bearbeitete Item
      LMLfile:= TStringList.Create;
      lmlfile.LoadFromFile(F);

      schnitt:= lmlfile.IndexOf(lastlink) +1; //position des letzten items in der liste +1

      if (lmlfile.Count-1 > 0) then
        for i:= schnitt to lmlfile.Count-1 do
         if r.Exec(lmlfile.Strings[i]) then //wenn der String matched
          begin
           //hinzufügen der alten Items;
            oldi:= length(RSSItems[pos]); //postion des letzten Items ist die stelle des nächsten
            setlength(RSSitems[pos],length(RSSItems[pos])+1);

            item:= trim(r.replace(lmlfile.strings[i], '$1', true));
            link:= trim(r.replace(lmlfile.strings[i], '$2', true));

            menu.Items.items[3].items[pos].Add(NewItem(item,TextToShortCut(''),False,True,RssRead.RssNotify,0,'Item1'));
            menu.Items.items[3].items[pos].items[oldi].Tag:= i;

            Rssitems[pos][oldi].title:= item;
            Rssitems[pos][oldi].link:= link;

            RssRead.Itemlist.Append(lmlfile.Strings[i]);

            if (oldi > Hauptfenster.Rss_max) then
              begin
                RSSREad.Itemlist.SaveToFile(F);
                lmlfile.Free;
                r.free;
                exit;
              end;
          end;

      lmlfile.Free;

    end; //if Fileexists
    end; //with hauptfenster do ... 

    RSSREad.Itemlist.SaveToFile(F);
    r.Free;
end;

procedure AppendStatic(item_name:string; posi: integer);
var items : TStringlist;
    r     : TRegExpr;
    item, link: string;
    j,count     : integer;
    bezeichner: string;
begin
  count:= 0;
  bezeichner:= item_name;

  delete(bezeichner, length(bezeichner)-3, 4);
  hauptfenster.menu.Items.items[3].Add(NewItem(bezeichner,TextToShortCut(''),False,True,nil,0,'Item1'));

  items:= TStringlist.Create;
  r:= TRegExpr.Create;

      if fileexists(ExtractFilePath(paramstr(0))+'RSS\' + item_Name) then
       begin
        ITEMS.LoadFromFile(ExtractFilePath(paramstr(0))+'RSS\' + item_Name);
        r.Expression:= '^\"(.*)\"  \"(.*)"';

        with hauptfenster do
        begin

         if items.Count > 0 then

         for J:= 0 to items.Count -1 do
        	 if r.exec(items.strings[j]) then //nur wenn der String matched
           begin


            setlength(RSSitems[posi],length(RSSItems[posi])+1);

            item:= trim(r.replace(Items.strings[j], '$1', true));
            link:= trim(r.replace(Items.strings[j], '$2', true));

            menu.Items.items[3].items[posi].Add(NewItem(item,TextToShortCut(''),False,True,RssRead.RssNotify,0,'Item1'));
            menu.Items.items[3].items[posi].items[count].Tag:= count;


            Rssitems[posi][count].title:= item;
            Rssitems[posi][count].link:= link;
	          inc(count);
           end;
        end;
      end;


    items.Free;
    r.free;

end;

procedure TRSS.RSSNotify(Sender: TObject);
var pos,item: integer;
begin
with sender as TMenuItem do
begin
 pos:= Parent.MenuIndex;
 item:= MenuIndex;

 checked:= true;

 hauptfenster.RSSItems[pos][item].checked:= true;

 Shellexecute( 0, nil, Pchar(hauptfenster.rssitems[pos][item].link), nil, nil, SW_SHOW);

end;
end;

procedure TRSS.LoadRSSList;
var i, j, pos: integer;
    r: TRegExpr;
    item, link: string;
    Files, Items: TStringList;
    item_name: string;
begin

 Files:= TStringList.Create;
 Items:= TStringList.Create;
 if fileexists(ExtractFilePath(ParamStr(0))+ 'RSSlist.txt')
  then Files.LoadFromFile(ExtractFilePath(ParamStr(0))+ 'RSSlist.txt')
  else begin
        items.free;
        files.free;
        exit;
       end; 

 //alle Items löschen
 with hauptfenster do
 if menu.Items.items[3].Count > 0 then
  for i:= menu.Items.items[3].Count-1 downto 0 do
  begin

   if menu.items.Items[3].Items[i].count > 0 then
      for j:= menu.items.Items[3].Items[i].count-1 downto 0 do
      begin
       menu.items.Items[3].items[i].items[j].Free;
      end;

   menu.items.Items[3].Delete(i);
   setlength(RSSitems,0);
  end;

 r:= TRegExpr.Create;

 if files.count > 0 then
   for i:= 0 to files.count -1 do
   begin
     r.Expression:= '^(.*)=http://(.*)'; //template für eine Zeile
     if r.exec(files.Strings[i]) then //wenn die Zeile matched
     begin

       item_name:= r.Replace(files.Strings[i],'$1', true);

       with hauptfenster do
       begin
       menu.Items.items[3].Add(NewItem(item_Name,TextToShortCut(''),False,True,nil,0,'Item1'));
       setlength(RSSitems,length(RssItems) +1);

       item_name:= item_name + '.lml';

       pos:= menu.Items.items[3].count-1;
       setlength(RSSitems[pos],0);
       end;
       
       if fileexists(ExtractFilePath(paramstr(0))+'RSS\' + item_Name) then
       begin

        ITEMS.LoadFromFile(ExtractFilePath(paramstr(0))+'RSS\' + item_Name);

        r.Expression:= '^\"(.*)\"  \"(.*)"';
        with hauptfenster do
        begin
         if items.Count > 0 then
         for J:= 0 to items.Count -1 do
         begin
          setlength(RSSitems[pos],length(RSSItems[pos])+1);

          item:= trim(r.replace(Items.strings[j], '$1', true));
          link:= trim(r.replace(Items.strings[j], '$2', true));

          menu.Items.items[3].items[pos].Add(NewItem(item,TextToShortCut(''),False,True,RssRead.RssNotify,0,'Item1'));
          menu.Items.items[3].items[pos].items[j].Tag:= j;

          Rssitems[pos][j].title:= item;
          Rssitems[pos][j].link:= link;
         end;
       end;
     end;
  end;
 end;

  r.Free;
  items.free;
  files.free;
end;


procedure TRSS.ThreadExecute(Sender: TObject; Thread: TBMDExecuteThread; var Data: Pointer);
var i,j: integer;
    r: TRegExpr;
    Files: TStringlist;
    adress, Name: string;
begin

  if fileexists(ExtractFilePath(ParamStr(0))+ 'RSSlist.txt') then
  begin
   Files:= TStringList.Create;
   Files.LoadFromFile(ExtractFilePath(ParamStr(0))+ 'RSSlist.txt');
  end else exit;
  
 hauptfenster.Status.SimpleText:= ('Starte RSS-Update');

 if not DirectoryExists(ExtractFilePath(paramstr(0))+'RSS') then MkDir(ExtractFilePath(paramstr(0))+'RSS');

 //alle löschen
 with hauptfenster do
 if menu.Items.items[3].Count > 0 then
  for i:= menu.Items.items[3].Count-1 downto 0 do
  begin

   if menu.items.Items[3].Items[i].count > 0 then
     for j:= menu.items.Items[3].Items[i].count-1 downto 0 do
     begin
      menu.items.Items[3].items[i].items[j].Free;
     end;

   menu.items.Items[3].Delete(i);
  end;

 r:= TRegExpr.Create;
 r.Expression:= '^(.*)=http://(.*)'; //template für eine Zeile

 setlength(Hauptfenster.RSSitems,files.count);

 if files.count > 0 then
   for i:= 0 to files.count -1 do
   begin
     if r.exec(files.Strings[i]) then //wenn die Zeile matched
     begin
       adress:= r.Replace(files.Strings[i],'http://$2', true);
       name:= r.Replace(files.Strings[i],'$1.xml', true);

       // Herunterladen der Datei
      if download(adress, name) then
       //Parsen der Datei
       begin
        ParseEasyXML(ExtractFilePath(paramstr(0))+'RSS\' + Name);
        //lml-datei wieder löschen
        if fileexists(ExtractFilePath(paramstr(0))+'RSS\' + Name) then deletefile(Pchar(ExtractFilePath(paramstr(0))+'RSS\' + Name));
        //Menü updaten
        delete(name, length(name)-3,4);
        AppendItem(name);
       end
       else //wenn Download fehlgeschlagen
       begin
        //Menü updaten
        name:= ChangeFileExt(Name,'.lml');
        AppendStatic(name,i);
       end;
     end;
     if RssRead.MyThread.Thread.Terminated then break;  //aus der schleife springen wenn der Thread abgebrochen wurde
   end;
 r.Free;
 Files.Free;
end;

procedure TRSS.ThreadStart(Sender: TObject;Thread: TBMDExecuteThread; var Data: Pointer);
begin
 hauptfenster.rssrunning:= true;
 hauptfenster.ledrss.coloroff:= clOlive;
 hauptfenster.ledrss.coloron:= clYellow;
 hauptfenster.LEDTimer.enabled:= true;
 hauptfenster.LEDRSS.Hint:= 'RSS-Update gestartet : ' + timetostr(timeof(now));

 RSSRead.XML:= TEasyXmlScanner.Create(hauptfenster);
 RssRead.XML.Normalize:= false;

 RSSRead.itemlist:= Tstringlist.Create;

 RSSRead.XML.OnStartTag :=  RSSRead.XmlStartTag;
 RSSRead.XML.OnEndTag   :=  RSSRead.XmlEndTag;
 RSSRead.XML.OnContent  :=  RSSRead.XmlContent;
end;

procedure TRSS.ThreadTerminate(Sender: TObject;Thread: TBMDExecuteThread; var Data: Pointer);
begin
 hauptfenster.rssrunning:= false;

 RSSRead.Itemlist.Free;
 RSSRead.XML.Free;
 RssRead.MyThread:= nil;
 RssRead.MyThread.Free;
// RSSRead.Free;

if (not Hauptfenster.noFeeds) then
   begin
    if (hauptfenster.isonline and (not hauptfenster.noballoon )) then hauptfenster.tray.showballoonHint('RSS-Update','Die RSS-Feeds wurden soeben aktualisiert.', bitINFO,10);
    hauptfenster.ledtimer.enabled:= false;
    hauptfenster.ledrss.coloron:= clLime;
    hauptfenster.ledrss.ledon:= true;
    hauptfenster.ledrss.hint:= 'Letzte Aktualisierung der Rss-Feeds um ' + timetostr(timeof(now));
   end;

 hauptfenster.Status.SimpleText:= ('RSS-Update beendet.');

 if RSSRead.shutdown then
 begin
    Hauptfenster.closeallowed:= true;
    Hauptfenster.autoclose:= true;
    hauptfenster.close;
 end;
end;


procedure ParseEasyXML(FName: string);
begin
with RSSRead do
 begin
  itemlist.clear; //alle Items löschen
  if fileexists(Fname) then
   begin
    XML.Filename:= FName;
    XML.Execute; //ausführen
   end;
 end;
end;


procedure TRSS.XmlStartTag(Sender: TObject; TagName: String; Attributes: TAttrList);
begin
if ansicontainstext(tagname, 'item') then RSSRead.isitem:= true;

if (ansicontainstext(tagname, 'link') or ansicontainstext(tagname, 'title'))
  then begin RssRead.lasttag:= tagname; exit; end
  else begin RSSRead.lasttag:= '';  end;

end;


procedure TRSS.XmlContent(Sender: TObject; Content: String);
begin
//wenn nicht innerhalb des item-tags
if ((RSSRead.lasttag <> 'title') and  (RSSRead.lasttag <> 'link') ) then exit;

if (RSSRead.lasttag = 'title') then RSSRead.lasttitle:= content
else
if (RSSRead.lasttag = 'link')  then RSSRead.lastlink := content;
end;

procedure TRSS.XmlEndTag(Sender: TObject; TagName: String);
begin

//wenn das itemtag geschlossen wird
if (tagname = 'item') then
begin
 //merken
 if isitem then
   RSSRead.Itemlist.Append('"'+RSSRead.lasttitle+'"' + '  "'+ RSSRead.lastlink+'"');
 // item-tag wird geschlossen > alle rücksetzen
 RSSRead.lasttitle:= '';
 RSSRead.lastlink := '';
 RSSRead.isitem   := false;
 RssRead.lasttag:= '';
end;
end;

procedure StartRssUpdate;
begin
 count:= 0;
// RSSRead:= TRSS.Create;
 RSSRead.shutdown:= false; //Rss-Feed gerade gestartet nicht beenden

 RSSRead.MyThread:= TBMDThread.Create(hauptfenster);
 RSSRead.MyThread.OnExecute   := RSSRead.ThreadExecute;
 RSSRead.MyThread.OnTerminate := RSSRead.ThreadTerminate;
 RSSRead.MyThread.OnStart     := RSSRead.ThreadStart;

 RSSRead.MyThread.Start;

end;

end.
