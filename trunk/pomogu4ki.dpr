program Pomogu4ki;

uses
  ShareMem,
  Forms,
  uMain in 'pas\uMain.pas' {fmMain},
  uFunctions in 'pas\uFunctions.pas',
  uTypes in 'pas\uTypes.pas',
  uLibraries in 'pas\uLibraries.pas',
  uErrorConst in 'pas\uErrorConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
