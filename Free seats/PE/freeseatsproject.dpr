program freeseatsproject;

uses
  Vcl.Forms,
  freeseatsinterface in 'freeseatsinterface.pas',
  freeseatsmodel in 'freeseatsmodel.pas' {DataModule1: TDataModule},
  freeseatspresenter in 'freeseatspresenter.pas',
  Fseats in 'Fseats.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
 // Application.CreateForm(TFCalculator, FCalculator);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.