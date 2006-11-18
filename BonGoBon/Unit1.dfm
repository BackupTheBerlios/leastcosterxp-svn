object Form1: TForm1
  Left = 282
  Top = 107
  ActiveControl = Start
  BorderStyle = bsNone
  Caption = 'BonGoBon 0.1'
  ClientHeight = 132
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  WindowState = wsMinimized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SRGradient1: TSRGradient
    Left = 0
    Top = 0
    Width = 415
    Height = 132
    Align = alClient
    BevelWidth = 1
    BevelStyle = bvNone
    Buffered = True
    Direction = gdDownRight
    EndColor = 10218667
    StartColor = 10279917
    StepWidth = 1
    Style = gsVertical
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 415
    Height = 132
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 263
    Top = 30
    Width = 116
    Height = 13
    Caption = 'maximale Einwahlgeb'#252'hr'
    Transparent = True
  end
  object Progress: TFlatProgressBar
    Left = 128
    Top = 80
    Width = 255
    Height = 16
    Min = 0
    Max = 100
  end
  object Label2: TLabel
    Left = 128
    Top = 32
    Width = 72
    Height = 13
    Caption = 'maximaler Preis'
    Transparent = True
  end
  object Label3: TLabel
    Left = 3
    Top = 3
    Width = 410
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'BongoBon '
    Color = clBackground
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnHighlight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object maxE: TFlatSpinEditFloat
    Left = 264
    Top = 48
    Width = 121
    Height = 20
    ColorFlat = clBtnFace
    AutoSize = False
    Digits = 2
    Precision = 9
    FloatFormat = ffFixed
    Increment = 0.100000000000000000
    ParentColor = True
    TabOrder = 2
  end
  object maxP: TFlatSpinEditFloat
    Left = 128
    Top = 48
    Width = 121
    Height = 20
    ColorFlat = clBtnFace
    AutoSize = False
    Digits = 2
    Precision = 9
    FloatFormat = ffGeneral
    Increment = 0.100000000000000000
    ParentColor = True
    TabOrder = 1
  end
  object Start: TFlatButton
    Left = 8
    Top = 37
    Width = 97
    Height = 45
    Caption = 'Start'
    TabStop = True
    TabOrder = 0
    OnClick = StartClick
  end
  object Status: TStatusBar
    Left = 2
    Top = 112
    Width = 412
    Height = 19
    Align = alNone
    Panels = <>
  end
  object FlatButton1: TFlatButton
    Left = 397
    Top = 3
    Width = 16
    Height = 16
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = FlatButton1Click
  end
  object FlatButton2: TFlatButton
    Left = 380
    Top = 3
    Width = 16
    Height = 16
    Caption = '_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = FlatButton2Click
  end
  object ResetB: TFlatButton
    Left = 8
    Top = 84
    Width = 97
    Height = 18
    Caption = 'Reset'
    TabOrder = 6
    OnClick = ResetBClick
  end
  object Http: THttpCli
    URL = 'http://www.bongosoft.de/Preistabelle-lang.txt'
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Mozilla/4.0 (compatible; ICS)'
    Accept = 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'
    NoCache = True
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    RequestVer = '1.0'
    FollowRelocation = True
    LocationChangeMaxCount = 5
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Options = []
    OnDocData = HttpDocData
    SocksAuthentication = socksNoAuthentication
    Left = 368
    Top = 96
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 256
    Top = 80
  end
  object BMDThread1: TBMDThread
    UpdateEnabled = False
    OnExecute = BMDThread1Execute
    OnTerminate = BMDThread1Terminate
    Left = 312
    Top = 96
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 192
    Top = 88
  end
end
