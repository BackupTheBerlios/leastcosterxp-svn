object stats: Tstats
  Left = 0
  Top = 0
  Width = 424
  Height = 380
  BorderStyle = bsSizeToolWin
  Caption = 'statistics'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Page: TPageControl
    Left = 0
    Top = 0
    Width = 416
    Height = 354
    ActivePage = Totals
    Align = alClient
    TabOrder = 0
    object Totals: TTabSheet
      Caption = 'Totals'
      object Panel1: TPanel
        Left = 0
        Top = 129
        Width = 408
        Height = 129
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 208
          Top = 0
          Width = 200
          Height = 129
          Align = alRight
          Caption = 'totals'
          TabOrder = 0
          object Label10: TLabel
            Left = 8
            Top = 24
            Width = 33
            Height = 13
            Caption = 'Upload'
          end
          object Label11: TLabel
            Left = 8
            Top = 40
            Width = 47
            Height = 13
            Caption = 'Download'
          end
          object Label12: TLabel
            Left = 8
            Top = 56
            Width = 20
            Height = 13
            Caption = 'Sum'
          end
          object Label22: TLabel
            Left = 150
            Top = 22
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label13'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label23: TLabel
            Left = 150
            Top = 38
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label14'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label24: TLabel
            Left = 150
            Top = 55
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label15'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 0
          Width = 200
          Height = 129
          Align = alLeft
          Caption = 'this month'
          TabOrder = 1
          object Label7: TLabel
            Left = 8
            Top = 24
            Width = 33
            Height = 13
            Caption = 'Upload'
          end
          object Label8: TLabel
            Left = 8
            Top = 40
            Width = 47
            Height = 13
            Caption = 'Download'
          end
          object Label9: TLabel
            Left = 8
            Top = 56
            Width = 20
            Height = 13
            Caption = 'Sum'
          end
          object Label19: TLabel
            Left = 150
            Top = 22
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label13'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label20: TLabel
            Left = 150
            Top = 38
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label14'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label21: TLabel
            Left = 150
            Top = 55
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label15'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 408
        Height = 129
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object GroupBox3: TGroupBox
          Left = 208
          Top = 0
          Width = 200
          Height = 129
          Align = alRight
          Caption = 'this week'
          TabOrder = 0
          object Label4: TLabel
            Left = 8
            Top = 24
            Width = 33
            Height = 13
            Caption = 'Upload'
          end
          object Label5: TLabel
            Left = 8
            Top = 40
            Width = 47
            Height = 13
            Caption = 'Download'
          end
          object Label6: TLabel
            Left = 8
            Top = 56
            Width = 20
            Height = 13
            Caption = 'Sum'
          end
          object Label16: TLabel
            Left = 150
            Top = 22
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label13'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label17: TLabel
            Left = 150
            Top = 38
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label14'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label18: TLabel
            Left = 150
            Top = 55
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label15'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object GroupBox4: TGroupBox
          Left = 0
          Top = 0
          Width = 200
          Height = 129
          Align = alLeft
          Caption = 'Today'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label1: TLabel
            Left = 8
            Top = 24
            Width = 39
            Height = 13
            Caption = 'Upload'
          end
          object Label2: TLabel
            Left = 8
            Top = 40
            Width = 55
            Height = 13
            Caption = 'Download'
          end
          object Label3: TLabel
            Left = 8
            Top = 56
            Width = 25
            Height = 13
            Caption = 'Sum'
          end
          object Label13: TLabel
            Left = 150
            Top = 22
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label13'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label14: TLabel
            Left = 150
            Top = 38
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label14'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label15: TLabel
            Left = 150
            Top = 55
            Width = 44
            Height = 13
            Align = alCustom
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Label15'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
    object projected: TTabSheet
      Caption = 'Projected'
      ImageIndex = 1
    end
  end
end
