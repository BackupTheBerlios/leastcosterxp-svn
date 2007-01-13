object Ctrlnfo: TCtrlnfo
  Left = 244
  Top = 213
  BorderStyle = bsNone
  Caption = 'Ctrlnfo'
  ClientHeight = 407
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 246
    Height = 407
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 0
    object Caption: TLabel
      Left = 4
      Top = 4
      Width = 99
      Height = 24
      Align = alTop
      Alignment = taCenter
      Caption = 'Shortcuts'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object ValueListEditor1: TValueListEditor
      Left = 4
      Top = 28
      Width = 238
      Height = 345
      TabStop = False
      Align = alTop
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
      Strings.Strings = (
        '[ Ctrl - B ]='#214'ffne Browser'
        '[ Ctrl - E ]=Export'
        '[ Ctrl - F ]=Fernbedienung testen'
        '[ Ctrl - I ]=Import (Oleco/DS)'
        '[ Ctrl - K ]=Monatskalender'
        '[ Ctrl - L ]=Lade Tarife ...'
        '[ Ctrl - M ]=ins Tray minimieren'
        '[ Ctrl - S ]=Speichere Tarife ...'
        '[ Ctrl - T ]=Tarifmanager'
        '[ Ctrl - P ]=Einstellungen'
        '[ Ctrl - V ]=Einzelverbindungs'#252'bersicht'
        '[ Ctrl - X ]=LeastCosterXP beenden'
        '[ Ctrl - Del ]=abgelaufene Tarife l'#246'schen'
        'F1=Hilfe'
        'F2=Beitrag posten (Mailingliste)'
        'F5=Online-Programme starten'
        'F6=Offline-Programme starten')
      TabOrder = 0
      TitleCaptions.Strings = (
        'ShortCut'
        'Funktion')
      ColWidths = (
        75
        157)
    end
    object Butclose: TBitBtn
      Left = 74
      Top = 377
      Width = 97
      Height = 24
      TabOrder = 1
      TabStop = False
      Kind = bkClose
    end
  end
end
