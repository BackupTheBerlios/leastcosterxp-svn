object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsToolWindow
  Caption = 'settings'
  ClientHeight = 312
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Page: TPageControl
    Left = 0
    Top = 0
    Width = 335
    Height = 273
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'program'
      ImageIndex = 2
      object startHidden: TCheckBox
        Left = 8
        Top = 8
        Width = 97
        Height = 17
        Caption = 'start minimized'
        TabOrder = 0
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Traffic'
      object GroupBox2: TGroupBox
        Left = 0
        Top = 57
        Width = 327
        Height = 96
        Align = alTop
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
          Left = 31
          Top = 72
          Width = 105
          Height = 13
          Caption = 'during current month.'
        end
        object RadioGB: TRadioButton
          Left = 226
          Top = 48
          Width = 38
          Height = 17
          Caption = 'GB'
          Checked = True
          TabOrder = 3
          TabStop = True
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
        object Limit: TEdit
          Left = 104
          Top = 45
          Width = 70
          Height = 21
          TabOrder = 1
          Text = '1'
          OnKeyPress = PriceKeyPress
        end
        object RadioMB: TRadioButton
          Left = 184
          Top = 48
          Width = 41
          Height = 17
          Caption = 'MB'
          TabOrder = 2
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 153
        Width = 327
        Height = 89
        Align = alTop
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
            OnKeyPress = PriceKeyPress
          end
        end
        object GroupBox1: TGroupBox
          Left = 174
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
        Top = 0
        Width = 327
        Height = 57
        Align = alTop
        Caption = 'Network device'
        TabOrder = 2
        object NDev: TComboBox
          Left = 6
          Top = 24
          Width = 313
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = 'NDev'
        end
      end
    end
    object FritzBox: TTabSheet
      Caption = 'Fritz!Box Monitor'
      ImageIndex = 1
      object Label7: TLabel
        Left = 184
        Top = 8
        Width = 117
        Height = 78
        Caption = 
          'Before the first use you have to activate the monitoring service' +
          ' on your Fritz!Box by dialling the code : #96*5*.'
        WordWrap = True
      end
      object FBMon: TCheckBox
        Left = 16
        Top = 8
        Width = 145
        Height = 17
        Caption = 'use Fritz!Box Monitor'
        TabOrder = 0
      end
      object FBIP: TLabeledEdit
        Left = 16
        Top = 112
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
        Top = 112
        Width = 121
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Port'
        TabOrder = 2
        Text = '1012'
        OnKeyPress = FBPortKeyPress
      end
      object monout: TCheckBox
        Left = 16
        Top = 144
        Width = 153
        Height = 17
        Caption = 'monitor outgoing calls, too'
        TabOrder = 3
      end
      object revpath: TLabeledEdit
        Left = 16
        Top = 184
        Width = 289
        Height = 21
        EditLabel.Width = 224
        EditLabel.Height = 13
        EditLabel.Caption = 'reverse lookup (use %NUMBER% as identifier)'
        TabOrder = 4
      end
    end
  end
  object BtnCancel: TBitBtn
    Left = 112
    Top = 280
    Width = 97
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = BtnCancelClick
    Kind = bkCancel
  end
  object BtnSave: TBitBtn
    Left = 16
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 2
    OnClick = BtnSaveClick
    Kind = bkOK
  end
end
