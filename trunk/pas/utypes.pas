{*
  Additional types
*}
unit uTypes;

interface

uses Graphics;

type
  TDllInfoStructure = record
    DllName : string;        // �������� ����������
    DllFilename: string;     // ��� ����� ����������
    DllDescription: string;  // �������� ����������
    DllCategory: byte;       // ID ���������, �� ������� :)
    DllVersion: byte;        // ������ ����������
    DllIco: TBitmap;         // ������ ����������
    DllAuthor: string;       // ��� ������ ����������
    DllAuthorEmail: string;  // ����� ������
    DllAuthorBlog: string;   // ���� ������

    DllFilePath : string;
  end;


type
  TDllInfoProc = function():string;
  TStartStopProc = function : byte;
  TGetErrorStrProc = function (code:byte):string;

implementation

end.
