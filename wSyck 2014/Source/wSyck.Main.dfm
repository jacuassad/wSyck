object wSyck2014: TwSyck2014
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'wSyck 2014'
  ClientHeight = 260
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Web: TWebBrowser
    Left = 152
    Top = 376
    Width = 115
    Height = 49
    TabOrder = 0
    ControlData = {
      4C000000E30B0000100500000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Pages: TTabbedNotebook
    Left = 0
    Top = 0
    Width = 526
    Height = 241
    Align = alClient
    PageIndex = 2
    TabFont.Charset = DEFAULT_CHARSET
    TabFont.Color = clBtnText
    TabFont.Height = -11
    TabFont.Name = 'Tahoma'
    TabFont.Style = []
    TabOrder = 1
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Hacks'
      object pHacks: TPanel
        Left = 0
        Top = 0
        Width = 518
        Height = 213
        Align = alClient
        TabOrder = 0
        object gHacksFunctions: TGroupBox
          Left = 8
          Top = 11
          Width = 177
          Height = 150
          Caption = ' Functions '
          TabOrder = 0
          object bOpenCargo: TButton
            Left = 10
            Top = 20
            Width = 75
            Height = 25
            Caption = 'Open Cargo'
            TabOrder = 0
            OnClick = bOpenCargoClick
          end
          object bRevive: TButton
            Left = 91
            Top = 20
            Width = 75
            Height = 25
            Caption = 'Revive'
            TabOrder = 1
            OnClick = bReviveClick
          end
          object bOneHitON: TButton
            Left = 10
            Top = 82
            Width = 156
            Height = 25
            Caption = 'One Hit [ON] | [OFF]'
            TabOrder = 2
            OnClick = bOneHitONClick
          end
          object bInvON: TButton
            Left = 10
            Top = 51
            Width = 156
            Height = 25
            Caption = 'Invisible [ON] | [OFF]'
            TabOrder = 3
            OnClick = bInvONClick
          end
          object bSecON: TButton
            Left = 10
            Top = 113
            Width = 156
            Height = 25
            Caption = 'Fix Pos [ON] | [OFF]'
            TabOrder = 4
            OnClick = bSecONClick
          end
        end
        object gTeleport: TGroupBox
          Left = 191
          Top = 11
          Width = 315
          Height = 54
          Caption = ' Teleport '
          TabOrder = 1
          object bTeleportOK: TButton
            Left = 263
            Top = 20
            Width = 34
            Height = 21
            Caption = 'OK'
            TabOrder = 0
            OnClick = bTeleportOKClick
          end
          object eTeleport: TComboBox
            Left = 15
            Top = 20
            Width = 242
            Height = 21
            TabOrder = 1
            OnKeyDown = eTeleportKeyDown
          end
        end
        object gParty: TGroupBox
          Left = 191
          Top = 71
          Width = 315
          Height = 54
          Caption = ' Party '
          TabOrder = 2
          object bPartyOK: TButton
            Left = 263
            Top = 20
            Width = 34
            Height = 21
            Caption = 'OK'
            TabOrder = 0
            OnClick = bPartyOKClick
          end
          object eParty: TComboBox
            Left = 15
            Top = 20
            Width = 242
            Height = 21
            TabOrder = 1
            OnKeyDown = ePartyKeyDown
          end
        end
        object gChat: TGroupBox
          Left = 191
          Top = 131
          Width = 315
          Height = 70
          Caption = ' Fake Chat '
          TabOrder = 3
          object bChatOK: TButton
            Left = 263
            Top = 20
            Width = 34
            Height = 21
            Caption = 'OK'
            TabOrder = 0
            OnClick = bChatOKClick
          end
          object eChat: TComboBox
            Left = 15
            Top = 20
            Width = 242
            Height = 21
            TabOrder = 1
            OnKeyDown = eChatKeyDown
          end
          object vChatFloder: TCheckBox
            Left = 15
            Top = 45
            Width = 57
            Height = 17
            Caption = 'Floder'
            TabOrder = 2
          end
        end
        object Version: TPanel
          Left = 8
          Top = 167
          Width = 177
          Height = 34
          TabOrder = 4
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Events'
      object pEvents: TPanel
        Left = 0
        Top = 0
        Width = 518
        Height = 213
        Align = alClient
        TabOrder = 0
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Macros'
      object pMacros: TPanel
        Left = 0
        Top = 0
        Width = 518
        Height = 213
        Align = alClient
        TabOrder = 0
        object Edit1: TEdit
          Left = 8
          Top = 4
          Width = 75
          Height = 21
          TabOrder = 0
        end
        object Button3: TButton
          Left = 8
          Top = 31
          Width = 75
          Height = 25
          Caption = 'Buff'
          TabOrder = 1
          OnClick = Button3Click
        end
        object AutoNy: TCheckBox
          Left = 8
          Top = 70
          Width = 121
          Height = 17
          Caption = 'Auto Ref. Nyerds'
          TabOrder = 2
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Monitor'
      object pMonitor: TPanel
        Left = 0
        Top = 0
        Width = 518
        Height = 213
        Align = alClient
        TabOrder = 0
        object ePlayerID: TLabeledEdit
          Left = 8
          Top = 19
          Width = 121
          Height = 21
          EditLabel.Width = 72
          EditLabel.Height = 13
          EditLabel.Caption = 'Game.PlayerID'
          TabOrder = 0
        end
        object eLoginCount: TLabeledEdit
          Left = 8
          Top = 62
          Width = 121
          Height = 21
          EditLabel.Width = 58
          EditLabel.Height = 13
          EditLabel.Caption = 'Login.Count'
          TabOrder = 1
        end
      end
    end
  end
  object Status: TStatusBar
    Left = 0
    Top = 241
    Width = 526
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object MainLoop: TTimer
    Interval = 1
    OnTimer = MainLoopTimer
    Left = 480
    Top = 8
  end
  object MainMenu: TMainMenu
    Left = 424
    Top = 8
    object Client1: TMenuItem
      Caption = 'Client'
      OnClick = Client1Click
    end
    object Maps1: TMenuItem
      Caption = 'Maps'
      OnClick = Maps1Click
    end
    object ChangeTitle1: TMenuItem
      Caption = 'MultWYD'
      OnClick = ChangeTitle1Click
    end
  end
end
