object shutter: Tshutter
  Left = 424
  Top = 293
  ActiveControl = Stop
  BorderStyle = bsNone
  Caption = 'shutdown'
  ClientHeight = 167
  ClientWidth = 232
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 232
    Height = 167
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    BorderWidth = 2
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 24
      Top = 48
      Width = 3
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Microsoft Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 156
      Top = 48
      Width = 3
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Microsoft Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 6
      Width = 190
      Height = 20
      Align = alTop
      Alignment = taCenter
      Caption = 'Windows wird beendet !'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 60
      Width = 210
      Height = 46
      Alignment = taCenter
      Caption = '30'
      Constraints.MaxWidth = 210
      Constraints.MinWidth = 210
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -40
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Stop: TBitBtn
      Left = 78
      Top = 128
      Width = 75
      Height = 25
      Caption = '&Stop'
      TabOrder = 0
      OnClick = StopClick
    end
  end
  object Timer2: TTimer
    Tag = 30
    Enabled = False
    OnTimer = Timer2Timer
    Left = 192
    Top = 96
  end
  object ApplicationEvents1: TApplicationEvents
    OnDeactivate = ApplicationEvents1Deactivate
    Left = 24
    Top = 64
  end
end
