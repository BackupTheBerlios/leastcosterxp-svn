object TaVerwaltung: TTaVerwaltung
  Left = 168
  Top = 53
  ActiveControl = Tarifbox
  BorderStyle = bsNone
  Caption = 'Tarifmanager'
  ClientHeight = 543
  ClientWidth = 737
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
  DesignSize = (
    737
    543)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 737
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
      Width = 721
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
  end
  object Vordergrund: TCheckBox
    Left = 424
    Top = 505
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
  object PageControl1: TPageControl
    Left = 416
    Top = 39
    Width = 297
    Height = 461
    ActivePage = TabSheet1
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 6
    OnChange = PageControl1Change
    object TabSheet2: TTabSheet
      Caption = 'Tarifdaten'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 289
        Height = 430
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 20
          Width = 21
          Height = 13
          Caption = 'Tarif'
        end
        object Label2: TLabel
          Left = 148
          Top = 19
          Width = 54
          Height = 13
          Caption = 'Rufnummer'
        end
        object Label3: TLabel
          Left = 8
          Top = 61
          Width = 33
          Height = 13
          Caption = 'Beginn'
        end
        object Label4: TLabel
          Left = 148
          Top = 61
          Width = 25
          Height = 13
          Caption = 'Ende'
        end
        object Label11: TLabel
          Left = 148
          Top = 119
          Width = 105
          Height = 13
          Caption = 'Einwahlgeb'#252'hr in cent'
        end
        object Label8: TLabel
          Left = 8
          Top = 119
          Width = 58
          Height = 13
          Caption = 'Preis in cent'
        end
        object Label9: TLabel
          Left = 8
          Top = 162
          Width = 22
          Height = 13
          Caption = 'Takt'
        end
        object Label5: TLabel
          Left = 8
          Top = 198
          Width = 48
          Height = 13
          Caption = 'Username'
        end
        object Label6: TLabel
          Left = 148
          Top = 198
          Width = 43
          Height = 13
          Caption = 'Passwort'
        end
        object Label7: TLabel
          Left = 8
          Top = 246
          Width = 107
          Height = 13
          Caption = 'Webseite (inkl. http://)'
        end
        object Label13: TLabel
          Left = 8
          Top = 340
          Width = 64
          Height = 13
          Caption = 'beginnt am ...'
        end
        object Label10: TLabel
          Left = 144
          Top = 340
          Width = 60
          Height = 13
          Caption = 'verf'#228'llt am ...'
        end
        object TaNumber: TEdit
          Left = 148
          Top = 34
          Width = 130
          Height = 21
          TabOrder = 1
          OnKeyPress = TaNumberKeyPress
        end
        object TaName: TEdit
          Left = 8
          Top = 34
          Width = 130
          Height = 21
          TabOrder = 0
          OnChange = TaNameChange
        end
        object TaStart: TDateTimePicker
          Left = 8
          Top = 77
          Width = 130
          Height = 21
          Date = 38713.000000000000000000
          Time = 38713.000000000000000000
          Kind = dtkTime
          TabOrder = 2
        end
        object ganztags: TCheckBox
          Left = 8
          Top = 98
          Width = 73
          Height = 17
          Caption = 'ganztags'
          TabOrder = 4
          OnClick = ganztagsClick
        end
        object TaEnd: TDateTimePicker
          Left = 148
          Top = 77
          Width = 130
          Height = 21
          Date = 38713.041666666660000000
          Time = 38713.041666666660000000
          Kind = dtkTime
          TabOrder = 3
        end
        object TaPrice: TEdit
          Left = 8
          Top = 133
          Width = 130
          Height = 21
          TabOrder = 5
          Text = '0,00'
          OnKeyPress = TaPriceKeyPress
        end
        object TaEinwahl: TEdit
          Left = 148
          Top = 133
          Width = 130
          Height = 21
          TabOrder = 6
          Text = '0,00'
          OnKeyPress = TaPriceKeyPress
        end
        object TaTaktbox: TComboBox
          Left = 148
          Top = 174
          Width = 130
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          ItemIndex = 0
          TabOrder = 8
          Text = 'Minutentakt'
          OnChange = TaTaktboxChange
          Items.Strings = (
            'Minutentakt'
            'Sekundentakt')
        end
        object TaTakt: TEdit
          Left = 8
          Top = 174
          Width = 130
          Height = 21
          TabOrder = 7
          Text = '60/60'
          OnKeyPress = TaTaktKeyPress
        end
        object TaUser: TEdit
          Left = 8
          Top = 214
          Width = 130
          Height = 21
          TabOrder = 9
        end
        object TaPass: TMaskEdit
          Left = 148
          Top = 214
          Width = 130
          Height = 21
          TabOrder = 10
        end
        object TaWebsite: TEdit
          Left = 8
          Top = 262
          Width = 273
          Height = 21
          TabOrder = 11
          Text = 'http://'
        end
        object CheckBox1: TCheckBox
          Left = 8
          Top = 296
          Width = 39
          Height = 18
          Caption = 'Mo'
          TabOrder = 12
        end
        object CheckBox2: TCheckBox
          Left = 48
          Top = 296
          Width = 35
          Height = 18
          Caption = 'Di'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object CheckBox3: TCheckBox
          Left = 87
          Top = 296
          Width = 37
          Height = 18
          Caption = 'Mi'
          TabOrder = 14
        end
        object CheckBox4: TCheckBox
          Left = 127
          Top = 296
          Width = 38
          Height = 18
          Caption = 'Do'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object CheckBox5: TCheckBox
          Left = 168
          Top = 296
          Width = 35
          Height = 18
          Caption = 'Fr'
          TabOrder = 16
        end
        object CheckBox6: TCheckBox
          Left = 208
          Top = 296
          Width = 37
          Height = 18
          Caption = 'Sa'
          TabOrder = 17
        end
        object CheckBox7: TCheckBox
          Left = 248
          Top = 296
          Width = 34
          Height = 18
          Caption = 'So'
          TabOrder = 18
        end
        object CheckBox10: TCheckBox
          Left = 210
          Top = 318
          Width = 62
          Height = 18
          Caption = 'feiertags'
          TabOrder = 21
        end
        object CheckBox9: TCheckBox
          Left = 101
          Top = 318
          Width = 89
          Height = 18
          Caption = 'Wochenende'
          TabOrder = 20
          OnClick = CheckBox9Click
        end
        object CheckBox8: TCheckBox
          Left = 8
          Top = 318
          Width = 89
          Height = 18
          Caption = 'wochentags'
          TabOrder = 19
          OnClick = CheckBox8Click
        end
        object TaStarts: TDateTimePicker
          Left = 8
          Top = 355
          Width = 121
          Height = 22
          Hint = 
            '... der erste Tag der G'#252'ltigkeit bzw. Tag der letzten Verl'#228'ngeru' +
            'ng.'
          Date = 38708.000000000000000000
          Time = 38708.000000000000000000
          ParentShowHint = False
          ShowHint = True
          TabOrder = 22
          OnDropDown = newexpireDropDown
        end
        object Taexpires: TDateTimePicker
          Left = 144
          Top = 354
          Width = 121
          Height = 22
          Hint = '... der letzte Tag der G'#252'ltigkeit.'
          Date = 38708.000000000000000000
          Time = 38708.000000000000000000
          ParentShowHint = False
          ShowHint = True
          TabOrder = 23
          OnDropDown = newexpireDropDown
        end
        object Button2: TButton
          Left = 145
          Top = 399
          Width = 130
          Height = 26
          Caption = '&Felder l'#246'schen'
          TabOrder = 25
          OnClick = Button2Click
        end
        object Button1: TButton
          Left = 8
          Top = 399
          Width = 130
          Height = 26
          Caption = '&Tarif hinzuf'#252'gen'
          TabOrder = 24
          OnClick = Button1Click
        end
        object Tadelend: TCheckBox
          Left = 144
          Top = 376
          Width = 121
          Height = 17
          Caption = 'l'#246'schen bei Ablauf'
          TabOrder = 26
        end
      end
    end
    object TabSheet1: TTabSheet
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
        Height = 226
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
        object konti_hinweis: TLabel
          Left = 2
          Top = 183
          Width = 285
          Height = 41
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 
            'Achtung: Kontingentfunktionen sind nicht ausreichend getestet. B' +
            'itte teilen Sie mir Ihre Erfahrung mit (leastcosterxp-owner@yaho' +
            'ogroups.de).'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
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
        Top = 244
        Width = 289
        Height = 179
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
          Width = 285
          Height = 213
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
    TabOrder = 7
    OnChange = TarifboxCloseUp
    OnCloseUp = TarifboxCloseUp
    OnDropDown = newexpireDropDown
  end
  object Tarifliste: TStringGrid
    Tag = -5
    Left = 24
    Top = 96
    Width = 369
    Height = 313
    Hint = '[Mehrfachauswahl durch Linksklick halten und Maus ziehen.]'
    TabStop = False
    Color = cl3DLight
    ColCount = 15
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goTabs, goThumbTracking]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
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
      64)
  end
  object BitBtn1: TBitBtn
    Left = 565
    Top = 501
    Width = 130
    Height = 25
    Caption = 'S&chlie'#223'en'
    TabOrder = 9
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
    TabOrder = 10
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
    TabOrder = 11
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
    TabOrder = 12
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 576
    Top = 504
    Width = 113
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 13
    Visible = False
  end
  object tarifliste_size: TPanel
    Left = 397
    Top = 96
    Width = 15
    Height = 313
    Hint = 'Tabellengr'#246#223'e '#228'ndern'
    Caption = '>'
    ParentBackground = False
    TabOrder = 14
    OnClick = tarifliste_sizeClick
  end
  object PBar: TProgressBar
    Left = 136
    Top = 240
    Width = 150
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 15
    Visible = False
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
  object ApplicationEvents1: TApplicationEvents
    OnDeactivate = ApplicationEvents1Deactivate
    Left = 664
    Top = 24
  end
end
