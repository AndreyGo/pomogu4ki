library Lib;

uses
  ShareMem,
  SysUtils,
  Classes,
  forms,
  Messages,
  Windows,
  uTypes in '..\..\pas\uTypes.pas';

{$R *.res}

var
  OldApp: TApplication;


function DllInfo:TDllInfo; stdcall;
var
  Buffer:array [byte] of char;
Begin
   // Get DLL info
  with Result do
    Begin
      DllName:= 'My Super Plagin!';
      if GetModuleFileName(hInstance,@Buffer,SizeOf(Buffer)-1) > 0 then
         DllPath:= ExtractFilePath(StrPas(Buffer));
    End;
End;

procedure DllInitialize; stdcall;
Begin
   // Init Dll
  OldApp:= Application;
End;

procedure DllRun; stdcall;
Begin
  // Start our Dll
End;

procedure DllTerminate; stdcall;
Begin
  // Destroy
End;

function DllGetErrorStr(code:byte):string; stdcall;
Begin
  case code of
     0: Result:= 'Error not found';
  end;
End;

//***************************************
// Вспомогательные и не основные функции
//***************************************

function DllRegisterServer: HResult; stdcall;
begin
  Result := ERROR_SUCCESS;
end;

function DllUnregisterServer: HResult; stdcall;
begin
  Result := ERROR_SUCCESS;
end;

function DllInstall( bInstall : BOOL; pszCmdLine : LPCWSTR ): HResult; stdcall;
begin
  Result := ERROR_SUCCESS;
end;

exports
   // Основные функции библиотеки
  DllInfo,DllTerminate,DllRun,DllGetErrorStr,DllInitialize,

   // Функции для регистрации/удаления библиотеки в системе
  DllRegisterServer,DllUnregisterServer,DllInstall;

end.
