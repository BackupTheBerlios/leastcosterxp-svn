object tarif: Ttarif
  Left = 157
  Top = 160
  BorderStyle = bsDialog
  Caption = 'Tarife bearbeiten'
  ClientHeight = 469
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 26
    Top = 360
    Width = 33
    Height = 13
    Caption = 'Tarifnr.'
  end
  object tarifname: TLabel
    Left = 29
    Top = 16
    Width = 54
    Height = 24
    Caption = 'Tarif: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object fort: TGauge
    Left = 27
    Top = 424
    Width = 406
    Height = 25
    ForeColor = clNavy
    Progress = 0
  end
  object Label2: TLabel
    Left = 27
    Top = 397
    Width = 58
    Height = 13
    Caption = 'von ... bis ...'
  end
  object liste: TStringGrid
    Left = 24
    Top = 48
    Width = 407
    Height = 297
    BorderStyle = bsNone
    ColCount = 4
    Ctl3D = True
    DefaultColWidth = 80
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    ParentCtl3D = False
    TabOrder = 0
    ColWidths = (
      142
      103
      81
      75)
  end
  object stelle: TSpinEdit
    Left = 67
    Top = 355
    Width = 48
    Height = 22
    MaxValue = 2
    MinValue = 1
    TabOrder = 1
    Value = 1
    OnChange = stelleChange
  end
  object start: TDateTimePicker
    Left = 86
    Top = 392
    Width = 89
    Height = 21
    Date = 36526.763548437500000000
    Time = 36526.763548437500000000
    TabOrder = 3
  end
  object ende: TDateTimePicker
    Left = 184
    Top = 392
    Width = 89
    Height = 21
    Date = 401769.763851064800000000
    Time = 401769.763851064800000000
    TabOrder = 4
  end
  object namen: TComboBox
    Left = 139
    Top = 356
    Width = 294
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    OnChange = namenChange
  end
  object BitBtn1: TBitBtn
    Left = 290
    Top = 392
    Width = 72
    Height = 21
    Caption = 'ok'
    TabOrder = 5
    OnClick = BitBtn1Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 424
    Top = 432
  end
end
