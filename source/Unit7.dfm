object PriceWarning: TPriceWarning
  Left = 313
  Top = 245
  BorderStyle = bsNone
  Caption = 'Achtung !'
  ClientHeight = 244
  ClientWidth = 525
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 525
    Height = 244
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
    object info2: TLabel
      Left = 6
      Top = 22
      Width = 500
      Height = 16
      Align = alTop
      Alignment = taCenter
      Constraints.MaxHeight = 60
      Constraints.MaxWidth = 500
      Constraints.MinHeight = 16
      Constraints.MinWidth = 500
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object neu2: TLabel
      Left = 6
      Top = 148
      Width = 500
      Height = 20
      Align = alTop
      Alignment = taCenter
      Caption = 'IchbineinTarif f'#252'r 0,02ct/min (Einwahl 10ct)'
      Constraints.MaxHeight = 60
      Constraints.MaxWidth = 500
      Constraints.MinHeight = 20
      Constraints.MinWidth = 500
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object neu1: TLabel
      Left = 6
      Top = 128
      Width = 509
      Height = 20
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Von 16:00:00 bis 18:00:00 steht Ihnen der Tarif'
      Constraints.MaxHeight = 60
      Constraints.MinHeight = 20
      Constraints.MinWidth = 400
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object info1: TLabel
      Left = 6
      Top = 6
      Width = 509
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Sie sind zur Zeit verbunden mit dem Tarif'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object info3: TLabel
      Left = 6
      Top = 38
      Width = 509
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Dieser gilt von 00:00:00 bis 12:00:00 Uhr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 118
      Width = 509
      Height = 10
      Align = alTop
      Constraints.MaxHeight = 10
      Constraints.MinHeight = 10
    end
    object neu3: TLabel
      Left = 6
      Top = 168
      Width = 509
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'zur Verf'#252'gung !'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object info4: TLabel
      Left = 6
      Top = 54
      Width = 509
      Height = 24
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Der Preis ab 12:00:00 Uhr betr'#228'gt  0,5ct/min.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object close: TBitBtn
      Left = 392
      Top = 200
      Width = 120
      Height = 25
      TabOrder = 0
      Kind = bkClose
    end
    object trennen: TBitBtn
      Left = 8
      Top = 200
      Width = 180
      Height = 25
      Cancel = True
      Caption = 'Jetzt trennen'
      ModalResult = 7
      TabOrder = 1
      OnClick = trennenClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333FFFFF333333000033333388888833333333333F888888FFF333
        000033338811111188333333338833FFF388FF33000033381119999111833333
        38F338888F338FF30000339119933331111833338F388333383338F300003391
        13333381111833338F8F3333833F38F3000039118333381119118338F38F3338
        33F8F38F000039183333811193918338F8F333833F838F8F0000391833381119
        33918338F8F33833F8338F8F000039183381119333918338F8F3833F83338F8F
        000039183811193333918338F8F833F83333838F000039118111933339118338
        F3833F83333833830000339111193333391833338F33F8333FF838F300003391
        11833338111833338F338FFFF883F83300003339111888811183333338FF3888
        83FF83330000333399111111993333333388FFFFFF8833330000333333999999
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object trennen2: TBitBtn
      Left = 200
      Top = 200
      Width = 179
      Height = 25
      Cancel = True
      Caption = 'Um ... trennen'
      ModalResult = 7
      TabOrder = 2
      OnClick = trennen2Click
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF808080808080000080000080000080000080808080C0C0
        C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF8080800000
        FF0000FF0000FF0000FF0000FF0000FF0000FF000080000080808080C0C0C0FF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFF0000FF0000FF000080808080C0C0C0C0
        C0C0FFFFFFC0C0C0C0C0C00000FF0000FF000080000080C0C0C0FFFFFFFFFFFF
        0000FFFFFF0000FF0000FF000080C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0C00000FF000080000080C0C0C0FFFFFF00008080800000FF
        000080FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFF
        FFC0C0C00000FF000080808080C0C0C000000000FF000080C0C0C0FFFFFF0000
        00C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C0C0C0C0C0C000
        00FF000080C0C0C000000000FF000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000FF000080808080
        0000000080C0C0C0FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000FF0000800000000080C0C0C0
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8080808080808080808080
        80808080808080C0C0C00000FF0000800000000080FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFC0
        C0C00000FF0000800000000080C0C0C0FFFFFF000000FFFFFFFFFFFFFFFFFF00
        0000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000FF000080
        0000000080C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF000000808080FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C00000FF00008000000000FF000080
        FFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFC0C0C00000FF00008080808000000000FF000080C0C0C0FFFFFF0000
        00C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFC0C0C000
        00FF000080FFFFFF00008080800000FF000080FFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFF000000FFFFFFFFFFFFC0C0C00000FF000080808080FFFFFF
        00008080800000FF0000FF000080C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0C0000080000080000080FFFFFFFFFFFF0000000000FFFFFF
        0000FF0000FF000080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FF0000
        FF000080000080FFFFFFFFFFFFFFFFFF00008080800000008080808080800000
        FF0000FF0000FF0000FF0000FF0000FF0000FF000080000080808080FFFFFFFF
        FFFFFFFFFFFFFFFF0000}
    end
    object time: TStaticText
      Left = 488
      Top = 7
      Width = 20
      Height = 20
      Alignment = taCenter
      BevelInner = bvLowered
      BevelKind = bkFlat
      BevelOuter = bvSpace
      BorderStyle = sbsSunken
      Caption = '59'
      TabOrder = 3
    end
    object Panel2: TPanel
      Left = 6
      Top = 78
      Width = 509
      Height = 40
      Align = alTop
      BevelEdges = [beTop, beBottom]
      BevelKind = bkFlat
      BevelOuter = bvNone
      Caption = 'Es folgt ein Tarifwechsel-Info :'
      TabOrder = 4
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 89
        Height = 36
        Align = alLeft
        Center = True
        Picture.Data = {
          0A544A504547496D616765D2030000FFD8FFE000104A46494600010101000000
          000000FFDB00430006040506050406060506070706080A100A0A09090A140E0F
          0C1017141818171416161A1D251F1A1B231C1616202C20232627292A29191F2D
          302D283025282928FFDB0043010707070A080A130A0A13281A161A2828282828
          2828282828282828282828282828282828282828282828282828282828282828
          28282828282828282828282828FFC00011080020002003012200021101031101
          FFC40017000101010100000000000000000000000007060508FFC4002C100002
          0104010303030305000000000000010203040511120613213100072214152308
          325116254161F0FFC40018010002030000000000000000000000000004050203
          06FFC40026110002010204050500000000000000000001021103040005127121
          415191B113146181F1FFDA000C03010002110311003F00E57890CB2A46A54331
          0A0B3051DFF927B01FECFA60E21EC5D65F90A4F7EA3A6AA6D99228A26986A01C
          16390572C31E3B0EE4F740F1FED85A52E7749DFEDF595F3D374DE38E8E555950
          97003856EC70DA8C9C80594156CF670E4370BE5A78FD15AE3B8422DAE58FF6F8
          E6A78C0D46B1624CB6A2365C61F520AE5411B3E7738BFAC8DE85AB857D81F3FA
          761386197597BCAEB4663575C4972FFD3FAD928A536FE4FF005F5D18D9A27A11
          0449E09DA4EAB1070460053DD901C6EB913B9D1496EB85451CED1B4B0B94631B
          065247F07FE23C1C1F5D0DC92E7C8AED1D65B578AC5749244491EAA7A976A669
          9BE6A862288A652662CB1AF8DD1865439709E5D4376A2BC1FBF50B50D4CD1A4B
          1C7D3D10C58C214C762985C0233E3CE41F52C96EEE6A92974EA4F28D33BC0270
          2D645530B840E11638E1B5504D70B6DD2AAD75134551BC34C95B4CDF07DBA8A3
          E6AAA6270CC8A1B1D41926352D6BC845A655E8C9537D59646DFA5582E118C069
          031FCCE46D991876C90DD4C118D9CC3DABE516BE372CE6B1A6A4AD9A4454AC58
          DA48D53F701205757081D518E9962324774506B39172CB35C42BC5C9ED794450
          3169AC0F818017E52B0FDA57FCE018C81DB05C1BBA1706E981D51D40307B2B79
          1F582EC1E8A5546AA4851CC448EFF384BB1DBE5ABB4710A49E5711D5C3124E26
          72D27525486A6794BC84FE479276F183D82F7CE3D637BFB67A24E013509498BD
          80A3D1995A332431BC8B0F4CE991D32AAAE010B80F18254A847C1E13EEE5AE96
          B26B6722A886A697A5D3A7B8BD2388E35D55590A21EA0DA251107018A140C770
          EC04A7BABEE37F50DBD2DF4955F58B22209A775D8EABA90819E35607650C71E0
          EC033ECCCCAACF2CBE198532548553AA78C193278ED208307BF1A9DD349D38FF
          D9}
        Proportional = True
        Stretch = True
      end
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnDeactivate = ApplicationEventsDeactivate
    Left = 480
    Top = 32
  end
  object Timer1: TTimer
    Tag = 59
    Enabled = False
    OnTimer = Timer1Timer
    Left = 424
    Top = 32
  end
end
