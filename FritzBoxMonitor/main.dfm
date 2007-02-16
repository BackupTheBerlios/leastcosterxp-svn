object Form1: TForm1
  Left = 0
  Top = 0
  Width = 424
  Height = 647
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Simple Fritz!Box Monitor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 275
    Width = 416
    Height = 15
    Align = alTop
    Caption = '> Open the settings panel here <'
    TabOrder = 0
    OnClick = Panel2Click
  end
  object Panel3: TPanel
    Left = 0
    Top = 292
    Width = 416
    Height = 321
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object BtnSave: TBitBtn
      Left = 16
      Top = 288
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 0
      OnClick = BtnSaveClick
      Kind = bkOK
    end
    object BtnCancel: TBitBtn
      Left = 112
      Top = 288
      Width = 97
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = BtnCancelClick
      Kind = bkCancel
    end
    object Page: TPageControl
      Left = 0
      Top = 0
      Width = 416
      Height = 281
      ActivePage = FritzBox
      Align = alTop
      Style = tsFlatButtons
      TabOrder = 2
      object TabSheet1: TTabSheet
        Caption = 'Traffic'
        object GroupBox2: TGroupBox
          Left = 0
          Top = 56
          Width = 408
          Height = 105
          Align = alBottom
          Caption = 'Traffic Volume'
          TabOrder = 0
          object Label3: TLabel
            Left = 32
            Top = 20
            Width = 52
            Height = 13
            Caption = 'Alert when'
          end
          object Label4: TLabel
            Left = 32
            Top = 48
            Width = 46
            Height = 13
            Caption = 'reach(es)'
          end
          object Label5: TLabel
            Left = 32
            Top = 76
            Width = 68
            Height = 13
            Caption = 'during current'
          end
          object ULDLSelect: TComboBox
            Left = 104
            Top = 16
            Width = 185
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = 'Upload + Download'
            Items.Strings = (
              'Upload + Download'
              'Download'
              'Upload')
          end
          object MoWeSelect: TComboBox
            Left = 104
            Top = 72
            Width = 185
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 2
            TabOrder = 1
            Text = 'Month'
            Items.Strings = (
              'Day'
              'Week'
              'Month')
          end
          object Limit: TEdit
            Left = 104
            Top = 45
            Width = 70
            Height = 21
            TabOrder = 2
          end
          object RadioMB: TRadioButton
            Left = 184
            Top = 48
            Width = 41
            Height = 17
            Caption = 'MB'
            TabOrder = 3
          end
          object RadioGB: TRadioButton
            Left = 232
            Top = 48
            Width = 57
            Height = 17
            Caption = 'GB'
            Checked = True
            TabOrder = 4
            TabStop = True
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 161
          Width = 408
          Height = 89
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object GroupBox3: TGroupBox
            Left = 0
            Top = 0
            Width = 168
            Height = 89
            Align = alLeft
            Caption = 'Prices'
            TabOrder = 0
            object Label6: TLabel
              Left = 16
              Top = 24
              Width = 45
              Height = 13
              Caption = 'Price per '
            end
            object PriceMB: TRadioButton
              Left = 64
              Top = 24
              Width = 41
              Height = 17
              Caption = 'MB'
              TabOrder = 0
            end
            object PriceGB: TRadioButton
              Left = 104
              Top = 24
              Width = 41
              Height = 17
              Caption = 'GB'
              Checked = True
              TabOrder = 1
              TabStop = True
            end
            object Price: TEdit
              Left = 40
              Top = 46
              Width = 65
              Height = 21
              TabOrder = 2
            end
          end
          object GroupBox1: TGroupBox
            Left = 255
            Top = 0
            Width = 153
            Height = 89
            Align = alRight
            Caption = 'Period settings'
            TabOrder = 1
            object Label1: TLabel
              Left = 8
              Top = 21
              Width = 117
              Height = 13
              Caption = 'Monthly period starts on'
            end
            object Label2: TLabel
              Left = 48
              Top = 68
              Width = 87
              Height = 13
              Caption = 'day of the month.'
            end
            object Period: TComboBox
              Left = 48
              Top = 40
              Width = 57
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 0
              TabOrder = 0
              Text = '1st'
              Items.Strings = (
                '1st'
                '2nd'
                '3rd'
                '4th'
                '5th'
                '6th'
                '7th'
                '8th'
                '9th'
                '10th'
                '11th'
                '12th'
                '13th'
                '15th'
                '15th'
                '17th'
                '18th'
                '19th'
                '20th'
                '21st'
                '22nd'
                '23rd'
                '24th'
                '25th'
                '26th'
                '27th'
                '28th'
                '29th'
                '30th'
                '31st')
            end
          end
        end
        object GroupBox4: TGroupBox
          Left = 0
          Top = -1
          Width = 408
          Height = 57
          Align = alBottom
          Caption = 'Network device'
          TabOrder = 2
          object Device: TComboBox
            Left = 8
            Top = 23
            Width = 313
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnCloseUp = DeviceCloseUp
          end
        end
      end
      object FritzBox: TTabSheet
        Caption = 'Fritz!Box Monitor'
        ImageIndex = 1
        object Label7: TLabel
          Left = 16
          Top = 96
          Width = 263
          Height = 26
          Caption = 
            'Before the first use you have to activate the Monitor service on' +
            ' your Fritz!Box by dialling the code : #96*5*'
          WordWrap = True
        end
        object FBMon: TCheckBox
          Left = 16
          Top = 8
          Width = 145
          Height = 17
          Caption = 'Use Fritz!Box Monitor'
          TabOrder = 0
        end
        object FBIP: TLabeledEdit
          Left = 16
          Top = 48
          Width = 153
          Height = 21
          EditLabel.Width = 94
          EditLabel.Height = 13
          EditLabel.Caption = 'IP of your Fritz!Box'
          TabOrder = 1
          Text = '192.168.178.1'
        end
        object FBPort: TLabeledEdit
          Left = 184
          Top = 48
          Width = 121
          Height = 21
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Port'
          TabOrder = 2
          Text = '1012'
        end
        object Memo1: TMemo
          Left = 16
          Top = 144
          Width = 185
          Height = 89
          Lines.Strings = (
            'Memo1')
          TabOrder = 3
        end
        object Button1: TButton
          Left = 304
          Top = 128
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 4
          OnClick = Button1Click
        end
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 416
    Height = 275
    ActivePage = TabSheet2
    Align = alTop
    PopupMenu = PopupMenu1
    TabOrder = 2
    OnChange = PageControl1Change
    object TabSheet2: TTabSheet
      Caption = 'Traffic'
      object Label8: TLabel
        Left = 64
        Top = 8
        Width = 47
        Height = 13
        Caption = 'Download'
      end
      object Label9: TLabel
        Left = 192
        Top = 7
        Width = 33
        Height = 13
        Caption = 'Upload'
      end
      object LimitLabel: TLabel
        Left = 64
        Top = 80
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 64
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object Edit2: TEdit
        Left = 192
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'Edit2'
      end
      object Edit3: TEdit
        Left = 64
        Top = 56
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'Edit3'
      end
      object Edit4: TEdit
        Left = 192
        Top = 56
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'Edit4'
      end
      object viewstats: TBitBtn
        Left = 240
        Top = 96
        Width = 75
        Height = 25
        Caption = 'view stats'
        TabOrder = 4
        OnClick = viewstatsClick
        NumGlyphs = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'List of calls'
      ImageIndex = 1
      object CallerList: TListView
        Left = 0
        Top = 0
        Width = 408
        Height = 247
        Align = alClient
        Anchors = [akLeft, akTop, akRight]
        Checkboxes = True
        Columns = <
          item
            AutoSize = True
            Caption = 'type'
          end
          item
            AutoSize = True
            Caption = 'date/time'
          end
          item
            AutoSize = True
            Caption = 'name'
          end
          item
            AutoSize = True
            Caption = 'number'
          end
          item
            AutoSize = True
            Caption = 'phone'
          end
          item
            AutoSize = True
            Caption = 'own number'
          end
          item
            AutoSize = True
            Caption = 'duration'
          end>
        FlatScrollBars = True
        GridLines = True
        HotTrack = True
        HotTrackStyles = [htUnderlineCold]
        RowSelect = True
        PopupMenu = PopupMenu1
        ShowWorkAreas = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Phonebook'
      ImageIndex = 2
      object PhoneBookList: TListView
        Left = 0
        Top = 0
        Width = 408
        Height = 247
        Align = alClient
        Anchors = [akLeft, akTop, akRight]
        Checkboxes = True
        Columns = <
          item
            AutoSize = True
            Caption = 'name'
          end
          item
            AutoSize = True
            Caption = 'number'
          end
          item
            AutoSize = True
            Caption = 'short dial'
          end>
        FlatScrollBars = True
        GridLines = True
        HotTrack = True
        HotTrackStyles = [htUnderlineCold]
        RowSelect = True
        PopupMenu = PopupMenu2
        ShowWorkAreas = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 344
    Top = 320
  end
  object Tray: TCoolTrayIcon
    CycleInterval = 0
    Icon.Data = {
      0000010001002020040000000000E80200001600000028000000200000004000
      0000010004000000000000020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006444
      4444444444444444444444444400666666666666666666666666666666007FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF8006FFFFFFFFFFFFFFFFFFFFFFFFFFFF8006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF8006FFFFFFFFFFFFFFFFFFFFFFFFFFFF8006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF8006FFFFFFFFFFFFFFFFFFFFFFFFFFFF8006888
      8888888888888888888888888600666666666666666666666664666666006666
      666666666666666666867E697600668EEEEEEEEEEEEEEEE66EE6EE6766006666
      6666666666666666666666666600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FFFFFFFFFFFF8000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001FFFFFFFFFFFFFFFFFFFFFFFF}
    IconVisible = True
    IconIndex = 0
    MinimizeToTray = True
    OnMouseDown = TrayMouseDown
    Left = 344
    Top = 352
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 328
    Top = 184
    object reloadCallerList: TMenuItem
      Caption = 'retrieve list of calls'
      OnClick = reloadCallerListClick
    end
    object searchNumber: TMenuItem
      Caption = 'reverse Lookup'
      OnClick = searchNumberClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 256
    Top = 208
    object ReloadPhonebook: TMenuItem
      Caption = 'retrieve phonebook'
      OnClick = ReloadPhonebookClick
    end
    object Eintraglschen1: TMenuItem
      Caption = 'Eintrag l'#246'schen'
      OnClick = Eintraglschen1Click
    end
    object TMenuItem
    end
  end
end
