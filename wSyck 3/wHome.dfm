object Syck: TSyck
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Syck'
  ClientHeight = 389
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TTabbedNotebook
    Left = 0
    Top = 0
    Width = 398
    Height = 370
    Align = alClient
    PageIndex = 3
    TabFont.Charset = DEFAULT_CHARSET
    TabFont.Color = clBtnText
    TabFont.Height = -11
    TabFont.Name = 'Tahoma'
    TabFont.Style = []
    TabOrder = 0
    ExplicitHeight = 343
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Hacks'
      ExplicitHeight = 315
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 390
        Height = 342
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 315
        object GroupBox1: TGroupBox
          Left = 7
          Top = 16
          Width = 162
          Height = 225
          Caption = ' OP'#199#213'ES '
          TabOrder = 0
          object Button1: TButton
            Left = 16
            Top = 20
            Width = 130
            Height = 25
            Caption = 'OPEN CARGO'
            TabOrder = 0
            OnClick = Button1Click
          end
          object Button5: TButton
            Left = 16
            Top = 51
            Width = 94
            Height = 25
            Caption = 'SEC ON'
            TabOrder = 1
            OnClick = Button5Click
          end
          object Button6: TButton
            Left = 116
            Top = 51
            Width = 30
            Height = 25
            Caption = 'OFF'
            TabOrder = 2
            OnClick = Button6Click
          end
          object Button4: TButton
            Left = 15
            Top = 82
            Width = 95
            Height = 25
            Caption = 'INV ON'
            TabOrder = 3
            OnClick = Button4Click
          end
          object Button7: TButton
            Left = 116
            Top = 82
            Width = 30
            Height = 25
            Caption = 'OFF'
            TabOrder = 4
            OnClick = Button7Click
          end
          object Button9: TButton
            Left = 14
            Top = 147
            Width = 132
            Height = 25
            Caption = 'REVIVE'
            TabOrder = 5
            OnClick = Button9Click
          end
          object Button13: TButton
            Left = 16
            Top = 113
            Width = 94
            Height = 25
            Caption = 'ONEHIT ON'
            TabOrder = 6
            OnClick = Button13Click
          end
          object Button14: TButton
            Left = 117
            Top = 113
            Width = 30
            Height = 25
            Caption = 'OFF'
            TabOrder = 7
            OnClick = Button14Click
          end
          object Button17: TButton
            Left = 14
            Top = 178
            Width = 132
            Height = 25
            Caption = 'MEUS DADOS'
            TabOrder = 8
            OnClick = Button17Click
          end
        end
        object GroupBox3: TGroupBox
          Left = 175
          Top = 18
          Width = 202
          Height = 108
          Caption = ' PULAR '
          TabOrder = 1
          object PX: TLabeledEdit
            Left = 16
            Top = 35
            Width = 97
            Height = 21
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = 'X'
            TabOrder = 0
          end
          object PY: TLabeledEdit
            Left = 15
            Top = 74
            Width = 98
            Height = 21
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = 'Y'
            TabOrder = 1
          end
          object Button2: TButton
            Left = 119
            Top = 32
            Width = 66
            Height = 27
            Caption = 'OK'
            TabOrder = 2
            OnClick = Button2Click
          end
          object Button16: TButton
            Left = 119
            Top = 65
            Width = 66
            Height = 25
            Caption = 'Minha Pos'
            TabOrder = 3
            OnClick = Button16Click
          end
        end
        object GroupBox4: TGroupBox
          Left = 8
          Top = 247
          Width = 369
          Height = 59
          Caption = ' ATALHOS '
          TabOrder = 2
          object Button3: TButton
            Left = 310
            Top = 24
            Width = 39
            Height = 25
            Caption = 'OK'
            TabOrder = 1
            OnClick = Button3Click
          end
          object LinkMap: TComboBoxEx
            Left = 16
            Top = 24
            Width = 281
            Height = 22
            ItemsEx = <>
            TabOrder = 0
          end
        end
        object GroupBox2: TGroupBox
          Left = 175
          Top = 132
          Width = 202
          Height = 109
          Caption = ' GRUPO '
          TabOrder = 3
          object Button15: TButton
            Left = 16
            Top = 57
            Width = 169
            Height = 32
            Caption = 'OK'
            TabOrder = 0
            OnClick = Button15Click
          end
          object PNick: TLabeledEdit
            Left = 15
            Top = 30
            Width = 170
            Height = 21
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'Nick'
            TabOrder = 1
          end
        end
        object MoveChar: TCheckBox
          Left = 8
          Top = 319
          Width = 169
          Height = 17
          Caption = 'MoveChar no Moved?'
          TabOrder = 4
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Evento'
      ExplicitHeight = 315
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 390
        Height = 342
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 315
        object PStart: TButton
          Left = 8
          Top = 12
          Width = 109
          Height = 25
          Caption = 'Iniciar'
          TabOrder = 0
          OnClick = PStartClick
        end
        object PStop: TButton
          Left = 130
          Top = 12
          Width = 111
          Height = 25
          Caption = 'Parar'
          TabOrder = 1
          OnClick = PStopClick
        end
        object NPC1ID: TLabeledEdit
          Left = 7
          Top = 67
          Width = 110
          Height = 21
          EditLabel.Width = 97
          EditLabel.Height = 13
          EditLabel.Caption = 'NPC Index (Galford)'
          TabOrder = 2
          Text = '1072'
        end
        object NPC1X: TLabeledEdit
          Left = 8
          Top = 105
          Width = 110
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'NPC Pos X'
          TabOrder = 3
          Text = '2070'
        end
        object NPC1Y: TLabeledEdit
          Left = 8
          Top = 145
          Width = 110
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'NPC Pos Y'
          TabOrder = 4
          Text = '2098'
        end
        object NPC2ID: TLabeledEdit
          Left = 130
          Top = 67
          Width = 110
          Height = 21
          EditLabel.Width = 103
          EditLabel.Height = 13
          EditLabel.Caption = 'NPC Index (Evento I)'
          TabOrder = 5
          Text = '1021'
        end
        object NPC2X: TLabeledEdit
          Left = 130
          Top = 105
          Width = 110
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'NPC Pos X'
          TabOrder = 6
          Text = '2540'
        end
        object NPC2Y: TLabeledEdit
          Left = 130
          Top = 145
          Width = 110
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'NPC Pos Y'
          TabOrder = 7
          Text = '3894'
        end
        object Guardar: TLabeledEdit
          Left = 246
          Top = 67
          Width = 131
          Height = 21
          EditLabel.Width = 39
          EditLabel.Height = 13
          EditLabel.Caption = 'Guardar'
          TabOrder = 8
          Text = '3330'
        end
        object Agrupar: TLabeledEdit
          Left = 246
          Top = 105
          Width = 131
          Height = 21
          EditLabel.Width = 39
          EditLabel.Height = 13
          EditLabel.Caption = 'Agrupar'
          TabOrder = 9
          Text = '412, 413'
        end
        object Apagar: TLabeledEdit
          Left = 246
          Top = 145
          Width = 131
          Height = 21
          EditLabel.Width = 35
          EditLabel.Height = 13
          EditLabel.Caption = 'Apagar'
          TabOrder = 10
          Text = '3314, 4054, 412'
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'ChangeNumeric'
      ExplicitHeight = 315
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 390
        Height = 342
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 315
        object PNum1: TLabeledEdit
          Left = 146
          Top = 21
          Width = 121
          Height = 21
          EditLabel.Width = 50
          EditLabel.Height = 13
          EditLabel.Caption = 'Iniciar em:'
          TabOrder = 0
          Text = '0'
        end
        object PNum2: TLabeledEdit
          Left = 146
          Top = 59
          Width = 121
          Height = 21
          EditLabel.Width = 63
          EditLabel.Height = 13
          EditLabel.Caption = 'Terminar em:'
          TabOrder = 1
          Text = '9999'
        end
        object PNumNew: TLabeledEdit
          Left = 273
          Top = 59
          Width = 103
          Height = 21
          EditLabel.Width = 54
          EditLabel.Height = 13
          EditLabel.Caption = 'Trocar Por:'
          TabOrder = 2
          Text = '1234'
        end
        object PNumSize: TLabeledEdit
          Left = 273
          Top = 21
          Width = 103
          Height = 21
          EditLabel.Width = 60
          EditLabel.Height = 13
          EditLabel.Caption = 'Num Digitos:'
          TabOrder = 3
          Text = '4'
        end
        object Button8: TButton
          Left = 2
          Top = 19
          Width = 138
          Height = 25
          Caption = 'Iniciar'
          TabOrder = 4
          OnClick = Button8Click
        end
        object Button10: TButton
          Left = 2
          Top = 53
          Width = 138
          Height = 25
          Caption = 'Pausar'
          TabOrder = 5
          OnClick = Button10Click
        end
        object PNumVisor: TLabeledEdit
          Left = 0
          Top = 98
          Width = 377
          Height = 21
          EditLabel.Width = 111
          EditLabel.Height = 13
          EditLabel.Caption = 'Ultima Senha Testada: '
          TabOrder = 6
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Fun'#231#245'es'
      ExplicitHeight = 315
      object InputA: TLabeledEdit
        Left = 1
        Top = 271
        Width = 384
        Height = 21
        EditLabel.Width = 43
        EditLabel.Height = 13
        EditLabel.Caption = 'Input #1'
        TabOrder = 3
      end
      object InputB: TLabeledEdit
        Left = 2
        Top = 312
        Width = 383
        Height = 21
        EditLabel.Width = 43
        EditLabel.Height = 13
        EditLabel.Caption = 'Input #2'
        TabOrder = 4
      end
      object b1: TButton
        Left = 2
        Top = 5
        Width = 112
        Height = 25
        Caption = 'Agrupar'
        TabOrder = 0
        OnClick = b1Click
      end
      object b3: TButton
        Left = 127
        Top = 36
        Width = 132
        Height = 25
        Caption = 'Vender'
        TabOrder = 2
        OnClick = b3Click
      end
      object b2: TButton
        Left = 2
        Top = 36
        Width = 111
        Height = 25
        Caption = 'Desagrupar'
        TabOrder = 1
        OnClick = b2Click
      end
      object b4: TButton
        Left = 127
        Top = 5
        Width = 132
        Height = 25
        Caption = 'Comprar'
        TabOrder = 5
        OnClick = b4Click
      end
      object b5: TButton
        Left = 273
        Top = 36
        Width = 113
        Height = 25
        Caption = 'Apagar'
        TabOrder = 6
        OnClick = b5Click
      end
      object b6: TButton
        Left = 273
        Top = 5
        Width = 113
        Height = 25
        Caption = 'Click NPC'
        TabOrder = 7
        OnClick = b6Click
      end
      object b7: TButton
        Left = 2
        Top = 67
        Width = 113
        Height = 25
        Caption = 'Refinar Item'
        TabOrder = 8
      end
      object b8: TButton
        Left = 129
        Top = 67
        Width = 130
        Height = 25
        Caption = 'Ver Item #0'
        TabOrder = 9
        OnClick = b8Click
      end
      object Button11: TButton
        Left = 273
        Top = 67
        Width = 113
        Height = 25
        Caption = 'Apagar Inventario'
        TabOrder = 10
        OnClick = Button11Click
      end
      object Button12: TButton
        Left = 2
        Top = 98
        Width = 112
        Height = 25
        Caption = 'Player Index'
        TabOrder = 11
        OnClick = Button12Click
      end
      object Button18: TButton
        Left = 130
        Top = 98
        Width = 129
        Height = 25
        Caption = 'Chat'
        TabOrder = 12
        OnClick = Button18Click
      end
      object Button19: TButton
        Left = 273
        Top = 98
        Width = 112
        Height = 25
        Caption = 'Chat All'
        TabOrder = 13
        OnClick = Button19Click
      end
    end
  end
  object Status: TStatusBar
    Left = 0
    Top = 370
    Width = 398
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    ExplicitTop = 343
  end
  object HotKeys: TTimer
    Interval = 1
    OnTimer = HotKeysTimer
    Left = 464
    Top = 88
  end
  object Hacks: TTimer
    Enabled = False
    Interval = 1
    OnTimer = HacksTimer
    Left = 456
    Top = 200
  end
  object Event: TTimer
    Enabled = False
    Interval = 1
    OnTimer = EventTimer
    Left = 472
    Top = 40
  end
  object Numeric: TTimer
    Enabled = False
    Interval = 200
    OnTimer = NumericTimer
    Left = 456
    Top = 136
  end
end
