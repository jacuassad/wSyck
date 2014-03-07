object Syck: TSyck
  Left = 815
  Top = 0
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'wSyck <SYCK.WYD>'
  ClientHeight = 194
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pHacks: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 194
    Align = alClient
    TabOrder = 0
    object gPrincipal: TGroupBox
      Left = 8
      Top = 8
      Width = 165
      Height = 113
      Caption = ' Principal '
      TabOrder = 0
      object OpenCargo: TButton
        Left = 10
        Top = 18
        Width = 70
        Height = 25
        Caption = 'Open Cargo'
        TabOrder = 0
        OnClick = OpenCargoClick
      end
      object Revive: TButton
        Left = 86
        Top = 18
        Width = 70
        Height = 25
        Caption = 'Revive'
        TabOrder = 1
        OnClick = ReviveClick
      end
      object Sec: TButton
        Left = 10
        Top = 49
        Width = 70
        Height = 25
        Caption = 'Sec'
        TabOrder = 2
        OnClick = SecClick
      end
      object OneHit: TButton
        Left = 86
        Top = 49
        Width = 70
        Height = 25
        Caption = 'OneHit'
        TabOrder = 3
        OnClick = OneHitClick
      end
      object InvON: TButton
        Left = 10
        Top = 80
        Width = 104
        Height = 25
        Caption = 'Invisible ON'
        TabOrder = 4
        OnClick = InvONClick
      end
      object InvOFF: TButton
        Left = 120
        Top = 80
        Width = 36
        Height = 25
        Caption = 'OFF'
        TabOrder = 5
        OnClick = InvOFFClick
      end
    end
    object gParty: TGroupBox
      Left = 179
      Top = 64
      Width = 262
      Height = 57
      Caption = ' Grupo '
      TabOrder = 2
      object GrupoOK: TButton
        Left = 223
        Top = 18
        Width = 30
        Height = 21
        Caption = 'OK'
        TabOrder = 1
        OnClick = GrupoOKClick
      end
      object vGrupo: TEdit
        Left = 12
        Top = 18
        Width = 205
        Height = 21
        TabOrder = 0
        OnKeyDown = vGrupoKeyDown
      end
    end
    object gTeleportar: TGroupBox
      Left = 179
      Top = 8
      Width = 262
      Height = 50
      Caption = ' Teleportar '
      TabOrder = 1
      object TeleportarOK: TButton
        Left = 223
        Top = 18
        Width = 30
        Height = 21
        Caption = 'OK'
        TabOrder = 1
        OnClick = TeleportarOKClick
      end
      object vTeleportar: TEdit
        Left = 12
        Top = 18
        Width = 205
        Height = 21
        TabOrder = 0
        OnKeyDown = vTeleportarKeyDown
      end
    end
    object gPossuir: TGroupBox
      Left = 8
      Top = 120
      Width = 433
      Height = 65
      Caption = ' Possuir '
      TabOrder = 3
      object PossuirOK: TButton
        Left = 394
        Top = 18
        Width = 30
        Height = 21
        Caption = 'OK'
        TabOrder = 2
        OnClick = PossuirOKClick
      end
      object vFlood: TCheckBox
        Left = 12
        Top = 42
        Width = 97
        Height = 17
        Caption = 'Flood'
        TabOrder = 1
      end
      object vPossuir: TEdit
        Left = 12
        Top = 18
        Width = 376
        Height = 21
        TabOrder = 0
        OnKeyDown = vPossuirKeyDown
      end
    end
  end
  object tSec: TTimer
    Interval = 1
    OnTimer = tSecTimer
    Left = 144
    Top = 136
  end
  object tHit: TTimer
    Interval = 1
    OnTimer = tHitTimer
    Left = 176
    Top = 136
  end
  object Timer: TTimer
    Interval = 1
    OnTimer = TimerTimer
    Left = 328
    Top = 32
  end
end
