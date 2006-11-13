object Hauptfenster: THauptfenster
  Left = 332
  Top = 94
  Width = 433
  Height = 575
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = DialBtn
  AlphaBlend = True
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'LeastCosterXP'
  Color = clBtnFace
  Constraints.MaxHeight = 575
  Constraints.MinHeight = 575
  Constraints.MinWidth = 433
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    000B3B3B3B33330000BB3B3000000000B3B3B3B3333333030BB3303300000003
    3330000000000030BB0B3B3330000003333B8B8383333033BBBB333330000000
    3333333333330B3B3BB33B3B3B0000000B3B3B3333330B3B33B3BBB3330000B3
    B3B3B3B333330B3B333BBB333B0003333000000000000B3B33BBBBB3B3000300
    000B3B3B33330B3B333BB0B33B000030B3B3B3B3B3330B3B333BBBB3B3000303
    3333333333330B33333BBB3B3B000003000B888383830BB33333333BB0000000
    33330000000000B33B3333BB300000033000B3B3B3B3B0BB33330BBB00000000
    0B3B3B3B3B3B3B0BB33B3BB00000000033333333333333300B33330000000000
    3000BBB838383830003000000000000003333380000000000000000000000000
    3338000B3B3B3B3B3B000000000000000330B3B3B3B3B3B3B3B3300000000000
    0003333FFFFFF33333333300000000000003088BBBB3B3B3B300030000000000
    000033333BBBBB3B3B33300000000000000333B3B3BBBBB3B3B3330000000000
    0000333B3BBBBBBB333330000000000000000003B3B3BFFFFB00000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFE003C1FF000000FE0000007C0000003C0000003C0000001C00000018000
    00010000000100000001000000010000000180000003C0000003C0000007E000
    000FE000001FE00000FFE00000FFE000007FF000003FF800001FFC00001FFC00
    001FFC00001FFE00003FFF00007FFFE003FFFFFFFFFFFFFFFFFFFFFFFFFF}
  Menu = Menu
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poDesktopCenter
  ScreenSnap = True
  ShowHint = True
  SnapBuffer = 20
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnResize = FormResize
  OnShortCut = FormShortCut
  OnShow = FormShow
  DesignSize = (
    425
    521)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 13
    Top = 291
    Width = 401
    Height = 60
    Anchors = [akLeft, akTop, akRight]
  end
  object LEDTime: TAMAdvLed
    Left = 379
    Top = 484
    Width = 13
    Height = 13
    Hint = 'Noch kein Atomzeit-Update seit dem Start.'
    ColorOff = clMaroon
    ColorOn = clYellow
    OnMouseDown = LedRSSMouseDown
    OnMouseUp = LedRSSMouseUp
  end
  object LedRSS: TAMAdvLed
    Left = 398
    Top = 484
    Width = 17
    Height = 17
    Hint = 'Noch kein Rss-Feed Update seit dem Start.'
    ColorOff = clMaroon
    ColorOn = clYellow
    OnMouseDown = LedRSSMouseDown
    OnMouseUp = LedRSSMouseUp
  end
  object Label3: TLabel
    Left = 213
    Top = 325
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object OCostLabel: TLabel
    Left = 130
    Top = 317
    Width = 79
    Height = 24
    Caption = '0.0000 '#8364
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    OnMouseEnter = OCostLabelMouseEnter
  end
  object ozeit: TLabel
    Left = 29
    Top = 317
    Width = 79
    Height = 24
    Caption = '00:00:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object StatLED2: TAMAdvLed
    Left = 313
    Top = 324
    Width = 15
    Height = 13
    ColorOff = clGray
    LedType = ltRectangleVrt
    OnClick = StatLED1Click
    OnMouseDown = LedRSSMouseDown
    OnMouseUp = LedRSSMouseUp
  end
  object online: TLabel
    Left = 329
    Top = 319
    Width = 67
    Height = 24
    Anchors = [akTop, akRight]
    Caption = 'Offline'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
    OnMouseMove = onlineMouseMove
  end
  object PanelBevel: TBevel
    Left = 25
    Top = 344
    Width = 371
    Height = 60
    Anchors = [akLeft, akTop, akRight]
    Shape = bsFrame
  end
  object StatLED1: TAMAdvLed
    Left = 303
    Top = 324
    Width = 13
    Height = 13
    ColorOff = clGray
    LedType = ltRectangleVrt
    OnClick = StatLED1Click
    OnMouseDown = LedRSSMouseDown
    OnMouseUp = LedRSSMouseUp
  end
  object Liste: TStringGrid
    Tag = -1
    Left = 10
    Top = 56
    Width = 405
    Height = 209
    Hint = '[Enter] oder [W'#228'hlen] w'#228'hlt den selektierten Tarif an.'
    Anchors = [akLeft, akTop, akRight]
    Color = cl3DLight
    ColCount = 18
    DefaultRowHeight = 16
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedHorzLine, goVertLine, goColSizing, goTabs, goThumbTracking]
    ParentFont = False
    TabOrder = 0
    OnClick = ListeClick
    OnDblClick = ListeDblClick
    OnDrawCell = ListeDrawCell
    OnKeyPress = ListeKeyPress
    OnKeyUp = ListeKeyUp
    OnMouseDown = ListeMouseDown
    OnMouseUp = ListeMouseUp
    OnMouseWheelDown = ListeMouseWheelDown
    OnMouseWheelUp = ListeMouseWheelDown
    OnSelectCell = ListeSelectCell
    ColWidths = (
      59
      50
      41
      47
      47
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
    RowHeights = (
      16
      16)
  end
  object Status: TStatusBar
    Left = 0
    Top = 502
    Width = 425
    Height = 19
    Panels = <>
    ParentShowHint = False
    ShowHint = False
    SimplePanel = True
    SizeGrip = False
  end
  object DialBtn: TBitBtn
    Left = 14
    Top = 431
    Width = 123
    Height = 25
    Caption = '&W'#228'hlen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = DialBtnClick
    Kind = bkOK
  end
  object Aktualisieren: TBitBtn
    Left = 152
    Top = 431
    Width = 123
    Height = 25
    Caption = '&Aktualisieren'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = AktualisierenClick
    Kind = bkRetry
  end
  object costs: TEdit
    Left = 27
    Top = 319
    Width = 155
    Height = 21
    TabStop = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  object DialStatus: TEdit
    Left = 16
    Top = 458
    Width = 398
    Height = 21
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 10
  end
  object surfdauer: TTrackBar
    Left = 20
    Top = 388
    Width = 385
    Height = 33
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = True
    Max = 720
    Min = 1
    ParentCtl3D = False
    Frequency = 20
    Position = 15
    TabOrder = 5
    TabStop = False
    ThumbLength = 18
    OnChange = surfdauerChange
  end
  object Oleco: TBitBtn
    Left = 291
    Top = 431
    Width = 123
    Height = 25
    Cancel = True
    Caption = '&Net::LCR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 9
    Visible = False
    OnClick = OlecoClick
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF7777777FFFFFFFF0000FFFF
      7FFFFFFF77FFFFFF0000FF7FFF0000010F7777770000FFF0002626C000111077
      0000FF0F02C2C2022011107700000FFF0EEEE0220199910700000FFF0EEEEE02
      01F9910F00000F7F2EE00222249910FF00000F007E60200EE0000F0F0000F044
      2777A00EE20FFFFF0000044C022AA200E60FFFF7000004CCC22A2A2260FFFF7F
      000004CC4402222007777F0F0000F044400FFFFFFFFFF0FF0000FF000FF00FFF
      FFF00FFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
      FFFFFFFFFFFFFFFF0000}
  end
  object edTarif: TEdit
    Left = 27
    Top = 294
    Width = 242
    Height = 21
    TabStop = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object edtime: TEdit
    Left = 274
    Top = 294
    Width = 121
    Height = 21
    TabStop = False
    Anchors = [akTop, akRight]
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object EdNumber: TEdit
    Left = 27
    Top = 345
    Width = 155
    Height = 21
    TabStop = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object smurf: TBitBtn
    Left = 291
    Top = 431
    Width = 123
    Height = 25
    Cancel = True
    Caption = '&SmartSurfer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Visible = False
    OnClick = OlecoClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      777777777777777777777777777777777777777777BBBB777777777BBBBBBBBB
      B77703BBBBBBBBBB3007700001300030BBB7BBB30B0B1BB0BBB7BBBB0B0B0B30
      BBB7BBBB0B0B0B30BBB7BBB33BBB3B33BBB77BB0333000003BB77BBBBB303333
      BB7777BBBBB0BBBBB77777777BBBBB7777777777777777777777}
  end
  object clock: TStaticText
    Left = 240
    Top = 37
    Width = 175
    Height = 17
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    Visible = False
  end
  object DateLabel: TStaticText
    Left = 14
    Top = 39
    Width = 4
    Height = 4
    Hint = 'Zeitpunkt der G'#252'ltigkeit der Tariftabelle'
    Constraints.MaxHeight = 17
    Constraints.MaxWidth = 222
    Constraints.MinHeight = 4
    Constraints.MinWidth = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
  end
  object beliebig_date: TDateTimePicker
    Left = 13
    Top = 267
    Width = 89
    Height = 21
    Date = 38727.920872025460000000
    Time = 38727.920872025460000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    Visible = False
    OnChange = beliebig_timeChange
  end
  object beliebig_time: TDateTimePicker
    Left = 107
    Top = 267
    Width = 89
    Height = 21
    Date = 38727.920872025460000000
    Time = 38727.920872025460000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Kind = dtkTime
    ParentFont = False
    TabOrder = 15
    Visible = False
    OnChange = beliebig_timeChange
  end
  object Takt2: TProgressBar
    Left = 11
    Top = 278
    Width = 275
    Height = 10
    Hint = 'Takt ( Kanal 2 )'
    ParentShowHint = False
    Smooth = True
    Step = 1
    ShowHint = True
    TabOrder = 16
    Visible = False
  end
  object Takt1: TProgressBar
    Left = 11
    Top = 267
    Width = 275
    Height = 10
    Hint = 'Takt ( Kanal 1 )'
    ParentShowHint = False
    Smooth = True
    Step = 1
    ShowHint = True
    TabOrder = 17
    Visible = False
  end
  object beliebig_check: TCheckBox
    Left = 296
    Top = 270
    Width = 116
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'zeige beliebige Zeit'
    TabOrder = 18
    OnClick = beliebig_check1Click
  end
  object AutoTrennen: TPageControl
    Left = 28
    Top = 345
    Width = 365
    Height = 57
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight]
    Style = tsFlatButtons
    TabOrder = 19
    object TabSheet1: TTabSheet
      Caption = 'Auto-Trennen'
      object Label1: TLabel
        Left = 46
        Top = 5
        Width = 14
        Height = 13
        Caption = 'um'
      end
      object AutoDiscLED: TAMAdvLed
        Left = 14
        Top = 6
        Width = 13
        Height = 13
        ColorOff = clMaroon
        OnLedStateChanged = AutoDialLEDLedStateChanged
        OnMouseDown = LedRSSMouseDown
        OnMouseUp = AutoDialLEDMouseUp
      end
      object Label6: TLabel
        Left = 158
        Top = 5
        Width = 36
        Height = 13
        Caption = 'trennen'
        Visible = False
      end
      object trennticker: TDateTimePicker
        Left = 72
        Top = 1
        Width = 78
        Height = 21
        Date = 38664.316839363420000000
        Time = 38664.316839363420000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Kind = dtkTime
        ParentFont = False
        TabOrder = 0
        OnChange = trenntickerChange
      end
      object trennask: TCheckBox
        Left = 209
        Top = 0
        Width = 97
        Height = 14
        Caption = 'mit Nachfrage'
        TabOrder = 1
      end
      object NoChangeWarning: TCheckBox
        Left = 209
        Top = 12
        Width = 137
        Height = 14
        Caption = 'keine Wechselmeldung'
        TabOrder = 2
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Auto-Verbinden'
      ImageIndex = 3
      object AutoDialLED: TAMAdvLed
        Left = 14
        Top = 6
        Width = 13
        Height = 13
        ColorOff = clMaroon
        OnLedStateChanged = AutoDialLEDLedStateChanged
        OnMouseDown = LedRSSMouseDown
        OnMouseUp = AutoDialLEDMouseUp
      end
      object Autobasis: TLabel
        Left = 296
        Top = 6
        Width = 65
        Height = 13
        AutoSize = False
      end
      object AutoDialEinwahl: TCheckBox
        Left = 37
        Top = 5
        Width = 124
        Height = 17
        Caption = 'mit Einwahlgeb'#252'hren'
        TabOrder = 0
      end
      object AutoBase: TTrackBar
        Left = 160
        Top = 5
        Width = 134
        Height = 19
        Ctl3D = True
        Max = 720
        Min = 1
        ParentCtl3D = False
        Frequency = 20
        Position = 15
        TabOrder = 1
        ThumbLength = 9
        OnChange = AutoBaseChange
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Leerlaufschutz'
      ImageIndex = 1
      object Label4: TLabel
        Left = 41
        Top = 6
        Width = 24
        Height = 13
        Caption = 'nach'
      end
      object Label5: TLabel
        Left = 129
        Top = 7
        Width = 96
        Height = 13
        Caption = 'min Leerlauf trennen'
      end
      object AutoLeerlaufLed: TAMAdvLed
        Left = 14
        Top = 6
        Width = 13
        Height = 13
        ColorOff = clMaroon
        OnLedStateChanged = AutoDialLEDLedStateChanged
        OnMouseDown = LedRSSMouseDown
        OnMouseUp = AutoDialLEDMouseUp
      end
      object Leertime: TSpinEdit
        Left = 69
        Top = 2
        Width = 56
        Height = 22
        MaxValue = 720
        MinValue = 1
        TabOrder = 0
        Value = 5
        OnChange = LeertimeChange
      end
      object leerlaufboxask: TCheckBox
        Left = 251
        Top = 6
        Width = 95
        Height = 17
        Caption = 'mit Nachfrage'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Auto-Aus'
      ImageIndex = 2
      object Autoaus: TComboBox
        Left = 96
        Top = 4
        Width = 177
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
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
  object setmultilink: TCheckBox
    Left = 15
    Top = 484
    Width = 97
    Height = 18
    Caption = 'Kanalb'#252'ndelung'
    TabOrder = 20
  end
  object TarifProgress: TProgressBar
    Left = 112
    Top = 152
    Width = 185
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    Smooth = True
    ShowHint = False
    TabOrder = 21
    Visible = False
  end
  object Menu: TMainMenu
    Left = 288
    Top = 16
    object MM1: TMenuItem
      Caption = '&Datei'
      object MM1_1: TMenuItem
        Caption = '&Lade Tarife ...'
        Default = True
        ShortCut = 16460
        OnClick = MainMenueClick
      end
      object MM1_2: TMenuItem
        Caption = '&Speichere Tarife ...'
        ShortCut = 16467
        OnClick = MainMenueClick
      end
      object MM1_3: TMenuItem
        Caption = '-'
      end
      object MM1_4: TMenuItem
        Caption = '&Import'
        object MM1_4_1: TMenuItem
          Caption = 'Oleco/ Discountsurfer - Protokoll'
          RadioItem = True
          ShortCut = 16457
          OnClick = MainMenueClick
        end
      end
      object MM1_5: TMenuItem
        Caption = '&Export'
        object MM1_5_1: TMenuItem
          Caption = 'Protokoll - Export'
          ShortCut = 16453
          OnClick = MainMenueClick
        end
      end
      object MM1_6: TMenuItem
        Caption = '-'
      end
      object MM1_7: TMenuItem
        Caption = '&abgelaufene Tarife l'#246'schen'
        ShortCut = 16430
        OnClick = MainMenueClick
      end
      object MM1_8: TMenuItem
        Caption = '-'
      end
      object MM1_9: TMenuItem
        Caption = 'Minimieren'
        ShortCut = 16461
        OnClick = MainMenueClick
      end
      object MM1_10: TMenuItem
        Caption = '&Beenden'
        ShortCut = 16472
        OnClick = MainMenueClick
      end
    end
    object MM2: TMenuItem
      Caption = '&Tools'
      object MM2_1: TMenuItem
        Caption = '&Tarifmanager'
        ShortCut = 16468
        OnClick = MainMenueClick
      end
      object MM2_2: TMenuItem
        Caption = '&Verbindungs'#252'bersicht'
        object MM2_2_1: TMenuItem
          Caption = 'Monats&kalender'
          RadioItem = True
          ShortCut = 16459
          OnClick = MainMenueClick
        end
        object MM2_2_2: TMenuItem
          Caption = '&Einzelverbindungs'#252'bersicht'
          Default = True
          ShortCut = 16470
          OnClick = MainMenueClick
        end
      end
      object MM2_3: TMenuItem
        Caption = '&Online'
        Enabled = False
        object MM2_3_1: TMenuItem
          Caption = 'OnlineInfo anzeigen'
          OnClick = MainMenueClick
        end
        object MM2_3_2: TMenuItem
          Caption = 'Atomzeitabgleich starten'
          OnClick = MainMenueClick
        end
        object MM2_3_3: TMenuItem
          Caption = 'RSS-Feeds jetzt updaten'
          OnClick = MainMenueClick
        end
        object MM2_3_4: TMenuItem
          Caption = 'Auf Programmupdates pr'#252'fen'
          OnClick = MainMenueClick
        end
      end
      object MM2_4: TMenuItem
        Caption = '&Programme'
        object MM2_4_1: TMenuItem
          Caption = #39'online'#39' - Programme starten'
          ShortCut = 116
          OnClick = MainMenueClick
        end
        object MM2_4_2: TMenuItem
          Caption = #39'offline'#39' -Programme starten'
          ShortCut = 117
          OnClick = MainMenueClick
        end
      end
      object MM2_5: TMenuItem
        Caption = 'Newsletter'
        object MM2_5_1: TMenuItem
          Caption = 'anmelden'
          OnClick = MainMenueClick
        end
        object MM2_5_2: TMenuItem
          Caption = 'abmelden'
          OnClick = MainMenueClick
        end
      end
      object MM2_6: TMenuItem
        Caption = '&Fernsteuerung testen'
        ShortCut = 16454
        OnClick = MainMenueClick
      end
      object MM2_7: TMenuItem
        Caption = '&LeastCosterXP-Dateien'
        object MM2_7_1: TMenuItem
          Caption = 'mit LeastCosterXP verkn'#252'pfen'
          OnClick = MainMenueClick
        end
        object MM2_7_2: TMenuItem
          Caption = 'Verkn'#252'pfungen entfernen'
          OnClick = MainMenueClick
        end
      end
      object MM2_8: TMenuItem
        Caption = 'Plugins'
      end
    end
    object MM3: TMenuItem
      Caption = '&Einstellungen'
      object MM3_1: TMenuItem
        Caption = '&Programmeinstellungen'
        Default = True
        ShortCut = 16464
        OnClick = MainMenueClick
      end
      object MM3_2: TMenuItem
        Caption = 'Fortgeschrittener Modus'
        OnClick = MM3_2Click
      end
      object MM3_3: TMenuItem
        Caption = 'Sprache'
        Enabled = False
        Visible = False
      end
    end
    object MM4: TMenuItem
      Caption = '&RSS'
      object LeastCosterXP1: TMenuItem
        Caption = 'LeastCosterXP'
      end
    end
    object MM5: TMenuItem
      Caption = '&Hilfe'
      object MM5_1: TMenuItem
        Caption = '&'#220'ber'
        OnClick = MainMenueClick
      end
      object MM5_2: TMenuItem
        Caption = '&Hilfe'
        Default = True
        ShortCut = 112
        OnClick = MainMenueClick
      end
      object MM5_3: TMenuItem
        Caption = '&Bug-Report'
        OnClick = MainMenueClick
      end
      object Donate: TMenuItem
        Caption = 'Spenden'
        OnClick = DonateClick
      end
    end
    object MM7: TMenuItem
      Caption = '&Windows beenden'
      object MM7_1: TMenuItem
        Caption = 'Standby'
        OnClick = MainMenueClick
      end
      object MM7_2: TMenuItem
        Caption = 'Ruhezustand'
        OnClick = MainMenueClick
      end
      object MM7_3: TMenuItem
        Caption = '-'
      end
      object MM7_4: TMenuItem
        Caption = 'Abmelden'
        OnClick = MainMenueClick
      end
      object MM7_5: TMenuItem
        Caption = 'Ausschalten'
        OnClick = MainMenueClick
      end
      object MM7_6: TMenuItem
        Caption = 'Neustart'
        OnClick = MainMenueClick
      end
    end
  end
  object Timer_an: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer_anTimer
    Left = 8
    Top = 504
  end
  object Timer_aus: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer_ausTimer
    Left = 72
    Top = 504
  end
  object firststartcheck: TTimer
    Enabled = False
    OnTimer = firststartcheckTimer
    Left = 32
    Top = 504
  end
  object Tray: TCoolTrayIcon
    IconList = Icons
    CycleInterval = 2000
    Hint = 'LeastCosterXP'
    Icon.Data = {
      0000010001001010040000000000280100001600000028000000100000002000
      0000010004000000000080000000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008888
      888888888888880FFFF7700FF0888770000000FFF70880777777FFF7FFF80777
      7777FF7FF7F8700FFF77FF7F07F877777777F77FFFF88077000007F77F0880FF
      FFFFFF7FF0888000F8888000888880780FFFFFF0888888077FFF777778888880
      77FFFFF7088888807FFFFF770888888880000008888888888888888888880000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    IconIndex = 0
    PopupMenu = PopupMenu1
    MinimizeToTray = True
    OnClick = TrayClick
    OnDblClick = TrayClick
    OnBalloonHintShow = TrayBalloonHintShow
    OnBalloonHintTimeout = TrayBalloonHintTimeout
    OnMinimizeToTray = TrayMinimizeToTray
    Left = 40
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    MenuAnimation = [maBottomToTop]
    OnPopup = PopupMenu1Popup
    Left = 312
    Top = 96
    object PM1: TMenuItem
      Caption = 'OFFLINE'
      RadioItem = True
    end
    object PM2: TMenuItem
      Caption = '-'
    end
    object PM3: TMenuItem
      Caption = 'IP'
      Visible = False
    end
    object PM4: TMenuItem
      Caption = 'Onlinedauer heute'
      Visible = False
    end
    object PM5: TMenuItem
      Caption = '-'
      Visible = False
    end
    object PM6: TMenuItem
      Caption = 'Statistik heute'
    end
    object PM7: TMenuItem
      Caption = 'Dauer:'
    end
    object PM8: TMenuItem
      Caption = 'Kosten:'
    end
    object PM9: TMenuItem
      Caption = 'Verbindungen:'
    end
    object PM10: TMenuItem
      Caption = 'Kosten/min:'
    end
    object PM11: TMenuItem
      Caption = '-'
      Visible = False
    end
    object PM12: TMenuItem
      Caption = 'LeastCoster beenden'
      OnClick = TrayMenueClick
    end
    object PM13: TMenuItem
      Caption = 'Windows beenden'
      object PM13_1: TMenuItem
        Caption = 'Standby'
        OnClick = TrayMenueClick
      end
      object PM13_2: TMenuItem
        Caption = 'Ruhezustand'
        OnClick = TrayMenueClick
      end
      object PM13_3: TMenuItem
        Caption = 'Abmelden'
        OnClick = TrayMenueClick
      end
      object PM13_4: TMenuItem
        Caption = 'Ausschalten'
        OnClick = TrayMenueClick
      end
      object PM13_5: TMenuItem
        Caption = 'Neustart'
        OnClick = TrayMenueClick
      end
    end
    object PM14: TMenuItem
      Caption = 'maximieren'
      OnClick = PM14Click
    end
    object PM15: TMenuItem
      Caption = 'Verbindung trennen'
      Visible = False
      OnClick = PM15Click
    end
  end
  object hinttimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = hinttimerTimer
    Left = 352
    Top = 40
  end
  object call: TTimer
    Enabled = False
    OnTimer = callTimer
    Left = 240
    Top = 496
  end
  object calloff: TTimer
    Enabled = False
    OnTimer = calloffTimer
    Left = 208
    Top = 496
  end
  object closer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = closerTimer
    Left = 112
    Top = 488
  end
  object hider: TTimer
    Enabled = False
    OnTimer = hiderTimer
    Left = 320
    Top = 40
  end
  object Icons: TImageList
    Left = 368
    Top = 112
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000BBBBBB00CCCCCC00BBBBBB00CCCC
      CC00BBBBBB00CCCCCC00BBBBBB00CCCCCC00BBBBBB00CCCCCC00BBBBBB00CCCC
      CC00BBBBBB00CCCCCC00BBBBBB00CCCCCC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB00BBBBBB0000000000EEEE
      EE00EEEEEE00EEEEEE00EEEEEE0077777700777777000000000000000000EEEE
      EE00EEEEEE0000000000BBBBBB00BBBBBB0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000080800000808000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB0077777700777777001111
      1100000000000000000011111100000000000000000011111100EEEEEE00EEEE
      EE00EEEEEE007777770000000000CCCCCC000000000000808000008080000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB0000000000888888007777
      770077777700777777008888880088888800EEEEEE00EEEEEE00EEEEEE008888
      8800EEEEEE00EEEEEE00EEEEEE00BBBBBB000000000000000000008080000080
      80000080800000808000008080000080800000FFFF0000FFFF0000FFFF000080
      800000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000088888800888888008888
      880088888800888888008888880077777700EEEEEE00EEEEEE0077777700EEEE
      EE00EEEEEE0077777700EEEEEE00BBBBBB000000000000808000008080000080
      80000080800000808000008080000080800000FFFF0000FFFF000080800000FF
      FF0000FFFF000080800000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000777777000000000000000000EEEE
      EE00EEEEEE00EEEEEE007777770077777700EEEEEE00EEEEEE0077777700EEEE
      EE001111110088888800EEEEEE00BBBBBB0000808000000000000000000000FF
      FF0000FFFF0000FFFF00008080000080800000FFFF0000FFFF000080800000FF
      FF00000000000080800000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007777770077777700888888008888
      880077777700888888008888880088888800EEEEEE008888880088888800EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00BBBBBB000080800000808000008080000080
      80000080800000808000008080000080800000FFFF00008080000080800000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB0011111100777777007777
      7700000000000000000000000000000000000000000088888800EEEEEE007777
      770088888800EEEEEE0000000000CCCCCC000000000000000000008080000080
      800000000000000000000000000000000000000000000080800000FFFF000080
      80000080800000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB0000000000EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0088888800EEEE
      EE00EEEEEE0011111100CCCCCC00BBBBBB00000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000080800000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CCCCCC0000000000111111000000
      0000EEEEEE00CCCCCC00CCCCCC00CCCCCC00CCCCCC0011111100000000001111
      1100BBBBBB00CCCCCC00BBBBBB00CCCCCC000000000000000000000000000000
      000000FFFF00C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CCCCCC000000000088888800CCCC
      CC0000000000EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE000000
      0000BBBBBB00BBBBBB00BBBBBB00CCCCCC00000000000000000000808000C0C0
      C0000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CCCCCC00BBBBBB00000000007777
      770077777700FFFFFF00FFFFFF00FFFFFF007777770088888800888888008888
      880088888800BBBBBB00BBBBBB00CCCCCC000000000000000000000000000080
      800000808000FFFFFF00FFFFFF00FFFFFF000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB00BBBBBB00BBBBBB000000
      00007777770088888800EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE007777
      770011111100BBBBBB00BBBBBB00CCCCCC000000000000000000000000000000
      0000008080000080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB00BBBBBB00BBBBBB000000
      000077777700EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00888888008888
      880000000000BBBBBB00BBBBBB00BBBBBB000000000000000000000000000000
      00000080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB00BBBBBB00BBBBBB00BBBB
      BB00CCCCCC00000000001111110011111100000000000000000000000000CCCC
      CC00CCCCCC00BBBBBB00BBBBBB00BBBBBB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBBBB00BBBBBB00BBBBBB00BBBB
      BB00BBBBBB00BBBBBB00BBBBBB00BBBBBB00BBBBBB00CCCCCC00BBBBBB00CCCC
      CC00CCCCCC00BBBBBB00BBBBBB00BBBBBB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF000000FFFF000000000000C00300000000
      0000800100000000000080010000000000000001000000000000000100000000
      0000000100000000000080010000000000008003000000000000800F00000000
      0000800F000000000000C007000000000000E007000000000000E00700000000
      0000F81F000000000000FFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object sntptimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = sntptimerTimer
    Left = 80
    Top = 72
  end
  object UpdateTimer: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = UpdateTimerTimer
    Left = 48
    Top = 72
  end
  object IsOntimer: TTimer
    OnTimer = IsOntimerTimer
    Left = 160
    Top = 96
  end
  object Aktualisieren_timer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Aktualisieren_timerTimer
    Left = 136
    Top = 416
  end
  object Reload: TTimer
    Interval = 60000
    OnTimer = ReloadTimer
    Left = 200
    Top = 416
  end
  object Rsstimer: TTimer
    Enabled = False
    Interval = 25000
    OnTimer = RsstimerTimer
    Left = 16
    Top = 72
  end
  object ApplicationEvents1: TApplicationEvents
    OnActivate = ApplicationEvents1Activate
    OnDeactivate = ApplicationEvents1Deactivate
    OnShortCut = ApplicationEvents1ShortCut
    Left = 72
    Top = 8
  end
  object LEDTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = LEDTimerTimer
    Left = 272
    Top = 496
  end
  object ctrltimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = ctrltimerTimer
    Left = 40
    Top = 184
  end
  object MagRasEdt: TMagRasEdt
    bUseCountryAndAreaCodes = False
    bSpecificIPAddress = False
    bSpecificNameServers = False
    bHeaderCompression = False
    bRemoteDefaultGateway = False
    bDisableLCPExtensions = False
    bTerminalBeforeDial = False
    bTerminalAfterDial = False
    bModemLights = True
    bSoftwareCompression = False
    bRequireEncryptedPassword = False
    bRequireMSEncryptedPassword = False
    bRequireDataEncryption = False
    bNetworkLogon = True
    bUseLogonCredentials = False
    bPromoteAlternates = False
    bSecureLocalFiles = False
    bRequireEAP = False
    bRequirePAP = False
    bRequireSPAP = False
    bCustom = False
    bPreviewPhoneNumber = True
    bSharedPhoneNumbers = False
    bPreviewUserPw = True
    bPreviewDomain = True
    bShowDialingProgress = False
    bRequireCHAP = False
    bRequireMsCHAP = False
    bRequireMsCHAP2 = False
    bRequireW95MSCHAP = False
    bCustomScript = False
    CountryCode = 0
    CountryID = 0
    IPAddress = '0.0.0.0'
    DNSAddress = '0.0.0.0'
    DNSAddressAlt = '0.0.0.0'
    WINSAddress = '0.0.0.0'
    WINSAddressAlt = '0.0.0.0'
    FrameSize = 0
    FramingProtocol = framePPP
    bNetBEUI = False
    bNetIPX = False
    bNetTCPIP = False
    ISDNChannels = 2
    DialMode = dialAll
    DialExtraPercent = 0
    DialExtraSampleSeconds = 0
    HangUpExtraPercent = 0
    HangUpExtraSampleSeconds = 0
    IdleDisconnectSeconds = -1
    PType = typePhone
    EncryptionType = encryptOptional
    CustomAuthKey = 0
    VpnStrategy = vpnDefault
    bSecureFileAndPrint = False
    bSecureClientForMSNet = False
    bDontNegotiateMultilink = False
    bDontUseRasCredentials = False
    bUsePreSharedKey = False
    bInternet = False
    bDisableNbtOverIP = False
    bUseGlobalDeviceSettings = False
    bReconnectIfDropped = False
    bSharePhoneNumbers = False
    TcpWindowSize = 0
    RedialCount = 0
    RedialPause = 0
    Left = 320
    Top = 216
  end
  object MagRasPer: TMagRasPer
    KeyDUNConn = 'ConnectSpeed'
    KeyDUNXmit = 'TotalBytesXmit'
    KeyDUNRecv = 'TotalBytesRecvd'
    UsePDH = False
    Left = 288
    Top = 216
  end
  object leerlauf: TTimer
    Enabled = False
    Interval = 300000
    OnTimer = leerlaufTimer
    Left = 104
    Top = 184
  end
  object warnung_unterdruecken: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = warnung_unterdrueckenTimer
    Left = 200
    Top = 96
  end
  object Autodial: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = AutodialTimer
    Left = 136
    Top = 184
  end
  object ipemail: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = ipemailTimer
    Left = 16
    Top = 104
  end
  object Time: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimeTimer
    Left = 384
    Top = 48
  end
  object MagRasCon: TMagRasCon
    SubEntry = 0
    CallbackId = 0
    CountryID = 0
    CountryCode = 0
    EntryOptions = 0
    DialMode = 0
    OnStateEvent = MagRasConStateEvent
    Left = 352
    Top = 216
  end
  object ConnectMenu: TPopupMenu
    MenuAnimation = [maTopToBottom]
    Left = 312
    Top = 296
    object N1Kanal1: TMenuItem
      Caption = 'Verbindung'
    end
    object rennen1: TMenuItem
      Caption = '    Trennen'
      OnClick = rennen1Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object N2Kanal1: TMenuItem
      Caption = '2. Kanal'
    end
    object Verbinden2Methode1: TMenuItem
      Caption = '    Verbinden'
      OnClick = Verbinden2Methode1Click
    end
    object rennen2: TMenuItem
      Caption = '    Trennen'
      OnClick = rennen2Click
    end
  end
  object TarifStatus: TPopupMenu
    OnPopup = TarifStatusPopup
    Left = 208
    Top = 144
    object TS1: TMenuItem
      Caption = 'zur Blacklist hinzuf'#252'gen'
      OnClick = TarifStatusClick
    end
    object TS2: TMenuItem
      Caption = 'Ablaufdatum'
      object TS2_1: TMenuItem
        Caption = 'gestern'
        OnClick = TarifStatusClick
      end
      object TS2_2: TMenuItem
        Caption = 'heute'
        OnClick = TarifStatusClick
      end
      object TS2_3: TMenuItem
        Caption = 'morgen'
        OnClick = TarifStatusClick
      end
      object TS2_4: TMenuItem
        Caption = 'heute in einer Woche'
        OnClick = TarifStatusClick
      end
      object TS2_5: TMenuItem
        Caption = 'am Ende des Monats'
        OnClick = TarifStatusClick
      end
    end
    object TS3: TMenuItem
      Caption = 'Tarifmarkierung'
      object TS3_1: TMenuItem
        Caption = 'neue Farbe'
        OnClick = TarifStatusClick
      end
      object TS3_2: TMenuItem
        Caption = 'verwende Standards'
        OnClick = TarifStatusClick
      end
      object TS3_3: TMenuItem
        Caption = 'Standards'
        object TS3_3_1: TMenuItem
          Caption = 'Tarife mit Einwahlgeb'#252'hr'
          OnClick = TarifStatusClick
        end
        object TS3_3_2: TMenuItem
          Caption = 'Tarife mit Freikontingent'
          OnClick = TarifStatusClick
        end
        object TS3_3_3: TMenuItem
          Caption = 'Tarife aus der Blacklist'
          OnClick = TarifStatusClick
        end
        object TS3_3_4: TMenuItem
          Caption = 'abgelaufene Tarife'
          OnClick = TarifStatusClick
        end
        object TS3_3_5: TMenuItem
          Caption = 'sonstige'
          OnClick = TarifStatusClick
        end
      end
    end
    object TS4: TMenuItem
      Caption = 'zur'#252'cksetzen'
      OnClick = TarifStatusClick
    end
    object TS5: TMenuItem
      Caption = 'Tarif l'#246'schen'
      OnClick = TarifStatusClick
    end
    object TS6: TMenuItem
      Caption = 'Einstellungen'
      object TS6_1: TMenuItem
        Caption = 'keine Tarife mit Einwahlgeb'#252'hr'
        OnClick = TarifStatusClick
      end
      object TS6_2: TMenuItem
        Caption = 'keine Farbmarkierung'
        OnClick = TarifStatusClick
      end
      object Spalten1: TMenuItem
        Caption = 'sichtbare Spalten'
        object S_1: TMenuItem
          Tag = 1
          Caption = 'Tarif'
          OnClick = S_1Click
        end
        object S_2: TMenuItem
          Tag = 2
          Caption = 'Beginn'
          OnClick = S_1Click
        end
        object S_3: TMenuItem
          Tag = 3
          Caption = 'Ende'
          OnClick = S_1Click
        end
        object S_4: TMenuItem
          Tag = 4
          Caption = 'Preis'
          OnClick = S_1Click
        end
        object S_5: TMenuItem
          Tag = 5
          Caption = 'Einwahl'
          OnClick = S_1Click
        end
        object S_6: TMenuItem
          Tag = 6
          Caption = 'Takt'
          OnClick = S_1Click
        end
        object S_7: TMenuItem
          Tag = 7
          Caption = 'Kosten'
          OnClick = S_1Click
        end
        object S_8: TMenuItem
          Tag = 8
          Caption = 'Nummer'
          OnClick = S_1Click
        end
        object S_9: TMenuItem
          Tag = 9
          Caption = 'User'
          OnClick = S_1Click
        end
        object S_10: TMenuItem
          Tag = 10
          Caption = 'Passwort'
          OnClick = S_1Click
        end
        object S_11: TMenuItem
          Tag = 11
          Caption = 'Webseite'
          OnClick = S_1Click
        end
        object S_12: TMenuItem
          Tag = 12
          Caption = 'gilt seit'
          OnClick = S_1Click
        end
        object S_13: TMenuItem
          Tag = 13
          Caption = 'gilt bis'
          OnClick = S_1Click
        end
        object S_14: TMenuItem
          Tag = 14
          Caption = 'eingetragen'
          OnClick = S_1Click
        end
        object S_15: TMenuItem
          Tag = 15
          Caption = 'Einwahlversuche'
          OnClick = S_1Click
        end
        object S_16: TMenuItem
          Tag = 16
          Caption = 'erfolgreiche Einwahlen'
          OnClick = S_1Click
        end
        object S_17: TMenuItem
          Tag = 17
          Caption = 'Tag der G'#252'ltigkeit'
          OnClick = S_1Click
        end
      end
      object ForceDial: TMenuItem
        Caption = 'erzwinge Einwahl'
        OnClick = ForceDialClick
      end
    end
  end
  object WaitOnDisconnect: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = WaitOnDisconnectTimer
    Left = 344
    Top = 168
  end
  object ScoreTimer: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = ScoreTimerTimer
    Left = 304
    Top = 192
  end
  object OneInstance: TBomeOneInstance
    ShowOnNewInstance = False
    UseHaltToExit = True
    OnInstanceStarted = OneInstanceInstanceStarted
    Left = 8
    Top = 8
  end
  object AtomzeitThread: TBMDThread
    UpdateEnabled = False
    OnExecute = AtomzeitThreadExecute
    Left = 120
    Top = 96
  end
  object ColorDialog: TColorDialog
    Options = [cdFullOpen, cdSolidColor, cdAnyColor]
    Left = 216
    Top = 200
  end
end
