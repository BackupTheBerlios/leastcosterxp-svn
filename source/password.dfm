object PWForm: TPWForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'PWForm'
  ClientHeight = 319
  ClientWidth = 228
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 228
    Height = 259
    Align = alClient
  end
  object passlabel: TLabel
    Left = 16
    Top = 55
    Width = 44
    Height = 13
    Caption = 'Passwort'
  end
  object Label1: TLabel
    Left = 8
    Top = 121
    Width = 65
    Height = 13
    Caption = 'Bemerkungen'
  end
  object PWEdit: TEdit
    Left = 16
    Top = 69
    Width = 137
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object savePwd: TCheckBox
    Left = 16
    Top = 99
    Width = 201
    Height = 17
    Caption = 'Userdaten speichern'
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 24
    Top = 230
    Width = 51
    Height = 21
    Caption = 'Senden'
    Default = True
    TabOrder = 5
    OnClick = BitBtn1Click
    NumGlyphs = 2
  end
  object UsernameEdit: TLabeledEdit
    Left = 16
    Top = 26
    Width = 137
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Username'
    TabOrder = 0
  end
  object Memo: TMemo
    Left = 0
    Top = 141
    Width = 228
    Height = 76
    Align = alCustom
    TabOrder = 4
  end
  object noNews: TCheckBox
    Left = 96
    Top = 120
    Width = 97
    Height = 17
    Caption = 'Tarif l'#228'uft aus'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object closeBtn: TBitBtn
    Left = 144
    Top = 231
    Width = 51
    Height = 21
    Caption = 'Schlie'#223'en'
    Default = True
    TabOrder = 6
    OnClick = closeBtnClick
    NumGlyphs = 2
  end
  object Memo1: TMemo
    Left = 0
    Top = 259
    Width = 228
    Height = 60
    Align = alBottom
    TabOrder = 7
  end
end
