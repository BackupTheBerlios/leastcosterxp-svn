object disconnect_leerlauf: Tdisconnect_leerlauf
  Left = 406
  Top = 280
  ActiveControl = Stop
  BorderStyle = bsNone
  Caption = 'disconnect_leerlauf'
  ClientHeight = 156
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 242
    Height = 156
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
    object Label2: TLabel
      Left = 6
      Top = 38
      Width = 226
      Height = 38
      Align = alTop
      Alignment = taCenter
      Caption = '30 Sekunden'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -33
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 6
      Top = 6
      Width = 226
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Ihre Verbindung ist im Leerlauf.'
      WordWrap = True
    end
    object label3: TLabel
      Left = 6
      Top = 76
      Width = 226
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'getrennt.'
      WordWrap = True
    end
    object Label4: TLabel
      Left = 6
      Top = 22
      Width = 226
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Es wird in'
      WordWrap = True
    end
    object Stop: TBitBtn
      Left = 121
      Top = 112
      Width = 102
      Height = 25
      Caption = '&Stop'
      TabOrder = 1
      OnClick = StopClick
    end
    object Trennen: TBitBtn
      Left = 12
      Top = 112
      Width = 102
      Height = 25
      Caption = 'Jetzt &Trennen'
      TabOrder = 0
      OnClick = TrennenClick
    end
  end
  object Timer1: TTimer
    Tag = 30
    Enabled = False
    OnTimer = Timer1Timer
    Left = 8
    Top = 8
  end
  object ApplicationEvents1: TApplicationEvents
    OnDeactivate = ApplicationEvents1Deactivate
    Left = 16
    Top = 80
  end
  object ConnectTimer: TTimer
    Enabled = False
    OnTimer = ConnectTimerTimer
    Left = 192
    Top = 80
  end
end
