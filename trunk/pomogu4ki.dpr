program Pomogu4ki;

uses
  Forms,
  uMain in 'pas\uMain.pas' {fmMain},
  uFunctions in 'pas\uFunctions.pas',
  uTypes in 'pas\uTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
