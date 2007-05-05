object Form1: TForm1
  Left = 282
  Top = 107
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
    Top = 16
    Width = 415
    Height = 116
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
    Top = 16
    Width = 415
    Height = 116
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 263
    Top = 21
    Width = 116
    Height = 13
    Caption = 'maximale Einwahlgeb'#252'hr'
    Transparent = True
  end
  object Label2: TLabel
    Left = 128
    Top = 23
    Width = 72
    Height = 13
    Caption = 'maximaler Preis'
    Transparent = True
  end
  object Label3: TLabel
    Left = 0
    Top = 0
    Width = 415
    Height = 16
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'BongoBon '
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnHighlight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label4: TLabel
    Left = 147
    Top = 66
    Width = 133
    Height = 13
    Caption = 'Tarife nach 2 tagen l'#246'schen'
    Transparent = True
    OnClick = Label4Click
  end
  object Status: TStatusBar
    Left = 2
    Top = 112
    Width = 412
    Height = 19
    Align = alNone
    Panels = <>
  end
  object Start: TButton
    Left = 8
    Top = 31
    Width = 97
    Height = 51
    Caption = 'Start'
    TabOrder = 0
    OnClick = StartClick
  end
  object ResetB: TButton
    Left = 8
    Top = 84
    Width = 97
    Height = 18
    Caption = 'Reset'
    TabOrder = 4
    TabStop = False
    OnClick = ResetBClick
  end
  object FlatButton1: TButton
    Left = 400
    Top = 0
    Width = 16
    Height = 16
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = False
    OnClick = FlatButton1Click
  end
  object FlatButton2: TButton
    Left = 383
    Top = 0
    Width = 16
    Height = 16
    Caption = '_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    TabStop = False
    OnClick = FlatButton2Click
  end
  object Progress: TProgressBar
    Left = 128
    Top = 86
    Width = 255
    Height = 16
    TabOrder = 6
  end
  object deleteit: TCheckBox
    Left = 128
    Top = 64
    Width = 16
    Height = 17
    TabOrder = 5
  end
  object Http: THttpCli
    URL = 'http://www.bongosoft.de/Preistabelle-bs.txt'
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
    Top = 80
  end
end
