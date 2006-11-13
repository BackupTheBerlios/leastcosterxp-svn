object wndlist: Twndlist
  Left = 353
  Top = 174
  BorderIcons = []
  BorderStyle = bsNone
  BorderWidth = 2
  Caption = 'wndlist'
  ClientHeight = 297
  ClientWidth = 352
  Color = clBtnFace
  DockSite = True
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
    Width = 352
    Height = 297
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    object Caption: TLabel
      Left = 6
      Top = 6
      Width = 336
      Height = 24
      Align = alTop
      Alignment = taCenter
      Caption = 'Import'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object NotImported_Label: TLabel
      Left = 6
      Top = 30
      Width = 336
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Achtung: Tarif'#252'berschneidung '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object ListBox: TListBox
      Left = 6
      Top = 43
      Width = 336
      Height = 193
      Align = alTop
      BevelKind = bkFlat
      ExtendedSelect = False
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
    end
    object Memo1: TMemo
      Left = 6
      Top = 258
      Width = 336
      Height = 10
      Align = alTop
      BevelKind = bkSoft
      Lines.Strings = (
        'M'
        'e'
        'm'
        'o'
        '1')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
      Visible = False
    end
    object Panel2: TPanel
      Left = 6
      Top = 251
      Width = 336
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object NotImported_OverWrite: TBitBtn
        Left = 9
        Top = 7
        Width = 155
        Height = 25
        Caption = 'Weiter'
        TabOrder = 1
        Visible = False
        OnClick = NotImported_OverWriteClick
        Kind = bkOK
      end
      object ok: TBitBtn
        Left = 10
        Top = 7
        Width = 155
        Height = 25
        TabOrder = 0
        OnClick = okClick
        Kind = bkOK
      end
      object sclose: TBitBtn
        Left = 170
        Top = 7
        Width = 155
        Height = 25
        TabOrder = 3
        Kind = bkClose
      end
      object Newimport: TBitBtn
        Left = 10
        Top = 7
        Width = 155
        Height = 25
        Caption = 'neuer Import'
        TabOrder = 2
        Visible = False
        OnClick = NewimportClick
        Kind = bkOK
      end
    end
    object Panel3: TPanel
      Left = 6
      Top = 236
      Width = 336
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object keine: TCheckBox
        Left = 113
        Top = 3
        Width = 105
        Height = 17
        Caption = 'keine ausw'#228'hlen'
        TabOrder = 0
        OnClick = keineClick
      end
      object alle: TCheckBox
        Left = 14
        Top = 3
        Width = 97
        Height = 17
        Caption = 'alle ausw'#228'hlen'
        TabOrder = 1
        OnClick = alleClick
      end
      object email: TCheckBox
        Left = 14
        Top = 22
        Width = 128
        Height = 15
        Caption = 'per eMail versenden'
        TabOrder = 2
      end
    end
    object Progress: TProgressBar
      Left = 96
      Top = 112
      Width = 150
      Height = 17
      TabOrder = 4
      Visible = False
    end
    object Progress2: TProgressBar
      Left = 96
      Top = 136
      Width = 150
      Height = 17
      TabOrder = 5
      Visible = False
    end
  end
  object Zip: TZipMaster
    AddOptions = []
    AddStoreSuffixes = [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR, assEXE, assJPG, assJPEG, ass7Zp, assMP3, assWMV, assWMA, assDVR, assAVI]
    Dll_Load = False
    ExtrOptions = []
    KeepFreeOnAllDisks = 0
    KeepFreeOnDisk1 = 0
    MaxVolumeSize = 0
    PasswordReqCount = 1
    SFXOptions = []
    SFXOverWriteMode = OvrConfirm
    SFXPath = 'DZSFXUS.bin'
    SpanOptions = []
    Trace = False
    Unattended = False
    Verbose = False
    Version = '1.79.04.01'
    VersionInfo = '1.79.04.01'
    Left = 240
    Top = 168
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'csv'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Left = 123
    Top = 496
  end
  object OpenDialog: TOpenDialog
    Left = 91
    Top = 496
  end
end
