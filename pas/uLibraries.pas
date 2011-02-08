unit uLibraries;

interface

uses  ShareMem,windows, classes, SysUtils, uTypes, uErrorConst;

type
  TDllInfoProc = function:TDllInfo; stdcall;
  TDllTerminateProc = procedure; stdcall;
  TDllRunProc = procedure; stdcall;
  TDllInitializeProc = procedure; stdcall;
  TDllLastErrorProc = function :string; stdcall;
  TDllSettingsProc = procedure; stdcall;

  PLibrary = ^Tlibrary;

  TLibrary = class
    private
       // Dll var's
      FDllPath: string;
      FDllHandle: THandle;
      FDllInfo: TDllInfo;
      FActivate: boolean;

       // Dll procedure's
      FLoadDllInfo: TDllInfoProc;
      FRun: TDllRunProc;
      FTerminate: TDllTerminateProc;
      FInitialize: TDllTerminateProc;
      FLstErrorStr: TDllLastErrorProc;
      FSettings: TDllSettingsProc;
    public
      LAST_ERROR: integer;
      constructor Create(ADllName:String; var IsValidModule:Boolean);
      destructor Destroy; override;
      // Call procedure's of Dll
      function LoadDllInfo:TDllInfo;
      procedure Run;
      procedure Terminate;
      procedure Initialize;
      function LastError:string;
      procedure Settings;
      procedure ShowErrorMessage;
      // property's
      property DllHandle : THandle read FDllHandle;
      property DllPath : string read FDllPath;
      property DllInfo : TDllInfo read FDllInfo;
      property Activate: boolean read FActivate;
end;


implementation

{ TLibrary }

constructor TLibrary.Create(ADllName: String; var IsValidModule: Boolean);
begin
  LAST_ERROR:= 0;

  if not FileExists(ADllName) then
    Begin
      LAST_ERROR:= ERROR_DLL_NOTFOUND;
      IsValidModule:= false;
      ShowErrorMessage;
      exit;
    End;

  FDLLHandle:= LoadLibrary(PChar(ADllName));

  if FDllHandle = 0 then
     Begin
       LAST_ERROR:= ERROR_DLL_LOAD_FAILED;
       IsValidModule:= false;
       ShowErrorMessage;
       exit;
     End;

  @FLoadDllInfo := GetProcAddress(FDllHandle,'DllInfo');

  if @FLoadDllInfo = nil then
     Begin
       LAST_ERROR:= ERROR_DLL_NOT_VALID;
       IsValidModule:= false;
       ShowErrorMessage;
       exit;
     End;

  FDllPath:= ADllName;
  IsValidModule:= true;
  FDllInfo:= LoadDllInfo;
end;

destructor TLibrary.Destroy;
begin
  FreeLibrary(DllHandle);
  inherited;
end;

function TLibrary.LastError:string;
begin
  @FLstErrorStr := GetProcAddress(DllHandle,'DllLastError');
  if @FLstErrorStr = nil  then
     Begin
       LAST_ERROR:= ERROR_DLL_FUNC_NOTFOUND;
       ShowErrorMessage;
       exit;
     End;
  Result:= FLstErrorStr;
end;

procedure TLibrary.Initialize;
begin
  @FInitialize := GetProcAddress(DllHandle,'DllInitialize');
  if @FInitialize = nil  then
     Begin
       LAST_ERROR:= ERROR_DLL_FUNC_NOTFOUND;
       ShowErrorMessage;
       exit;
     End;
  FInitialize;
end;

function TLibrary.LoadDllInfo: TDllInfo;
begin
  Result:= FLoadDllInfo;
end;

procedure TLibrary.Run;
begin
  if DllHandle = 0 then
     Begin
       FDLLHandle:= LoadLibrary(PChar(FDllPath));
     End;

  @FRun:= GetProcAddress(DllHandle,'DllRun');
  if @FRun = nil  then
     Begin
       LAST_ERROR:= ERROR_DLL_FUNC_NOTFOUND;
       ShowErrorMessage;
       exit;
     End;

  FRun;

  FActivate:= true;
end;

procedure TLibrary.Settings;
begin
  @FSettings := GetProcAddress(DllHandle,'DllSettings');
  if @FSettings = nil  then
     Begin
       LAST_ERROR:= ERROR_DLL_FUNC_NOTFOUND;
       ShowErrorMessage;
       exit;
     End;
  FSettings;
end;

procedure TLibrary.ShowErrorMessage;
Var
 sMessage: string;
 sTitle: string;
begin
  case LAST_ERROR of
    0: sMessage:= 'All ok!';
    ERROR_DLL_NOTFOUND: sMessage:= 'Dll not found.';
    ERROR_DLL_NOT_VALID: sMessage:= 'Is not valid DLL.';
    ERROR_DLL_LOAD_FAILED: sMessage:= 'Can''t load DLL file.';
    ERROR_DLL_FUNC_NOTFOUND: sMessage:= 'Function not found in loaded DLL.';
  end;
  sTitle:= 'Libraries error ('+PChar(IntToStr(LAST_ERROR))+')';
  MessageBox(0,PChar(sMessage),PChar(sTitle),MB_ICONERROR);
  LAST_ERROR:= 0;
end;

procedure TLibrary.Terminate;
begin
  @FTerminate := GetProcAddress(DllHandle,'DllTerminate');
  if @FTerminate = nil  then
     Begin
       LAST_ERROR:= ERROR_DLL_FUNC_NOTFOUND;
       exit;
     End;
  FTerminate;
  FActivate:= false;
end;

Begin
end.
