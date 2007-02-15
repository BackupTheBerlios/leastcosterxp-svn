object CallIn: TCallIn
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'CallIn'
  ClientHeight = 116
  ClientWidth = 234
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    234
    116)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 234
    Height = 116
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Calltype: TLabel
    Left = 8
    Top = 8
    Width = 97
    Height = 13
    Caption = 'Incoming Call: '
  end
  object info2: TLabel
    Left = 40
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
    Left = 40
    Top = 56
    Width = 24
    Height = 13
    Caption = 'info3'
  end
  object info4: TLabel
    Left = 40
    Top = 72
    Width = 24
    Height = 13
    Caption = 'info4'
  end
  object Date: TLabel
    Left = 120
    Top = 8
    Width = 105
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Date'
  end
  object BitBtn1: TBitBtn
    Left = 160
    Top = 82
    Width = 65
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
end
