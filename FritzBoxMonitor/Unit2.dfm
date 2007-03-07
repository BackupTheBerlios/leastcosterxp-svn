object CallIn: TCallIn
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'CallIn'
  ClientHeight = 122
  ClientWidth = 246
  Color = clMoneyGreen
  TransparentColorValue = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnShow = FormShow
  DesignSize = (
    246
    122)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 246
    Height = 122
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Calltype: TLabel
    Left = 8
    Top = 8
    Width = 70
    Height = 13
    Caption = 'Incoming Call: '
  end
  object info2: TLabel
    Left = 25
    Top = 31
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
    Left = 25
    Top = 55
    Width = 24
    Height = 13
    Caption = 'info3'
  end
  object info4: TLabel
    Left = 25
    Top = 71
    Width = 24
    Height = 13
    Caption = 'info4'
  end
  object Date: TLabel
    Left = 214
    Top = 8
    Width = 23
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Date'
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 90
    Width = 65
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object topbox: TCheckBox
    Left = 8
    Top = 96
    Width = 97
    Height = 17
    Caption = 'topbox'
    TabOrder = 1
    OnClick = topboxClick
  end
end
