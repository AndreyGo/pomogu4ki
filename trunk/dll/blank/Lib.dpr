library Lib;



{$R *.dres}

uses
  ShareMem,
  SysUtils,
  Classes,
  forms,
  Messages,
  Windows,
  uTypes in '..\..\pas\uTypes.pas',
  uSettings in 'uSettings.pas' {fmSettings},
  uSettingsClass in '..\..\pas\uSettingsClass.pas';

{$R *.res}

var
  OldApp: TApplication;
  LAST_ERROR: integer;

function DllInfo:TDllInfo; stdcall;
var
  Buffer:array [byte] of char;
Begin
   // Get DLL info
  with Result do
    Begin
      DllName:= 'Test DLL';
      DllDescription:= 'Description';
      DllExtension.Author:= 'Andrey_Go';
      DllExtension.Blog:= 'http://pomogu4ki.blogspot.com/';
      DllExtension.Email:= 'slashinin.andrrey@gmail.com';
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

function DllLastError:string; stdcall;
Begin
   // Return error
   case LAST_ERROR of
    0: Result:= 'All ok!';
   end;
End;

procedure DllSettings();
Begin
   // Show settings window
  OldApp.CreateForm(TfmSettings,fmSettings);
  fmSettings.ShowModal;
  fmSettings.Free;
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
  DllInfo,DllTerminate,DllRun,DllLastError,DllInitialize, DllSettings,

   // Функции для регистрации/удаления библиотеки в системе
  DllRegisterServer,DllUnregisterServer,DllInstall;
end.
