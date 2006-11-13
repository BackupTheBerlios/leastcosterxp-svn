object htmlwindow: Thtmlwindow
  Left = 296
  Top = 197
  ActiveControl = ok1
  BorderStyle = bsNone
  Caption = 'HTMLExport'
  ClientHeight = 280
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 402
    Height = 280
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    OnMouseDown = Panel1MouseDown
    OnMouseMove = Panel1MouseMove
    object balken: TGauge
      Left = 4
      Top = 258
      Width = 390
      Height = 14
      Hint = '... zeigt den Fortschirtt des Exports an.'
      Align = alBottom
      Enabled = False
      ForeColor = clNavy
      ParentShowHint = False
      Progress = 0
      ShowHint = True
    end
    object Export: TLabel
      Left = 4
      Top = 4
      Width = 390
      Height = 24
      Align = alTop
      Alignment = taCenter
      Caption = 'Protokoll - Export'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      OnMouseDown = Panel1MouseDown
      OnMouseMove = Panel1MouseMove
    end
    object warning: TLabel
      Left = 8
      Top = 272
      Width = 3
      Height = 13
      Color = clBtnFace
      Constraints.MaxWidth = 353
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object ok1: TBitBtn
      Left = 257
      Top = 65
      Width = 130
      Height = 25
      Hint = '... startet den Export.'
      Caption = '      &Export             '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = ok1Click
      Kind = bkOK
    end
    object kind: TComboBox
      Left = 257
      Top = 33
      Width = 90
      Height = 21
      Hint = 'W'#228'hlen Sie hier aus, welches Protokoll Sie exportieren m'#246'chten.'
      AutoCloseUp = True
      Style = csDropDownList
      DropDownCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Sorted = True
      TabOrder = 3
      OnDropDown = kindDropDown
      Items.Strings = (
        '*.csv'
        '*.html')
    end
    object CheckBox2: TCheckBox
      Left = 26
      Top = 240
      Width = 104
      Height = 17
      Hint = '... w'#228'hlt alle Protokolle aus.'
      Caption = 'keine ausw'#228'hlen'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox1: TCheckBox
      Left = 145
      Top = 240
      Width = 97
      Height = 17
      Hint = '... w'#228'hlt kein Protokoll aus.'
      Caption = 'alle ausw'#228'hlen'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object BitBtn1: TBitBtn
      Left = 257
      Top = 214
      Width = 130
      Height = 25
      Hint = '... schlie'#223't dieses Fenster.'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = BitBtn1Click
      Kind = bkClose
    end
    object auswahlbox: TListBox
      Left = 9
      Top = 33
      Width = 241
      Height = 209
      Hint = 'Ausw'#228'hlen durch klicken, Mehrfachauswahl m'#246'glich ... '
      BevelKind = bkTile
      BevelOuter = bvRaised
      ExtendedSelect = False
      ItemHeight = 13
      MultiSelect = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = auswahlboxClick
    end
    object BitBtn2: TBitBtn
      Left = 257
      Top = 97
      Width = 130
      Height = 25
      Hint = '... verschiebt die *.csv und *.htm Protokolle in den Papierkorb.'
      Caption = '     &L'#246'schen             '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      WordWrap = True
      OnClick = BitBtn2Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn3: TBitBtn
      Left = 257
      Top = 129
      Width = 130
      Height = 25
      Hint = '... l'#246'scht Daten, die aus Oleco/Discountsurfer importiert wurden'
      Caption = 'L'#246'sche &Importdaten'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      WordWrap = True
      OnClick = BitBtn3Click
      Kind = bkNo
    end
  end
end
