unit uSettingsClass;

interface

{
  1. ���������� ������
  2. �������� ������
  3. ��� �������� ���������� (INI ���� ��� ������)
}

uses forms,StdCtrls, ComCtrls, ActnList;

type
  PSettings = ^TSettings;
  TSettings = class
     public
       constructor Create(AOwner: TControl);
       destructor Destroy; override;
       procedure SaveData();
       procedure LoadData();
     private
  end;

implementation

end.
