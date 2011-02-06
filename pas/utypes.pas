{*
  Additional types
*}
unit uTypes;

interface

uses Graphics;

type
  TDllInfoStructure = record
    DllName : string;        // Название библиотеки
    DllFilename: string;     // Имя файла библиотеки
    DllDescription: string;  // Описание библиотеки
    DllCategory: byte;       // ID категории, на будущее :)
    DllVersion: byte;        // Версия библиотеки
    DllIco: TBitmap;         // Иконка библиотеки
    DllAuthor: string;       // Имя автора библиотеки
    DllAuthorEmail: string;  // Почта автора
    DllAuthorBlog: string;   // Блог автора

    DllFilePath : string;
  end;


type
  TDllInfoProc = function():string;
  TStartStopProc = function : byte;
  TGetErrorStrProc = function (code:byte):string;

implementation

end.
