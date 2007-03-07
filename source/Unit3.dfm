object auswert: Tauswert
  Left = 197
  Top = 111
  ActiveControl = ok
  BiDiMode = bdRightToLeftNoAlign
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsNone
  ClientHeight = 473
  ClientWidth = 601
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 601
    Height = 473
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
      Width = 585
      Height = 24
      Align = alTop
      Alignment = taCenter
      Caption = 'Einzelverbindungs'#252'bersicht'
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
    object Panel4: TPanel
      Left = 6
      Top = 122
      Width = 585
      Height = 21
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      OnMouseDown = Panel1MouseDown
      OnMouseMove = Panel1MouseMove
      object Filter: TCheckBox
        Left = 24
        Top = 2
        Width = 57
        Height = 17
        Caption = 'Filter :'
        TabOrder = 0
        OnClick = FilterClick
      end
      object FilterName: TEdit
        Left = 87
        Top = 0
        Width = 482
        Height = 21
        Hint = 'alle Tarife die mit dem Filter beginnen werden angezeigt'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
    object Panel3: TPanel
      Left = 6
      Top = 30
      Width = 585
      Height = 92
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      OnMouseDown = Panel1MouseDown
      OnMouseMove = Panel1MouseMove
      object Sortierung: TLabel
        Left = 280
        Top = 0
        Width = 48
        Height = 13
        Caption = 'Sortierung'
      end
      object Label3: TLabel
        Left = 154
        Top = 0
        Width = 25
        Height = 13
        Caption = 'Ende'
      end
      object Label2: TLabel
        Left = 26
        Top = 0
        Width = 22
        Height = 13
        Caption = 'Start'
      end
      object Ausgabeformat: TLabel
        Left = 425
        Top = 0
        Width = 71
        Height = 13
        Caption = 'Ausgabeformat'
      end
      object errormsg: TLabel
        Left = 30
        Top = 79
        Width = 545
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object TimePick2: TDateTimePicker
        Left = 154
        Top = 53
        Width = 113
        Height = 21
        Date = 38691.323859409720000000
        Time = 38691.323859409720000000
        Kind = dtkTime
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        OnChange = TimePick2Change
      end
      object TimePick1: TDateTimePicker
        Left = 26
        Top = 53
        Width = 113
        Height = 21
        Date = 38691.323859409720000000
        Time = 38691.323859409720000000
        Kind = dtkTime
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        OnChange = TimePick1Change
      end
      object DatePick2: TDateTimePicker
        Left = 154
        Top = 15
        Width = 113
        Height = 21
        Date = 38691.323859409720000000
        Time = 38691.323859409720000000
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        OnChange = Datepick1Change
        OnDropDown = Datepick1DropDown
      end
      object Datepick1: TDateTimePicker
        Left = 26
        Top = 15
        Width = 113
        Height = 21
        Date = 38691.323859409720000000
        Time = 38691.323859409720000000
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnChange = Datepick1Change
        OnDropDown = Datepick1DropDown
      end
      object Sortbox: TComboBox
        Left = 281
        Top = 14
        Width = 135
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        MaxLength = 10
        TabOrder = 4
        OnCloseUp = SortboxCloseUp
        OnDropDown = Datepick1DropDown
        Items.Strings = (
          'chronologisch'
          'Uhrzeit'
          'Verbindungsdauer'
          'Kosten'
          'Tarif'
          'Rufnummer'
          'wie im Protokoll')
      end
      object ok: TBitBtn
        Left = 282
        Top = 50
        Width = 90
        Height = 25
        Caption = '&Laden'
        TabOrder = 6
        OnClick = okClick
        Kind = bkOK
      end
      object FormatBox: TComboBox
        Left = 426
        Top = 14
        Width = 135
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        OnDropDown = Datepick1DropDown
        Items.Strings = (
          'HTML (Webseite)'
          'CSV')
      end
      object Exportiere: TBitBtn
        Left = 378
        Top = 50
        Width = 90
        Height = 25
        Caption = '&Export'
        Default = True
        Enabled = False
        TabOrder = 7
        OnClick = ExportiereClick
        NumGlyphs = 2
      end
      object BitBtn1: TBitBtn
        Left = 475
        Top = 50
        Width = 90
        Height = 25
        TabOrder = 8
        Kind = bkClose
      end
    end
    object Panel2: TPanel
      Left = 6
      Top = 143
      Width = 585
      Height = 300
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object Grid: TStringGrid
        Tag = -5
        Left = 0
        Top = 0
        Width = 569
        Height = 280
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        Color = cl3DLight
        ColCount = 9
        Ctl3D = True
        DefaultRowHeight = 18
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSizing, goColSizing, goColMoving, goTabs, goThumbTracking]
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 0
        Visible = False
        OnColumnMoved = GridColumnMoved
        OnDblClick = GridDblClick
        OnDrawCell = GridDrawCell
        OnGetEditMask = GridGetEditMask
        OnMouseDown = GridMouseDown
        OnMouseUp = GridMouseUp
        OnSelectCell = GridSelectCell
        ColWidths = (
          65
          64
          64
          64
          64
          64
          64
          64
          64)
      end
      object sizer: TPanel
        Left = 569
        Top = 0
        Width = 16
        Height = 280
        Align = alRight
        Caption = '>'
        Locked = True
        ParentBackground = False
        TabOrder = 1
        OnMouseDown = sizerMouseDown
        OnMouseUp = sizerMouseUp
      end
      object deletelist: TPanel
        Left = 0
        Top = 280
        Width = 585
        Height = 20
        Align = alBottom
        Caption = #220'bersicht l'#246'schen'
        TabOrder = 2
        OnMouseDown = deletelistMouseDown
        OnMouseUp = deletelistMouseUp
      end
    end
    object Progress1: TProgressBar
      Left = 6
      Top = 446
      Width = 585
      Height = 17
      Align = alBottom
      TabOrder = 3
      Visible = False
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 561
    Top = 46
  end
end
