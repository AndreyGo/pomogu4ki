unit uSettingsClass;

interface

{
  1. Сохранение данных
  2. Загрузка данных
  3. Тип хранения информации (INI файл или реестр)
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
