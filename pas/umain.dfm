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
  OnClose = FormClose
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
    Visible = False
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
      Action = acActivateDeactivate
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
    object btnSettings: TButton
      Left = 5
      Top = 36
      Width = 75
      Height = 25
      Action = acSettings
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
    object lvDllList: TListView
      Left = 0
      Top = 0
      Width = 264
      Height = 284
      Align = alClient
      Columns = <
        item
          Caption = #8470
          Width = 35
        end
        item
          Caption = 'NAME'
          Width = 100
        end
        item
          Caption = 'DESC'
          Width = 125
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      ParentFont = False
      ParentShowHint = False
      PopupMenu = pmLibraries
      ShowWorkAreas = True
      ShowHint = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = lvDllListClick
      OnSelectItem = lvDllListSelectItem
    end
  end
  object ActionList: TActionList
    Left = 64
    Top = 280
    object acExit: TAction
      Caption = 'Exit'
      OnExecute = acExitExecute
    end
    object acDelete: TAction
      Caption = 'Delete'
      Enabled = False
      OnExecute = acDeleteExecute
    end
    object acInstall: TAction
      Caption = 'Install ...'
      OnExecute = acInstallExecute
    end
    object acHide: TAction
      Caption = 'Hide'
      OnExecute = acHideExecute
    end
    object acShow: TAction
      Caption = 'Show'
      OnExecute = acShowExecute
    end
    object acActivateDeactivate: TAction
      Caption = 'Activate'
      Enabled = False
      OnExecute = acActivateDeactivateExecute
    end
    object acSettings: TAction
      Caption = 'Settings ...'
      Enabled = False
      OnExecute = acSettingsExecute
    end
    object acShowDetail: TAction
      Caption = 'Show detail'
      OnExecute = acShowDetailExecute
    end
  end
  object TrayIcon: TTrayIcon
    PopupMenu = pmTray
    OnClick = acShowExecute
    Left = 16
    Top = 280
  end
  object pmTray: TPopupMenu
    Left = 112
    Top = 280
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
    Left = 160
    Top = 280
  end
  object odInstallDll: TOpenDialog
    Filter = 'Dll Files|*.dll|Archive files|*.zip,*.rar|All files|*.*'
    Title = 'Install dll'
    Left = 216
    Top = 280
  end
  object pmLibraries: TPopupMenu
    Left = 112
    Top = 240
    object Activate1: TMenuItem
      Action = acActivateDeactivate
    end
    object Delete1: TMenuItem
      Action = acDelete
    end
    object Showdetail1: TMenuItem
      Action = acShowDetail
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Settings1: TMenuItem
      Action = acSettings
    end
  end
end
