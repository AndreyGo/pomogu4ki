unit uSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ActnList;

type
  TfmSettings = class(TForm)
    pnBottom: TPanel;
    pnLeft: TPanel;
    btnOk: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    pcSettings: TPageControl;
    tsMain: TTabSheet;
    tvNavigate: TTreeView;
    tsAdditional: TTabSheet;
    acSettings: TActionList;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvNavigateChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSettings: TfmSettings;

implementation

{$R *.dfm}

procedure TfmSettings.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmSettings.FormCreate(Sender: TObject);
var
  i: integer;
  tNode: TTreeNode;
begin
  for i := 0 to pcSettings.PageCount - 1 do
      Begin
        tNode:= TTreeNode.Create(tvNavigate.Items);
        with tvNavigate.Items.Add(tNode,'Да') do
          Begin
            Text:= pcSettings.Pages[i].Caption;
            pcSettings.Pages[i].TabVisible:= false;
          End;
      End;

  pcSettings.ActivePageIndex:= 0;
  Self.Caption:=pcSettings.ActivePage.Caption;
end;

procedure TfmSettings.tvNavigateChange(Sender: TObject; Node: TTreeNode);
begin
  if tvNavigate.Selected = nil then exit;
  pcSettings.ActivePageIndex:= tvNavigate.Selected.AbsoluteIndex;
  Self.Caption:= pcSettings.Pages[tvNavigate.Selected.AbsoluteIndex].Caption;
end;

end.
