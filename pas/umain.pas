unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ActnList, Menus;

type
  TfmMain = class(TForm)
    pnTop: TPanel;
    pnBottom: TPanel;
    pnCenter: TPanel;
    edSearch: TEdit;
    lbListOfDll: TListBox;
    btnActivateDeActivate: TButton;
    btnDelete: TButton;
    btnExit: TButton;
    btnDesabledEnabled: TButton;
    btnInstall: TButton;
    btnHide: TButton;
    ActionList: TActionList;
    acExit: TAction;
    TrayIcon: TTrayIcon;
    acActivateDeActivate: TAction;
    acDisabledEnabled: TAction;
    acDelete: TAction;
    acInstall: TAction;
    acHide: TAction;
    pmTray: TPopupMenu;
    Show1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    acShow: TAction;
    tmStartUp: TTimer;
    procedure acExitExecute(Sender: TObject);
    procedure acHideExecute(Sender: TObject);
    procedure acShowExecute(Sender: TObject);
    procedure tmStartUpTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitApplication;
  end;

var
  fmMain: TfmMain;

implementation

uses
  uFunctions;

{$R *.dfm}

procedure TfmMain.acExitExecute(Sender: TObject);
begin
   // Close application
  Application.MainForm.Close;
end;

procedure TfmMain.acHideExecute(Sender: TObject);
begin
   // Hide application
  Application.MainForm.Hide;
end;

procedure TfmMain.acShowExecute(Sender: TObject);
begin
   // show Application
  Application.MainForm.Show;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   // Start init timer
  tmStartUp.Enabled:= true;
end;

procedure TfmMain.InitApplication;
begin
   // Init application
  TrayIcon.Visible:= true;
end;

procedure TfmMain.tmStartUpTimer(Sender: TObject);
begin
   // Run init procedures when application is started
  tmStartUp.Enabled:= false;
  InitApplication;
end;

end.
