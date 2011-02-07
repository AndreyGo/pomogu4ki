unit uLibraries;

interface

uses  ShareMem,windows, classes, SysUtils, uTypes, uErrorConst;

type
  TDllInfoProc = function:TDllInfo; stdcall;
  TDllTerminateProc = procedure; stdcall;
  TDllRunProc = procedure; stdcall;
  TDllInitializeProc = procedure; stdcall;
  TDllGetErrorStrProc = function(code:byte):string; stdcall;

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
      FGetErrorStr: TDllGetErrorStrProc;
    public
      LAST_ERROR: integer;
      constructor Create(ADllName:String; var IsValidModule:Boolean);
      destructor Destroy; override;
      // Call procedure's of Dll
      function LoadDllInfo:TDllInfo;
      procedure Run;
      procedure Terminate;
      procedure Initialize;
      function GetErrorStr(code:byte):string;
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
      exit;
    End;

  FDLLHandle:= LoadLibrary(PChar(ADllName));

  if FDllHandle = 0 then
     Begin
       LAST_ERROR:= ERROR_DLL_LOAD_FAILED;
       IsValidModule:= false;
       exit;
     End;

  @FLoadDllInfo := GetProcAddress(FDllHandle,'DllInfo');

  if @FLoadDllInfo = nil then
     Begin
       LAST_ERROR:= ERROR_DLL_NOT_VALID;
       IsValidModule:= false;
       exit;
     End;

  IsValidModule:= true;
  FDllInfo:= LoadDllInfo;
end;

destructor TLibrary.Destroy;
begin
  FreeLibrary(DllHandle);
  inherited;
end;

function TLibrary.GetErrorStr(code: byte): string;
begin
  @FGetErrorStr := GetProcAddress(DllHandle,'DllGetErrorStr');
  if @FGetErrorStr = nil  then
     Begin
       LAST_ERROR:= ERROR_DLL_FUNC_NOTFOUND;
       exit;
     End;
  Result:= FGetErrorStr(code);
end;

procedure TLibrary.Initialize;
begin
  @FInitialize := GetProcAddress(DllHandle,'DllInitialize');
  if @FInitialize = nil  then
     Begin
       LAST_ERROR:= ERROR_DLL_FUNC_NOTFOUND;
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
  @FRun:= GetProcAddress(DllHandle,'DllRun');
  if @FRun = nil  then
     Begin
       LAST_ERROR:= ERROR_DLL_FUNC_NOTFOUND;
       exit;
     End;
  FRun;
  FActivate:= true;
end;

procedure TLibrary.Terminate;
begin
  @FTerminate:= GetProcAddress(DllHandle,'DllTerminate');
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
