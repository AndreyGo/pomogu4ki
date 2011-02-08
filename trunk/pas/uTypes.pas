{*
  Additional types
*}
unit uTypes;

interface

uses  ShareMem;

type
 TDllExtension = record
  Author: string[50];
  Email: string[50];
  Blog: string[50];
 end;

 PDllInfo = ^TDllInfo;

 TDllInfo = record
    DllName: string[20];
    DllPath:  string[255];
    DllDescription: string[255];
    DllExtension: TDllExtension;
  end;

implementation

Begin
end.
