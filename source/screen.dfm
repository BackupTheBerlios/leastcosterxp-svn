object screenshot: Tscreenshot
  Left = 55
  Top = 311
  AlphaBlend = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Fernbedienung'
  ClientHeight = 204
  ClientWidth = 239
  Color = clBtnFace
  UseDockManager = True
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  ScreenSnap = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 14
    Top = 9
    Width = 129
    Height = 160
    Center = True
    Proportional = True
    Stretch = True
  end
  object BitBtn2: TBitBtn
    Left = 152
    Top = 44
    Width = 81
    Height = 25
    Caption = '&n'#228'chster'
    Enabled = False
    TabOrder = 0
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 152
    Top = 78
    Width = 81
    Height = 25
    Caption = '&vorheriger'
    Enabled = False
    TabOrder = 1
    OnClick = BitBtn3Click
  end
  object BitBtn1: TBitBtn
    Left = 152
    Top = 112
    Width = 81
    Height = 25
    Caption = '&w'#228'hlen'
    Enabled = False
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object TrackBar1: TTrackBar
    Left = 0
    Top = 179
    Width = 239
    Height = 25
    Align = alBottom
    Max = 255
    Min = 100
    ParentShowHint = False
    Position = 255
    ShowHint = False
    TabOrder = 3
    ThumbLength = 12
    TickStyle = tsManual
    OnChange = TrackBar1Change
  end
  object shot: TBitBtn
    Left = 152
    Top = 10
    Width = 81
    Height = 25
    Caption = '&start'
    TabOrder = 4
    OnClick = shotClick
  end
  object BitBtn4: TBitBtn
    Left = 152
    Top = 144
    Width = 81
    Height = 25
    Caption = 'S&chlie'#223'en'
    TabOrder = 5
    Kind = bkClose
  end
end
