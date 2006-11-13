object floatingW: TfloatingW
  Left = 0
  Top = 0
  Width = 208
  Height = 213
  AlphaBlend = True
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsSizeToolWin
  Caption = 'OnlineInfo'
  Color = clBtnFace
  Constraints.MinHeight = 20
  Constraints.MinWidth = 100
  UseDockManager = True
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDefault
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = ApplicationEvents1Deactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 200
    Height = 187
    Align = alClient
    Center = True
    Stretch = True
    Transparent = True
  end
  object preis: TLabel
    Left = 163
    Top = 45
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'Preis'
    Transparent = True
  end
  object valid: TLabel
    Left = 8
    Top = 45
    Width = 113
    Height = 13
    Caption = '06:00:00 - 08:00:00'
    Transparent = True
  end
  object OCostlabel: TLabel
    Left = 114
    Top = 20
    Width = 79
    Height = 24
    Alignment = taRightJustify
    Caption = '0,0000 '#8364
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Ozeit: TLabel
    Left = 7
    Top = 20
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
    Transparent = True
  end
  object Tarif: TLabel
    Left = 8
    Top = 6
    Width = 27
    Height = 13
    Caption = 'Tarif'
  end
  object LEDXmit: TAMAdvLed
    Left = 104
    Top = 61
    Width = 13
    Height = 13
    ColorOff = 16384
    ColorOn = 65408
    LedType = ltSquare
  end
  object LEDRecv: TAMAdvLed
    Left = 8
    Top = 61
    Width = 13
    Height = 13
    ColorOff = 64
    ColorOn = clRed
    LedType = ltSquare
  end
  object LabelDataRecv: TLabel
    Left = 188
    Top = 123
    Width = 5
    Height = 13
    Alignment = taRightJustify
  end
  object LabelDataXmit: TLabel
    Left = 188
    Top = 107
    Width = 5
    Height = 13
    Alignment = taRightJustify
  end
  object LabelSpeedVal: TLabel
    Left = 188
    Top = 91
    Width = 5
    Height = 13
    Alignment = taRightJustify
  end
  object LabelSpeedXmit: TLabel
    Left = 120
    Top = 61
    Width = 5
    Height = 13
  end
  object LabelSpeedRecv: TLabel
    Left = 24
    Top = 61
    Width = 5
    Height = 13
  end
  object Label3: TLabel
    Left = 8
    Top = 123
    Width = 72
    Height = 13
    Caption = 'Empfangen :'
  end
  object Label2: TLabel
    Left = 8
    Top = 107
    Width = 63
    Height = 13
    Caption = 'Gesendet :'
  end
  object labelx: TLabel
    Left = 8
    Top = 91
    Width = 102
    Height = 13
    Caption = 'Geschwindigkeit :'
  end
  object Label1: TLabel
    Left = 47
    Top = 145
    Width = 82
    Height = 13
    Caption = 'immer sichtbar'
    Transparent = True
    Layout = tlCenter
  end
  object beenden: TBitBtn
    Left = 178
    Top = 3
    Width = 17
    Height = 17
    Caption = 'x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    TabStop = False
    OnClick = beendenClick
  end
  object mini: TBitBtn
    Left = 157
    Top = 3
    Width = 17
    Height = 17
    Caption = '_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    TabStop = False
    OnClick = miniClick
  end
  object visbar: TTrackBar
    Left = 0
    Top = 159
    Width = 200
    Height = 24
    Max = 255
    Min = 50
    Frequency = 15
    Position = 50
    TabOrder = 3
    TabStop = False
    ThumbLength = 15
    OnChange = visbarChange
  end
  object changepos: TBitBtn
    Left = 8
    Top = 143
    Width = 17
    Height = 17
    Caption = 'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TabStop = False
    OnClick = changeposClick
  end
  object topbox: TCheckBox
    Left = 30
    Top = 144
    Width = 14
    Height = 14
    TabStop = False
    TabOrder = 4
    OnClick = topboxClick
  end
  object fontup: TButton
    Left = 182
    Top = 144
    Width = 15
    Height = 15
    Hint = 'Schrift vergr'#246#223'ern'
    Caption = '>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    TabStop = False
    OnClick = fontupClick
  end
  object fontdown: TButton
    Left = 166
    Top = 144
    Width = 15
    Height = 15
    Hint = 'Schrift verkleinern'
    Caption = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    TabStop = False
    OnClick = fontdownClick
  end
  object ScaleUp: TButton
    Left = 132
    Top = 144
    Width = 15
    Height = 15
    Caption = '+'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    TabStop = False
    OnClick = ScaleUpClick
  end
  object ScaleDown: TButton
    Left = 149
    Top = 144
    Width = 15
    Height = 15
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    TabStop = False
    OnClick = ScaleDownClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnDeactivate = ApplicationEvents1Deactivate
    Left = 144
    Top = 104
  end
end
