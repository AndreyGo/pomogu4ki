object fmMain: TfmMain
  Left = 571
  Top = 193
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'Contol panel v0.1'
  ClientHeight = 393
  ClientWidth = 264
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
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 264
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object edSearch: TEdit
      Left = 0
      Top = 0
      Width = 264
      Height = 41
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = #1041#1099#1089#1090#1088#1099#1081' '#1087#1086#1080#1089#1082' ...'
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 325
    Width = 264
    Height = 68
    Align = alBottom
    TabOrder = 1
    object btnActivateDeActivate: TButton
      Left = 5
      Top = 8
      Width = 75
      Height = 25
      Action = acActivateDeActivate
      TabOrder = 0
    end
    object btnDelete: TButton
      Left = 85
      Top = 8
      Width = 75
      Height = 25
      Action = acDelete
      TabOrder = 1
    end
    object btnExit: TButton
      Left = 181
      Top = 36
      Width = 75
      Height = 25
      Action = acExit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object btnDesabledEnabled: TButton
      Left = 5
      Top = 36
      Width = 75
      Height = 25
      Action = acDisabledEnabled
      TabOrder = 3
    end
    object btnInstall: TButton
      Left = 85
      Top = 36
      Width = 75
      Height = 25
      Action = acInstall
      Default = True
      TabOrder = 4
    end
    object btnHide: TButton
      Left = 181
      Top = 8
      Width = 75
      Height = 25
      Action = acHide
      Cancel = True
      TabOrder = 5
    end
  end
  object pnCenter: TPanel
    Left = 0
    Top = 41
    Width = 264
    Height = 284
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object lbListOfDll: TListBox
      Left = 0
      Top = 0
      Width = 264
      Height = 284
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ItemHeight = 29
      Items.Strings = (
        'Move by Alt'
        'Minimize to tray')
      ParentFont = False
      TabOrder = 0
    end
  end
  object ActionList: TActionList
    Left = 56
    Top = 208
    object acExit: TAction
      Caption = 'Exit'
      OnExecute = acExitExecute
    end
    object acActivateDeActivate: TAction
      Caption = 'Activate'
      Enabled = False
    end
    object acDisabledEnabled: TAction
      Caption = 'Disabled'
      Enabled = False
    end
    object acDelete: TAction
      Caption = 'Delete'
      Enabled = False
    end
    object acInstall: TAction
      Caption = 'Install ...'
    end
    object acHide: TAction
      Caption = 'Hide'
      OnExecute = acHideExecute
    end
    object acShow: TAction
      Caption = 'Show'
      OnExecute = acShowExecute
    end
  end
  object TrayIcon: TTrayIcon
    PopupMenu = pmTray
    OnClick = acShowExecute
    Left = 8
    Top = 208
  end
  object pmTray: TPopupMenu
    Left = 104
    Top = 208
    object Show1: TMenuItem
      Action = acShow
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Exit1: TMenuItem
      Action = acExit
    end
  end
  object tmStartUp: TTimer
    Enabled = False
    Interval = 5
    OnTimer = tmStartUpTimer
    Left = 152
    Top = 208
  end
end
