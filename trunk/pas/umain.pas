unit uMain;

interface

uses
  ShareMem, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ActnList, Menus, uTypes, uLibraries, ComCtrls,uFunctions,uErrorConst ;

type
  TfmMain = class(TForm)
    pnTop: TPanel;
    pnBottom: TPanel;
    pnCenter: TPanel;
    edSearch: TEdit;
    btnActivateDeActivate: TButton;
    btnDelete: TButton;
    btnExit: TButton;
    btnSettings: TButton;
    btnInstall: TButton;
    btnHide: TButton;
    ActionList: TActionList;
    acExit: TAction;
    TrayIcon: TTrayIcon;
    acDelete: TAction;
    acInstall: TAction;
    acHide: TAction;
    pmTray: TPopupMenu;
    Show1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    acShow: TAction;
    tmStartUp: TTimer;
    lvDllList: TListView;
    odInstallDll: TOpenDialog;
    acActivateDeactivate: TAction;
    acSettings: TAction;
    pmLibraries: TPopupMenu;
    Activate1: TMenuItem;
    Delete1: TMenuItem;
    Settings1: TMenuItem;
    N2: TMenuItem;
    acShowDetail: TAction;
    Showdetail1: TMenuItem;
    procedure acExitExecute(Sender: TObject);
    procedure acHideExecute(Sender: TObject);
    procedure acShowExecute(Sender: TObject);
    procedure tmStartUpTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acInstallExecute(Sender: TObject);
    procedure lvDllListClick(Sender: TObject);
    procedure lvDllListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure acActivateExecute(Sender: TObject);
    procedure acActivateDeactivateExecute(Sender: TObject);
    procedure acSettingsExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure acShowDetailExecute(Sender: TObject);
  private
    { Private declarations }
    procedure ScanLibraries;
  public
    { Public declarations }
    LAST_ERROR : integer;
    procedure InitApplication;
    procedure TerminateApplication;
    procedure ShowErrorMessage;
    procedure AddLibrary(Lib:TLibrary);
    procedure SwitchCaptions;
  end;

var
  fmMain: TfmMain;
  ROOT_DIR : string = '';
  EXE_FILE_NAME : string = '';

Const
  LIBRARIES_DIR = '\libraries\';

   // Errors constants
  ERROR_LIBRARIES_DIR_NOTFOUND = 10;
  ERROR_LIBRARIES_EMPTY = 11;

implementation

{$R *.dfm}

procedure TfmMain.acActivateDeactivateExecute(Sender: TObject);
begin
   // Activate or deactivate item
  if lvDllList.Selected = nil then exit;
  if Plibrary(lvDllList.Selected.Data).Activate then
     Begin
       Plibrary(lvDllList.Selected.Data).Terminate;
     End
  else
    Begin
      Plibrary(lvDllList.Selected.Data).Run;
    End;
  SwitchCaptions;
end;

procedure TfmMain.acActivateExecute(Sender: TObject);
begin
  PLibrary(lvDllList.Selected.Data).Run;
end;

procedure TfmMain.acDeleteExecute(Sender: TObject);
begin
   // Stop and delete library. With confirm window
  if lvDllList.Selected = nil then exit;

  if MessageBox(Application.MainForm.Handle,'You realy want to delete library ?','Delete library!',MB_YESNO + MB_ICONQUESTION) = ID_YES then
     Begin
       if PLibrary(lvDllList.Selected.Data).Activate then PLibrary(lvDllList.Selected.Data).Terminate;
       if DeleteFile(PLibrary(lvDllList.Selected.Data).DllPath) then
          Begin
            PLibrary(lvDllList.Selected.Data).Free;
            lvDllList.Selected.Delete;
          End
       else
          Begin
            LAST_ERROR:= ERROR_DLL_NOT_DELETE;
            ShowErrorMessage;
          End;
     End;
end;

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

procedure TfmMain.acInstallExecute(Sender: TObject);
var
  IsValid: boolean;
  CheckLibrary: TLibrary;
begin
   // Install new dll
  if odInstallDll.Execute then
     Begin
       if odInstallDll.FileName <> '' then
          Begin
            // check file
            // copy file
            CheckLibrary:= TLibrary.Create(odInstallDll.FileName,IsValid);
            if not IsValid then
               Begin
                 CheckLibrary.Free;
                 exit;
               End;
            WindowsCopyFile(odInstallDll.FileName,ROOT_DIR + LIBRARIES_DIR + ExtractFileName(odInstallDll.FileName));
            AddLibrary(CheckLibrary);
          End;
     End;
end;

procedure TfmMain.acSettingsExecute(Sender: TObject);
begin
   // Run settings window if exists
end;

procedure TfmMain.acShowDetailExecute(Sender: TObject);
Var
  sInfo: string;
begin
   // Show detail info about selected library
  if lvDllList.Selected = nil then exit;
  sInfo:= '----- Detail info about ' +  PLibrary(lvDllList.Selected).DllInfo.DllName + ' -----' + #13;
  sInfo:= sInfo + 'Author: ' + PLibrary(lvDllList.Selected).DllInfo.DllExtension.Author + #13;
  sInfo:= sInfo + 'E-Mail: ' + PLibrary(lvDllList.Selected).DllInfo.DllExtension.Email + #13;
  sInfo:= sInfo + 'Blog: ' + PLibrary(lvDllList.Selected).DllInfo.DllExtension.Blog + #13;
  sInfo:= sInfo + 'Description: ' + PLibrary(lvDllList.Selected).DllInfo.DllDescription;
  MessageBox(Application.MainForm.Handle,PChar(sInfo),'Detail info',MB_ICONINFORMATION);
end;

procedure TfmMain.acShowExecute(Sender: TObject);
begin
   // show Application
  Application.MainForm.Show;
end;

procedure TfmMain.AddLibrary(Lib: TLibrary);
var
  pData:PLibrary;
begin
   // Add new library in list view
  New(pData);
  with lvDllList.Items.Add do
   Begin
      Caption:= '#';
      SubItems.Add(Lib.DllInfo.DllName);
      SubItems.Add(Lib.DllInfo.DllDescription);
      pData^ := lib;
      Data:= pData;
   End;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // Close form and application
  if MessageBox(Application.MainForm.Handle,'You realy want close application ?','Close Application',MB_YESNO + MB_ICONQUESTION) = ID_NO then
     Begin
       Action:= caNone;
       exit;
     End;

  TerminateApplication;
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

   // Init application
  TrayIcon.Visible:= true;
  ScanLibraries;
  if LAST_ERROR <> 0 then
     Begin
       ShowErrorMessage;
       exit;
     End;
end;

procedure TfmMain.lvDllListClick(Sender: TObject);
begin
   // Click to DLL
end;

procedure TfmMain.lvDllListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
    // Enabled some buttons
  acActivateDeActivate.Enabled:= lvDllList.Selected <> nil;
  acDelete.Enabled:= lvDllList.Selected <> nil;
  acSettings.Enabled:= lvDllList.Selected <> nil;
  SwitchCaptions;
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
                   AddLibrary(DllLibrary);
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

procedure TfmMain.SwitchCaptions;
begin
   // Switch captioins in buttons and other controls
  if lvDllList.Selected <> nil then
     Begin
       if PLibrary(lvDllList.Selected.Data).Activate then
          Begin
            acActivateDeactivate.Caption:= 'Deactivate';
          End
        else
          Begin
            acActivateDeactivate.Caption:= 'Activate';
          End;
     End;
end;

procedure TfmMain.TerminateApplication;
{var
  i: integer;}
begin
{  if Length(LibraryList) > 0 then
     Begin
       for i := 0 to Length(LibraryList) - 1 do
           LibraryList[i].Terminate;
     End; }

  TrayIcon.Visible:= false;
end;

procedure TfmMain.tmStartUpTimer(Sender: TObject);
begin
   // Run init procedures when application is started
  tmStartUp.Enabled:= false;
  InitApplication;
end;

end.
