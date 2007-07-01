object TaVerwaltung: TTaVerwaltung
  Left = 168
  Top = 53
  ActiveControl = Tarifbox
  BorderStyle = bsNone
  Caption = 'Tarifmanager'
  ClientHeight = 543
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 743
    Height = 543
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    OnMouseDown = Panel1MouseDown
    OnMouseMove = Panel1MouseMove
    object Caption: TLabel
      Left = 6
      Top = 6
      Width = 727
      Height = 24
      Align = alTop
      Alignment = taCenter
      Caption = 'Tarifmanager'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
      OnMouseDown = Panel1MouseDown
      OnMouseMove = Panel1MouseMove
    end
    object Eingabemode: TPanel
      Left = 6
      Top = 30
      Width = 14
      Height = 503
      Align = alLeft
      BevelKind = bkSoft
      Caption = '>'
      ParentBackground = False
      TabOrder = 0
      OnClick = EingabemodeClick
    end
    object Button1: TButton
      Left = 424
      Top = 474
      Width = 130
      Height = 26
      Caption = '&Tarif hinzuf'#252'gen'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 569
      Top = 474
      Width = 130
      Height = 25
      Caption = '&Felder l'#246'schen'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object Vordergrund: TCheckBox
    Left = 424
    Top = 510
    Width = 137
    Height = 17
    Caption = 'Im Vordergrund halten'
    TabOrder = 1
  end
  object Blacklist: TBitBtn
    Left = 325
    Top = 68
    Width = 76
    Height = 25
    Caption = 'Whitelist'
    TabOrder = 2
    OnClick = BlacklistClick
  end
  object GroupBox2: TGroupBox
    Left = 263
    Top = 457
    Width = 150
    Height = 72
    Caption = 'Alle Tarife l'#246'schen'
    TabOrder = 3
    object DelAll: TBitBtn
      Left = 30
      Top = 27
      Width = 90
      Height = 25
      Caption = 'Alles L'#246'&schen'
      TabOrder = 0
      OnClick = DelAllClick
    end
  end
  object Panel3: TPanel
    Left = 24
    Top = 411
    Width = 390
    Height = 47
    BorderStyle = bsSingle
    TabOrder = 4
    object errormsg: TLabel
      Left = 1
      Top = 1
      Width = 384
      Height = 40
      Align = alClient
      Alignment = taCenter
      Color = clBtnFace
      Constraints.MaxHeight = 40
      Constraints.MaxWidth = 384
      Constraints.MinWidth = 384
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 24
    Top = 457
    Width = 233
    Height = 72
    Caption = 'Import/ Export'
    TabOrder = 5
    object butBatchExport: TBitBtn
      Left = 126
      Top = 27
      Width = 90
      Height = 25
      Caption = '&Export'
      TabOrder = 1
      OnClick = butBatchExportClick
    end
    object ButBatchImport: TBitBtn
      Left = 14
      Top = 27
      Width = 90
      Height = 25
      Caption = '&Import'
      TabOrder = 0
      OnClick = ButBatchImportClick
    end
  end
  object Tarifbox: TComboBox
    Left = 24
    Top = 70
    Width = 297
    Height = 21
    Hint = 
      'W'#228'hlen Sie hier den Tarif, den Sie anzeigen oder bearbeiten m'#246'ch' +
      'ten.'
    Style = csDropDownList
    DropDownCount = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentFont = False
    Sorted = True
    TabOrder = 6
    OnChange = TarifboxCloseUp
    OnCloseUp = TarifboxCloseUp
    OnDropDown = newexpireDropDown
  end
  object Tarifliste: TStringGrid
    Tag = -5
    Left = 27
    Top = 96
    Width = 369
    Height = 313
    Hint = '[Mehrfachauswahl durch Linksklick halten und Maus ziehen.]'
    TabStop = False
    Color = cl3DLight
    ColCount = 17
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goTabs, goThumbTracking]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = TariflisteClick
    OnDblClick = TariflisteDblClick
    OnDrawCell = TariflisteDrawCell
    OnMouseDown = TariflisteMouseDown
    OnMouseUp = TariflisteMouseUp
    ColWidths = (
      128
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
  end
  object BitBtn1: TBitBtn
    Left = 571
    Top = 506
    Width = 130
    Height = 25
    Caption = 'S&chlie'#223'en'
    TabOrder = 8
    Kind = bkClose
  end
  object ButDelExp: TButton
    Left = 156
    Top = 40
    Width = 120
    Height = 25
    Hint = '... l'#246'scht alle abgelaufenen Tarife (unwiderruflich !)'
    Caption = '&abgelaufene l'#246'schen'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = ButDelExpClick
  end
  object Butkopieren: TButton
    Left = 288
    Top = 40
    Width = 120
    Height = 25
    Hint = 
      '... kopiert einen Datensatz in die Eingabefelder zum Hinzuf'#252'gen ' +
      'neuer Daten mit '#228'hnlichen Einstellungen (spart ne Menge Tipparbe' +
      'it)'
    Caption = 'Datensatz &kopieren'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = ButkopierenClick
  end
  object Button4: TButton
    Left = 24
    Top = 40
    Width = 120
    Height = 25
    Hint = '... l'#246'scht die selektierten Eintr'#228'ge.'
    Caption = 'Eintrag &l'#246'schen'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = Button4Click
  end
  object tarifliste_size: TPanel
    Left = 397
    Top = 96
    Width = 15
    Height = 313
    Hint = 'Tabellengr'#246#223'e '#228'ndern'
    Caption = '>'
    ParentBackground = False
    TabOrder = 12
    OnClick = tarifliste_sizeClick
  end
  object PBar: TProgressBar
    Left = 136
    Top = 240
    Width = 137
    Height = 17
    TabOrder = 13
    Visible = False
  end
  object PageControl1: TPageControl
    Left = 416
    Top = 40
    Width = 297
    Height = 437
    ActivePage = SheetPreise
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 14
    OnChange = PageControl1Change
    object TabSheet2: TTabSheet
      Caption = 'Tarifdaten'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 289
        Height = 382
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 13
          Width = 39
          Height = 13
          Caption = 'Provider'
        end
        object Label2: TLabel
          Left = 9
          Top = 51
          Width = 54
          Height = 13
          Caption = 'Rufnummer'
        end
        object Label9: TLabel
          Left = 8
          Top = 92
          Width = 22
          Height = 13
          Caption = 'Takt'
        end
        object Label5: TLabel
          Left = 8
          Top = 130
          Width = 48
          Height = 13
          Caption = 'Username'
        end
        object Label6: TLabel
          Left = 148
          Top = 130
          Width = 43
          Height = 13
          Caption = 'Passwort'
        end
        object Label7: TLabel
          Left = 8
          Top = 174
          Width = 107
          Height = 13
          Caption = 'Webseite (inkl. http://)'
        end
        object Label13: TLabel
          Left = 8
          Top = 220
          Width = 64
          Height = 13
          Caption = 'beginnt am ...'
        end
        object Label10: TLabel
          Left = 144
          Top = 220
          Width = 60
          Height = 13
          Caption = 'verf'#228'llt am ...'
        end
        object Label27: TLabel
          Left = 70
          Top = 109
          Width = 5
          Height = 13
          Caption = '/'
        end
        object Label3: TLabel
          Left = 148
          Top = 13
          Width = 21
          Height = 13
          Caption = 'Tarif'
        end
        object Label4: TLabel
          Left = 150
          Top = 51
          Width = 19
          Height = 13
          Caption = 'Tag'
        end
        object TaNumber: TEdit
          Left = 9
          Top = 66
          Width = 130
          Height = 21
          TabOrder = 2
          OnKeyPress = TaNumberKeyPress
        end
        object TaProvider: TEdit
          Left = 8
          Top = 27
          Width = 130
          Height = 21
          TabOrder = 0
          OnChange = TaProviderChange
        end
        object TaTaktbox: TComboBox
          Left = 148
          Top = 104
          Width = 130
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          ItemIndex = 0
          TabOrder = 5
          Text = 'Minutentakt'
          OnChange = TaTaktboxChange
          Items.Strings = (
            'Minutentakt'
            'Sekundentakt')
        end
        object TaTakt_a: TEdit
          Left = 8
          Top = 104
          Width = 57
          Height = 21
          TabOrder = 3
          Text = '60'
          OnKeyPress = OnlyInt
        end
        object TaUser: TEdit
          Left = 8
          Top = 146
          Width = 130
          Height = 21
          TabOrder = 6
        end
        object TaPass: TMaskEdit
          Left = 148
          Top = 146
          Width = 130
          Height = 21
          TabOrder = 7
        end
        object TaWebsite: TEdit
          Left = 8
          Top = 190
          Width = 273
          Height = 21
          TabOrder = 8
          Text = 'http://'
        end
        object TaStarts: TDateTimePicker
          Left = 8
          Top = 235
          Width = 121
          Height = 22
          Hint = 
            '... der erste Tag der G'#252'ltigkeit bzw. Tag der letzten Verl'#228'ngeru' +
            'ng.'
          Date = 38708.000000000000000000
          Time = 38708.000000000000000000
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnDropDown = newexpireDropDown
        end
        object Taexpires: TDateTimePicker
          Left = 144
          Top = 234
          Width = 121
          Height = 22
          Hint = '... der letzte Tag der G'#252'ltigkeit.'
          Date = 38708.000000000000000000
          Time = 38708.000000000000000000
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          OnDropDown = newexpireDropDown
        end
        object Tadelend: TCheckBox
          Left = 144
          Top = 256
          Width = 121
          Height = 17
          Caption = 'l'#246'schen bei Ablauf'
          TabOrder = 11
        end
        object TaTakt_b: TEdit
          Left = 80
          Top = 104
          Width = 57
          Height = 21
          TabOrder = 4
          Text = '60'
          OnKeyPress = OnlyInt
        end
        object BitBtn2: TBitBtn
          Left = 16
          Top = 344
          Width = 105
          Height = 25
          Caption = 'Zur DB hinzuf'#252'gen'
          TabOrder = 12
          OnClick = BitBtn2Click
        end
        object TaName: TEdit
          Left = 148
          Top = 26
          Width = 130
          Height = 21
          TabOrder = 1
          OnChange = TaProviderChange
        end
        object TaTag: TComboBox
          Left = 148
          Top = 64
          Width = 130
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 13
          Items.Strings = (
            'Mo-Fr'
            'Sa+So+Feiertag'
            'Sa'
            'So/Feiertag'
            'ganze Woche')
        end
        object BitBtn3: TBitBtn
          Left = 152
          Top = 344
          Width = 105
          Height = 25
          Caption = 'in der DB l'#246'schen'
          TabOrder = 14
          OnClick = BitBtn3Click
        end
      end
    end
    object SheetPreise: TTabSheet
      Caption = 'Zeiten und Preise'
      ImageIndex = 2
      object Label8: TLabel
        Left = 16
        Top = 8
        Width = 33
        Height = 13
        Caption = 'Beginn'
      end
      object Label11: TLabel
        Left = 53
        Top = 8
        Width = 25
        Height = 13
        Caption = 'Ende'
      end
      object Label28: TLabel
        Left = 80
        Top = 8
        Width = 23
        Height = 13
        Caption = 'Preis'
      end
      object Label29: TLabel
        Left = 106
        Top = 8
        Width = 37
        Height = 13
        Caption = 'Einwahl'
      end
      object Label30: TLabel
        Left = 149
        Top = 8
        Width = 33
        Height = 13
        Caption = 'Beginn'
      end
      object Label31: TLabel
        Left = 185
        Top = 8
        Width = 25
        Height = 13
        Caption = 'Ende'
      end
      object Label32: TLabel
        Left = 213
        Top = 8
        Width = 23
        Height = 13
        Caption = 'Preis'
      end
      object Label33: TLabel
        Left = 241
        Top = 8
        Width = 37
        Height = 13
        Caption = 'Einwahl'
      end
      object TaMindestumsatz: TLabeledEdit
        Left = 21
        Top = 277
        Width = 130
        Height = 21
        EditLabel.Width = 105
        EditLabel.Height = 13
        EditLabel.Caption = 'Mindestumsatz in cent'
        LabelSpacing = 1
        TabOrder = 0
        OnKeyPress = TaMindestumsatzKeyPress
      end
    end
    object SheetKontis: TTabSheet
      Caption = 'Freikontingente und Datenvolumen'
      ImageIndex = 1
      object Konti_tarif: TStaticText
        Left = 0
        Top = 0
        Width = 289
        Height = 17
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        BiDiMode = bdLeftToRight
        BorderStyle = sbsSunken
        Color = clBtnFace
        Constraints.MaxHeight = 17
        Constraints.MinHeight = 17
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
      object Freikontingente: TGroupBox
        Left = 0
        Top = 18
        Width = 289
        Height = 191
        Align = alTop
        Caption = 'Freikontingente'
        TabOrder = 1
        object konti_up: TLabel
          Left = 107
          Top = 95
          Width = 3
          Height = 13
        end
        object konti_down: TLabel
          Left = 104
          Top = 108
          Width = 3
          Height = 13
        end
        object Label24: TLabel
          Left = 15
          Top = 124
          Width = 107
          Height = 26
          Caption = 'gilt ab dem x. Tag des Monats'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label25: TLabel
          Left = 193
          Top = 43
          Width = 8
          Height = 13
          Caption = 'h'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label26: TLabel
          Left = 230
          Top = 72
          Width = 19
          Height = 13
          Caption = 'MB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object nextreset: TLabel
          Left = 15
          Top = 163
          Width = 43
          Height = 13
          Caption = 'nextreset'
        end
        object Label22: TLabel
          Left = 265
          Top = 43
          Width = 10
          Height = 13
          Caption = 'm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Konti_upvol: TSpinEdit
          Left = 142
          Top = 67
          Width = 81
          Height = 22
          Hint = 'Angabe in [MB]'
          Increment = 1000
          MaxValue = 1048576
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 0
        end
        object konti_change: TButton
          Left = 181
          Top = 157
          Width = 91
          Height = 25
          Caption = 'speichern'
          TabOrder = 8
          OnClick = konti_changeClick
        end
        object konti_tag: TSpinEdit
          Left = 142
          Top = 125
          Width = 81
          Height = 22
          Hint = 'Der Z'#228'hler wird immer am angegebenen Tag im Monat zur'#252'ckgesetzt.'
          MaxValue = 31
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Value = 1
        end
        object Panel2: TPanel
          Left = 134
          Top = 91
          Width = 145
          Height = 34
          BevelOuter = bvNone
          TabOrder = 6
          object konti_voltype_both: TRadioButton
            Left = 8
            Top = -1
            Width = 130
            Height = 20
            Caption = 'Up - und  Downstream'
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object konti_voltype_down: TRadioButton
            Left = 8
            Top = 15
            Width = 113
            Height = 20
            Caption = 'nur Downstream'
            TabOrder = 1
          end
        end
        object konti_zeit: TSpinEdit
          Left = 142
          Top = 38
          Width = 51
          Height = 22
          Hint = 'Angabe in [Stunden]'
          Increment = 10
          MaxValue = 5000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 0
        end
        object radio_zeit: TRadioButton
          Left = 8
          Top = 42
          Width = 113
          Height = 17
          Caption = 'Zeitkontingent'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = radio_zeitClick
        end
        object Radio_Vol: TRadioButton
          Left = 8
          Top = 70
          Width = 128
          Height = 16
          Caption = 'Volumenkontingent'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = radio_zeitClick
        end
        object radio_NO: TRadioButton
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = 'kein Kontingent'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = radio_zeitClick
        end
        object konti_min: TSpinEdit
          Left = 206
          Top = 37
          Width = 51
          Height = 22
          Hint = 'Angabe in [Minuten]'
          Increment = 10
          MaxValue = 59
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 0
        end
      end
      object Verbrauch: TGroupBox
        Left = 0
        Top = 209
        Width = 289
        Height = 170
        Align = alTop
        Caption = 'Verbrauch'
        TabOrder = 2
        object Label15: TLabel
          Left = 86
          Top = 56
          Width = 150
          Height = 13
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Constraints.MaxWidth = 150
          Constraints.MinWidth = 150
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 86
          Top = 94
          Width = 150
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Constraints.MaxWidth = 150
          Constraints.MinWidth = 150
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 86
          Top = 114
          Width = 150
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Constraints.MaxWidth = 150
          Constraints.MinWidth = 150
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label18: TLabel
          Left = 15
          Top = 94
          Width = 68
          Height = 13
          Caption = 'Empfangen '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label19: TLabel
          Left = 15
          Top = 114
          Width = 55
          Height = 13
          Caption = 'Gesendet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label20: TLabel
          Left = 15
          Top = 56
          Width = 27
          Height = 13
          Hint = '... ohne Ber'#252'cksichtigung der Taktung.'
          Align = alCustom
          Caption = 'Zeit '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label21: TLabel
          Left = 15
          Top = 26
          Width = 65
          Height = 13
          Caption = 'Z'#228'hler seit '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 16
          Top = 75
          Width = 63
          Height = 13
          Hint = '... in diesem Wert ist die Taktung ber'#252'cksichtigt'
          Caption = 'Verbrauch '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object Label23: TLabel
          Left = 86
          Top = 75
          Width = 150
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Constraints.MaxWidth = 150
          Constraints.MinWidth = 150
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object konti_zaehler: TEdit
          Left = 85
          Top = 23
          Width = 153
          Height = 21
          TabStop = False
          BevelKind = bkFlat
          BiDiMode = bdLeftToRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object reset: TButton
          Left = 181
          Top = 139
          Width = 91
          Height = 25
          Hint = 'Setzt den Z'#228'hler zur'#252'ck.'
          Caption = 'Reset'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = resetClick
        end
        object RadioButton1: TRadioButton
          Left = 51
          Top = 144
          Width = 41
          Height = 17
          Hint = 'Werte in Megabyte'
          Caption = 'MB'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          TabStop = True
          OnClick = RadioButton3Click
        end
        object RadioButton2: TRadioButton
          Left = 94
          Top = 144
          Width = 41
          Height = 17
          Hint = 'Werte in Gigabyte'
          Caption = 'GB'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = RadioButton3Click
        end
        object RadioButton3: TRadioButton
          Left = 8
          Top = 144
          Width = 41
          Height = 17
          Hint = 'Werte in Kilobyte'
          Caption = 'kB'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = RadioButton3Click
        end
      end
      object Freikontis_online: TGroupBox
        Left = 0
        Top = 17
        Width = 289
        Height = 1
        Align = alTop
        Caption = 'Freikontingente'
        TabOrder = 3
        Visible = False
        object Label14: TLabel
          Left = 2
          Top = 15
          Width = 250
          Height = 26
          Align = alClient
          Alignment = taCenter
          Caption = 'W'#228'hrend Sie online sind, k'#246'nnen Sie keine Kontingente verwalten.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
      end
    end
  end
  object blinker: TTimer
    Enabled = False
    Interval = 300
    OnTimer = blinkerTimer
    Left = 56
    Top = 360
  end
  object Icons: TImageList
    Left = 256
    Top = 168
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object applicationevents1: TApplicationEvents
    OnDeactivate = applicationevents1Deactivate
    Left = 664
    Top = 24
  end
end
