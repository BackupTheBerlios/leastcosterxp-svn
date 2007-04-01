object CallIn: TCallIn
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'CallIn'
  ClientHeight = 107
  ClientWidth = 245
  Color = 14600382
  TransparentColorValue = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    245
    107)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 25
    Width = 245
    Height = 82
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object info2: TLabel
    Left = 18
    Top = 32
    Width = 52
    Height = 19
    Caption = 'InfoNr'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object info3: TLabel
    Left = 19
    Top = 72
    Width = 24
    Height = 13
    Caption = 'info3'
  end
  object Date: TLabel
    Left = 213
    Top = 37
    Width = 23
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Date'
  end
  object duration: TLabel
    Left = 160
    Top = 65
    Width = 72
    Height = 19
    Caption = '00:00:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 95
    Width = 65
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object topbox: TCheckBox
    Left = 8
    Top = 101
    Width = 81
    Height = 17
    Caption = 'stay on top'
    TabOrder = 1
    OnClick = topboxClick
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 245
    Height = 25
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    object Calltype: TLabel
      Left = 8
      Top = 4
      Width = 70
      Height = 13
      Caption = 'Incoming Call: '
    end
    object info4: TLabel
      Left = 113
      Top = 4
      Width = 24
      Height = 13
      Caption = 'info4'
    end
    object Bright: TButton
      Left = 221
      Top = 2
      Width = 18
      Height = 17
      Caption = '>'
      TabOrder = 0
      OnClick = BrightClick
    end
    object Bleft: TButton
      Left = 201
      Top = 2
      Width = 18
      Height = 17
      Caption = '<'
      TabOrder = 1
      OnClick = BleftClick
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 15000
    OnTimer = TimerTimer
    Left = 112
    Top = 56
  end
end
