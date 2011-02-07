{*
  Additional functions
*}
unit uFunctions;

interface

uses ShellApi;
function WindowsCopyFile(FromFile, ToDir : string) : boolean;

implementation

function WindowsCopyFile(FromFile, ToDir : string) : boolean;
var
  F : TShFileOpStruct;
begin
  F.Wnd := 0;
  F.wFunc := FO_COPY;
  FromFile:=FromFile + #0;
  F.pFrom:=pchar(FromFile);
  ToDir:=ToDir + #0;
  F.pTo:=PChar(ToDir);
  F.fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
  Result:=ShFileOperation(F) = 0;
end;

end.
