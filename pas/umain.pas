unit uMain;

interface

uses
  ShareMem, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ActnList, Menus, uTypes ;

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
    procedure ScanLibraries;
  public
    { Public declarations }
    LAST_ERROR : integer;
    procedure InitApplication;
    procedure ShowErrorMessage;
  end;

var
  fmMain: TfmMain;
  ROOT_DIR : string = '';
  EXE_FILE_NAME : string = '';
  LibraryList : array of TLibrary;
Const
  LIBRARIES_DIR = '\libraries\';

   // Errors constants
  ERROR_LIBRARIES_DIR_NOTFOUND = 10;
  ERROR_LIBRARIES_EMPTY = 11;

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
   // Init vars
  ROOT_DIR:= ExtractFileDir(ParamStr(0));
  EXE_FILE_NAME:= ExtractFileName(ParamStr(0));
  LAST_ERROR := 0;
  SetLength(LibraryList,0);

   // Init application
  TrayIcon.Visible:= true;
  ScanLibraries;
  if LAST_ERROR <> 0 then
     Begin
       ShowErrorMessage;
       exit;
     End;
end;

procedure TfmMain.ScanLibraries;
Var
  SearchRec: TSearchRec;
  DllLibrary: TLibrary;
  IsValid: boolean;
begin
   // Scan libraries directory, find all DLL and fill array of libraries
  if not DirectoryExists(ROOT_DIR  + LIBRARIES_DIR) then
     Begin
       LAST_ERROR:= ERROR_LIBRARIES_DIR_NOTFOUND;
       exit;
     End;

  if FindFirst(ROOT_DIR  + LIBRARIES_DIR + '*.dll', faAnyFile, SearchRec) = 0 then
     Begin
       repeat
        if (SearchRec.name = '.') or (SearchRec.name = '..') then continue;
        if (SearchRec.Attr and faDirectory) = 0 then
            Begin
              DllLibrary:= TLibrary.Create(ROOT_DIR  + LIBRARIES_DIR + SearchRec.Name,IsValid);
              if IsValid then
                 Begin
                   SetLength(LibraryList,Length(LibraryList)+1);
                   LibraryList[Length(LibraryList)-1]:= DllLibrary;
                   lbListOfDll.Items.Add(DllLibrary.DllName);
                 End;
            End;
       until FindNext(SearchRec) <> 0;
     End;
  FindClose(SearchRec);
  LAST_ERROR:= 0;
end;

procedure TfmMain.ShowErrorMessage;
Var
  sMessage: string;
begin
   // Show error message for user
  case LAST_ERROR of
    ERROR_LIBRARIES_DIR_NOTFOUND: sMessage:= 'Libraries directory not found';
    ERROR_LIBRARIES_EMPTY: sMessage:= 'Libraries not available, please install it first';
  end;

  MessageBox(Application.Handle,PChar(sMessage),'Application error',MB_ICONERROR + MB_OK);
end;

procedure TfmMain.tmStartUpTimer(Sender: TObject);
begin
   // Run init procedures when application is started
  tmStartUp.Enabled:= false;
  InitApplication;
end;

end.
