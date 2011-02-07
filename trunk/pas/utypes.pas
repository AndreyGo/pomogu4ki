{*
  Additional types
*}
unit uTypes;

interface

uses  ShareMem,windows, classes, SysUtils;

type
  TDllInfo = record
    DllName: string[20];
    DllPath: string[50];
  end;


type
  TDllInfoProc = function:TDllInfo; stdcall;
  TDllTerminateProc = procedure; stdcall;
  TDllRunProc = procedure; stdcall;
  TDllInitializeProc = procedure; stdcall;
  TDllGetErrorStrProc = function(code:byte):string; stdcall;

  TLibrary = class
    private
       // Dll var's
      FDllName: string;
      FDllPath: string;
      FDllHandle: THandle;
      FDllInfo: TDllInfo;

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
      property DllName : string read FDllname;
      property DllHandle : THandle read FDllHandle;
      property DllPath : string read FDllPath;
end;


implementation

{ TLibrary }

constructor TLibrary.Create(ADllName: String; var IsValidModule: Boolean);
begin
  LAST_ERROR:= 0;

  if not FileExists(ADllName) then
    Begin
      IsValidModule:= false;
      exit;
    End;

  FDLLHandle:= LoadLibrary(PChar(ADllName));

  if FDllHandle = 0 then
     Begin
       IsValidModule:= false;
       exit;
     End;

  @FLoadDllInfo := GetProcAddress(FDllHandle,'DllInfo');

  if @FLoadDllInfo = nil then
     Begin
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

end;

procedure TLibrary.Initialize;
begin

end;

function TLibrary.LoadDllInfo: TDllInfo;
begin
  Result:= FLoadDllInfo;
  FDllName:= Result.DllName;
  FDllPath:= Result.DllPath;
end;

procedure TLibrary.Run;
begin

end;

procedure TLibrary.Terminate;
begin

end;

end.
