object ClientView: TClientView
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Client'
  ClientHeight = 376
  ClientWidth = 875
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gInventory: TGroupBox
    Left = 95
    Top = 51
    Width = 269
    Height = 274
    Caption = ' Inventory '
    TabOrder = 5
  end
  object gEquip: TGroupBox
    Left = 8
    Top = 51
    Width = 77
    Height = 274
    Caption = ' Equip '
    TabOrder = 4
  end
  object gCargo: TGroupBox
    Left = 373
    Top = 51
    Width = 493
    Height = 274
    Caption = ' Cargo '
    TabOrder = 6
  end
  object eCharGold: TLabeledEdit
    Left = 95
    Top = 345
    Width = 121
    Height = 21
    EditLabel.Width = 21
    EditLabel.Height = 13
    EditLabel.Caption = 'Gold'
    ReadOnly = True
    TabOrder = 7
  end
  object eCargoGold: TLabeledEdit
    Left = 373
    Top = 345
    Width = 121
    Height = 21
    EditLabel.Width = 21
    EditLabel.Height = 13
    EditLabel.Caption = 'Gold'
    ReadOnly = True
    TabOrder = 9
  end
  object eID: TLabeledEdit
    Left = 8
    Top = 24
    Width = 75
    Height = 21
    EditLabel.Width = 11
    EditLabel.Height = 13
    EditLabel.Caption = 'ID'
    ReadOnly = True
    TabOrder = 0
  end
  object ePos: TLabeledEdit
    Left = 95
    Top = 24
    Width = 106
    Height = 21
    EditLabel.Width = 17
    EditLabel.Height = 13
    EditLabel.Caption = 'Pos'
    ReadOnly = True
    TabOrder = 1
  end
  object eSpeed: TLabeledEdit
    Left = 207
    Top = 24
    Width = 43
    Height = 21
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Speed'
    ReadOnly = True
    TabOrder = 2
  end
  object eHP: TLabeledEdit
    Left = 256
    Top = 24
    Width = 99
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'HP'
    ReadOnly = True
    TabOrder = 3
  end
  object eBolsas: TLabeledEdit
    Left = 225
    Top = 345
    Width = 139
    Height = 21
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Bolsas'
    ReadOnly = True
    TabOrder = 8
  end
  object MainLoop: TTimer
    Interval = 1
    OnTimer = MainLoopTimer
    Left = 448
    Top = 8
  end
end
