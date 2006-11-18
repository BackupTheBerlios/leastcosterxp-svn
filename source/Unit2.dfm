object LCXPSettings: TLCXPSettings
  Left = 336
  Top = 130
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Einstellungen'
  ClientHeight = 585
  ClientWidth = 439
  Color = clBtnFace
  UseDockManager = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 448
    Width = 441
    Height = 81
    Lines.Strings = (
      'Memo1')
    OEMConvert = True
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    WantReturns = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 439
    Height = 449
    ActivePage = TabSheet3
    Align = alTop
    MultiLine = True
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Einstellungen'
      object settingbox: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 105
        Align = alTop
        Caption = 'Programmstart und Hinweise'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object minimiert: TCheckBox
          Left = 24
          Top = 48
          Width = 193
          Height = 17
          Caption = 'LeastCoster XP minimiert starten'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnMouseMove = minimiertMouseMove
        end
        object noBalloon: TCheckBox
          Left = 216
          Top = 48
          Width = 193
          Height = 17
          Caption = 'keine BalloonTips anzeigen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnMouseMove = noBalloonMouseMove
        end
        object autostart: TCheckBox
          Left = 24
          Top = 24
          Width = 138
          Height = 20
          Caption = 'Autostart aktivieren'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = autostartClick
          OnMouseMove = autostartMouseMove
        end
        object minimize: TCheckBox
          Left = 24
          Top = 72
          Width = 201
          Height = 17
          Caption = 'Klick auf [X] minimiert LCXP'
          TabOrder = 4
        end
        object time: TCheckBox
          Left = 216
          Top = 24
          Width = 169
          Height = 17
          Caption = 'zeige aktuelle Uhrzeit an'
          TabOrder = 1
        end
      end
      object GroupBox17: TGroupBox
        Left = 0
        Top = 201
        Width = 431
        Height = 96
        Align = alTop
        Caption = 'Balkendiagramme im HTML-Protokoll'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 2
        object Label2: TLabel
          Left = 17
          Top = 28
          Width = 162
          Height = 13
          Caption = 'Einf'#228'rbung der Balkendiagramme :'
          OnMouseMove = Label10MouseMove
        end
        object Label3: TLabel
          Left = 26
          Top = 56
          Width = 29
          Height = 13
          Caption = 'gelb : '
        end
        object Label4: TLabel
          Left = 141
          Top = 56
          Width = 18
          Height = 13
          Caption = 'rot :'
          OnMouseMove = gelbMouseMove
        end
        object gelb: TEdit
          Left = 64
          Top = 52
          Width = 65
          Height = 21
          TabOrder = 0
          OnChange = gelbChange
          OnMouseMove = gelbMouseMove
        end
        object rot: TEdit
          Left = 168
          Top = 52
          Width = 65
          Height = 21
          TabOrder = 1
          OnChange = rotChange
          OnMouseMove = gelbMouseMove
        end
        object Button6: TButton
          Left = 248
          Top = 49
          Width = 137
          Height = 24
          Caption = 'Standard wiederherstellen'
          TabOrder = 2
          OnClick = Button3Click
        end
      end
      object GroupBox16: TGroupBox
        Left = 0
        Top = 105
        Width = 431
        Height = 96
        Align = alTop
        Caption = 'Log Dateien'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        object Label10: TLabel
          Left = 140
          Top = 29
          Width = 77
          Height = 13
          Caption = 'Tage speichern.'
        end
        object Label11: TLabel
          Left = 12
          Top = 29
          Width = 50
          Height = 13
          Caption = 'Die letzten'
        end
        object DaystoSaveLogs: TSpinEdit
          Left = 70
          Top = 24
          Width = 65
          Height = 22
          MaxValue = 365
          MinValue = 1
          TabOrder = 0
          Value = 60
          OnMouseMove = DaystoSaveLogsMouseMove
        end
        object Button3: TButton
          Left = 248
          Top = 23
          Width = 139
          Height = 25
          Caption = 'Atomzeit-Log  &anzeigen'
          TabOrder = 1
          OnClick = showatomlogClick
          OnMouseMove = showatomlogMouseMove
        end
        object Button7: TButton
          Left = 248
          Top = 55
          Width = 139
          Height = 25
          Caption = 'Einwahl-Log  &anzeigen'
          TabOrder = 2
          OnClick = Button7Click
          OnMouseMove = showatomlogMouseMove
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ausweich-LCR'
      ImageIndex = 1
      object GroupBox15: TGroupBox
        Left = 0
        Top = 168
        Width = 431
        Height = 121
        Align = alTop
        Caption = 'Oleco/ Discountsurfer - Protokolle'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lasttimelabel: TLabel
          Left = 24
          Top = 43
          Width = 119
          Height = 13
          Caption = 'Stand des letzten Imports'
        end
        object pledelete: TButton
          Left = 264
          Top = 83
          Width = 121
          Height = 25
          Caption = 'L'#246'sche Oleco Protokoll'
          TabOrder = 4
          OnClick = pledeleteClick
        end
        object pleopen: TButton
          Left = 120
          Top = 83
          Width = 137
          Height = 25
          Caption = 'Bearbeite Oleco Protokoll'
          TabOrder = 3
          OnClick = pleopenClick
        end
        object resetdate: TButton
          Left = 24
          Top = 83
          Width = 89
          Height = 25
          Caption = 'Reset'
          TabOrder = 2
          OnClick = resetdateClick
          OnMouseMove = resetdateMouseMove
        end
        object lasttime: TEdit
          Left = 24
          Top = 59
          Width = 361
          Height = 21
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 1
          OnMouseMove = lasttimeMouseMove
        end
        object autoread: TCheckBox
          Left = 24
          Top = 19
          Width = 297
          Height = 17
          Caption = 'automatisch von Oleco/ Discountsurfer importieren'
          TabOrder = 0
          OnMouseMove = autoreadMouseMove
        end
      end
      object GroupBox14: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 168
        Align = alTop
        Caption = 'Ausweich-LCR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Suchen: TSpeedButton
          Left = 369
          Top = 37
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SuchenClick
          OnMouseMove = PfadMouseMove
        end
        object Label1: TLabel
          Left = 22
          Top = 115
          Width = 253
          Height = 13
          Caption = 'Tarife mit Einwahlgeb'#252'hr anzeigen f'#252'r Zeiten > ...  min'
          Enabled = False
          OnMouseMove = Label1MouseMove
        end
        object Pfad: TLabeledEdit
          Left = 22
          Top = 37
          Width = 337
          Height = 21
          EditLabel.Width = 218
          EditLabel.Height = 13
          EditLabel.Caption = 'Pfad zum Discountsurfer / Oleco/ Smartsurfer '
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          TabOrder = 0
          OnChange = PfadChange
          OnMouseMove = PfadMouseMove
        end
        object Button2: TButton
          Left = 296
          Top = 79
          Width = 97
          Height = 25
          Caption = 'Titel herausfinden'
          TabOrder = 2
          OnClick = Button2Click
          OnMouseMove = Button2MouseMove
        end
        object DSurfer: TLabeledEdit
          Left = 21
          Top = 83
          Width = 252
          Height = 21
          EditLabel.Width = 233
          EditLabel.Height = 13
          EditLabel.Caption = 'Titelleiste von Discountsurfer/ Oleco/ Smartsurfer'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnMouseMove = DSurferMouseMove
        end
        object selectshowtime: TSpinEdit
          Left = 38
          Top = 130
          Width = 64
          Height = 22
          Enabled = False
          MaxValue = 180
          MinValue = 1
          TabOrder = 4
          Value = 1
          OnChange = selectshowtimeChange
          OnMouseMove = selectshowtimeMouseMove
        end
        object RadioButton3: TRadioButton
          Left = 22
          Top = 135
          Width = 17
          Height = 17
          Enabled = False
          TabOrder = 3
          OnEnter = RadioButton3Enter
        end
        object RadioButton2: TRadioButton
          Left = 126
          Top = 135
          Width = 113
          Height = 17
          Caption = 'immer an'
          Enabled = False
          TabOrder = 5
          OnEnter = RadioButton2Enter
          OnMouseMove = RadioButton2MouseMove
        end
        object RadioButton1: TRadioButton
          Left = 230
          Top = 135
          Width = 113
          Height = 17
          Caption = 'immer aus'
          Enabled = False
          TabOrder = 6
          OnEnter = RadioButton1Enter
          OnMouseMove = RadioButton1MouseMove
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Online'
      ImageIndex = 2
      object GroupBox9: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 161
        Align = alTop
        Caption = 'Modemeinstellungen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object modemlabel: TLabel
          Left = 24
          Top = 36
          Width = 41
          Height = 13
          Caption = 'Modem :'
          OnMouseMove = modemlabelMouseMove
        end
        object vorwahllabel: TLabel
          Left = 25
          Top = 118
          Width = 91
          Height = 13
          Caption = 'Nummer vorw'#228'hlen'
          OnMouseMove = vorwahllabelMouseMove
        end
        object Device: TComboBox
          Left = 24
          Top = 52
          Width = 273
          Height = 21
          Hint = 'Welches Modem wird verwendet, um ins Internet zu gehen ?'
          Style = csDropDownList
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnDropDown = DeviceDropDown
        end
        object edvorwahl: TEdit
          Left = 25
          Top = 134
          Width = 184
          Height = 21
          TabOrder = 4
          OnKeyPress = edvorwahlKeyPress
          OnMouseMove = vorwahllabelMouseMove
        end
        object Button8: TButton
          Left = 318
          Top = 24
          Width = 99
          Height = 41
          Caption = 'Netzwerk- und DF'#220'-Verbindungen'
          TabOrder = 5
          WordWrap = True
          OnClick = Button8Click
          OnMouseMove = Button8MouseMove
        end
        object Multilink: TCheckBox
          Left = 24
          Top = 75
          Width = 241
          Height = 17
          Caption = 'Kanalb'#252'ndelung erm'#246'glichen / Modem 2 '
          TabOrder = 2
          OnClick = MultilinkClick
          OnMouseMove = MultilinkMouseMove
        end
        object Device2: TComboBox
          Left = 24
          Top = 93
          Width = 273
          Height = 21
          Hint = 'Welches Modem wird verwendet, um ins Internet zu gehen ?'
          Style = csDropDownList
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnDropDown = DeviceDropDown
        end
        object setupmodems: TCheckBox
          Left = 26
          Top = 16
          Width = 265
          Height = 18
          Caption = 'benutze immer die Einstellung der DF'#220'-Verbindung'
          TabOrder = 0
          OnClick = setupmodemsClick
          OnMouseMove = setupmodemsMouseMove
        end
      end
      object GroupBox11: TGroupBox
        Left = 0
        Top = 235
        Width = 431
        Height = 166
        Align = alTop
        Caption = 'Programme starten bei Online-/ Offlinewechsel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object Label20: TLabel
          Left = 266
          Top = 88
          Width = 38
          Height = 13
          Caption = 'Timeout'
        end
        object Label21: TLabel
          Left = 338
          Top = 88
          Width = 69
          Height = 13
          Caption = 'mind. Basiszeit'
        end
        object Label22: TLabel
          Left = 29
          Top = 48
          Width = 47
          Height = 13
          Caption = 'Programm'
        end
        object Label19: TLabel
          Left = 28
          Top = 88
          Width = 48
          Height = 13
          Caption = 'Parameter'
        end
        object programs_suchen: TSpeedButton
          Left = 232
          Top = 65
          Width = 19
          Height = 18
          Caption = '...'
          OnClick = programs_suchenClick
          OnMouseMove = programs_pathMouseMove
        end
        object Label36: TLabel
          Left = 242
          Top = 136
          Width = 16
          Height = 13
          Caption = 'alle'
        end
        object Label38: TLabel
          Left = 349
          Top = 135
          Width = 25
          Height = 13
          Caption = 'Tage'
        end
        object BitBtn2: TBitBtn
          Left = 124
          Top = 130
          Width = 81
          Height = 25
          Caption = '&Felder l'#246'schen'
          TabOrder = 11
          OnClick = BitBtn2Click
          OnMouseMove = programs_pathMouseMove
        end
        object programs_add: TBitBtn
          Left = 28
          Top = 130
          Width = 81
          Height = 25
          Caption = 'h&inzuf'#252'gen'
          TabOrder = 10
          OnClick = programs_addClick
          OnMouseMove = programs_pathMouseMove
        end
        object programs_params: TEdit
          Left = 28
          Top = 103
          Width = 197
          Height = 21
          TabOrder = 7
          OnMouseMove = programs_paramsMouseMove
        end
        object programs_path: TEdit
          Left = 28
          Top = 64
          Width = 198
          Height = 21
          TabOrder = 5
          OnMouseMove = programs_pathMouseMove
        end
        object programs_kill: TCheckBox
          Left = 128
          Top = 46
          Width = 97
          Height = 17
          Caption = 'wieder beenden'
          TabOrder = 2
          OnMouseMove = programs_killMouseMove
        end
        object Programs: TComboBox
          Left = 27
          Top = 22
          Width = 166
          Height = 21
          Hint = '... Liste aller bereits eingerichteten Programme.'
          DropDownCount = 20
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnCloseUp = ProgramsCloseUp
        end
        object BitBtn3: TBitBtn
          Left = 208
          Top = 22
          Width = 81
          Height = 21
          Caption = 'l'#246'&schen'
          TabOrder = 1
          OnClick = BitBtn3Click
          OnMouseMove = programs_pathMouseMove
        end
        object programs_online: TRadioButton
          Left = 264
          Top = 46
          Width = 58
          Height = 17
          Caption = 'online'
          TabOrder = 3
          OnClick = programs_onlineClick
        end
        object programs_offline: TRadioButton
          Left = 320
          Top = 46
          Width = 58
          Height = 17
          Caption = 'offline'
          TabOrder = 4
          OnClick = programs_offlineClick
        end
        object programs_style: TComboBox
          Left = 264
          Top = 64
          Width = 135
          Height = 21
          Hint = 'In welchem Modus soll das Programm ausgef'#252'hrt werden ?'
          Style = csDropDownList
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          Sorted = True
          TabOrder = 6
          OnDropDown = DeviceDropDown
          Items.Strings = (
            'maximiert'
            'minimiert'
            'normal '
            'versteckt')
        end
        object programs_mintime: TSpinEdit
          Left = 345
          Top = 103
          Width = 54
          Height = 22
          MaxValue = 720
          MinValue = 1
          TabOrder = 9
          Value = 1
          OnMouseMove = programs_mintimeMouseMove
        end
        object programs_timeout: TSpinEdit
          Left = 265
          Top = 103
          Width = 70
          Height = 22
          MaxValue = 60000
          MinValue = 1
          TabOrder = 8
          Value = 1
          OnMouseMove = programs_timeoutMouseMove
        end
        object opendays: TSpinEdit
          Left = 267
          Top = 131
          Width = 68
          Height = 22
          MaxValue = 365
          MinValue = 0
          TabOrder = 12
          Value = 0
          OnMouseMove = opendaysMouseMove
        end
      end
      object GroupBox19: TGroupBox
        Left = 0
        Top = 161
        Width = 431
        Height = 74
        Align = alTop
        Caption = 'Verhalten nach dem Verbinden'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label15: TLabel
          Left = 26
          Top = 24
          Width = 55
          Height = 13
          Caption = 'Tariftabelle '
          OnMouseMove = forwardtableMouseMove
        end
        object Label16: TLabel
          Left = 162
          Top = 24
          Width = 208
          Height = 13
          Caption = 'Minuten im Voraus berechnen und anzeigen'
          OnMouseMove = forwardtableMouseMove
        end
        object forwardtable: TSpinEdit
          Left = 90
          Top = 20
          Width = 65
          Height = 22
          MaxValue = 120
          MinValue = 1
          TabOrder = 0
          Value = 5
          OnMouseMove = forwardtableMouseMove
        end
        object hidetray: TCheckBox
          Left = 26
          Top = 52
          Width = 196
          Height = 17
          Caption = 'nach Verbinden im Tray verstecken'
          TabOrder = 1
          OnMouseMove = hidetrayMouseMove
        end
        object OpenWebsite: TCheckBox
          Left = 227
          Top = 52
          Width = 169
          Height = 17
          Caption = #246'ffne Webseite des Anbieters'
          TabOrder = 2
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Online(2)'
      ImageIndex = 3
      object GroupBox6: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 97
        Align = alTop
        Caption = 'Sounds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label24: TLabel
          Left = 23
          Top = 18
          Width = 105
          Height = 13
          Caption = 'Sound bei Verbindung'
        end
        object Label23: TLabel
          Left = 24
          Top = 39
          Width = 30
          Height = 13
          Caption = 'Online'
        end
        object Label25: TLabel
          Left = 25
          Top = 67
          Width = 30
          Height = 13
          Caption = 'Offline'
        end
        object SoundOn: TEdit
          Left = 64
          Top = 35
          Width = 304
          Height = 21
          TabOrder = 0
          OnMouseMove = SoundOnMouseMove
        end
        object SoundOff: TEdit
          Left = 64
          Top = 66
          Width = 304
          Height = 21
          TabOrder = 2
          OnMouseMove = SoundOnMouseMove
        end
        object SoundOffBut: TButton
          Left = 376
          Top = 66
          Width = 20
          Height = 20
          Caption = '...'
          TabOrder = 3
          OnClick = SoundOnButClick
          OnMouseMove = SoundOnMouseMove
        end
        object SoundOnBut: TButton
          Left = 376
          Top = 35
          Width = 20
          Height = 20
          Caption = '...'
          TabOrder = 1
          OnClick = SoundOnButClick
        end
      end
      object GroupBox7: TGroupBox
        Left = 0
        Top = 185
        Width = 431
        Height = 200
        Align = alTop
        Caption = 'OnlineInfo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label17: TLabel
          Left = 15
          Top = 37
          Width = 71
          Height = 13
          Caption = 'Hintergrundbild'
        end
        object Label18: TLabel
          Left = 16
          Top = 80
          Width = 48
          Height = 13
          Caption = 'Schriftart :'
        end
        object OnlineInfo: TCheckBox
          Left = 15
          Top = 20
          Width = 224
          Height = 16
          Caption = 'OnlineInfo beim Verbinden anzeigen '
          TabOrder = 0
          OnClick = OnlineInfoClick
          OnMouseMove = OnlineInfoMouseMove
        end
        object bgedit: TEdit
          Left = 14
          Top = 51
          Width = 379
          Height = 21
          TabOrder = 2
          OnMouseMove = bgeditMouseMove
        end
        object bgbutton: TButton
          Left = 400
          Top = 51
          Width = 20
          Height = 20
          Caption = '...'
          TabOrder = 3
          OnClick = bgbuttonClick
        end
        object GroupBox25: TGroupBox
          Left = 16
          Top = 99
          Width = 277
          Height = 97
          Caption = 'Farbeinstellungen'
          TabOrder = 6
          object InfoBG: TLabel
            Left = 5
            Top = 46
            Width = 79
            Height = 13
            Caption = 'Hintergrundfarbe'
          end
          object InfoSpecialText: TLabel
            Left = 5
            Top = 68
            Width = 118
            Height = 13
            Caption = 'Farbe der Kostenanzeige'
          end
          object InfoText: TLabel
            Left = 5
            Top = 24
            Width = 45
            Height = 13
            Caption = 'Textfarbe'
          end
          object ColorBox1: TColorBox
            Left = 128
            Top = 39
            Width = 145
            Height = 22
            ItemHeight = 16
            TabOrder = 1
            OnChange = ColorBox1Change
          end
          object ColorBox2: TColorBox
            Left = 128
            Top = 16
            Width = 145
            Height = 22
            ItemHeight = 16
            TabOrder = 0
            OnChange = ColorBox2Change
          end
          object ColorBox3: TColorBox
            Left = 128
            Top = 63
            Width = 145
            Height = 22
            ItemHeight = 16
            TabOrder = 2
            OnChange = ColorBox3Change
          end
        end
        object SetOnlineInfoWidth: TCheckBox
          Left = 207
          Top = 34
          Width = 191
          Height = 17
          Caption = 'Tarifnamen immer vollst'#228'ndig lesbar'
          TabOrder = 1
        end
        object Fontedit: TEdit
          Left = 88
          Top = 76
          Width = 305
          Height = 21
          ReadOnly = True
          TabOrder = 4
        end
        object FontB: TButton
          Left = 400
          Top = 78
          Width = 20
          Height = 20
          Caption = '...'
          TabOrder = 5
          OnClick = FontBClick
        end
      end
      object GroupBox22: TGroupBox
        Left = 0
        Top = 97
        Width = 431
        Height = 88
        Align = alTop
        Caption = 'Programmupdates'
        TabOrder = 2
        object keepfiles: TCheckBox
          Left = 24
          Top = 40
          Width = 187
          Height = 17
          Caption = 'Backups beim Updaten anlegen'
          TabOrder = 1
          OnClick = keepfilesClick
        end
        object updatebox: TCheckBox
          Left = 24
          Top = 23
          Width = 163
          Height = 17
          Caption = 'auf Programmupdates pr'#252'fen'
          TabOrder = 0
          OnMouseMove = updateboxMouseMove
        end
        object Button10: TButton
          Left = 318
          Top = 16
          Width = 99
          Height = 41
          Caption = 'Zeige BackUp-Ordner'
          TabOrder = 2
          WordWrap = True
          OnClick = Button9Click
        end
        object keepfiles_one: TCheckBox
          Left = 43
          Top = 58
          Width = 206
          Height = 17
          Caption = 'nur die letzten '#196'nderungen sichern'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Online - Tools'
      ImageIndex = 5
      object GroupBox10: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 169
        Align = alTop
        Caption = 'Atomzeit - Update'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnMouseMove = AtomboxMouseMove
        object Label6: TLabel
          Left = 16
          Top = 57
          Width = 72
          Height = 13
          Caption = 'Atomzeitserver:'
          OnMouseMove = Label6MouseMove
        end
        object Label37: TLabel
          Left = 146
          Top = 131
          Width = 76
          Height = 13
          Caption = 'min wiederholen'
          OnMouseMove = RssUpdateMouseMove
        end
        object Atombox: TCheckBox
          Left = 16
          Top = 24
          Width = 209
          Height = 17
          Caption = 'Systemzeit mit der Atomzeit abgleichen'
          TabOrder = 0
          OnClick = AtomboxClick
          OnMouseMove = AtomboxMouseMove
        end
        object showatomlog: TButton
          Left = 264
          Top = 16
          Width = 122
          Height = 25
          Caption = 'Logfile &anzeigen'
          TabOrder = 1
          OnClick = showatomlogClick
          OnMouseMove = showatomlogMouseMove
        end
        object serverdelete: TButton
          Left = 296
          Top = 53
          Width = 91
          Height = 25
          Caption = '&l'#246'schen'
          TabOrder = 5
          OnClick = serverdeleteClick
          OnMouseMove = serverdeleteMouseMove
        end
        object Serveraddbutton: TButton
          Left = 296
          Top = 82
          Width = 91
          Height = 25
          Caption = '&hinzuf'#252'gen'
          TabOrder = 7
          OnClick = ServeraddbuttonClick
          OnMouseMove = ServeraddbuttonMouseMove
        end
        object Serveradd: TEdit
          Left = 120
          Top = 83
          Width = 145
          Height = 21
          TabOrder = 6
          OnMouseMove = Label6MouseMove
        end
        object Serverbox: TComboBox
          Left = 120
          Top = 54
          Width = 145
          Height = 21
          ItemHeight = 0
          TabOrder = 3
          Text = 'Serverliste'
          OnEnter = ServerboxEnter
        end
        object AtomInterval: TSpinEdit
          Left = 63
          Top = 126
          Width = 73
          Height = 22
          MaxValue = 2440
          MinValue = 1
          TabOrder = 9
          Value = 1
        end
        object atomrepeat: TCheckBox
          Left = 16
          Top = 128
          Width = 41
          Height = 17
          Caption = 'alle'
          TabOrder = 8
          OnClick = atomrepeatClick
        end
        object left: TButton
          Left = 97
          Top = 53
          Width = 21
          Height = 21
          Caption = '<'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 2
          OnClick = rightClick
          OnMouseMove = leftMouseMove
        end
        object right: TButton
          Left = 267
          Top = 53
          Width = 21
          Height = 21
          Caption = '>'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 4
          OnClick = rightClick
          OnMouseMove = leftMouseMove
        end
      end
      object GroupBox18: TGroupBox
        Left = 0
        Top = 169
        Width = 431
        Height = 72
        Align = alTop
        Caption = 'IP Adresse per eMail versenden'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnMouseMove = GroupBox18MouseMove
        object Label34: TLabel
          Left = 129
          Top = 21
          Width = 28
          Height = 13
          Caption = 'Name'
        end
        object Label35: TLabel
          Left = 265
          Top = 20
          Width = 66
          Height = 13
          Caption = 'eMail Adresse'
        end
        object ipmail_name: TEdit
          Left = 128
          Top = 34
          Width = 130
          Height = 21
          TabOrder = 1
          OnMouseMove = ipmail_nameMouseMove
        end
        object ipmail_adress: TEdit
          Left = 265
          Top = 33
          Width = 130
          Height = 21
          TabOrder = 2
          OnMouseMove = ipmail_adressMouseMove
        end
        object ipmail_active: TCheckBox
          Left = 16
          Top = 33
          Width = 57
          Height = 17
          Caption = 'aktiv'
          TabOrder = 0
          OnClick = ipmail_activeClick
        end
      end
      object GroupBox8: TGroupBox
        Left = 0
        Top = 305
        Width = 431
        Height = 64
        Align = alTop
        Caption = 'IP Adressen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object Edit2: TEdit
          Left = 24
          Top = 25
          Width = 255
          Height = 21
          Hint = 'mehrere Ip'#39's bitte mit Semikolon trennen.'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          Text = '-'
          OnMouseMove = BitBtn1MouseMove
        end
        object BitBtn1: TBitBtn
          Left = 296
          Top = 23
          Width = 75
          Height = 25
          Caption = 'IP ermitteln'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BitBtn1Click
          OnMouseMove = BitBtn1MouseMove
        end
      end
      object GroupBox23: TGroupBox
        Left = 0
        Top = 241
        Width = 431
        Height = 64
        Align = alTop
        Caption = 'Windows Internet Einstellungen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object DFUE: TButton
          Left = 8
          Top = 24
          Width = 193
          Height = 25
          Caption = 'DF'#220'-Einwahl > keine Verbindung'
          TabOrder = 0
          OnClick = DFUEClick
        end
        object DFUE2: TButton
          Left = 223
          Top = 24
          Width = 193
          Height = 25
          Caption = 'DF'#220'-Einwahl > Standardverbindung'
          TabOrder = 1
          OnClick = DFUE2Click
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Automatik'
      ImageIndex = 7
      object Label27: TLabel
        Left = 16
        Top = 10
        Width = 172
        Height = 16
        Caption = '... Standardeinstellungen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 102
        Align = alTop
        Caption = 'Auto - Trennen nach Uhrzeit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnMouseMove = GroupBox2MouseMove
        object Label29: TLabel
          Left = 290
          Top = 38
          Width = 99
          Height = 13
          Caption = 'Sekunden abwarten.'
          OnMouseMove = autotrennenwaitMouseMove
        end
        object Label39: TLabel
          Left = 76
          Top = 81
          Width = 221
          Height = 13
          Caption = 'Sekunden vor den Ende eines Tarifes trennen.'
          OnMouseMove = forwardtableMouseMove
        end
        object autotrennen: TCheckBox
          Left = 8
          Top = 18
          Width = 201
          Height = 17
          Caption = 'Automatisch bei Tarifende trennen'
          TabOrder = 0
          OnClick = autotrennenClick
          OnMouseMove = autotrennenMouseMove
        end
        object autotrennenask: TCheckBox
          Left = 8
          Top = 38
          Width = 201
          Height = 17
          Caption = 'vor dem Trennen nachfragen und '
          TabOrder = 2
          OnClick = autotrennenaskClick
          OnMouseMove = autotrennenaskMouseMove
        end
        object autotrennenwaitval: TSpinEdit
          Left = 216
          Top = 35
          Width = 65
          Height = 22
          MaxValue = 900
          MinValue = 1
          TabOrder = 4
          Value = 30
          OnMouseMove = autotrennenwaitMouseMove
        end
        object autotrennenwait: TRadioButton
          Left = 192
          Top = 38
          Width = 17
          Height = 17
          TabOrder = 3
          OnClick = autotrennenwaitClick
          OnMouseMove = autotrennenwaitMouseMove
        end
        object autotrennenconfirm: TRadioButton
          Left = 192
          Top = 62
          Width = 201
          Height = 17
          Caption = 'nur nach Best'#228'tigung trennen.'
          TabOrder = 5
          OnClick = autotrennenwaitClick
          OnMouseMove = autotrennenconfirmMouseMove
        end
        object autotrennen_konti: TCheckBox
          Left = 193
          Top = 17
          Width = 232
          Height = 17
          Caption = 'Trennen am Ende von Zeitkontingenten'
          TabOrder = 1
          OnClick = autotrennenClick
          OnMouseMove = autotrennenMouseMove
        end
        object DisconnectSeconds: TSpinEdit
          Left = 6
          Top = 75
          Width = 65
          Height = 22
          MaxValue = 1800
          MinValue = 1
          TabOrder = 6
          Value = 5
          OnMouseMove = forwardtableMouseMove
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 102
        Width = 431
        Height = 147
        Align = alTop
        Caption = 'Leerlaufschutz'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnMouseMove = GroupBox2MouseMove
        object Label31: TLabel
          Left = 290
          Top = 19
          Width = 41
          Height = 13
          Caption = 'Minuten.'
        end
        object Label32: TLabel
          Left = 290
          Top = 46
          Width = 99
          Height = 13
          Caption = 'Sekunden abwarten.'
        end
        object Label12: TLabel
          Left = 28
          Top = 124
          Width = 79
          Height = 13
          Caption = 'Leerlaufschwelle'
        end
        object Label28: TLabel
          Left = 187
          Top = 124
          Width = 73
          Height = 13
          Caption = 'bytes/Sekunde'
        end
        object leerlauf: TCheckBox
          Left = 8
          Top = 19
          Width = 201
          Height = 17
          Caption = 'Automatisch trennen bei Leerlauf nach'
          TabOrder = 0
          OnClick = leerlaufClick
          OnMouseMove = leerlaufminutenMouseMove
        end
        object leerlaufminuten: TSpinEdit
          Left = 216
          Top = 16
          Width = 65
          Height = 22
          MaxValue = 720
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnMouseMove = leerlaufminutenMouseMove
        end
        object leerlaufask: TCheckBox
          Left = 8
          Top = 46
          Width = 201
          Height = 17
          Caption = 'vor dem Trennen nachfragen und '
          TabOrder = 2
          OnClick = leerlaufaskClick
          OnMouseMove = autotrennenMouseMove
        end
        object leerlaufwait: TRadioButton
          Left = 192
          Top = 46
          Width = 17
          Height = 17
          TabOrder = 3
          OnClick = leerlaufwaitClick
          OnMouseMove = autotrennenwaitMouseMove
        end
        object leerlaufwaitval: TSpinEdit
          Left = 216
          Top = 43
          Width = 65
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 900
          MinValue = 1
          ParentFont = False
          TabOrder = 4
          Value = 30
          OnMouseMove = autotrennenwaitMouseMove
        end
        object leerlaufconfirm: TRadioButton
          Left = 192
          Top = 70
          Width = 201
          Height = 17
          Caption = 'nur nach Best'#228'tigung trennen.'
          TabOrder = 5
          OnClick = leerlaufwaitClick
          OnMouseMove = autotrennenconfirmMouseMove
        end
        object Leerlaufsound: TEdit
          Left = 63
          Top = 93
          Width = 304
          Height = 21
          TabOrder = 7
          OnMouseMove = SoundOnMouseMove
        end
        object leerlaufsoundbut: TButton
          Left = 375
          Top = 93
          Width = 20
          Height = 20
          Caption = '...'
          TabOrder = 8
          OnClick = SoundOnButClick
        end
        object LeerlaufPlaySound: TCheckBox
          Left = 8
          Top = 74
          Width = 103
          Height = 17
          Caption = 'Spiele Sound ab '
          TabOrder = 6
          OnClick = LeerlaufPlaySoundClick
        end
        object Leerlaufschwelle: TSpinEdit
          Left = 117
          Top = 120
          Width = 65
          Height = 22
          Increment = 100
          MaxValue = 10000
          MinValue = 1
          TabOrder = 9
          Value = 500
          OnMouseMove = LeerlaufschwelleMouseMove
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 249
        Width = 431
        Height = 40
        Align = alTop
        Caption = 'Auto - Auschalten'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnMouseMove = AutoEinwahlMouseMove
        object AutoAus: TComboBox
          Left = 128
          Top = 12
          Width = 177
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          Items.Strings = (
            'Tue nichts'
            'Abmelden'
            'Ausschalten'
            'Neustart'
            'Ruhezustand'
            'StandBy')
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Automatik (2)'
      ImageIndex = 8
      object GroupBox20: TGroupBox
        Left = 0
        Top = 121
        Width = 431
        Height = 109
        Align = alTop
        Caption = 'Auto - Blacklist'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnMouseMove = AutoEinwahlMouseMove
        object Label41: TLabel
          Left = 159
          Top = 70
          Width = 3
          Height = 13
        end
        object Label40: TLabel
          Left = 61
          Top = 20
          Width = 116
          Height = 26
          Caption = 'Automatisch zur Blacklist, wenn mehr als '
          WordWrap = True
        end
        object Label42: TLabel
          Left = 62
          Top = 75
          Width = 81
          Height = 13
          Caption = 'Einwahlversuche'
          WordWrap = True
        end
        object Label43: TLabel
          Left = 193
          Top = 56
          Width = 18
          Height = 13
          Caption = 'und'
          WordWrap = True
        end
        object Label44: TLabel
          Left = 240
          Top = 20
          Width = 53
          Height = 13
          Caption = 'mindestens '
          WordWrap = True
        end
        object Label45: TLabel
          Left = 238
          Top = 75
          Width = 123
          Height = 26
          Caption = 'Prozent fehlgeschlagener Einwahlen.'
          WordWrap = True
        end
        object AutoBlacklist: TSpinEdit
          Left = 61
          Top = 50
          Width = 108
          Height = 22
          MaxValue = 100000
          MinValue = 1
          TabOrder = 0
          Value = 100
        end
        object AutoBlackListScore: TSpinEdit
          Left = 237
          Top = 50
          Width = 108
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 100
        end
      end
      object AutoEinwahl: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 121
        Align = alTop
        Caption = 'Auto - Einwahl  |  Wiederverbinden'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnMouseMove = AutoEinwahlMouseMove
        object Label30: TLabel
          Left = 28
          Top = 70
          Width = 125
          Height = 13
          Caption = 'Basiszeit bei Autoeinwahl :'
          OnMouseMove = Label30MouseMove
        end
        object Label33: TLabel
          Left = 159
          Top = 70
          Width = 3
          Height = 13
        end
        object AutoConnectOnStart: TCheckBox
          Left = 8
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Auto-Einwahl bei Programmstart aktivieren'
          TabOrder = 0
          OnMouseMove = AutoConnectOnStartMouseMove
        end
        object AutoReConnect: TCheckBox
          Left = 8
          Top = 32
          Width = 216
          Height = 17
          Caption = 'Wiederverbinden aktivieren'
          TabOrder = 1
          OnMouseMove = AutoReConnectMouseMove
        end
        object AutoConnectEinwahl: TCheckBox
          Left = 8
          Top = 49
          Width = 232
          Height = 17
          Caption = 'Tarife mit Einwahlgeb'#252'hren ber'#252'cksichtigen'
          TabOrder = 2
          OnMouseMove = AutoConnectEinwahlMouseMove
        end
        object AutoSurfdauer: TTrackBar
          Left = 27
          Top = 84
          Width = 342
          Height = 20
          Ctl3D = True
          Max = 720
          Min = 1
          ParentCtl3D = False
          Frequency = 20
          Position = 15
          TabOrder = 3
          ThumbLength = 10
          OnChange = AutoSurfdauerChange
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'WebInterface'
      ImageIndex = 4
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 97
        Align = alTop
        Caption = 'WebInterface'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label5: TLabel
          Left = 24
          Top = 24
          Width = 19
          Height = 13
          Caption = 'Port'
        end
        object serverautostart: TCheckBox
          Left = 24
          Top = 60
          Width = 241
          Height = 17
          Caption = 'Server mit LeastCoster XP starten'
          TabOrder = 3
          OnMouseMove = serverautostartMouseMove
        end
        object PoEdit: TEdit
          Left = 50
          Top = 20
          Width = 53
          Height = 21
          TabOrder = 0
          OnExit = PoEditExit
          OnMouseMove = PoEditMouseMove
        end
        object StartButton: TButton
          Left = 112
          Top = 21
          Width = 53
          Height = 21
          Caption = '&Start'
          TabOrder = 1
          OnClick = StartButtonClick
          OnMouseMove = StartButtonMouseMove
        end
        object StopButton: TButton
          Left = 176
          Top = 21
          Width = 53
          Height = 21
          Caption = 'St&op'
          Enabled = False
          TabOrder = 2
          OnClick = StopButtonClick
          OnMouseMove = StopButtonMouseMove
        end
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 97
        Width = 431
        Height = 153
        Align = alTop
        Caption = 'Userverwaltung'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label26: TLabel
          Left = 16
          Top = 18
          Width = 238
          Height = 16
          Caption = '... zur Benutzung des WebInterface'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 280
          Top = 72
          Width = 75
          Height = 13
          Caption = 'neues Passwort'
        end
        object Label8: TLabel
          Left = 147
          Top = 72
          Width = 68
          Height = 13
          Caption = 'altes Passwort'
        end
        object Label9: TLabel
          Left = 16
          Top = 72
          Width = 48
          Height = 13
          Caption = 'Username'
        end
        object userbox1: TComboBox
          Left = 16
          Top = 48
          Width = 170
          Height = 21
          Hint = 'W'#228'hlen Sie hier den User aus. '
          ItemHeight = 0
          ParentShowHint = False
          ShowHint = True
          Sorted = True
          TabOrder = 0
          Text = '<neuer User>'
          OnChange = userbox1Change
          Items.Strings = (
            '<neuer User>')
        end
        object Button1: TButton
          Left = 200
          Top = 48
          Width = 70
          Height = 21
          Caption = 'speichern'
          TabOrder = 1
          OnClick = Button1Click
        end
        object loeschen: TBitBtn
          Left = 280
          Top = 48
          Width = 70
          Height = 21
          Caption = 'l'#246'schen'
          TabOrder = 2
          OnClick = loeschenClick
        end
        object pw: TEdit
          Left = 280
          Top = 88
          Width = 121
          Height = 21
          Hint = '... das gew'#252'nschte Passwort.'
          ParentShowHint = False
          PasswordChar = '*'
          ShowHint = True
          TabOrder = 5
          Text = 'pw'
          OnMouseMove = pwMouseMove
        end
        object pw2: TEdit
          Left = 280
          Top = 112
          Width = 121
          Height = 21
          Hint = '... das Passwort zu Best'#228'tigung.'
          ParentShowHint = False
          PasswordChar = '*'
          ShowHint = True
          TabOrder = 6
          Text = 'pw2'
          OnMouseMove = pw2MouseMove
        end
        object oldpw: TEdit
          Left = 147
          Top = 88
          Width = 121
          Height = 21
          Hint = '... das alte Passwort ist zum '#196'ndern n'#246'tig.'
          ParentShowHint = False
          PasswordChar = '*'
          ShowHint = True
          TabOrder = 4
          OnMouseMove = oldpwMouseMove
        end
        object username: TEdit
          Left = 16
          Top = 88
          Width = 121
          Height = 21
          TabOrder = 3
          Text = 'username'
          OnMouseMove = usernameMouseMove
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'RSS'
      ImageIndex = 6
      object GroupBox12: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 369
        Align = alTop
        Caption = 'RSS-Feeds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object label_min: TLabel
          Left = 374
          Top = 292
          Width = 16
          Height = 13
          Caption = 'min'
          OnMouseMove = RssUpdateMouseMove
        end
        object Label13: TLabel
          Left = 236
          Top = 293
          Width = 54
          Height = 13
          Caption = 'Update alle'
          OnMouseMove = RssUpdateMouseMove
        end
        object Label14: TLabel
          Left = 16
          Top = 49
          Width = 59
          Height = 13
          Caption = 'Adressliste : '
          OnMouseMove = RssListMouseMove
        end
        object Label49: TLabel
          Left = 22
          Top = 333
          Width = 50
          Height = 13
          Caption = 'zeige max.'
        end
        object Label50: TLabel
          Left = 160
          Top = 333
          Width = 27
          Height = 13
          Caption = 'News'
        end
        object RssUpdate: TSpinEdit
          Left = 296
          Top = 288
          Width = 73
          Height = 22
          MaxValue = 2440
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnMouseMove = RssUpdateMouseMove
        end
        object Button4: TButton
          Left = 116
          Top = 285
          Width = 75
          Height = 25
          Caption = 'l'#246'schen'
          TabOrder = 5
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 32
          Top = 285
          Width = 75
          Height = 25
          Caption = 'hinzuf'#252'gen'
          TabOrder = 4
          OnClick = Button5Click
        end
        object RssList: TValueListEditor
          Left = 16
          Top = 72
          Width = 377
          Height = 209
          Color = cl3DLight
          DisplayOptions = [doColumnTitles]
          KeyOptions = [keyEdit, keyAdd, keyDelete]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goEditing, goTabs, goThumbTracking]
          Strings.Strings = (
            
              'LeastCosterXP=http://rss.groups.yahoo.com/group/leastcosterxp/rs' +
              's'
            '=')
          TabOrder = 1
          TitleCaptions.Strings = (
            'Name'
            'Adresse')
          OnMouseMove = RssListMouseMove
          ColWidths = (
            110
            261)
        end
        object rssdown: TBitBtn
          Left = 397
          Top = 183
          Width = 25
          Height = 37
          Caption = #244
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Math3Mono'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = rssdownClick
        end
        object rssup: TBitBtn
          Left = 396
          Top = 135
          Width = 25
          Height = 37
          Caption = #242
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Math3Mono'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = rssupClick
        end
        object noFeeds: TCheckBox
          Left = 16
          Top = 24
          Width = 145
          Height = 17
          Caption = 'keine RSS-Feeds laden'
          TabOrder = 0
          OnClick = noFeedsClick
        end
        object Rss_oldItems: TCheckBox
          Left = 243
          Top = 331
          Width = 150
          Height = 17
          Caption = 'speichere/ zeige alte News'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object Rss_maxitems: TSpinEdit
          Left = 80
          Top = 328
          Width = 73
          Height = 22
          MaxValue = 100
          MinValue = 5
          TabOrder = 7
          Value = 40
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'PlugIns'
      ImageIndex = 9
      object GroupBox24: TGroupBox
        Left = 0
        Top = 0
        Width = 431
        Height = 329
        Align = alTop
        Caption = 'PlugIns'
        TabOrder = 0
        object Label46: TLabel
          Left = 5
          Top = 192
          Width = 36
          Height = 13
          Caption = 'Status :'
        end
        object Label47: TLabel
          Left = 5
          Top = 24
          Width = 84
          Height = 13
          Caption = 'installierte PlugIns'
        end
        object unregister: TButton
          Left = 232
          Top = 120
          Width = 75
          Height = 25
          Caption = 'deinstallieren'
          TabOrder = 2
          OnClick = unregisterClick
        end
        object register: TButton
          Left = 232
          Top = 88
          Width = 75
          Height = 25
          Caption = 'installieren'
          TabOrder = 1
          OnClick = registerClick
        end
        object readme: TMemo
          Left = 2
          Top = 208
          Width = 427
          Height = 119
          Align = alBottom
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 4
        end
        object PlugBox: TListBox
          Left = 2
          Top = 40
          Width = 225
          Height = 145
          ItemHeight = 13
          Sorted = True
          TabOrder = 0
          OnMouseUp = PlugBoxMouseUp
        end
        object plugSettings: TButton
          Left = 232
          Top = 160
          Width = 75
          Height = 25
          Caption = 'Einstellungen'
          Enabled = False
          TabOrder = 3
          OnClick = plugSettingsClick
        end
        object State: TStaticText
          Left = 48
          Top = 189
          Width = 131
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 5
        end
        object activate: TButton
          Left = 232
          Top = 41
          Width = 75
          Height = 25
          Caption = 'aktivieren'
          TabOrder = 6
          OnClick = activateClick
        end
      end
    end
  end
  object beenden: TBitBtn
    Left = 157
    Top = 540
    Width = 105
    Height = 33
    Caption = '&OK'
    TabOrder = 2
    OnClick = beendenClick
    Kind = bkOK
  end
  object open: TOpenDialog
    Filter = 'exe|*.exe'
    InitialDir = 'c:\programme'
    Options = [ofHideReadOnly, ofEnableSizing, ofForceShowHidden]
    Title = 'Pfad angeben'
    Left = 363
    Top = 544
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [fdForceFontExist]
    Left = 400
    Top = 328
  end
end
